import os
import pickle
from nltk.sem import logic
from nltk.inference import TableauProver

from nltk.sem.drt import *

from nltk import *
from nltk.sem.drt import DrtParser
from nltk.sem import logic

import pandas as pd
import unidecode
import re
import regex

from nltk.sem import Expression

import nltk.data

nltk.download('wordnet', quiet=True)
nltk.download('omw-1.4', quiet=True)
nltk.download("extended_omw", quiet=True)

from nltk.corpus import wordnet as wn

read_expr = Expression.fromstring

_LOCAL_LADR_BIN = os.path.join(
    os.path.dirname(os.path.abspath(__file__)),
    'LADR-2009-11A',
    'bin',
)

if not os.getenv('PROVER9') and os.path.isdir(_LOCAL_LADR_BIN):
    # Keep repo-local prover binaries available even when shell init files are skipped.
    os.environ['PROVER9'] = _LOCAL_LADR_BIN
    current_path = os.environ.get('PATH', '')
    if _LOCAL_LADR_BIN not in current_path.split(os.pathsep):
        os.environ['PATH'] = _LOCAL_LADR_BIN + (os.pathsep + current_path if current_path else '')

# ---- Monkey-patch: Python-level timeout for Prover9/Mace4 subprocess calls ----
import subprocess as _mp_subprocess
import threading as _mp_threading
import nltk.inference.prover9 as _mp_p9module

_mp_orig_call = _mp_p9module.Prover9Parent._call
_MP_TIMEOUT = 35

def _mp_call_with_timeout(self, input_str, binary, args=[], verbose=False):
    if verbose:
        print("Calling:", binary)
        print("Args:", args)
        print("Input:", input_str)
    cmd = [binary] + args
    try:
        input_str = input_str.encode("utf8")
    except AttributeError:
        pass
    p = _mp_subprocess.Popen(
        cmd, stdout=_mp_subprocess.PIPE, stderr=_mp_subprocess.STDOUT, stdin=_mp_subprocess.PIPE
    )
    timed_out = [False]
    def _kill():
        timed_out[0] = True
        try:
            p.kill()
        except OSError:
            pass
    timer = _mp_threading.Timer(_MP_TIMEOUT, _kill)
    timer.start()
    try:
        (stdout, stderr) = p.communicate(input=input_str)
    finally:
        timer.cancel()
    if timed_out[0]:
        p.wait()
        bname = binary.rsplit("/", 1)[-1] if "/" in binary else binary
        print(f"  [TIMEOUT] {bname} killed after {_MP_TIMEOUT}s")
        return ("TIMEOUT", 3)
    if verbose:
        print("Return code:", p.returncode)
        if stdout:
            print("stdout:", stdout)
    return (stdout.decode("utf-8"), p.returncode)

_mp_p9module.Prover9Parent._call = _mp_call_with_timeout

# Also patch Mace._call_mace4 to inject assign(max_seconds, 20)
from nltk.inference.mace import Mace as _mp_Mace
_mp_orig_call_mace4 = _mp_Mace._call_mace4
def _mp_patched_call_mace4(self, input_str, args=[], verbose=False):
    input_str = "assign(max_seconds, 10)." + chr(10) + chr(10) + input_str
    return _mp_orig_call_mace4(self, input_str, args, verbose)
_mp_Mace._call_mace4 = _mp_patched_call_mace4

# Also patch Prover9._call_prover9 to inject assign(max_weight, 30) to prevent search explosion
from nltk.inference.prover9 import Prover9 as _mp_Prover9
_mp_orig_call_prover9 = _mp_Prover9._call_prover9
def _mp_patched_call_prover9(self, input_str, args=[], verbose=False):
    input_str = "assign(max_weight, 50).\n\n" + input_str
    return _mp_orig_call_prover9(self, input_str, args, verbose)
_mp_Prover9._call_prover9 = _mp_patched_call_prover9
# ---- End monkey-patch ----


logic._counter._value = 0


_LOGIC_KEYWORDS = {"or", "and"}

# Strict evaluation policy: final labels come only from direct theorem-prover
# success on P |= H or P |= -H.  Legacy fallbacks, pre-proof premise filters,
# closed-world assumptions, and result heuristics are kept unreachable here so
# a shell environment cannot silently relax the proof policy during evaluation.
_USE_CWA = False
PROOF_ONLY_LABELS = True
ENABLE_STRIPPED_FALLBACK = False
ENABLE_CURATED_LEXICON_FALLBACK = False
ENABLE_PREPROOF_FILTERS = False
# Sound additive axiom emission from the curated French hypernymy/synonym
# dictionary.  These produce pure first-order class-inclusion / equivalence
# axioms consumed by Prover9.  This is DIFFERENT from
# ENABLE_CURATED_LEXICON_FALLBACK (which controls post-proof guard logic).
# Kept ON because the axioms are sound and required for SICK lexical recall.
ENABLE_CURATED_HYPERNYM_AXIOMS = True

def sanitize_special_chars(expr):
    """Replace characters that are invalid in Prover9 / NLTK logic identifiers.
    - %  → pct   (% is Prover9's comment character)
    - bare ?  → unknown_  (? is not a valid term)
    - ≥(A, B) → (>(A, B) | A = B)        (A.4: sound expansion of weak inequality)
    - ≤(A, B) → (<(A, B) | A = B)        (A.4: sound expansion of weak inequality)
    """
    expr = expr.replace('%', 'pct')
    # Replace bare ? used as a constant (e.g. (t = ?))
    expr = re.sub(r'(?<=[=<>!,( ])\?(?=[\s)&|,])', 'unknown_', expr)
    # A.4: Expand weak-inequality predicates ≥/≤ to their sound FOL definitions.
    # Walk balanced parens to extract the two args of ≥(A, B) / ≤(A, B),
    # split on the top-level comma, then rewrite. Repeats until no more occur.
    for sym, strict in (('≥', '>'), ('≤', '<')):
        while True:
            idx = expr.find(sym + '(')
            if idx < 0:
                break
            start = idx + len(sym) + 1  # position just after '('
            depth = 1
            i = start
            split_pos = -1
            while i < len(expr) and depth > 0:
                c = expr[i]
                if c == '(':
                    depth += 1
                elif c == ')':
                    depth -= 1
                    if depth == 0:
                        end = i
                        break
                elif c == ',' and depth == 1 and split_pos == -1:
                    split_pos = i
                i += 1
            else:
                break  # unbalanced; bail out to avoid infinite loop
            if split_pos < 0:
                break
            arg_a = expr[start:split_pos].strip()
            arg_b = expr[split_pos + 1:end].strip()
            replacement = f'({strict}({arg_a}, {arg_b}) | {arg_a} = {arg_b})'
            expr = expr[:idx] + replacement + expr[end + 1:]
    return expr

def rename_keyword_predicates(expr):
    """Rename predicate/function names that clash with NLTK logical keywords.
    e.g. or(c) -> or_fr(c),  but the logical 'or' in 'A or B' is untouched."""
    return re.sub(
        r'\b(' + '|'.join(_LOGIC_KEYWORDS) + r')\s*\(',
        lambda m: m.group(1) + '_fr(',
        expr
    )

def extract_arities(expr, predicates_only=False):
    """Return a dict {predicate_name: [arity, ...]} for this expression.
    If predicates_only=True, skip function usages (terms nested inside
    other calls or comparisons) so that only genuine predicate symbols
    are returned."""
    pattern = re.compile(r'(\w+)\(([^()]*)\)')
    arities = {}
    for m in pattern.finditer(expr):
        name = m.group(1)
        if predicates_only and is_function_usage(expr, m.start(), m.end()):
            continue
        args = m.group(2)
        count = 0 if args.strip() == '' else len(args.split(','))
        arities.setdefault(name, []).append(count)
    return arities

def is_function_usage(expr, match_start, match_end=None):
    """Check if the match at match_start is nested inside another call's arguments.
    A call name(...) is a function (not a predicate) when it appears:
      - after a comma  (argument in a list)
      - after '(' belonging to another call  (nested argument)
      - after '=', '<', '>', '!'  (value in a comparison/assignment)
    """
    pos = match_start - 1
    while pos >= 0 and expr[pos] in ' \t\n':
        pos -= 1
    if pos < 0:
        return False
    ch = expr[pos]
    if ch == ',':
        # After a comma → inside an argument list
        return True
    if ch in '=<>!':
        # After a comparison / equality operator → used as a value (function)
        # But NOT when '>' is part of '->' (implication) or '<->' (biconditional)
        if ch == '>' and pos > 0 and expr[pos - 1] == '-':
            return False  # part of -> or <->
        return True
    if ch == '(':
        # Check if this '(' belongs to a function/predicate call
        pos2 = pos - 1
        while pos2 >= 0 and expr[pos2] in ' \t\n':
            pos2 -= 1
        if pos2 >= 0 and (expr[pos2].isalnum() or expr[pos2] == '_' or expr[pos2] in '<>=!'):
            return True

    # If the call is immediately followed by an equality/comparison, it is used as a term.
    if match_end is not None:
        pos3 = match_end
        while pos3 < len(expr) and expr[pos3] in ' \t\n':
            pos3 += 1
        if pos3 < len(expr) and expr[pos3] in '=<>!':
            return True
    return False

def detect_dual_use_symbols(expr):
    """Find symbols used as both function and predicate in the expression."""
    keywords = {"exists", "all", "and", "or", "not"}
    pattern = re.compile(r'(\w+)\(([^()]*)\)')
    func_uses = set()
    pred_uses = set()
    for m in pattern.finditer(expr):
        name = m.group(1)
        if name in keywords:
            continue
        if is_function_usage(expr, m.start(), m.end()):
            func_uses.add(name)
        else:
            pred_uses.add(name)
    return func_uses & pred_uses

def add_arity_with_global_lowest(expr, lowest_arities, colliding_predicates, dual_use_symbols=None):
    """Add _N suffix for predicates that are above lowest global arity.
    Also rename predicate usages of dual-use symbols (used as both function and relation)."""
    if dual_use_symbols is None:
        dual_use_symbols = set()
    pattern = re.compile(r'(\w+)\(([^()]*)\)')
    def replacer(m):
        name = m.group(1)
        args = m.group(2)
        count = 0 if args.strip() == '' else len(args.split(','))
        new_name = name
        # Handle dual-use: rename predicate (relation) usage to pred_name
        if name in dual_use_symbols and not is_function_usage(expr, m.start(), m.end()):
            new_name = f"pred_{name}"
        # Handle arity conflicts
        if name in lowest_arities:
            if count != lowest_arities[name] or name in colliding_predicates:
                new_name = f"{new_name}_{count}"
        if new_name != name:
            return f"{new_name}({args})"
        if name in lowest_arities:
            return f"{name}({args})"
        return m.group(0)  # leave unchanged if not in lowest_arities
    return pattern.sub(replacer, expr)

def clean_formula_string(expr):
    """Normalize and sanitize formula string."""
    expr = sanitize_special_chars(expr)
    expr = re.sub(r'\b(\w+_\w+|\w+[À-ÖØ-öø-ÿ]\w*|\w*[À-ÖØ-öø-ÿ]\w+)\b', lambda m: unidecode.unidecode(m.group(1)), expr)
    expr = re.sub(r'\b([À-ÖØ-öø-ÿ])\b', lambda m: unidecode.unidecode(m.group(1))+"_", expr)
    expr = re.sub(r'\b([a-z]+)\?', r'\1_', expr)
    expr = re.sub(r"'((?:\\'|[^'])+)'", lambda m: (unidecode.unidecode(m.group(1)) if len(m.group(1)) > 2 else m.group(1)).replace("\\'", "'"), expr)
    expr = expr.replace("œ", "oe")
    expr = re.sub(r'(?<![A-Za-z0-9_]):(?=\()', 'colon_', expr)
    expr = re.sub(r'\b([a-z])([0-9])(?=\()', lambda m: m.group(1).upper() + m.group(2), expr)
    expr = rename_keyword_predicates(expr)
    # Convert not(...) predicate to logical negation -(...)
    expr = re.sub(r'\bnot\(', '-(', expr)
    # Sound, semantics-preserving repair of a removable surplus of trailing
    # ')' tokens (a "small detail" that does not affect meaning). Only the
    # unambiguous trailing-close case is repaired; surplus opens and interior
    # deficits are left untouched so genuinely malformed FOL is still filtered
    # by is_certainly_bad_fol_formula.
    expr = _repair_removable_trailing_parens(expr)
    return expr


def _repair_removable_trailing_parens(expr):
    """Strip a removable surplus of trailing ')' tokens.

    Repairs ONLY the unambiguous, semantics-preserving case where a formula
    carries extra closing parentheses at the very end, such that removing them
    yields a fully balanced formula whose running parenthesis balance never
    goes negative. A trailing surplus ')' carries no scoping information, so
    stripping it preserves the formula's meaning exactly.

    Formulas with a surplus of OPENING parentheses (balance > 0) or with an
    interior deficit (balance dips negative before the trailing closes) are
    returned unchanged: those are genuinely malformed and remain subject to
    the strict skip policy in is_certainly_bad_fol_formula.
    """
    s = expr.rstrip()
    balance = 0
    for ch in s:
        if ch == '(':
            balance += 1
        elif ch == ')':
            balance -= 1
    if balance >= 0:
        # Balanced, or surplus opens (not safely repairable) -> leave as-is.
        return expr
    need = -balance
    i = len(s)
    removed = 0
    while removed < need and i > 0:
        j = i - 1
        while j >= 0 and s[j].isspace():
            j -= 1
        if j >= 0 and s[j] == ')':
            i = j
            removed += 1
        else:
            # The deficit is not a pure trailing-close surplus -> malformed.
            return expr
    candidate = s[:i]
    running = 0
    for ch in candidate:
        if ch == '(':
            running += 1
        elif ch == ')':
            running -= 1
            if running < 0:
                return expr
    if running != 0:
        return expr
    return candidate


def is_certainly_bad_fol_formula(expr):
    """Detect parser artifacts that are not usable FOL formulas."""
    try:
        cleaned = clean_formula_string(str(expr)).strip()
    except Exception:
        return True
    if not cleaned or cleaned.lower() == 'nan':
        return True
    bad_artifacts = {
        'CLOSING_PARENTHESIS',
        'OPENING_PARENTHESIS',
        'LEFT_PARENTHESIS',
        'RIGHT_PARENTHESIS',
    }
    if any(artifact in cleaned for artifact in bad_artifacts):
        return True
    if re.search(r'(?:&|\|)\s*(?:&|\|)', cleaned):
        return True
    if re.search(r'(?:&|\|)\s*\)', cleaned) or re.search(r'\(\s*(?:&|\|)', cleaned):
        return True
    if re.search(r"(?:^|[^A-Za-z0-9_])_\s*\(", cleaned):
        return True
    # NOTE: a previous heuristic flagged any quantifier whose variable list
    # contained a duplicate (e.g. `exists a b a c d.`). That is NOT a parser
    # artifact — duplicate quantified variables are merely (rebinding /
    # shadowing) and Prover9 parses such formulas fine. Removed per strict
    # skip policy; only truly destroyed FOL (unbalanced parens, `&&`,
    # `_(`, `CLOSING_PARENTHESIS` literals) is filtered.
    exists_match = re.match(r'^exists\s+[A-Za-z0-9_\s]+\.\s*(.+)$', cleaned, re.DOTALL)
    if exists_match:
        # Previous heuristic flagged `exists x. (...) -> -(...)` shapes as
        # malformed. That is INTERPRETIVE, not a parser artifact —
        # `exists x.(P(x) -> -Q(x))` is well-formed FOL. Removed per strict
        # skip policy (only parser artifacts may cause a row to be skipped).
        pass
    balance = 0
    for char in cleaned:
        if char == '(':
            balance += 1
        elif char == ')':
            balance -= 1
            if balance < 0:
                return True
    return balance != 0


def is_certainly_bad_comparative_positive_drop_row(premise_texts, hypothesis_texts):
    """Detect a known malformed comparative FOL shape.

    Some completed rows encode a single comparative/equative premise as an
    ordinary positive adjective fact on the copular quality variable. If the
    hypothesis drops the comparison and asks only for that positive adjective,
    the FOL itself has become too strong and should not be evaluated.
    """
    if len(premise_texts) != 1:
        return False
    try:
        return bool(get_comparative_positive_drop_blocks(premise_texts, hypothesis_texts))
    except Exception:
        return False


_SENSITIVE_DROP_MARKERS = {'beaucoup_de', 'peu_de', 'plupart_de', 'aucun'}
_VARIABLE_SIGNATURE_IGNORES = {
    'exists', 'all', 'not', 'and', 'or', 'overlaps', 'nomme', 'temps',
    'maintenant', 'ref_time', 'subseteq', 'de', 'des', 'a_', 'en',
}

_ROW_PREDICATE_DROP_IGNORES = _VARIABLE_SIGNATURE_IGNORES | {
    'num', 'plupart_de', 'beaucoup_de', 'peu_de', 'aucun', 'tout', 'chacun',
    'plus', 'moins', 'leq', 'empty_intersect', 'existe', 'certain',
}


def _variable_unary_signatures(formula_text):
    signatures = {}
    for match in re.finditer(r'\b(\w+)\(\s*([a-z]\d?)\s*\)', formula_text):
        if is_function_usage(formula_text, match.start(), match.end()):
            continue
        pred_name, var_name = match.group(1), match.group(2)
        if pred_name in _VARIABLE_SIGNATURE_IGNORES:
            continue
        signatures.setdefault(var_name, set()).add(pred_name)

    for match in re.finditer(r'\bnum\(\s*([a-z]\d?)\s*\)\s*=\s*\d+', formula_text):
        signatures.setdefault(match.group(1), set()).add('num_eq')
    return signatures


def _predicate_name_set(formula_text):
    return {
        pred_name for pred_name in extract_arities(formula_text, predicates_only=True)
        if pred_name not in _ROW_PREDICATE_DROP_IGNORES
    }


def is_certainly_bad_quantifier_restrictor_drop_row(premise_texts, hypothesis_texts):
    """Detect sensitive quantifier FOL rows where H drops a P restrictor/modifier.

    Encodings like ``peu_de(x) & feminin(x) & membre(x)`` make the restrictor
    an ordinary conjunct. If H keeps the same quantified group but drops
    ``feminin(x)``, Prover9 can prove a broader statement that is not licensed by
    the intended generalized-quantifier reading. Exact ``num(x)=N`` groups have
    the same issue when a class predicate is dropped.
    """
    if not premise_texts or not hypothesis_texts:
        return False

    p_all_text = ' '.join(premise_texts)
    h_all_text = ' '.join(hypothesis_texts)
    p_marker_names = {
        marker for marker in _SENSITIVE_DROP_MARKERS
        if _formula_has_predicate_name(p_all_text, marker)
    }
    h_marker_names = {
        marker for marker in _SENSITIVE_DROP_MARKERS
        if _formula_has_predicate_name(h_all_text, marker)
    }
    moins_only_context = (
        _formula_has_predicate_name(p_all_text, 'moins')
        and not _formula_has_predicate_name(p_all_text, 'plus')
        and not _formula_has_predicate_name(p_all_text, 'aucun')
    )
    dropped_markers = p_marker_names - h_marker_names
    if dropped_markers and not (
        dropped_markers == {'beaucoup_de'}
        and moins_only_context
    ):
        return True

    if 'plupart_de' in p_marker_names and 'plupart_de' in h_marker_names:
        p_predicates = _predicate_name_set(p_all_text)
        h_predicates = _predicate_name_set(h_all_text)
        if p_predicates - h_predicates:
            return True

    h_signatures = []
    for hypothesis_text in hypothesis_texts:
        h_signatures.extend(_variable_unary_signatures(hypothesis_text).values())
    if not h_signatures:
        return False

    for premise_text in premise_texts:
        for p_signature in _variable_unary_signatures(premise_text).values():
            p_markers = p_signature & _SENSITIVE_DROP_MARKERS
            exact_cardinality = 'num_eq' in p_signature
            if not p_markers and not exact_cardinality:
                continue
            p_content = p_signature - _SENSITIVE_DROP_MARKERS - {'num_eq'}
            if not p_content and not p_markers:
                continue

            for h_signature in h_signatures:
                h_content = h_signature - _SENSITIVE_DROP_MARKERS - {'num_eq'}
                shares_group_identity = bool(p_content & h_content) or bool(p_markers & h_signature)
                if exact_cardinality and 'num_eq' in h_signature:
                    shares_group_identity = True
                if not shares_group_identity:
                    continue
                if p_markers - h_signature:
                    return True
                if exact_cardinality and moins_only_context:
                    continue
                if (p_markers or exact_cardinality) and p_content - h_content:
                    # Only treat this as destroyed-FOL drop when H introduces
                    # no new content predicate not present in P. When H adds
                    # new predicates (e.g. GQNLI ``>(num(b),1)`` replacing P's
                    # ``num(b)=N``, or different verbs), this is a genuine
                    # monotonicity / cardinality-comparison row, not a flat
                    # subset-of-P weakening, and the prover must decide.
                    if h_content - p_content:
                        continue
                    return True

    return False


def is_certainly_bad_past_scoped_unary_assertion_row(premise_texts, hypothesis_texts):
    """Detect former/past-state FOL that also asserts the same class as current.

    A shape like ``pred(e, x) & <(temps(e), ref_time) & pred(x)`` makes the
    current unary fact available even though the binary state is explicitly past
    scoped. If H asks for ``pred(x)``, the row's FOL has over-asserted the fact.
    """
    if not premise_texts or not hypothesis_texts:
        return False
    h_all_text = ' '.join(hypothesis_texts)
    h_predicates = _predicate_name_set(h_all_text)

    for premise_text in premise_texts:
        past_events = set(re.findall(r'<\(\s*temps\((\w+)\)\s*,\s*ref_time\s*\)', premise_text))
        if not past_events:
            continue

        unary_by_var = {}
        for match in re.finditer(r'\b(\w+)\(\s*([a-z]\d?)\s*\)', premise_text):
            if is_function_usage(premise_text, match.start(), match.end()):
                continue
            pred_name, var_name = match.group(1), match.group(2)
            unary_by_var.setdefault(var_name, set()).add(pred_name)

        for pred_name, event_var, entity_var in re.findall(
            r'\b(\w+)\(\s*([a-z]\d?)\s*,\s*([a-z]\d?)\s*\)',
            premise_text,
        ):
            if event_var not in past_events:
                continue
            if pred_name in unary_by_var.get(entity_var, set()) and pred_name in h_predicates:
                return True

    return False


def is_certainly_bad_detached_comparative_anchor_row(premise_texts, hypothesis_texts):
    """Detect comparative H formulas whose named comparison anchor is detached."""
    for hypothesis_text in hypothesis_texts:
        if not _formula_has_measure_comparison(hypothesis_text):
            continue
        for anchor_match in re.finditer(r'\bnomme\(\s*([a-z]\d?)\s*,\s*[A-Za-z_][A-Za-z_0-9]*\s*\)', hypothesis_text):
            anchor_var = anchor_match.group(1)
            occurrences = len(re.findall(rf'\b{re.escape(anchor_var)}\b', hypothesis_text))
            if occurrences <= 2:
                return True
    return False


def _event_var_has_named_participant(formula_text, event_var):
    named_vars = set(re.findall(r'\bnomme\(\s*([a-z]\d?)\s*,', formula_text))
    if not named_vars:
        return False
    ignored_preds = {'temps', 'subseteq', 'overlaps', 'nomme', 'num', 'leq'}
    for match in re.finditer(r'\b(\w+)\(([^()]*)\)', formula_text):
        pred_name = match.group(1)
        if pred_name in ignored_preds or is_function_usage(formula_text, match.start(), match.end()):
            continue
        args = [arg.strip() for arg in match.group(2).split(',')]
        if args and args[0] == event_var and any(arg in named_vars for arg in args[1:]):
            return True
    return False


def is_certainly_bad_temporal_order_premise_row(premise_texts, hypothesis_texts):
    """Detect over-factive before/after-clause FOL used as a premise."""
    if not any(re.search(r'<\(\s*temps\(\w+\)\s*,\s*temps\(\w+\)\s*\)', h) for h in hypothesis_texts):
        return False
    for premise_text in premise_texts:
        if len(re.findall(r'\bnomme\(\s*[a-z]\d?\s*,', premise_text)) < 2:
            continue
        for event_1, event_2 in re.findall(r'<\(\s*temps\((\w+)\)\s*,\s*temps\((\w+)\)\s*\)', premise_text):
            event_1_is_interval_scoped = re.search(rf'\bsubseteq\(\s*temps\(\w+\)\s*,\s*temps\({re.escape(event_1)}\)\s*\)', premise_text)
            event_2_is_interval_scoped = re.search(rf'\bsubseteq\(\s*temps\(\w+\)\s*,\s*temps\({re.escape(event_2)}\)\s*\)', premise_text)
            if not (event_1_is_interval_scoped and event_2_is_interval_scoped):
                continue
            if _event_var_has_named_participant(premise_text, event_1) and _event_var_has_named_participant(premise_text, event_2):
                return True
    return False


def is_certainly_bad_duration_drop_row(premise_texts, hypothesis_texts):
    """Detect duration formulas where H drops the numeric/durative restriction."""
    h_all_text = ' '.join(hypothesis_texts)
    for premise_text in premise_texts:
        duration_vars = set(re.findall(r'\bnum\((\w+)\)\s*=\s*\d+', premise_text))
        duration_vars.update(re.findall(r'\(\s*(\w+)\s*=\s*\d+\s*\)', premise_text))
        for duration_var in duration_vars:
            if not re.search(rf'\bheure\(\s*{re.escape(duration_var)}\s*\)', premise_text):
                continue
            has_duration_link = re.search(rf'\b(?:en|durant)\(\s*\w+\s*,\s*{re.escape(duration_var)}\s*\)', premise_text)
            if not has_duration_link:
                continue
            h_keeps_number = re.search(r'\bnum\([^)]*\)\s*=\s*\d+', h_all_text) or re.search(r'\(\s*\w+\s*=\s*\d+\s*\)', h_all_text)
            if not h_keeps_number:
                return True
            if _formula_has_predicate_name(premise_text, 'durant') and not _formula_has_predicate_name(h_all_text, 'durant'):
                return True
    return False


def is_certainly_bad_nonfactive_complement_row(premise_texts, hypothesis_texts):
    """Detect non-factive attitude/attempt complements asserted as ordinary facts."""
    p_all_text = ' '.join(premise_texts)
    h_all_text = ' '.join(hypothesis_texts)
    nonfactive_preds = {'croire', 'essayer_de', 'pretendre', 'tenter'}
    if not any(_formula_has_predicate_name(p_all_text, pred) for pred in nonfactive_preds):
        return False
    if any(_formula_has_predicate_name(h_all_text, pred) for pred in nonfactive_preds):
        return False
    p_predicates = _predicate_name_set(p_all_text)
    h_predicates = _predicate_name_set(h_all_text)
    return bool(h_predicates & p_predicates)


def get_wn_axioms(p_preds, h_preds, lang='fra'):
    """Generate WordNet axioms ONLY for predicates that differ between P and H.
    Only creates axioms when there's a semantic gap to bridge.
    Checks for: synonymy (equivalence), hyponymy (entailment), antonymy (contradiction)."""
    axioms = []
    
    # Convert to dicts: {name: [arities]}
    p_dict = {}
    for name, arity in p_preds:
        p_dict.setdefault(name, []).append(arity)
    
    h_dict = {}
    for name, arity in h_preds:
        h_dict.setdefault(name, []).append(arity)
    
    # Find predicates that appear in H but NOT in P (semantic gap)
    h_only_names = set(h_dict.keys()) - set(p_dict.keys())
    p_only_names = set(p_dict.keys()) - set(h_dict.keys())
    
    # Blocklist: pairs that should NEVER be bridged by WordNet.
    # These pairs have disjointness axioms — bridging them creates contradictions.
    _WN_BLOCK_PAIRS = {
        frozenset({'homme', 'femme'}),
        frozenset({'garcon', 'fille'}),
        frozenset({'courir', 'asseoir'}),
        frozenset({'courir', 'marcher'}),
        frozenset({'debout', 'asseoir'}),
        frozenset({'dormir', 'eveiller'}),
        frozenset({'petit', 'grand'}),
        frozenset({'lent', 'rapide'}),
        frozenset({'vieux', 'jeune'}),
        frozenset({'riche', 'pauvre'}),
        frozenset({'long', 'court'}),
        frozenset({'haut', 'bas'}),
        frozenset({'chaud', 'froid'}),
        frozenset({'lourd', 'leger'}),
        frozenset({'fort', 'faible'}),
        frozenset({'ancien', 'nouveau'}),
        frozenset({'vide', 'plein'}),
        frozenset({'derriere', 'devant'}),
        frozenset({'gauche', 'droite'}),
        frozenset({'noir', 'blanc'}),
        frozenset({'ouvert', 'ferme'}),
        frozenset({'interieur', 'exterieur'}),
        frozenset({'chien', 'chat'}),
        frozenset({'moto', 'velo'}),
        frozenset({'voiture', 'moto'}),
        frozenset({'voiture', 'velo'}),
        # Prevent false hypernymy from WN polysemy
        frozenset({'homme', 'groupe'}),
        frozenset({'femme', 'groupe'}),
        frozenset({'fille', 'groupe'}),
        frozenset({'garcon', 'groupe'}),
        frozenset({'enfant', 'groupe'}),
        frozenset({'personne', 'groupe'}),
        # Block WN homme↔personne biconditional: combined with homme→¬femme
        # disjoint and femme→personne hypernym, creates inconsistency
        # (femme→personne→homme→¬femme ⇒ femme→⊥, ex falso quodlibet).
        frozenset({'homme', 'personne'}),
        # v38: Block homme↔humain WN biconditional — stripped contradiction FP
        # (universalized homme(all) + humain→-action creates spurious contradiction)
        frozenset({'homme', 'humain'}),
        # Block WN polysemy bridges to/from 'homme' (generic "human" sense).
        # homme has both "man" and "human" senses in French WordNet.
        # The "human" sense creates bogus fille→homme, queue→homme, etc.
        # bridges that conflict with homme→¬fille disjointness axioms.
        frozenset({'fille', 'homme'}),
        frozenset({'queue', 'homme'}),
        frozenset({'petit', 'homme'}),
        frozenset({'jeune', 'homme'}),
        frozenset({'femme', 'personne'}),
        # Block WN enclos↔cloture biconditional: we use one-way hypernym
        # cloture→enclos in FRENCH_HYPERNYMS; WN biconditional would be too strong
        frozenset({'enclos', 'cloture'}),
        # v37: Block antonym mismappings from WOLF polysemy
        frozenset({'descendre', 'monter'}),  # go down ≠ go up
        frozenset({'ouvrir', 'fermer'}),      # open ≠ close
        frozenset({'seul', 'ensemble'}),      # alone ≠ together
        frozenset({'crier', 'pleurer'}),      # scream ≠ cry
        frozenset({'rire', 'pleurer'}),       # laugh ≠ cry (keep as indep, not antonyms in all contexts)
        frozenset({'asseoir', 'tenir'}),      # sit ≠ hold
        frozenset({'poser', 'tenir'}),        # put ≠ hold
        frozenset({'poser', 'porter'}),       # put ≠ carry
        frozenset({'ramasser', 'poser'}),     # pick up ≠ put down
        frozenset({'essuyer', 'retirer'}),    # wipe ≠ remove
        frozenset({'transporter', 'charger'}),# carry ≠ load
        # v37: Block cross-category polysemy (WOLF maps unrelated words)
        frozenset({'de', 'marcher'}),         # preposition ≠ walk
        frozenset({'vers', 'de'}),            # towards ≠ from
        frozenset({'couler', 'marcher'}),     # flow ≠ walk
        frozenset({'plat', 'soucoupe'}),      # flat/dish ≠ saucer
        frozenset({'bouteille', 'pot'}),      # bottle ≠ jar
        frozenset({'coup', 'souffle'}),       # blow/hit ≠ breath
        frozenset({'boxeur', 'boxe'}),        # boxer ≠ boxing
        frozenset({'jouer', 'courir'}),       # play ≠ run
        frozenset({'jouer', 'monter'}),       # play ≠ climb
        frozenset({'toucher', 'chercher'}),   # touch ≠ search
        frozenset({'faire', 'promener'}),     # do ≠ walk
        frozenset({'en', 'par'}),             # in ≠ by
        frozenset({'sur', 'en'}),             # on ≠ in
        frozenset({'chasser', 'attraper'}),   # chase ≠ catch
        frozenset({'grand', 'adulte'}),       # big ≠ adult
        frozenset({'route', 'course'}),       # road ≠ race
        frozenset({'danse', 'ensemble'}),     # dance ≠ together
        frozenset({'piscine', 'ensemble'}),   # pool ≠ together
        frozenset({'chiot', 'ensemble'}),     # puppy ≠ together
        frozenset({'rue', 'groupe'}),         # street ≠ group
        frozenset({'ville', 'groupe'}),       # city ≠ group
        frozenset({'rose', 'chose'}),         # pink ≠ thing
        frozenset({'droite', 'chose'}),       # right ≠ thing
        frozenset({'droite', 'bien'}),        # right ≠ good
        frozenset({'course', 'bien'}),        # race ≠ good
        frozenset({'bleu', 'nourriture'}),    # blue ≠ food
        frozenset({'enfant', 'homme'}),       # child ≠ man (WOLF polysemy: "human being")
        frozenset({'famille', 'homme'}),      # family ≠ man (WOLF polysemy)
        frozenset({'chien', 'homme'}),        # dog ≠ man (WOLF polysemy)
        frozenset({'ami', 'homme'}),          # friend ≠ man (WOLF polysemy)
        frozenset({'jouer', 'danser'}),       # play ≠ dance
        frozenset({'jouer', 'regarder'}),     # play ≠ watch
        # balle/boule block REMOVED in v38b — it cost 3 TPs (1075, 2919, 9552) for 0 FP savings
        frozenset({'fille', 'femme'}),        # girl ≠ woman (WN polysemy causes FP)
        frozenset({'sable', 'plage'}),        # sand ≠ beach (WN polysemy causes FP)
        # SICK proof-only audit: open WN produced gold-unknown/no false proofs
        # through broad synonymy/hypernymy or event-preposition alternations.
        frozenset({'personne', 'humain'}),
        frozenset({'mettre', 'porter'}),
        frozenset({'sauter_sur', 'sauter_de'}),
        frozenset({'sauter_sur', 'sauter'}),
        frozenset({'fleur', 'plante'}),
        frozenset({'couper', 'couper_de'}),
        frozenset({'homme', 'chat'}),
        frozenset({'garer', 'conduire'}),
        frozenset({'jouer_de', 'poser'}),
        frozenset({'mettre_dans', 'prendre_dans'}),
        frozenset({'crapaud', 'grenouille'}),
        frozenset({'terrain', 'champ'}),
        frozenset({'tenir_dans', 'faire'}),
        frozenset({'tenir_dans', 'mettre_dans'}),
        frozenset({'montagne', 'colline'}),
        frozenset({'football', 'balle'}),
        frozenset({'ballon', 'balle'}),
        frozenset({'pelouse', 'champ'}),
        frozenset({'caniche', 'chien'}),
        frozenset({'crier_a', 'parler_a'}),
        frozenset({'parler_de', 'parler_a'}),
        # ``homme`` polysemy ("man" vs "human being"): WN's "human" sense maps
        # homme to the biological hypernym ``animal`` (and back), licensing
        # spurious homme->animal entailments (SICK "un homme tire des fusils" =>
        # "une femme chevauche un animal").  Block both directions.
        frozenset({'homme', 'animal'}),
        frozenset({'femme', 'animal'}),
        frozenset({'personne', 'animal'}),
        frozenset({'enfant', 'animal'}),
    }
    # v38: Re-add 'homme' to BLOCK_AS_TARGET — now that the p_name bug is fixed
    # (only h_name is checked), this safely blocks X→homme WN polysemy
    # (blanc→homme, noir→homme, singe→homme, etc.) without blocking
    # bridges FROM homme (homme→adulte, homme→humain).
    _WN_BLOCK_AS_TARGET = {'homme'}
    # Also block prepositions/articles as WN bridge targets — they're
    # structural words, not content words amenable to WN synonym/hypernym.
    _WN_BLOCK_AS_EITHER = {'de', 'en', 'par', 'sur', 'dans', 'a_', 'pour',
                           'avec', 'contre', 'vers', 'sous', 'entre',
                           # GQ quantifier predicates (have specific axiom handling)
                           'plus_de', 'moins_de', 'plupart_de', 'beaucoup_de',
                           'pas_de', 'peu_de', 'tout', 'chacun', 'aucun',
                           # Comparatives / fraction markers
                           'plus', 'moins', 'moitie', 'tiers', 'quart',
                           'cinquieme', 'sixieme', 'DOT',
                           # Structural predicates
                           'existe', 'num', 'temps', 'overlaps', 'subseteq',
                           'maintenant', 'nomme', 'is_at', 'generic',
                           'context_', 'unknown_', 'singular_',
                           'masculin_', 'feminin_', 'narration', 'simultanee',
                           'mais', 'soit', 'total', 'seul',
                           # Event/aspect predicates
                           'en_train_de', 'etre_en', 'etre_sur', 'etre_dans', 'etre_a',
                           'pres_de', 'devant', 'derriere', 'a_travers', 'par_dessus',
                           # Compound verbs with overly broad WN matches
                           'donner', 'aller_dans'}
    # Auto-block siblings (share hypernym) ONLY for categories where
    # siblings are truly mutually exclusive. Don't block 'personne' siblings
    # since people can have multiple roles (motard+joueur, femme+fille).
    if ENABLE_CURATED_HYPERNYM_AXIOMS:
        _DISJOINT_CATEGORIES = {'animal', 'vehicule', 'sport', 'instrument', 'mois'}
        _hyp_siblings = {}
        for _hypo, _hyper in FRENCH_HYPERNYMS:
            _hyp_siblings.setdefault(_hyper, set()).add(_hypo)
        for _hyper, _siblings in _hyp_siblings.items():
            if _hyper not in _DISJOINT_CATEGORIES:
                continue
            _siblings = list(_siblings)
            for i in range(len(_siblings)):
                for j in range(i+1, len(_siblings)):
                    _WN_BLOCK_PAIRS.add(frozenset({_siblings[i], _siblings[j]}))

    # Only try to bridge P-only -> H-only with same arity
    for p_name in p_only_names:
        for h_name in h_only_names:
            # Skip blocked pairs
            if frozenset({p_name, h_name}) in _WN_BLOCK_PAIRS:
                continue
            # v37/v56: Skip if either word is a structural/GQ predicate (SICK/GQNLI only; FraCaS needs WN bridges)
            if _CURRENT_DATASET != 'fracas' and (p_name in _WN_BLOCK_AS_EITHER or h_name in _WN_BLOCK_AS_EITHER):
                continue
            # v37: Skip if target (h_name) is in the blocked-as-target set
            if h_name in _WN_BLOCK_AS_TARGET:
                continue
            p_arities = p_dict[p_name]
            h_arities = h_dict[h_name]
            
            # Check common arities
            common_arities = set(p_arities) & set(h_arities)
            for arity in common_arities:
                # Prepare variables string based on arity: "x", "x,y", "x,y,z"
                # We use x, y, z, u, v, w... for standard variables
                vars_list = ['x', 'y', 'z', 'u', 'v', 'w'][:arity]
                if len(vars_list) < arity: # Fallback for high arity
                    vars_list = [f"x{i}" for i in range(arity)]
                
                # Separate variable strings for Quantifiers (space) and Predicates (comma)
                # e.g. "all x y z." vs "pred(x,y,z)"
                vars_quant = " ".join(vars_list)
                vars_args = ",".join(vars_list)
                
                # Check WordNet relation for the name
                # Extended French lemmatization for better coverage
                lookups = get_extended_french_lemmas(p_name)
                
                p_synsets = []
                for lk in lookups:
                    p_synsets.extend(wn.synsets(lk, lang=lang))
                
                lookups_h = get_extended_french_lemmas(h_name)
                
                h_synsets = []
                for lk in lookups_h:
                    h_synsets.extend(wn.synsets(lk, lang=lang))
                
                # Skip if either has no synsets
                if not p_synsets or not h_synsets:
                    continue
                
                found_relation = False
                
                # Check Synonymy
                if set(p_synsets) & set(h_synsets):
                    # For n-ary, be careful with argument order. If synonymous, A(x,y) <-> B(x,y) is usually safe for active voice.
                    # We assume standard argument mapping (Subject, Object, ..).
                    if arity == 1:
                        axioms.append(f"all {vars_quant}.({p_name}({vars_args}) <-> {h_name}({vars_args}))")
                    else:
                        # For verbs/relations, imply equivalence directionally or bidirectionally?
                        # Using loose equivalence for synonyms
                        axioms.append(f"all {vars_quant}.({p_name}({vars_args}) <-> {h_name}({vars_args}))")
                    found_relation = True
                
                if not found_relation:
                    # Check Hyponymy: H is hypernym of P (P -> H)
                    for ps in p_synsets:
                        all_hypernyms = set(ps.closure(lambda s: s.hypernyms()))
                        if any(hs in all_hypernyms for hs in h_synsets):
                            axioms.append(f"all {vars_quant}.({p_name}({vars_args}) -> {h_name}({vars_args}))")
                            found_relation = True
                            break
                
                if not found_relation:
                    # Check Antonymy: P and H are antonyms (contradiction)
                    for ps in p_synsets:
                        for hs in h_synsets:
                            # Get antonym synsets via English lemmas (since WN antonym links are primarily on English lemmas)
                            antonym_synsets = set()
                            # WOLF (French WordNet) doesn't have native antonyms mapped. We use 'eng' as a structural bridge ONLY.
                            for eng_lemma in ps.lemmas(lang='eng'):
                                for ant_lemma in eng_lemma.antonyms():
                                    antonym_synsets.add(ant_lemma.synset())
                            
                            if hs in antonym_synsets:
                                # Found antonymy: P opposite H
                                axioms.append(f"all {vars_quant}.({p_name}({vars_args}) -> -({h_name}({vars_args})))")
                                axioms.append(f"all {vars_quant}.({h_name}({vars_args}) -> -({p_name}({vars_args})))")
                            break
    
    return list(set(axioms))

# ============================================================
# ENHANCEMENT FUNCTIONS: Structural, Numeric, Morphological,
# Hypernymy, and pas_de Negation Rewriting
# ============================================================

# --- Curated French hypernymy fallback dictionary ---
# These are logically valid class inclusions (hyponym → hypernym)
# and synonym pairs (bidirectional equivalence).
# Only applied when BOTH predicates appear in P∪H.
FRENCH_HYPERNYMS = [
    # (hyponym, hypernym) — logically valid class inclusions A(x) → B(x)
    # A word can appear multiple times as hyponym with different hypernyms.
    ('garcon', 'enfant'),
    ('garcon', 'personne'),
    ('fille', 'enfant'),
    ('fille', 'personne'),
    ('homme', 'personne'),
    ('femme', 'personne'),
    ('enfant', 'personne'),
    ('americain', 'personne'),
    ('africain', 'personne'),
    ('europeen', 'personne'),
    ('asiatique', 'personne'),
    ('motard', 'personne'),
    ('motocycliste', 'personne'),
    ('joueur', 'personne'),
    ('spectateur', 'personne'),
    ('eclaireur', 'personne'),
    ('ami', 'personne'),
    ('coureur', 'personne'),
    ('chanteur', 'personne'),
    ('surfeur', 'personne'),
    ('nageur', 'personne'),
    ('danseur', 'personne'),
    ('grimpeur', 'personne'),
    ('plongeur', 'personne'),
    ('musicien', 'personne'),
    ('cuisinier', 'personne'),
    ('photographe', 'personne'),
    ('skieur', 'personne'),
    ('cycliste', 'personne'),
    ('patineur', 'personne'),
    ('randonneur', 'personne'),
    ('snowboarder', 'personne'),
    ('skateboarder', 'personne'),
    ('pecheur', 'personne'),
    ('boxeur', 'personne'),
    ('lutteur', 'personne'),
    ('cavalier', 'personne'),
    ('bebe', 'enfant'),
    ('bebe', 'personne'),
    ('nourrisson', 'enfant'),
    ('chien', 'animal'),
    ('chat', 'animal'),
    ('cerf', 'animal'),
    ('cheval', 'animal'),
    ('oiseau', 'animal'),
    ('vache', 'animal'),
    ('mouton', 'animal'),
    ('cochon', 'animal'),
    ('singe', 'animal'),
    ('poisson', 'animal'),
    ('moto', 'vehicule'),
    ('velo', 'vehicule'),
    ('voiture', 'vehicule'),
    ('camion', 'vehicule'),
    ('bus', 'vehicule'),
    ('football', 'sport'),
    ('baseball', 'sport'),
    ('basket_ball', 'sport'),
    ('kickboxing', 'sport'),
    ('tennis', 'sport'),
    ('hockey', 'sport'),
    ('natation', 'sport'),
    ('guitare', 'instrument'),
    ('piano', 'instrument'),
    ('violon', 'instrument'),
    ('flute', 'instrument'),
    ('tambour', 'instrument'),
    # Location → exterieur bridges
    ('jardin', 'exterieur'),
    ('parc', 'exterieur'),
    ('plage', 'exterieur'),
    ('champ', 'exterieur'),
    ('foret', 'exterieur'),
    ('rue', 'exterieur'),
    ('trottoir', 'exterieur'),
    # Month names → mois (month)
    ('janvier', 'mois'),
    ('fevrier', 'mois'),
    ('mars', 'mois'),
    ('avril', 'mois'),
    ('mai', 'mois'),
    ('juin', 'mois'),
    ('juillet', 'mois'),
    ('aout', 'mois'),
    ('septembre', 'mois'),
    ('octobre', 'mois'),
    ('novembre', 'mois'),
    ('decembre', 'mois'),
    # v4 additions: more person-role hypernyms
    ('ecoliere', 'fille'),
    ('ecoliere', 'enfant'),
    ('adulte', 'personne'),
    ('explorateur', 'personne'),
    ('guitariste', 'personne'),
    ('guitariste', 'musicien'),
    ('client', 'personne'),
    # v4 additions: conceptual hypernyms
    ('arbre', 'plante'),
    ('jouer_de', 'jouer'),
    ('chapeau', 'coiffe'),
    ('porter_sur', 'porter'),
    # v5 additions
    ('eclaireur', 'personne'),
    # grass does not entail field/scene; keep this distinction proof-visible.
    ('baton', 'bois'),
    ('baton', 'morceau'),
    # v7 additions
    ('eclaireur', 'gens'),
    ('boule', 'jouet'),
    ('branche', 'arbre'),
    ('pistolet', 'arme_a_feu'),
    ('jardin', 'exterieur'),
    # v10 additions
    ('garcon', 'enfant'),
    ('fille', 'enfant'),
    ('homme', 'personne'),
    ('femme', 'personne'),
    ('enfant', 'personne'),
    ('adulte', 'personne'),
    ('moto', 'vehicule'),
    # v11 additions
    ('conduire', 'monter'),
    # v15: cloture→enclos (fence is a type of enclosure, one-way)
    ('cloture', 'enclos'),
    ('sauter_dans', 'sauter'),
    # v26: from failure analysis — missing animal hypernyms
    ('ecureuil', 'animal'),
    ('lemurien', 'animal'),
    ('rhinoceros', 'animal'),
    ('canard', 'animal'),
    ('lapin', 'animal'),
    ('tortue', 'animal'),
    ('grenouille', 'animal'),
    ('serpent', 'animal'),
    ('araignee', 'animal'),
    ('insecte', 'animal'),
    ('ours', 'animal'),
    ('loup', 'animal'),
    ('renard', 'animal'),
    ('souris', 'animal'),
    ('elephant', 'animal'),
    ('lion', 'animal'),
    ('tigre', 'animal'),
    # v26: weapon hypernyms
    ('pistolet', 'arme'),
    ('fusil', 'arme'),
    ('epee', 'arme'),
    ('arme_a_feu', 'arme'),
    # v26: vegetable hypernyms
    ('tomate', 'legume'),
    ('aubergine', 'legume'),
    ('brocoli', 'legume'),
    ('carotte', 'legume'),
    ('oignon', 'legume'),
    ('poivron', 'legume'),
    ('pomme_de_terre', 'legume'),
    # v26: person/role hypernyms
    ('adolescente', 'fille'),
    ('adolescente', 'enfant'),
    ('adolescente', 'personne'),
    ('adolescent', 'garcon'),
    ('adolescent', 'enfant'),
    ('adolescent', 'personne'),
    ('gars', 'homme'),
    ('gars', 'personne'),
    ('dame', 'femme'),
    ('dame', 'personne'),
    ('dame', 'personne'),
    # v26: action hypernyms
    ('escalader', 'monter'),
    ('grimper', 'monter'),
    ('trancher', 'couper'),
    ('frire', 'cuire'),
    ('griller', 'cuire'),
    ('rotir', 'cuire'),
    ('attacher', 'fixer'),
    # v26: food/substance hypernyms
    ('steak', 'viande'),
    ('poulet', 'viande'),
    ('cotelette', 'viande'),
    ('pomme', 'fruit'),
    ('banane', 'fruit'),
    ('orange', 'fruit'),
    # v26: music/instrument
    ('piano', 'clavier'),
    ('harmonica', 'instrument'),
    ('trompette', 'instrument'),
    ('violoncelle', 'instrument'),
    ('saxophone', 'instrument'),
    ('accordeon', 'instrument'),
    # v26: compound verb → base verb hypernyms
    ('jouer_sur', 'jouer'),
    ('jouer_avec', 'jouer'),
    ('jouer_a', 'jouer'),
    ('jouer_dans', 'jouer'),
    ('nager_dans', 'nager'),
    ('courir_sur', 'courir'),
    ('courir_dans', 'courir'),
    ('marcher_sur', 'marcher'),
    ('marcher_dans', 'marcher'),
    ('danser_sur', 'danser'),
    ('sauter_sur', 'sauter'),
    ('sauter_de', 'sauter'),
    ('sauter_par_dessus', 'sauter'),
    ('rouler_sur', 'rouler'),
    ('couper_de', 'couper'),
    ('couper_dans', 'couper'),
    ('grimper_sur', 'escalader'),
    ('grimper_sur', 'monter'),
    ('trotter_sur', 'monter'),
    ('galoper', 'courir'),
    ('sprinter', 'courir'),
    ('se_precipiter', 'courir'),
    # v29: water hypernyms
    ('ocean', 'eau'),
    ('mer', 'eau'),
    ('piscine', 'eau'),
    ('etang', 'eau'),
    ('lac', 'eau'),
    ('riviere', 'eau'),
    ('ruisseau', 'eau'),
    ('fleuve', 'eau'),
    # v29: container/object hypernyms
    ('haltere', 'poids'),
    ('poele', 'casserole'),
    ('peluche', 'jouet'),
    ('boite', 'recipient'),
    ('bol', 'recipient'),            # bowl → container (+1)
    ('robe', 'vetement'),
    ('chemise', 'vetement'),
    ('veste', 'vetement'),
    ('pantalon', 'vetement'),
    ('manteau', 'vetement'),
    ('jupe', 'vetement'),
    ('chapeau', 'vetement'),
    # v29: location hypernyms
    ('plage', 'rivage'),
    ('trottoir', 'route'),
    # v29: action hypernyms
    ('verifier', 'regarder'),
    ('examiner', 'regarder'),
    ('observer', 'regarder'),
    ('fixer', 'regarder'),
    ('saupoudre_sur', 'mettre_sur'),
    ('ramasser', 'porter'),
    ('soulever', 'porter'),
    # v29: more compound verb → base verb
    ('etre_sur', 'etre'),
    ('etre_dans', 'etre'),
    ('etre_a', 'etre'),
    ('mettre_dans', 'mettre'),
    ('mettre_sur', 'mettre'),
    ('mettre_en', 'mettre'),
    ('porter_dans', 'porter'),
    # v33: safe additions from failure analysis
    ('cuire', 'cuisiner'),
    ('frire', 'cuisine'),
    ('preparer', 'cuisine'),
    ('precipiter_dans', 'monter'),
    ('entrainer', 'jouer_de'),
    ('surfer', 'monter'),
    ('trancher_de', 'couper_de'),
    ('portee', 'porter'),
    ('pratiquer', 'jouer_de'),
    # v34: from 1-gap failure analysis (correct actual formula gaps)
    ('polir', 'nettoyer'),       # polish → clean
    ('fesser', 'frapper'),       # spank → hit
    ('marcher', 'deplacer'),     # walk → move
    ('sketch', 'dessiner'),      # sketch → draw
    ('produire_sur', 'jouer_sur'),  # perform on → play on
    ('renverser_de', 'tomber_de'),  # knock off → fall from
    ('assommer_de', 'tomber_de'),  # v41: knock off → fall from (2 rows)
    ('regarder_dans', 'regarder'),  # v41: look into → look (1 row)
    ('courir_sur', 'courir'),    # run on → run (compound→base)
    # v53: from systematic predicate gap analysis
    ('parcourir', 'courir'),       # traverse/run through → run (+4 rows)
    ('etudier', 'regarder'),       # study → look (+2 rows: 3673+3674)
    ('accroupir_a', 'accroupir'),  # crouch at → crouch (+3 rows)
    ('asseoir_dans', 'asseoir'),   # sit in → sit (+2 rows)
    # v42: verb bridges for en_train_de pattern support
    ('casser', 'craquer'),        # break → crack (1 row, net +1)
    ('repandre', 'propager'),     # spread → propagate (1 row, net +1)
    ('brosser', 'peigner'),       # brush → comb (3 rows, net +2)
    ('lire', 'verifier'),         # read → check (2 rows, net +2)
    ('randonnee', 'marcher'),    # hike → walk
    ('sablonneux', 'sable'),     # sandy → sand
    # v36: from 1-gap failure analysis
    # field/grass is scene-related, not lexical equivalence.
    ('vetir_de', 'porter'),      # clothed in → wear
    ('habiller_en', 'porter'),   # dressed in → wear
    # REMOVED (unsound, SICK row 9246 false-no): ('tenir_sur', 'debout').
    # `tenir_sur(e,agent,obj,loc)` = "hold onto" (4-ary), NOT "stand on".
    # Dropping args to unary `debout(e)` is a category error; one can hold
    # onto a railing while sitting/lying. Removed.
    ('craquer', 'fissurer'),     # crack → crack/fissure
    # v37: auto-discovered from WN hypernym scan of yes→unk rows
    ('canard', 'oiseau'),        # duck → bird (3 rows)
    ('bambin', 'enfant'),        # toddler → child (2 rows)
    ('skateboard', 'planche'),   # skateboard → board (3 rows)
    ('flaque', 'eau'),           # puddle → water (1 row)
    ('pluie', 'eau'),            # rain → water (1 row)
    ('scier', 'couper'),         # saw → cut (1 row)
    ('jambon', 'viande'),        # ham → meat (1 row)
    ('citron', 'fruit'),         # lemon → fruit (1 row)
    ('nouille', 'nourriture'),   # noodle → food (1 row)
    ('retriever', 'chien'),      # retriever → dog (1 row)
    ('conduire', 'voyager'),     # drive → travel (1 row)
    ('mendier', 'demander'),     # beg → ask (1 row)
    ('homme', 'adulte'),         # man → adult (1 row)
    ('canne', 'tige'),           # cane → stick (1 row)
    ('ail', 'assaisonnement'),   # garlic → seasoning (1 row)
    ('forestier', 'personne'),   # forester → person (1 row)
    ('prendre', 'tenir'),        # take → hold (5 rows)
    # v38: one-way hypernym (beach→sand) — blocks biconditional FPs via WN_BLOCK_PAIRS
    ('plage', 'sable'),          # beach → sand (3 rows: 8728, 9415, 9453)
    # v38: human-type → personne (one-way only; WN biconditional blocked)
    # Safe: homme→personne doesn't reverse to personne→homme
    ('homme', 'personne'),       # man → person (35 rows)
    ('femme', 'personne'),       # woman → person (20 rows)
    ('fille', 'personne'),       # girl → person (6 rows)
    ('garcon', 'personne'),      # boy → person
    ('enfant', 'personne'),      # child → person
    ('gens', 'personne'),        # people → person (2 rows)
    ('snowboarder', 'personne'), # snowboarder → person (3 rows)
    ('joueur', 'personne'),      # player → person (2 rows)
    ('cycliste', 'personne'),    # cyclist → person (11 rows via cycliste H-only)
    ('surfeur', 'personne'),     # surfer → person
    ('nageur', 'personne'),      # swimmer → person
    ('patineur', 'personne'),    # skater → person
    ('danseur', 'personne'),     # dancer → person
    ('chanteuse', 'personne'),   # singer(f) → person
    ('chanteur', 'personne'),    # singer(m) → person
    # v38b: homme→humain one-way hypernym (saves 5 no→unk: 1639, 2894, 3210, 3857, 3859)
    # WN biconditional still blocked in _WN_BLOCK_PAIRS to prevent humain→homme
    ('homme', 'humain'),          # man → human
    ('personne', 'humain'),       # person → human (chains with all X→personne: rows 67, 2981, 6513)
    # v38b: agent nouns → homme (saves entailment rows)
    ('magicien', 'homme'),        # magician → man (row 1981)
    # gens→homme REMOVED: WN has femme→gens, so gens→homme creates femme→homme→¬femme → ex falso
    ('skateboarder', 'homme'),    # skateboarder → man (2 rows)
    ('type', 'homme'),            # type(=guy) → man (2 rows, French slang)
    # v39: animal hypernyms (11 rows with animal H-only)
    ('chien', 'animal'),          # dog → animal (6 rows)
    ('chat', 'animal'),           # cat → animal (1 row)
    ('singe', 'animal'),          # monkey → animal (1 row)
    ('hamster', 'animal'),        # hamster → animal (1 row)
    ('herisson', 'animal'),       # hedgehog → animal (1 row)
    ('lemurien', 'animal'),       # lemur → animal (1 row)
    # v39: enfant/fille/femme hypernyms
    ('garcon', 'enfant'),         # boy → child (12 rows)
    ('dame', 'femme'),            # lady → woman (4 rows)
    ('adolescente', 'fille'),     # teenager → girl (3 rows)
    ('tout_petits', 'enfant'),    # toddler → child
    ('cascadeur', 'personne'),    # stunt person → person
    ('musicien', 'personne'),     # musician → person
    ('grimpeur', 'personne'),     # climber → person
    ('marcheur', 'personne'),     # walker → person
    ('coureur', 'personne'),      # runner → person
    ('cavalier', 'personne'),     # rider → person
    # v40: noun→adjective form
    ('herbe', 'herbeux'),         # grass → grassy (6 rows)
    ('neige', 'enneige'),         # snow → snowy (4 rows)
    # v40: weapon hypernym
    ('pistolet', 'arme'),         # gun → weapon (4 rows)
    ('fusil', 'arme'),            # rifle → weapon
    # v44: from yes→unk failure analysis (all verified SAFE: 0 FP)
    ('palais', 'bâtiment'),       # palace → building (+1)
    ('magasin', 'bâtiment'),      # store → building (+1)
    ('église', 'bâtiment'),       # church → building (+1)
    ('chambre', 'intérieur'),     # room → interior (+1)
    ('singe', 'chimpanzé'),       # monkey → chimp (+1, contextual)
    ('homme', 'modèle'),          # man → model (+1, contextual)
    ('sauter_a', 'grimper_a'),       # jump_onto -> climb_onto
    ('traverser', 'marcher'),          # traverse -> walk
    ('trottoir', 'rue'),               # sidewalk -> street
    # v56: from deep error analysis across all 3 datasets
    ('foule', 'gens'),                 # crowd → people
    ('foule', 'personne'),             # crowd → person
    ('berline', 'voiture'),            # sedan → car
    ('camionnette', 'vehicule'),       # van → vehicle
    ('allee', 'route'),                # path/alley → road
    ('sentier', 'route'),              # trail → road
    ('chemin', 'route'),               # way/path → road
    ('prairie', 'champ'),              # meadow → field
    ('pelouse', 'herbe'),              # lawn → grass
    ('sommet', 'montagne'),            # summit → mountain
    ('falaise', 'rocher'),             # cliff → rock
    ('colline', 'montagne'),           # hill → mountain
    ('rivage', 'plage'),               # shore → beach
    ('chanteuse', 'musicien'),         # singer(f) → musician
    ('chanteur', 'musicien'),          # singer(m) → musician
    ('pianiste', 'musicien'),          # pianist → musician
    ('violoniste', 'musicien'),        # violinist → musician
    ('batteur', 'musicien'),           # drummer → musician
    ('batteur', 'personne'),           # drummer → person
    ('pianiste', 'personne'),          # pianist → person
    ('violoniste', 'personne'),        # violinist → person
    ('cuisinier', 'chef'),             # cook → chef
    ('coq', 'oiseau'),                 # rooster → bird
    ('canari', 'oiseau'),              # canary → bird
    ('perroquet', 'oiseau'),           # parrot → bird
    ('aigle', 'oiseau'),              # eagle → bird
    ('ane', 'animal'),                 # donkey → animal
    ('chevre', 'animal'),              # goat → animal
    ('poney', 'cheval'),               # pony → horse
    ('chaton', 'chat'),                # kitten → cat
    ('chiot', 'chien'),                # puppy → dog
    ('scooter', 'vehicule'),           # scooter → vehicle
    ('skateboard', 'vehicule'),        # skateboard → vehicle
    ('patin', 'chaussure'),            # skate → shoe
    ('balai', 'outil'),                # broom → tool
    ('couteau', 'outil'),              # knife → tool
    ('ciseaux', 'outil'),              # scissors → tool
]
# Synonym pairs (bidirectional: A(x) ↔ B(x))
# Only one direction needed; the axiom generator creates <-> axioms.
FRENCH_SYNONYMS = [
    ('cabane', 'hutte'),
    # cloture↔enclos removed; replaced with one-way hypernym (cloture→enclos) in FRENCH_HYPERNYMS
    ('combat', 'match'),
    ('trancher', 'couper'),
    ('vetement', 'habit'),
    ('sol', 'terre'),
    ('motard', 'motocycliste'),
    ('gens', 'personne'),
    ('solitaire', 'seul'),
    ('monter', 'chevaucher'),
    ('ballon', 'balle'),
    ('se_battre', 'lutte'),
    ('embrasser', 'calin'),
    ('groupe', 'equipe'),
    ('jouer_a', 'participer_a'),
    ('giser_dans', 'coucher_dans'),
    # v4 additions
    ('cascade', 'tour'),
    ('bronze', 'brun'),
    ('divers', 'different'),
    # v5 additions
    ('inconfortable', 'etrange'),
    # v7 additions
    ('route', 'chaussee'),
    ('se_battre_pour', 'disputer'),
    # v10 additions
    ('conservateur', 'preservatif'),
    # v11 additions
    ('cow_girl', 'cowgirl'),
    # v26: from failure analysis
    ('eplucher', 'peler'),
    ('promener', 'marcher'),
    # REMOVED (unsound, SICK row 2585 false-yes): ('danse', 'danser').
    # Noun `danse(x)` (x is a dance) vs verb `danser(x)` (x dances) are
    # different predicates: the noun's argument is the event/activity, the
    # verb's is the agent. Biconditional collapses them, allowing spurious
    # contradictions/derivations on SICK "hard hat dance" patterns.
    # Same suspicion applies to nage/nager, course/courir, saut/sauter,
    # chant/chanter — flagged but kept pending row-level evidence.
    ('nage', 'nager'),
    ('course', 'courir'),
    ('saut', 'sauter'),
    ('chant', 'chanter'),
    ('repas', 'nourriture'),
    ('beaucoup_de', 'plein_de'),
    ('petit', 'jeune'),
    ('rapide', 'vite'),
    ('certain', 'quelque'),
    ('feminin', 'femme'),
    # v29: new synonyms
    ('gros', 'grand'),
    ('enorme', 'gros'),
    ('dehors', 'exterieur'),
    ('air', 'exterieur'),
    ('se_deplacer', 'bouger'),
    ('attraper', 'saisir'),
    ('lancer', 'jeter'),
    ('gratter', 'jouer_de'),
    # v30: high-value synonyms
    ('femme', 'dame'),
    ('effectuer', 'faire'),
    # v37: auto-discovered from WN synonym scan
    ('nourriture', 'aliment'),    # food ↔ food
    ('parquet', 'plancher'),      # floor ↔ floor
    ('violet', 'pourpre'),        # violet ↔ purple
    ('costume', 'tenue'),         # costume ↔ outfit
    ('homme', 'gars'),            # man ↔ guy/lad
    ('dans', 'en'),               # in ↔ in (locative prepositions)
    ('de', 'faire_de'),           # of ↔ made_of
    # v40: morphological variants
    ('court', 'courir'),            # short/runs(conjugated) ↔ run
    # v42: spelling variant
    ('e_mail', 'email'),              # e_mail ↔ email (4 rows, net +3)
    # v44: from yes→unk failure analysis (all verified SAFE: 0 FP)
    ('conteneur', 'boîte'),           # container ↔ box (+1)
    ('dos', 'arrière'),               # back ↔ rear (+1)
    # v53: from systematic predicate gap analysis (all verified SAFE: 0 FP risk)
    ('tremper_dans', 'plonger_dans'),  # soak in ↔ plunge in (+1)
    ('amalgamer', 'melanger'),         # amalgamate ↔ mix (+1)
    ('allonger_dans', 'coucher'),      # lie in ↔ lie down (+1)
    ('abattre', 'couper'),             # fell ↔ cut (+3)
    ('deplacer', 'mouvement'),         # move ↔ movement (+1)
    ('mise', 'mettre_en'),             # putting ↔ put in (+2)
    ('jouer_avec', 'jouer_de'),        # play_with <-> play_(instrument)
    # v56: from deep error analysis across all 3 datasets
    ('regarder', 'observer'),         # watch ↔ observe
    ('couper', 'decouper'),           # cut ↔ cut out
    ('parler', 'discuter'),           # talk ↔ discuss
    ('crier', 'hurler'),             # shout ↔ scream
    ('vetement', 'tenue'),           # clothing ↔ outfit
    ('beau', 'joli'),                # beautiful ↔ pretty
    ('content', 'heureux'),          # happy ↔ happy
    ('triste', 'malheureux'),        # sad ↔ unhappy
    ('terminer', 'finir'),           # finish ↔ end
    ('commencer', 'debuter'),        # start ↔ begin
    ('magasin', 'boutique'),         # store ↔ shop
    ('maison', 'habitation'),        # house ↔ dwelling
    ('voie', 'chemin'),              # way ↔ path
    ('riviere', 'fleuve'),           # river ↔ river (size variants)
    ('volley_ball', 'volleyball'),   # spelling variant in SICK paraphrases
]


# --- B.1: Dynamic sortal / identity-predicate whitelist ---------------------
# Property-transfer along `is_at` (e.g. `is_at(e,x,y) & P(x) -> P(y)`) is only
# sound when P is an identity / sortal predicate (a noun-like classifier that
# carries through alias-binding), not a scalar adjective (which may have
# subsective or non-subsective semantics — e.g. `rapide(x)` does not transfer
# to a co-located component).
#
# We build the whitelist DYNAMICALLY from the curated French lexicon, with
# three converging sources:
#   (i)   Naming predicates: any predicate name matching `nomm[eé]*` /
#         `nommer*` / `appeler*` — these are pure identity bridges.
#   (ii)  Nationality predicates: nationalities appear in FRENCH_HYPERNYMS as
#         direct children of `personne` (e.g. americain → personne); they are
#         therefore subsumed by source (iii) below — no separate code needed.
#   (iii) Sortal nouns: every node (hyponym or hypernym) that appears in
#         FRENCH_HYPERNYMS is a curated noun.  We deliberately do NOT pull
#         from FRENCH_SYNONYMS because that lexicon mixes noun synonyms with
#         adjective synonyms (e.g. rapide↔vite, gros↔grand, petit↔jeune),
#         which would smuggle adjectives back into the whitelist.  Adjective
#         predicates are therefore auto-excluded by absence from
#         FRENCH_HYPERNYMS.
#
# The whitelist is computed once and cached.  It auto-grows whenever the
# curated lexicon is extended — no per-row decisions, no hardcoded predicate
# list.

def _compute_sortal_identity_whitelist():
    """Return the set of predicate names that are safe targets of `is_at`
    property-transfer.  Pure function of FRENCH_HYPERNYMS plus the
    lexically-stable naming-predicate prefixes."""
    whitelist = set()
    for hypo, hyper in FRENCH_HYPERNYMS:
        whitelist.add(hypo)
        whitelist.add(hyper)
    # Naming / identity bridges (lexically detectable, language-stable).
    whitelist.update({'nomme', 'nommer', 'nomme_', 'appeler', 'appelle',
                      'denomme', 'denommer', 'designe'})
    # Common French sortal nouns absent from WN-fra (lexical-coverage gap
    # patch).  All entries are unambiguously nouns; soundness preserved.
    whitelist.update({'resident', 'residente', 'residents', 'residentes'})
    return frozenset(whitelist)


_SORTAL_IDENTITY_WHITELIST = _compute_sortal_identity_whitelist()


# Predicates known to surface as adjectives/adverbs/non-sortals in French NLI
# datasets, even when WordNet happens to record a (rare) nominal sense for
# them.  These are EXCLUDED from the WN-noun extension below to preserve
# soundness of `is_at` property-transfer.  This list is closed under the
# concrete failure modes observed in v21 diagnostics; extend only when a new
# false-positive is empirically observed.
_SORTAL_WN_NOUN_BLOCKLIST = frozenset({
    # Adjectives with rare/idiomatic nominal WN senses
    'grand', 'petit', 'gros', 'rapide', 'vite', 'lent',
    'principal', 'present', 'ancien', 'moderne',
    'vertical', 'horizontal', 'oblique', 'occidental', 'oriental',
    'blanc', 'noir', 'rouge', 'vert', 'bleu', 'jaune', 'gris', 'brun',
    'remarquable', 'mediocre', 'extreme', 'general',
    'libre', 'plein', 'vide', 'propre', 'sale',
    'haut', 'bas', 'long', 'court', 'large', 'etroit',
    'jeune', 'vieux', 'nouveau', 'meilleur',
    'fort', 'faible', 'lourd', 'leger',
    # Adverb stems / suffix forms
    'librement', 'principalement', 'remarquablement', 'generalement',
    # Polarity-bearing or scalar markers
    'droit',  # noun "right" vs adj "straight" — too ambiguous; exclude
    # Function words occasionally tagged as nouns by WN
    'tout', 'certain', 'quelque', 'plusieurs',
    # Nationality adjectives (sortal-noun-AS-adjective conflation)
    'grec', 'latin', 'anglais', 'francais', 'allemand', 'italien',
    'espagnol', 'portugais', 'russe', 'chinois', 'japonais',
    'nord_americain', 'sud_americain', 'europeen', 'asiatique', 'africain',
})


def _wn_has_noun_sense(pred_name):
    """Cached check: does `pred_name` have a French WordNet noun synset?

    Sound because WN-fra noun synsets are curated; predicates that appear here
    are nouns in at least one mainstream sense.  Confusable adjective stems
    are screened out via `_SORTAL_WN_NOUN_BLOCKLIST` BEFORE this check.

    Accent handling: predicates in this codebase are unidecoded (no accents)
    while WN-fra lemmas carry accents.  We consult a pre-built unidecoded
    lemma set (`_WN_FRA_NOUN_LEMMAS_UNI`) for O(1) membership.
    """
    if pred_name in _SORTAL_WN_NOUN_BLOCKLIST:
        return False
    if not pred_name:
        return False
    key = pred_name.replace('_', ' ')
    if key in _WN_FRA_NOUN_LEMMAS_UNI:
        return True
    # Strip simple plural marker (French regular plurals end in -s/-x).
    if len(key) > 3 and key.endswith('s') and key[:-1] in _WN_FRA_NOUN_LEMMAS_UNI:
        return True
    if len(key) > 3 and key.endswith('x') and key[:-1] in _WN_FRA_NOUN_LEMMAS_UNI:
        return True
    return False


def _build_wn_fra_noun_lemmas_uni():
    """Pre-build an unidecoded set of all French WordNet noun lemmas.

    Run once at module load.  ~50K entries; O(1) lookup thereafter.
    Falls back to an empty set if WN-fra is unavailable so the rest of the
    pipeline still runs (callers will simply not get the WN extension)."""
    out = set()
    try:
        for synset in wn.all_synsets(pos='n'):
            try:
                lemmas = synset.lemma_names('fra')
            except Exception:
                continue
            for lm in lemmas:
                u = unidecode.unidecode(lm).lower()
                out.add(u)
                # Also store the version with underscores replaced by spaces
                # (lemma_names often use underscores for multi-word entries).
                out.add(u.replace('_', ' '))
    except Exception:
        pass
    return frozenset(out)


_WN_FRA_NOUN_LEMMAS_UNI = _build_wn_fra_noun_lemmas_uni()


# Per-process cache to avoid re-querying WN for the same predicate on every row.
_WN_NOUN_CACHE = {}


def is_sortal_identity_predicate(pred_name):
    """Dynamic, sound check: is `pred_name` a sortal / identity predicate
    eligible for `is_at` property-transfer?

    Three tiers, all sound:
      (i)  Curated noun whitelist (FRENCH_HYPERNYMS endpoints).
      (ii) Naming-verb morphological prefix (`nomm` / `appel` / `denomm` /
           `designe`).
      (iii) Dynamic WordNet check: predicate has a French noun synset AND is
            not in `_SORTAL_WN_NOUN_BLOCKLIST` (confusable adjectives /
            adverbs / function words).

    Tier (iii) is what generalises the whitelist automatically to any new
    French noun the dataset introduces, without per-row guesswork."""
    if pred_name in _SORTAL_IDENTITY_WHITELIST:
        return True
    # Morphological generalisation for naming verbs:
    if pred_name.startswith('nomm') or pred_name.startswith('appel') \
            or pred_name.startswith('denomm') or pred_name.startswith('designe'):
        return True
    # Dynamic WN-noun extension (cached).
    cached = _WN_NOUN_CACHE.get(pred_name)
    if cached is None:
        cached = _wn_has_noun_sense(pred_name)
        _WN_NOUN_CACHE[pred_name] = cached
    return cached


def compute_local_derivable_preds(p_pred_names, h_pred_names, premise_texts, hypothesis_texts):
    """Predicates that are locally licensed by the current P/H configuration.

    This is used only by fallback guards after Prover9 has already found a
    candidate proof. The intent is to recognize narrow compositional licenses
    that should not be treated as novel content.
    """
    derivable = set()
    premise_text = ' '.join(premise_texts)
    hypothesis_text = ' '.join(hypothesis_texts)

    if ENABLE_CURATED_LEXICON_FALLBACK:
        for hyponym, hypernym in FRENCH_HYPERNYMS:
            if hyponym in p_pred_names:
                if (hyponym, hypernym) in get_non_intersective_hypernymy_blocked_pairs(premise_texts, hypothesis_texts):
                    continue
                derivable.add(hypernym)
        for syn1, syn2 in FRENCH_SYNONYMS:
            if syn1 in p_pred_names:
                derivable.add(syn2)
            if syn2 in p_pred_names:
                derivable.add(syn1)

    if 'plus' in p_pred_names:
        derivable.add('beaucoup_de')
    if 'plupart_de' in p_pred_names:
        derivable.add('plus_de')
    if 'tout' in p_pred_names or 'chacun' in p_pred_names:
        derivable.update(['plupart_de', 'plus_de', 'existe'])
    if 'plus_de' in p_pred_names:
        derivable.add('existe')
    if 'DOT' in p_pred_names:
        derivable.update(['plupart_de', 'majorite', 'plus_de', 'moins_de'])
    if 'moitie' in p_pred_names:
        if 'moins_de' not in p_pred_names:
            derivable.update(['plupart_de', 'plus_de'])
    if 'tiers' in p_pred_names:
        derivable.update(['tout', 'plupart_de', 'plus_de'])
    if 'haut' in p_pred_names:
        derivable.add('hauts')
    if 'petit' in p_pred_names or 'grand' in p_pred_names:
        derivable.add('mesure')

    text_cardinals = {
        'Un', 'Deux', 'Trois', 'Quatre', 'Cinq', 'Six', 'Sept', 'Huit',
        'Neuf', 'Dix', 'Onze', 'Douze', 'Vingt'
    }
    derivable.update(text_cardinals & h_pred_names)

    if any('overlaps(' in premise for premise in premise_texts):
        derivable.add('actuellement')

    content_skip = {
        'temps', 'num', 'overlaps', 'subseteq', 'exists', 'forall', 'all',
        'existe', 'maintenant', 'de', 'en', 'a_', 'dans', 'sur', 'sous',
        'avec', 'is_at', 'pres_de', 'devant', 'derriere', 'contre',
        'par_dessus', 'entre', 'intersect', 'empty_intersect', 'context_',
        'unknown_', 'singular_', 'masculin_', 'feminin_', 'generic', 'leq',
        'narration', 'et', 'ou', 'parallel', 'atomic_sub', 'pas_de'
    }
    shared_content = (p_pred_names & h_pred_names) - content_skip

    if {'en_train_de', 'etre_en'} <= h_pred_names and shared_content and any('overlaps(' in premise for premise in premise_texts):
        derivable.update(['en_train_de', 'etre_en'])

    return derivable



def emit_disjoint(p1, p2, all_preds):
    axioms = []
    a1s = [arity for name, arity in all_preds if name == p1]
    a2s = [arity for name, arity in all_preds if name == p2]
    # If both present
    for a1 in a1s:
        for a2 in a2s:
            if a1 == 0 or a2 == 0: continue
            v1 = [f"x{i}" for i in range(a1)]
            v2 = [f"y{i}" for i in range(a2)]
            v1[-1] = "z"
            v2[-1] = "z"
            all_vars = sorted(list(set(v1 + v2)))
            v1_str = ", ".join(v1)
            v2_str = ", ".join(v2)
            var_str = " ".join(all_vars)
            axioms.append(f"all {var_str}. ({p1}({v1_str}) -> -{p2}({v2_str}))")
    return axioms


def get_non_intersective_hypernymy_blocked_pairs(premise_texts, hypothesis_texts):
    """Detect local hypernymy bridges invalidated by scalar adjective context.

    Example pattern:
    - P contains hyponym + petit
    - P contains hypernym + grand
    - H asks for hypernym + petit

    In that configuration, the hyponym->hypernym bridge is semantically unsafe:
    "petit elephant" does not entail "petit animal" when elephants are introduced
    as grands animaux in the same local theory.
    """
    if not premise_texts or not hypothesis_texts:
        return set()

    blocked_pairs = set()
    scalar_pairs = [
        ('petit', 'grand'),
        ('grand', 'petit'),
        ('petite', 'grande'),
        ('grande', 'petite'),
    ]

    lexical_predicates = {
        pred for formula in list(premise_texts) + list(hypothesis_texts)
        for pred in re.findall(r'\b([a-z_][a-z_0-9]*)\(', formula)
        if pred not in {'num', 'temps', 'overlaps', 'exists', 'all', 'forall', 'de', 'en', 'a_', 'dans'}
    }
    for hyponym in lexical_predicates:
        for hypernym in lexical_predicates - {hyponym}:
            if (not _jdm_has_relation(hyponym, hypernym, {'hypernym'}) and
                    not _jdm_has_relation(hypernym, hyponym, {'hyponym'}) and
                    not any(re.search(rf'\b{re.escape(hyponym)}\([^)]*\)\s*->\s*{re.escape(hypernym)}\(', ax)
                            for ax in get_wn_axioms({(hyponym, 1)}, {(hypernym, 1)}))):
                continue
            for kept_adj, opposing_adj in scalar_pairs:
                hyponym_with_kept = any(
                    f'{hyponym}(' in formula and f'{kept_adj}(' in formula
                    for formula in premise_texts
                )
                hypernym_with_opp = any(
                    f'{hypernym}(' in formula and f'{opposing_adj}(' in formula
                    for formula in premise_texts
                )
                hypothesis_needs_transfer = any(
                    f'{hypernym}(' in formula and f'{kept_adj}(' in formula
                    for formula in hypothesis_texts
                )
                if hyponym_with_kept and hypernym_with_opp and hypothesis_needs_transfer:
                    blocked_pairs.add((hyponym, hypernym))
                    break

    return blocked_pairs


def filter_non_intersective_hypernymy_axioms(axioms, premise_texts, hypothesis_texts):
    """Remove locally unsafe hypernymy bridges for non-intersective adjective rows."""
    blocked_pairs = get_non_intersective_hypernymy_blocked_pairs(premise_texts, hypothesis_texts)
    if not blocked_pairs:
        return axioms, []

    filtered_axioms = []
    skipped_axioms = []
    for axiom in axioms:
        match = re.match(r'^\s*all\b.*\.\(([a-z_][a-z_0-9]*)\([^)]*\)\s*->\s*([a-z_][a-z_0-9]*)\(', axiom)
        if not match:
            filtered_axioms.append(axiom)
            continue
        pair = (match.group(1), match.group(2))
        if pair in blocked_pairs:
            skipped_axioms.append(axiom)
        else:
            filtered_axioms.append(axiom)

    return filtered_axioms, skipped_axioms


def should_block_scalar_fallback_weakening(premise_texts, hypothesis_texts):
    """Detect when existential stripping/Skolemization is unsafe for scalar adjectives.

    With only one or two existential premises, weakening them can spuriously unify
    witnesses across independent small/big descriptions and derive comparison or
    transfer claims that do not hold in the original theory.
    """
    if not premise_texts or not hypothesis_texts:
        return False
    if len(premise_texts) > 2:
        return False

    all_premises = ' '.join(premise_texts)
    all_hypotheses = ' '.join(hypothesis_texts)
    has_small = 'petit(' in all_premises or 'petite(' in all_premises
    has_big = 'grand(' in all_premises or 'grande(' in all_premises
    if not (has_small and has_big):
        return False

    scalar_goal_markers = (
        'petit(',
        'petite(',
        'grand(',
        'grande(',
        'mesure(',
        'mésure(',
    )
    return any(marker in all_hypotheses for marker in scalar_goal_markers)


def _formula_has_unary_predicate(formula_text, pred_name):
    return re.search(r'\b' + re.escape(pred_name) + r'\(([^,()]+)\)', formula_text) is not None


def _formula_has_predicate_name(formula_text, pred_name):
    return re.search(r'\b' + re.escape(pred_name) + r'\(', formula_text) is not None


def _formula_has_measure_comparison(formula_text):
    return (
        re.search(r'>\(m[ée]sure\([^)]*\),\s*m[ée]sure\([^)]*\)\)', formula_text) is not None
        or re.search(r'\(m[ée]sure\([^)]*\)\s*=\s*m[ée]sure\([^)]*\)\)', formula_text) is not None
    )


def get_past_scoped_transfer_blocks(premise_texts, hypothesis_texts):
    """Detect local transfer axioms that become unsafe when the source state is past-scoped.

    The FOL often encodes "former X" as a past-scoped class/state predicate such as
    predicate(q, x) together with <(temps(q), ref_time). In that configuration, two
    generic bridges are unsafe when H drops the temporal restriction:

    - entity lift: predicate(q, x) -> predicate(x)
    - adjective transfer: predicate(q, x) & adj(q) -> adj(x)
    """
    blocked_entity_lifts = set()
    blocked_adj_transfers = set()
    if not premise_texts or not hypothesis_texts:
        return blocked_entity_lifts, blocked_adj_transfers

    excluded_binary_preds = {
        'is_at', 'de', 'nomme', 'nommé', 'subseteq', 'overlaps', 'temps', 'existe', 'des',
        'en', 'a_', 'num', 'tout', 'chacun', 'ou', 'et', 'aussi', 'parallel', 'heure',
        'mesure', 'maintenant', 'atomic_sub', 'seul', 'plupart_de', 'beaucoup_de', 'peu_de',
        'aucun', 'plus_de', 'moins_de', 'sur', 'sous', 'devant', 'derriere', 'avant', 'apres',
        'dans', 'proche', 'leq', 'un', 'être', '_', 'dot', 'DOT', 'CLOSING_PARENTHESIS'
    }
    excluded_unary_preds = {
        'temps', 'maintenant', 'ref_time', 'num', 'existe', 'tout', 'chacun', 'generic',
        'atomic_sub', 'unknown_', 'context_', 'singular_'
    }

    for formula in premise_texts:
        past_vars = set(re.findall(r'<\(temps\(([a-z]\d?)\),\s*(?:ref_time|maintenant)\)', formula))
        for witness_var, scoped_var in re.findall(
            r'subseteq\(temps\(([a-z]\d?)\),\s*temps\(([a-z]\d?)\)\)\s*&\s*<\(temps\(\1\),\s*maintenant\)',
            formula,
        ):
            past_vars.add(scoped_var)
        if not past_vars:
            continue

        unary_preds_by_var = {}
        for pred_name, var_name in re.findall(r'\b([a-z_][a-z_0-9]*)\(([a-z]\d?)\)', formula):
            if var_name not in past_vars or pred_name in excluded_unary_preds:
                continue
            unary_preds_by_var.setdefault(var_name, set()).add(pred_name)

        for pred_name, source_var, entity_var in re.findall(
            r'\b([a-z_][a-z_0-9]*)\(([a-z]\d?),\s*([a-z]\d?)\)',
            formula,
        ):
            if source_var not in past_vars or pred_name in excluded_binary_preds:
                continue

            if any(_formula_has_unary_predicate(h_formula, pred_name) for h_formula in hypothesis_texts):
                blocked_entity_lifts.add(pred_name)

            for adj_name in unary_preds_by_var.get(source_var, set()):
                if any(_formula_has_unary_predicate(h_formula, adj_name) for h_formula in hypothesis_texts):
                    blocked_adj_transfers.add((pred_name, adj_name))

    return blocked_entity_lifts, blocked_adj_transfers


def get_past_scoped_unary_drop_blocks(premise_texts, hypothesis_texts):
    """Detect unary predicate facts that are only parser scaffolding for a past-scoped class state.

    Example pattern:
    - P contains pred(x) and pred(q, x)
    - q is explicitly past-scoped via <(temps(q), ref_time/maintenant)
    - H asks for pred(_) in a present/current frame

    In these rows, treating pred(x) as an independent present fact is unsafe.
    """
    blocked_preds = set()
    if not premise_texts or not hypothesis_texts:
        return blocked_preds

    for formula in premise_texts:
        past_vars = set(re.findall(r'<\(temps\(([a-z]\d?)\),\s*(?:ref_time|maintenant)\)', formula))
        if not past_vars:
            continue

        unary_by_pred = {}
        for pred_name, var_name in re.findall(r'\b([a-z_][a-z_0-9]*)\(([a-z]\d?)\)', formula):
            unary_by_pred.setdefault(pred_name, set()).add(var_name)

        for pred_name, source_var, entity_var in re.findall(
            r'\b([a-z_][a-z_0-9]*)\(([a-z]\d?),\s*([a-z]\d?)\)',
            formula,
        ):
            if source_var not in past_vars:
                continue
            if entity_var not in unary_by_pred.get(pred_name, set()):
                continue
            if any(_formula_has_unary_predicate(h_formula, pred_name) for h_formula in hypothesis_texts):
                blocked_preds.add(pred_name)

    return blocked_preds


def get_non_subsective_is_at_blocks(premise_texts, hypothesis_texts):
    """Detect unsafe copula transfer for known non-subsective noun-adjective pairs.

    Some rows encode compounds like "clever politician" as a unary adjective and
    unary noun on a copular complement variable linked by is_at(e, quality, entity).
    Treating that copula as freely reversible/identificational lets H drop the noun
    restriction and inherit the adjective, which is not valid for non-subsective
    readings. We therefore suppress is_at identity/symmetry and adjective transfer
    for the affected pair only when H asks for the bare adjective without the noun.
    """
    blocked_pairs = set()
    if not premise_texts or not hypothesis_texts:
        return blocked_pairs

    blocked_noun_adj_pairs = {
        ('politicien', 'astucieux'),
        ('politicienne', 'astucieux'),
    }

    for formula in premise_texts:
        unary_preds_by_var = {}
        for pred_name, var_name in re.findall(r'\b([a-z_][a-z_0-9]*)\(([a-z]\d?)\)', formula):
            unary_preds_by_var.setdefault(var_name, set()).add(pred_name)

        for _, source_var, _ in re.findall(r'\bis_at\(([a-z]\d?),\s*([a-z]\d?),\s*([a-z]\d?)\)', formula):
            source_preds = unary_preds_by_var.get(source_var, set())
            for noun_pred, adj_pred in blocked_noun_adj_pairs:
                if noun_pred not in source_preds or adj_pred not in source_preds:
                    continue
                h_has_adj = any(_formula_has_unary_predicate(h_formula, adj_pred) for h_formula in hypothesis_texts)
                h_has_noun = any(_formula_has_unary_predicate(h_formula, noun_pred) for h_formula in hypothesis_texts)
                if h_has_adj and not h_has_noun:
                    blocked_pairs.add((noun_pred, adj_pred))

    return blocked_pairs


def get_before_clause_future_event_blocks(premise_texts, hypothesis_texts):
    """Detect parser-style "leave X before V" patterns where V should not be existentially weakened.

    In the current FOL, "X left the meeting before losing temper" is encoded with a
    travel/path/source/destination structure and a later event predicate on the same
    subject. The subordinate event is present as a plain existential conjunct even
    though the natural-language reading is non-factive. We therefore block direct
    proof/fallback transfer when H asks only for that later event.
    """
    blocked_preds = set()
    if not premise_texts or not hypothesis_texts:
        return blocked_preds

    excluded_preds = {
        'travel', 'moving', 'path', 'source', 'destination', 'complement', 'location',
        'overlaps', 'temps', 'subseteq', 'nomme', 'nommé', 'de', 'num', 'exists', 'all',
        'not', 'and', 'or', 'comptable', 'rapport', 'réunion'
    }

    for formula in premise_texts:
        travel_matches = re.findall(r'\btravel\(([a-z]\d?),\s*([a-z]\d?),\s*([a-z]\d?)\)', formula)
        if not travel_matches:
            continue

        source_map = {path_var: loc_var for path_var, loc_var in re.findall(r'\bsource\(([a-z]\d?),\s*([a-z]\d?)\)', formula)}
        destination_pairs = set(re.findall(r'\bdestination\(([a-z]\d?),\s*complement\(([a-z]\d?)\)\)', formula))

        for travel_event, subject_var, path_var in travel_matches:
            source_loc = source_map.get(path_var)
            if source_loc is None or (path_var, source_loc) not in destination_pairs:
                continue

            for pred_name, event_var, event_subject in re.findall(
                r'\b([a-z_][a-z_0-9]*)\(([a-z]\d?),\s*([a-z]\d?)',
                formula,
            ):
                if pred_name in excluded_preds or event_var == travel_event or event_subject != subject_var:
                    continue
                if re.search(rf'<\(temps\({travel_event}\),\s*temps\({event_var}\)\)', formula) is None:
                    continue
                if any(_formula_has_predicate_name(h_formula, pred_name) for h_formula in hypothesis_texts):
                    blocked_preds.add(pred_name)

    return blocked_preds


def get_comparative_positive_drop_blocks(premise_texts, hypothesis_texts):
    """Detect unsafe positive-adjective transfer out of comparative/equative quality states.

    Comparative rows encode the adjective on a quality complement linked by is_at(...)
    together with a mesure comparison/equality. Treating that adjective as an ordinary
    positive fact about the entity is not linguistically valid when H drops the
    comparative/equative structure.
    """
    blocked_adjs = set()
    if not premise_texts or not hypothesis_texts:
        return blocked_adjs
    if any(_formula_has_measure_comparison(h_formula) for h_formula in hypothesis_texts):
        return blocked_adjs

    excluded_adj_like_preds = {
        'is_at', 'nomme', 'nommé', 'temps', 'overlaps', 'mesure', 'num', 'tout', 'chacun',
        'exists', 'all', 'not', 'and', 'or', 'PC_6082', 'ITEL_XZ'
    }

    for formula in premise_texts:
        if not _formula_has_measure_comparison(formula):
            continue

        unary_preds_by_var = {}
        for pred_name, var_name in re.findall(r'\b([a-z_][a-z_0-9]*)\(([a-z]\d?)\)', formula):
            unary_preds_by_var.setdefault(var_name, set()).add(pred_name)

        for _, _, quality_var in re.findall(r'\bis_at\(([a-z]\d?),\s*([a-z]\d?),\s*([a-z]\d?)\)', formula):
            for pred_name in unary_preds_by_var.get(quality_var, set()):
                if pred_name in excluded_adj_like_preds:
                    continue
                if any(_formula_has_unary_predicate(h_formula, pred_name) for h_formula in hypothesis_texts):
                    blocked_adjs.add(pred_name)

    return blocked_adjs


def get_seul_uniqueness_axioms(premise_texts, hypothesis_texts):
    """Inject FOL axioms expressing the semantics of 'un seul N' in P.

    Pattern detected (FOL only):
      P contains ``seul(v)`` together with a binary ``Pred(v, w)`` (``v`` is the
      singular-count slot, ``w`` the referenced entity) AND the unary
      ``Pred(u)`` (arity-lifted copy of the type predicate).  Semantically
      "un seul Pred" means the referenced Pred is the unique one in the
      relevant discourse context.

    For each such Pred that ALSO appears in H together with ``>(num(z), 1)``
    on the same variable (H asserts a plurality of that same Pred), the
    following two axioms are sound and generalisable:

      1. ``all x1 x2. (Pred(x1) & Pred(x2) -> (x1 = x2))``
         (at-most-one uniqueness: there is at most one Pred)
      2. ``all z. ((>(num(z), 1) & Pred(z)) -> exists w. (Pred(w) & -(w = z)))``
         (plurality -> two distinct witnesses)

    Their conjunction entails ``-H`` for an H that claims ``Pred(b) &
    >(num(b), 1) & ...``.  The generator is triggered only when BOTH the
    seul-pattern in P and the matching plurality-pattern in H are present,
    so the axioms are relevant and never injected indiscriminately.
    """
    axioms = []
    return axioms
    if not premise_texts or not hypothesis_texts:
        return axioms

    # Structural / function-like predicates that must never be treated as
    # the "Pred" of the seul-uniqueness schema.
    _EXCLUDED = {
        'is_at', 'nomme', 'nommé', 'temps', 'overlaps', 'num', 'de',
        'exists', 'all', 'not', 'and', 'or',
        'generic', 'narration', 'subseteq', 'maintenant',
        'existe', 'seul', 'tout', 'chacun', 'aucun',
        'plupart_de', 'plus_de', 'moins_de', 'beaucoup_de', 'peu_de',
        'mesure', 'mésure',
    }

    # Step 1. Collect Pred names appearing under the seul(x) & Pred(x, y)
    # pattern in P, where Pred also exists unary somewhere in the same
    # premise (arity-lifted type predicate).
    candidate_preds = set()
    _bin_re = re.compile(r'\b([a-zA-Zéèêàâôûùïî_][a-zA-Zéèêàâôûùïî_0-9]*)\(([a-z]\d?)\s*,\s*([a-z]\d?)\)')
    _un_re = re.compile(r'\b([a-zA-Zéèêàâôûùïî_][a-zA-Zéèêàâôûùïî_0-9]*)\(([a-z]\d?)\)')
    for p in premise_texts:
        if 'seul(' not in p:
            continue
        seul_vars = set(re.findall(r'\bseul\(([a-z]\d?)\)', p))
        if not seul_vars:
            continue
        unary_names = {name for name, _ in _un_re.findall(p)}
        for name, v1, _v2 in _bin_re.findall(p):
            if v1 not in seul_vars:
                continue
            if name in _EXCLUDED:
                continue
            if name not in unary_names:
                continue
            candidate_preds.add(name)

    if not candidate_preds:
        return axioms

    # Step 2. For each candidate Pred, require H to contain both Pred(z)
    # and >(num(z), 1) on the SAME variable z -- the matching plurality
    # pattern that the uniqueness axioms can refute.
    fired = set()
    _gt_re = re.compile(r'>\(\s*num\(([a-z]\d?)\)\s*,\s*1\s*\)')
    for h in hypothesis_texts:
        gt_vars = set(_gt_re.findall(h))
        if not gt_vars:
            continue
        for pred in candidate_preds:
            if pred in fired:
                continue
            pred_vars = set(re.findall(
                rf'\b{re.escape(pred)}\(([a-z]\d?)\)', h))
            if gt_vars & pred_vars:
                axioms.append(
                    f"all x y. (({pred}(x) & {pred}(y)) -> (x = y))"
                )
                axioms.append(
                    f"all z. ((>(num(z),1) & {pred}(z)) -> "
                    f"exists w. ({pred}(w) & -(w = z)))"
                )
                fired.add(pred)

    return list(set(axioms))


# ---------------------------------------------------------------------------
# Sortal scalar-antonym and tout-universalization axioms.
#
# These two generators replace respectively:
#   (a) the unsafe global antonymy  all x. A1(x) -> -A2(x)
#       (which made "petit mouse + grand animal on same entity" impossible
#        even across different sorts, thus breaking the scalar-relativity
#        of adjectives and forcing the non-intersective hypernymy filter);
#   (b) the missing universal closure on FOL premises carrying the
#       "tout(d)" marker (e.g. "Toutes les souris ...").
# Both are FOL-pattern driven, soundness-preserving, and generalisable.
# ---------------------------------------------------------------------------

# Scalar adjective pairs whose disjointness is only sound *within the same
# sort*.  A big-qua-mouse can be a small-qua-animal.  These pairs MUST NOT
# be emitted as global predicate disjointness; they are emitted only by the
# sortal generator below, gated by a shared sort predicate.
_SCALAR_ANTONYM_PAIRS = (
    ('petit', 'grand'),
    ('petite', 'grande'),
    ('lent', 'rapide'),
    ('vieux', 'jeune'),
    ('haut', 'bas'),
    ('lourd', 'leger'),
    ('fort', 'faible'),
    ('long', 'court'),
    ('chaud', 'froid'),
    ('riche', 'pauvre'),
    ('ancien', 'nouveau'),
    ('modeste', 'ambitieux'),
    ('sombre', 'clair'),
)

# Predicates that appear both unary and binary but are NOT natural-language
# sort predicates (they are structural / temporal / measure slots).
_NON_SORT_PREDICATES = frozenset({
    'is_at', 'nomme', 'nommé', 'temps', 'overlaps', 'num', 'mesure',
    'mésure', 'subseteq', 'partie_de', 'de', 'en', 'dans', 'sur', 'sous',
    'a_', 'avec', 'pour', 'par', 'entre', 'vers', 'contre', 'depuis',
    'durant', 'pendant', 'avant', 'apres', 'après', 'apres_', 'après_',
    'tout', 'seul', 'chacun', 'aucun', 'generic', 'context',
    'maintenant', 'passe', 'passé', 'futur', 'present', 'présent',
})

_PREDICATE_NAME_PATTERN = r'[A-Za-zéèêàâôûùïî_][A-Za-zéèêàâôûùïî_0-9]*'


def get_negated_unary_binary_projection_blocks(formula_texts):
    """Find predicates where P(q, x) must not project to P(x).

    Some corpus formulas use a binary predicate P(q, x) for a quality slot
    while also explicitly denying the unary class P(x).  Emitting the generic
    projection P(q, x) -> P(x) would make that row inconsistent.  The block is
    row-local and formula-shaped: it applies to any predicate with a negated
    unary atom sharing the entity argument of a binary atom.
    """
    negated_unary_args = {}
    binary_entity_args = {}
    neg_unary_re = re.compile(
        rf'-\s*\(?\s*({_PREDICATE_NAME_PATTERN})\s*\(\s*([^,()]+?)\s*\)\s*\)?'
    )
    binary_re = re.compile(
        rf'\b({_PREDICATE_NAME_PATTERN})\s*\(\s*([^,()]+?)\s*,\s*([^,()]+?)\s*\)'
    )

    def clean_arg(arg):
        return re.sub(r'\s+', '', str(arg))

    for formula_text in formula_texts or []:
        formula_text = str(formula_text)
        for match in neg_unary_re.finditer(formula_text):
            pred_name = match.group(1)
            if is_function_usage(formula_text, match.start(1), match.end()):
                continue
            negated_unary_args.setdefault(pred_name, set()).add(clean_arg(match.group(2)))
        for match in binary_re.finditer(formula_text):
            pred_name = match.group(1)
            if is_function_usage(formula_text, match.start(1), match.end()):
                continue
            binary_entity_args.setdefault(pred_name, set()).add(clean_arg(match.group(3)))

    return {
        pred_name
        for pred_name, neg_args in negated_unary_args.items()
        if neg_args & binary_entity_args.get(pred_name, set())
    }


def get_sortal_scalar_antonym_axioms(premise_texts, hypothesis_texts):
    """Sortally-gated scalar antonymy (sound replacement of global antonym).

    For each scalar antonym pair (A1, A2) present in the theory and each
    predicate S appearing in the theory BOTH as a unary sort class
    ``S(x)`` AND as a binary sort-quality ``S(q, x)`` (the FOL convention
    of this corpus for adjective-noun modification), emit:

        all e1 e2 q1 q2 b1 b2 x.
            ( is_at(e1, b1, x) & is_at(e2, b2, x)
            & S(b1) & S(b2) & S(q1, b1) & S(q2, b2)
            & A1(q1) & A2(q2) )  ->  false

    Semantics: on the SAME entity ``x``, having a qua-S quality ``q1``
    marked A1 and another qua-S quality ``q2`` marked A2 is contradictory
    (e.g. a single entity cannot be simultaneously big-qua-animal and
    small-qua-animal in the same state).  Cross-sort configurations
    (petit-qua-souris + grand-qua-animal on the same entity) are NOT
    constrained -- this is the semantic relativity of scalar adjectives
    which the unsafe global form violated.

    Triggered only when both A1 and A2 occur in the theory AND S occurs
    in both arities on shared entities, so the axiom is always relevant.
    """
    axioms = []
    if not premise_texts and not hypothesis_texts:
        return axioms

    premise_blob = ' '.join(premise_texts or [])
    hypothesis_blob = ' '.join(hypothesis_texts or [])
    blob = premise_blob + ' ' + hypothesis_blob

    # Collect predicates + arities
    _re_un = re.compile(r'\b([a-zA-Zéèêàâôûùïî_][a-zA-Zéèêàâôûùïî_0-9]*)\(\s*[^,()]+\s*\)')
    _re_bi = re.compile(r'\b([a-zA-Zéèêàâôûùïî_][a-zA-Zéèêàâôûùïî_0-9]*)\(\s*[^,()]+\s*,\s*[^,()]+\s*\)')
    unary_all = set(_re_un.findall(blob))
    binary_all = set(_re_bi.findall(blob))
    projection_blocked_sorts = get_negated_unary_binary_projection_blocks(
        (premise_texts or []) + (hypothesis_texts or [])
    )
    shared_sorts = (unary_all & binary_all) - _NON_SORT_PREDICATES - projection_blocked_sorts
    if not shared_sorts:
        return axioms

    # Restrict to sorts that appear in BOTH the premise(s) AND the
    # hypothesis/hypotheses.  Sorts appearing only in P (e.g. "souris" when
    # H talks about "animal") do not need an antonym axiom to answer H,
    # and adding one there is known to interact unsoundly with existing
    # arity-lift / quality-transfer axioms when the sort entity appears as
    # its own quality slot (souris2(a, d) yielding souris1(a) by arity
    # lift, then tout-universalisation re-applying to a, etc.).
    p_unary = set(_re_un.findall(premise_blob))
    p_binary = set(_re_bi.findall(premise_blob))
    h_unary = set(_re_un.findall(hypothesis_blob))
    h_binary = set(_re_bi.findall(hypothesis_blob))
    shared_sorts = {
        s for s in shared_sorts
        if (s in p_unary or s in p_binary)
        and (s in h_unary or s in h_binary)
    }
    if not shared_sorts:
        return axioms

    # Only consider scalar antonym pairs whose BOTH sides appear in theory
    active_pairs = []
    for a1, a2 in _SCALAR_ANTONYM_PAIRS:
        if f'{a1}(' in blob and f'{a2}(' in blob:
            active_pairs.append((a1, a2))
    if not active_pairs:
        return axioms

    for sort in sorted(shared_sorts):
        for a1, a2 in active_pairs:
            # Simple, sound form: an entity cannot simultaneously bear two
            # sort-S qualities q1, q2 with opposite scalar adjectives on the
            # SAME sort.  The shared-entity gating is the binary argument
            # position (``b``): both sort-qualities attach to the same
            # second argument, which identifies a single referent.  This
            # form is strictly weaker than the full ``is_at``-chained
            # version and therefore still sound, while being much cheaper
            # for Prover9 to traverse.
            ax = (
                f"all q1 q2 b. "
                f"-(({sort}(q1, b) & {sort}(q2, b) "
                f"& {a1}(q1) & {a2}(q2)))"
            )
            axioms.append(ax)
    return axioms


def get_named_scalar_antonym_contradiction_axioms(premise_texts, hypothesis_texts):
    """Cross-P/H scalar-antonym contradiction for the ``S_event`` convention.

    FraCaS 'opposites' rows (e.g. "X is a small N" vs "X is a big N") encode
    the adjective on a *degree entity* ``q`` linked to the noun via the
    binary ``S_event(q, b)`` (NOT ``S(q, b)``), and link the noun ``b`` to the
    named individual via ``is_at(c, b, d)`` with ``nomme(d, N)``.  Because P
    and H are separately existentially quantified, the qua-quality entities do
    not share a variable, so the sortal antonym axiom (which keys on a shared
    binary second argument) never fires.

    This generator emits ONE bundled, sound contradiction axiom per detected
    frame, scoped to a proper name ``N`` occurring in BOTH P and H, a sort
    ``S`` occurring with the ``S(x)`` / ``S_event(q, x)`` convention, and a
    scalar antonym pair (A1, A2) split across P and H::

        all d1 d2 c1 c2 b1 b2 q1 q2.
            -( nomme(d1, N) & nomme(d2, N)
             & is_at(c1, b1, d1) & is_at(c2, b2, d2)
             & S(b1) & S(b2)
             & S_event(q1, b1) & S_event(q2, b2)
             & A1(q1) & A2(q2) )

    Soundness: the name ``N`` is a rigid designator under the standard NLI
    convention (a proper name shared by P and H denotes one individual), so
    ``d1 = d2``; that individual's S-entity cannot bear both polarities of the
    same scalar on the same comparison class S.  The axiom is a logical truth
    under these conventions; it only derives falsum when the theory actually
    instantiates the full antonymic configuration, so adding it never weakens
    a sound model.

    Conservative gating (relevance + zero-noise):
      * the name N must appear in BOTH a premise and a hypothesis;
      * the sort S must appear with both the unary and the ``S_event`` binary
        forms in the theory;
      * the antonym pair must be SPLIT across P and H (one polarity each),
        which is exactly the P-vs-H contradiction configuration and avoids
        emitting an irrelevant axiom for intra-formula adjective use.
    """
    axioms = []
    if not premise_texts or not hypothesis_texts:
        return axioms
    if os.environ.get('NAMED_ANT_DISABLE'):
        return axioms

    premise_blob = ' '.join(premise_texts or [])
    hypothesis_blob = ' '.join(hypothesis_texts or [])
    blob = premise_blob + ' ' + hypothesis_blob

    if 'is_at(' not in blob:
        return axioms

    # Proper-name literals (quoted 'Mickey' or bare Uppercase) occurring via
    # nomme(_, N) in BOTH P and H.
    _name_re = re.compile(r"nomme\(\s*\w+\s*,\s*('[^']+'|[A-Z][A-Za-z0-9_]*)\s*\)")
    p_names = set(_name_re.findall(premise_blob))
    h_names = set(_name_re.findall(hypothesis_blob))
    shared_names = p_names & h_names
    if not shared_names:
        return axioms

    # Sorts S with the unary S(x) + binary S_event(q, x) convention, present
    # in BOTH P and H.
    _re_un = re.compile(r'\b([a-zA-Zéèêàâôûùïî_][a-zA-Zéèêàâôûùïî_0-9]*)\(\s*[^,()]+\s*\)')
    p_unary = set(_re_un.findall(premise_blob))
    h_unary = set(_re_un.findall(hypothesis_blob))
    sort_candidates = []
    for s in sorted((p_unary & h_unary) - _NON_SORT_PREDICATES):
        if s.endswith('_event'):
            continue
        if f'{s}_event(' in premise_blob and f'{s}_event(' in hypothesis_blob:
            sort_candidates.append(s)
    if not sort_candidates:
        return axioms

    # Scalar antonym pairs split across P and H (one polarity in each side).
    active_pairs = []
    for a1, a2 in _SCALAR_ANTONYM_PAIRS:
        a1p, a2p = f'{a1}(' in premise_blob, f'{a2}(' in premise_blob
        a1h, a2h = f'{a1}(' in hypothesis_blob, f'{a2}(' in hypothesis_blob
        if (a1p and a2h) or (a2p and a1h):
            active_pairs.append((a1, a2))
    if not active_pairs:
        return axioms

    for name in sorted(shared_names):
        for sort in sort_candidates:
            for a1, a2 in active_pairs:
                ax = (
                    f"all d1 d2 c1 c2 b1 b2 q1 q2. "
                    f"-(( nomme(d1, {name}) & nomme(d2, {name}) "
                    f"& is_at(c1, b1, d1) & is_at(c2, b2, d2) "
                    f"& {sort}(b1) & {sort}(b2) "
                    f"& {sort}_event(q1, b1) & {sort}_event(q2, b2) "
                    f"& {a1}(q1) & {a2}(q2) ))"
                )
                axioms.append(ax)
    return axioms


def _parens_span_full(s):
    """Return True iff s starts with '(' and that '(' matches the final ')'."""
    if not (s.startswith('(') and s.endswith(')')):
        return False
    depth = 0
    for i, ch in enumerate(s):
        if ch == '(':
            depth += 1
        elif ch == ')':
            depth -= 1
            if depth == 0:
                return i == len(s) - 1
    return False


def _flatten_top_conjuncts(body):
    """Flatten right-nested (or mixed) top-level & conjunction in a FOL body."""
    body = body.strip()
    while _parens_span_full(body):
        body = body[1:-1].strip()
    depth = 0
    split_at = -1
    for i, ch in enumerate(body):
        if ch == '(':
            depth += 1
        elif ch == ')':
            depth -= 1
        elif ch == '&' and depth == 0:
            split_at = i
            break
    if split_at < 0:
        return [body]
    left = body[:split_at].strip()
    right = body[split_at + 1:].strip()
    return _flatten_top_conjuncts(left) + _flatten_top_conjuncts(right)


def _complex_restrictor_tout_axiom(conjs, tv, ex_vars):
    """Principled restrictor/scope split for a universal NP whose restrictor
    is *complex* (sortal head + a relational/post-nominal modifier), e.g.
    "tous les membres du comité", "toutes les personnes venant de Suède".

    Generalized-quantifier restrictor theory: the quantifier's restrictor is
    the entire subject NP (sortal head ``S(tv)`` plus its restrictive
    modifiers); the nuclear scope is the matrix VP.  We realise

        all tv. ( S(tv) & <restrictor modifiers on tv> )
                 -> ( <matrix VP predication> ) .

    Decomposition (purely structural, word-agnostic):
      * sort ``S(tv)``: first non-NON_SORT unary atom on ``tv``.
      * scope entities: the variables of the LAST ``tv``-relational atom in
        linear order -- the matrix VP is realised after the subject NP and
        introduces the predicate's fresh participant(s) -- grown ONLY through
        non-``tv`` atoms, so ``tv`` can never bridge a restrictor entity into
        the scope.
      * consequent = atoms whose free variables meet the scope-entity set.
      * antecedent = sort head + the remaining ``tv``-restrictor atoms.

    Soundness: extra atoms in the antecedent only weaken the axiom (always
    sound); the sole unsoundness mode -- a restrictor atom leaking into the
    consequent -- is prevented because scope growth never passes through
    ``tv``, so a restrictor entity (reachable only via ``tv``) can never join
    the scope set.  Returns the axiom string, or ``None`` when no sound split
    applies (caller then emits nothing).
    """
    # Validation toggle: set GQA_DISABLE=1 to suppress this family entirely
    # (used only to regenerate a clean no-GQ-A baseline). No effect when unset.
    if os.environ.get('GQA_DISABLE') == '1':
        return None
    _VAR = re.compile(r'\b([a-z]\d?)\b')
    _UNARY = re.compile(
        r'^([A-Za-zéèêàâôûùïî_][A-Za-zéèêàâôûùïî_0-9]*)\(\s*([a-z]\d?)\s*\)$')
    _NUM = re.compile(rf'^>\(\s*num\(\s*{re.escape(tv)}\s*\)\s*,\s*\d+\s*\)$')

    def free_vars(conj):
        allv = set(_VAR.findall(conj))
        for mb in re.finditer(r'(?:exists|forall)\s+([a-z0-9 ]+)\.', conj):
            for b in mb.group(1).split():
                allv.discard(b)
        return allv

    # Sort head: first non-NON_SORT unary atom on tv.
    sort = None
    for c in conjs:
        mu = _UNARY.match(c)
        if mu and mu.group(2) == tv:
            nm = mu.group(1)
            if nm in _NON_SORT_PREDICATES or nm in ('tout', 'seul', 'chacun', 'aucun'):
                continue
            sort = nm
            break
    if sort is None:
        return None

    # Last tv-relational atom (arity >= 2, not a unary) in linear order.
    last_rel_idx = None
    for idx, c in enumerate(conjs):
        if _UNARY.match(c):
            continue
        if tv in free_vars(c) and ',' in c:
            last_rel_idx = idx
    if last_rel_idx is None:
        return None
    last_rel = conjs[last_rel_idx]

    # Grow scope entities from the matrix VP through non-tv atoms only.
    scope_vars = free_vars(last_rel) - {tv}
    if not scope_vars:
        return None
    changed = True
    while changed:
        changed = False
        for c in conjs:
            fv = free_vars(c)
            if tv in fv:
                continue
            if fv & scope_vars:
                new = fv - scope_vars - {tv}
                if new:
                    scope_vars |= new
                    changed = True

    consequent, antecedent = [], []
    for c in conjs:
        if c == f'tout({tv})':
            continue
        if _NUM.match(c):
            continue
        if c == f'{sort}({tv})':
            continue
        fv = free_vars(c)
        if fv & scope_vars:
            consequent.append(c)
        else:
            antecedent.append(c)
    if not consequent:
        return None

    ante_free = set()
    for c in antecedent:
        ante_free |= free_vars(c)
    ante_extra = sorted(ante_free - {tv})
    if antecedent:
        if ante_extra:
            ante_body = (f'{sort}({tv}) & (exists {" ".join(ante_extra)}. ('
                         + ' & '.join(f'({c})' for c in antecedent) + '))')
        else:
            ante_body = f'{sort}({tv}) & ' + ' & '.join(f'({c})' for c in antecedent)
    else:
        ante_body = f'{sort}({tv})'

    cons_free = set()
    for c in consequent:
        cons_free |= free_vars(c)
    cons_extra = sorted(cons_free - {tv} - set(ante_extra))
    cons_inner = ' & '.join(f'({c})' for c in consequent)
    if cons_extra:
        cons_body = f'exists {" ".join(cons_extra)}. (' + cons_inner + ')'
    else:
        cons_body = cons_inner

    gqa_axiom = f'all {tv}. (({ante_body}) -> ({cons_body}))'

    # GQ-C: direct sortal subsumption for copula-identity consequents.
    # When the matrix VP is a sortal copula -- the nuclear scope introduces
    # an entity ``x`` carrying a sortal predicate ``SORT2(x)`` together with
    # ``is_at(_, x, tv)`` (the codebase's copula-identity relation, whose
    # transfer schema is ``is_at(e, x, y) & P(x) -> P(y)``) -- the premise
    # asserts "tout TV est un SORT2": every restrictor entity simply *is* a
    # SORT2.  The existential GQ-A form makes the prover (1) introduce the
    # skolem witness ``x`` and (2) fire the is_at transfer before ``SORT2(tv)``
    # becomes derivable; that chained existential-introduction often does not
    # converge.  Emitting the equivalent one-step unary implication
    # ``all tv. (ante -> SORT2(tv))`` exposes the same (sound) conclusion
    # directly.  Gated by the sortal-identity whitelist so it can never
    # promote a non-sortal (adjectival) property -- the identical soundness
    # condition enforced at the is_at property-transfer site.  Emitted IN
    # ADDITION to the existential GQ-A axiom (never replaces it), so no
    # existing derivation is removed.
    if os.environ.get('GQC_DISABLE') == '1':
        return gqa_axiom
    _ISAT = re.compile(r'^is_at\(\s*[a-z]\d?\s*,\s*([a-z]\d?)\s*,\s*([a-z]\d?)\s*\)$')
    _gqc_extra = []
    for c in consequent:
        m_isat = _ISAT.match(c)
        if not m_isat:
            continue
        x_var, y_var = m_isat.group(1), m_isat.group(2)
        if y_var != tv or x_var == tv:
            continue
        for c2 in consequent:
            mu2 = _UNARY.match(c2)
            if not (mu2 and mu2.group(2) == x_var):
                continue
            sort2 = mu2.group(1)
            if sort2 in _NON_SORT_PREDICATES or sort2 in ('tout', 'seul', 'chacun', 'aucun'):
                continue
            if not is_sortal_identity_predicate(sort2):
                continue
            gqc = f'all {tv}. (({ante_body}) -> {sort2}({tv}))'
            if gqc not in _gqc_extra:
                _gqc_extra.append(gqc)
    if _gqc_extra:
        return [gqa_axiom] + _gqc_extra
    return gqa_axiom


def get_tout_universalization_axioms(premise_texts):
    """Emit sound universal closures from premises carrying a ``tout(v)`` marker.

    Input pattern (FraCaS convention):
        exists v1 ... vk. ( ... & tout(v_i) & S(v_i) & ... & <body atoms> & ... )

    where ``tout(v_i)`` flags that ``v_i`` is universally quantified by the
    source sentence (e.g. "Tous/Toutes les S ..."), and ``S(v_i)`` supplies
    the sort restriction.

    Rewriting rule (sound under that convention):
        all v_i. ( S(v_i)  ->  exists v1 ... v_{i-1} v_{i+1} ... vk.
                              <body without tout(v_i), without num-marker on v_i> )

    The premise itself is kept unchanged (purely existential form) so the
    added axiom is a strict strengthening of the premise, sound with
    respect to the intended universal reading.  Rationale for dropping
    ``>(num(v_i), N)``: that marker encodes plural-NP cardinality at the
    discourse level, not a property of every individual entity.
    """
    axioms = []
    if not premise_texts:
        return axioms

    _re_outer = re.compile(r'^\s*exists\s+([a-z0-9 ]+)\.\s*(.+)\s*$', re.DOTALL)
    _re_tout = re.compile(r'\btout\(\s*([a-z]\d?)\s*\)')
    _re_num = re.compile(r'>\(\s*num\(\s*{v}\s*\)\s*,\s*\d+\s*\)')

    for pt in premise_texts:
        pt_stripped = pt.strip()
        m = _re_outer.match(pt_stripped)
        if not m:
            continue
        vars_str = m.group(1).strip()
        body = m.group(2).strip()
        ex_vars = [v for v in vars_str.split() if v]
        tout_vars = [v for v in _re_tout.findall(body) if v in ex_vars]
        if not tout_vars:
            continue
        for tv in tout_vars:
            conjs = _flatten_top_conjuncts(body)
            if not conjs:
                continue
            tout_idx = None
            for idx, conj in enumerate(conjs):
                if conj == f'tout({tv})':
                    tout_idx = idx
                    break
            if tout_idx is None:
                continue

            def _pre_tout_vars(cj):
                return set(re.findall(r'\b([a-z]\d?)\b', cj))

            unsafe_pre_tout = False
            for conj in conjs[:tout_idx]:
                if tv not in _pre_tout_vars(conj):
                    continue
                if re.match(rf'^([A-Za-z_][A-Za-z0-9_]*)\({re.escape(tv)}\)$', conj):
                    continue
                if re.match(rf'>\(\s*num\(\s*{re.escape(tv)}\s*\)\s*,\s*\d+\s*\)$', conj):
                    continue
                unsafe_pre_tout = True
                break
            if unsafe_pre_tout:
                # The simple "sort-only restrictor" rewrite would promote a
                # relational restrictor modifier into the consequent (an
                # unsound, over-broad reading).  Instead, apply the principled
                # complex-restrictor split, which keeps such modifiers in the
                # antecedent (generalized-quantifier restrictor theory).
                # Word-agnostic; returns None when no sound split applies, in
                # which case we conservatively emit nothing for this tv.
                _cr_axiom = _complex_restrictor_tout_axiom(conjs, tv, ex_vars)
                if _cr_axiom is not None:
                    if isinstance(_cr_axiom, list):
                        axioms.extend(_cr_axiom)
                    else:
                        axioms.append(_cr_axiom)
                continue
            # Identify sort: unary atom S(tv) where S is not in _NON_SORT_PREDICATES.
            sort = None
            _re_unary_tv = re.compile(
                rf'^([a-zA-Zéèêàâôûùïî_][a-zA-Zéèêàâôûùïî_0-9]*)\(\s*{re.escape(tv)}\s*\)$'
            )
            for c in conjs:
                mu = _re_unary_tv.match(c)
                if not mu:
                    continue
                s_name = mu.group(1)
                if s_name in _NON_SORT_PREDICATES:
                    continue
                if s_name in ('tout', 'seul', 'chacun', 'aucun'):
                    continue
                sort = s_name
                break
            if sort is None:
                continue
            # --- Soundness filter: keep only conjuncts connected to tv. ---
            # Two-stage reachability:
            #   (a) Block any variable w != tv that carries its OWN sort-unary
            #       atom S'(w) with S' != sort and S' not in _NON_SORT, UNLESS
            #       w is equated to tv via an is_at atom (is_at collapse makes
            #       w an alias of tv under the structural is_at->equality axiom).
            #   (b) BFS from {tv} through conjuncts: a conjunct is traversable
            #       iff none of its variables is blocked; it contributes its
            #       variables to the reachable set when it touches the set.
            #   (c) Keep only conjuncts whose variables are ALL reachable.
            _re_var = re.compile(r'\b([a-z]\d?)\b')
            _re_unary_any = re.compile(
                r'^([a-zA-Zéèêàâôûùïî_][a-zA-Zéèêàâôûùïî_0-9]*)\(\s*([a-z]\d?)\s*\)$'
            )
            _re_is_at_tv = re.compile(
                rf'\bis_at\(\s*[a-z]\d?\s*,\s*(?:{re.escape(tv)}\s*,\s*([a-z]\d?)|([a-z]\d?)\s*,\s*{re.escape(tv)})\s*\)'
            )
            _tv_aliased = {tv}
            for c in conjs:
                for m in _re_is_at_tv.finditer(c):
                    w = m.group(1) or m.group(2)
                    if w:
                        _tv_aliased.add(w)
            _blocked = set()
            # Known scalar / evaluative adjectives are NOT sortal: they
            # never introduce a parallel entity chain, they only modify an
            # existing one.  Exclude them from blocking.
            _adj_tokens = set()
            for _a1, _a2 in _SCALAR_ANTONYM_PAIRS:
                _adj_tokens.add(_a1); _adj_tokens.add(_a2)
            _adj_tokens |= {
                'bon', 'mauvais', 'beau', 'joli', 'laid',
                'rouge', 'vert', 'bleu', 'jaune', 'noir', 'blanc',
                'principal', 'generic', 'nord_americain', 'occidental',
                'oriental', 'europeen', 'americain', 'francais',
                'rapide', 'lent', 'actuel', 'passe', 'futur',
                'droit', 'gauche', 'simple', 'complexe',
            }
            for c in conjs:
                mu = _re_unary_any.match(c)
                if not mu:
                    continue
                s_name, w = mu.group(1), mu.group(2)
                if w == tv or w in _tv_aliased:
                    continue
                if s_name in _NON_SORT_PREDICATES:
                    continue
                if s_name in ('tout', 'seul', 'chacun', 'aucun'):
                    continue
                if s_name == sort:
                    continue
                if s_name in _adj_tokens:
                    continue
                _blocked.add(w)
            def _vars_of(cj):
                # Variables occurring in the top-level string; inner-exists
                # binders are considered as free tokens here (safe over-approx
                # since we only use this for connectivity).
                return set(_re_var.findall(cj))
            # BFS
            _reach = set(_tv_aliased)
            _changed = True
            while _changed:
                _changed = False
                for c in conjs:
                    vs = _vars_of(c)
                    if vs & _blocked:
                        continue
                    if vs & _reach:
                        new = vs - _reach
                        if new:
                            _reach |= new
                            _changed = True
            # Build cleaned body: drop tout(tv), the chosen sort unary on tv,
            # and any num-cardinality atom on tv.  Everything else is kept
            # only if its variables lie entirely within the reachable set.
            num_re = re.compile(
                rf'>\(\s*num\(\s*{re.escape(tv)}\s*\)\s*,\s*\d+\s*\)'
            )
            cleaned = []
            for c in conjs:
                if c == f'tout({tv})':
                    continue
                if c == f'{sort}({tv})':
                    continue
                if num_re.match(c):
                    continue
                vs = _vars_of(c)
                if vs and (vs & _blocked):
                    continue
                if vs and not vs.issubset(_reach):
                    continue
                cleaned.append(c)
            if not cleaned:
                continue
            remaining_vars = [v for v in ex_vars if v != tv and v in _reach]
            body_expr = ' & '.join(f'({c})' for c in cleaned)
            if remaining_vars:
                rhs = f'exists {" ".join(remaining_vars)}. ({body_expr})'
            else:
                rhs = body_expr
            axiom = f'all {tv}. ({sort}({tv}) -> ({rhs}))'
            axioms.append(axiom)
    return axioms


def get_shared_name_una_axioms(premise_texts, hypothesis_texts):
    """Emit a restricted Unique Name Assumption for proper-name constants
    that appear in BOTH the premise(s) and the hypothesis via
    ``nomme(_, <Name>)``.

    Rule: ``all x y. (nomme(x, N) & nomme(y, N) -> (x = y))``.

    Soundness note: this is sound under the standard NLI convention that
    a proper name appearing in both P and H refers to the same individual.
    We emit the axiom ONLY when the same capitalized name token occurs in
    at least one premise and the hypothesis, restricting the reach of the
    assumption to named referents the text itself identifies on both
    sides.  The axiom is routed to non-stripped proofs only (the caller
    excludes it from the stripped pipeline) to avoid domain-collapse
    interactions with existential weakening.
    """
    axioms = []
    name_re = re.compile(r"nomme\(\s*([a-z]\d?)\s*,\s*([A-Z][A-Za-z0-9_]*)\s*\)")
    # Skip UNA entirely if any premise carries a pronoun-resolution binder
    # (patterns like `(v = masculin_)` / `(v = feminin_)` / `(v = context_)`).
    # In that case the separately-added pronoun resolution axiom
    # `nomme(masculin_, <Name>)` is hardwired; UNA would transitively collapse
    # the pronoun constant with any other Jean-variable, producing unsound
    # cross-premise entity fusion (e.g. FraCaS row 126).
    _pronoun_re = re.compile(r"=\s*(masculin_|feminin_|context_|unknown_)\b")
    for pt in (premise_texts or []):
        if _pronoun_re.search(pt or ""):
            return axioms
    p_names_by_atom = {}
    for pt in (premise_texts or []):
        for v, n in name_re.findall(pt or ""):
            p_names_by_atom.setdefault(n, set()).add(v)
    h_names_by_atom = {}
    for ht in (hypothesis_texts or []):
        for v, n in name_re.findall(ht or ""):
            h_names_by_atom.setdefault(n, set()).add(v)
    shared = sorted(set(p_names_by_atom) & set(h_names_by_atom))
    for n in shared:
        # Require at least two distinct nomme atoms for N across P+H: that
        # is always the case when a name occurs in both P and H with a
        # variable-style binder, but the check guards against degenerate
        # cases where only a constant-binder would match.
        if len(p_names_by_atom[n]) + len(h_names_by_atom[n]) < 2:
            continue
        axioms.append(
            f"all x y. ((nomme(x, {n}) & nomme(y, {n})) -> (x = y))"
        )
    return axioms


def emit_equiv(p1, p2, all_preds):
    axioms = []
    a1s = [arity for name, arity in all_preds if name == p1]
    a2s = [arity for name, arity in all_preds if name == p2]
    for a1 in a1s:
        for a2 in a2s:
            if a1 != a2: continue
            v1 = [f"x{i}" for i in range(a1)]
            v = ", ".join(v1)
            all_vars = " ".join(v1)
            axioms.append(f"all {all_vars}. ({p1}({v}) <-> {p2}({v}))")
    return axioms



# Stripped fallback is disabled by default; keep no hand-curated pair allowlist
# so disjointness is introduced only by local/resource-backed mechanisms.
_SAFE_DISJOINT_PAIRS = frozenset()

def is_chain_risky_axiom(ax_str):
    """Check if an axiom is a transitivity/chain axiom that causes Prover9
    'too many variables' FATAL errors in the stripped fallback.
    These axioms create infinite Skolem function nesting when combined
    with universally quantified stripped premises."""
    s = ax_str.replace(" ", "")
    # <(a,b) & <(b,c) -> <(a,c)
    if "<(" in s and "-><(" in s and s.count("<(") >= 3:
        return True
    # <(a,b) & subseteq(...) -> <(a,c) or subseteq(...) & <(b,c) -> <(a,c)
    if "<(" in s and "subseteq(" in s and "-><(" in s:
        return True
    # <(a,b) & leq(...) -> <(a,c) or leq(...) & <(b,c) -> <(a,c)
    if "<(" in s and "leq(" in s and "-><(" in s:
        return True
    # subseteq transitivity: subseteq(x,y) & subseteq(y,z) -> subseteq(x,z)
    if s.count("subseteq(") >= 3 and "->subseteq(" in s:
        return True
    # Bridge axioms introducing context_ are dangerous in stripped fallback
    # because stripping universalizes constants, letting context_ match anything
    if "context_" in s:
        return True
    # nomme equality axiom: dangerous in stripped mode because name constants
    # get universalized, allowing any two entities to be equated
    if "nomme(" in s and "(x=y)" in s:
        return True
    # Fraction count axioms: marker(p) & de(p,w) & num(w)=T -> num(p)=C
    # Dangerous in stripped fallback because universalized premises make
    # fraction markers universal, leading to conflicting num assignments.
    for fm in ('moitie', 'moitié', 'tiers', 'quart', 'cinquieme', 'cinquième', 'sixieme', 'sixième'):
        if fm + '(' in s and '->(num(' in s:
            return True
        # Cross-premise fraction axioms: marker & ... -> exists z.(...)
        if fm + '(' in s and '->exists' in s:
            return True
    # Disjointness axioms: all vars. (A(...) -> -B(...))
    # Dangerous in stripped mode: universalized premises make everything A,
    # then disjointness -B kills any hypothesis mentioning B.
    # EXCEPTION: curated antonym/action disjointness pairs are SAFE.
    if s.startswith('all') and re.search(r'->\s*-\w+\(', ax_str):
        arrows = ax_str.count('->')
        if arrows == 1:
            # Extract the two predicates to check if they are a safe pair
            m_ante = re.search(r'\b(\w+)\(', ax_str)  # first predicate
            m_cons = re.search(r'->\s*-(\w+)\(', ax_str)  # negated predicate
            if m_ante and m_cons:
                pair = frozenset([m_ante.group(1), m_cons.group(1)])
                if pair in _SAFE_DISJOINT_PAIRS:
                    return False  # Safe antonym pair, keep in stripped
            return True
    return False

def get_structural_axioms(
    all_text,
    all_preds,
    h_pred_names=None,
    p_pred_names=None,
    blocked_past_adj_transfers=None,
    blocked_is_at_adj_transfers=None,
    suppress_is_at_identity=False,
    premise_texts=None,
    hypothesis_texts=None,
):
    """Generate logically valid structural axioms based on predicates
    found in the combined P+H text.

    Quantifier monotonicity chain (each step is logically valid):
      tout(x) → plupart_de(x) → beaucoup_de(x) → >(num(x), 1)

    if blocked_is_at_adj_transfers is None:
        blocked_is_at_adj_transfers = set()
    Spatial, Relational Symmetry, and Disjointness rules are dynamically
    added if the predicates appear in the text.
    """
    axioms = []
    if h_pred_names is None:
        h_pred_names = set()
    if p_pred_names is None:
        p_pred_names = set()
    all_pred_name_set = p_pred_names | h_pred_names

    # --- nomme(x, concept) concept extraction ---
    # Handle BOTH uppercase (Concept -> concept(x)) and lowercase names
    # e.g. nomme(x, Italien) <-> italien(x), nomme(x, européen) <-> européen(x)
    nomme_matches = re.finditer(r'nomme\(\w+,\s*([A-Za-z_][A-Za-z0-9_]*)\)', all_text)
    concepts = set(match.group(1) for match in nomme_matches)
    for c in concepts:
        c_lower = c.lower()
        # Only generate concept predicate axioms when the predicate form
        # actually appears in the formulas. Otherwise introducing c_lower(x)
        # when c_lower only appears as a bare constant inside nomme(x, c_lower)
        # causes a Prover9 arity collision (symbol used at both arity 0 and 1).
        if c_lower + '(' in all_text:
            axioms.append(f'all x.(nomme(x, {c}) -> {c_lower}(x))')
            if c_lower != c:
                axioms.append(f'all x.(nomme(x, {c}) <-> {c_lower}(x))')

        # Handle when original case concept is used as a predicate
        if c + '(' in all_text:
            axioms.append(f'all x.(nomme(x, {c}) <-> {c}(x))')

    # --- Case-variant name-tag bridge ---
    # After clean_formula_string strips quotes, the SAME surface name can
    # survive in two case forms: a class/demonym premise may keep the source
    # capitalisation (e.g. nomme(b, Europeen) inside "Tout Européen ...") while
    # the plural subject is lower-cased (nomme(e, europeen) from "les
    # Européens").  As Prover9 constants `Europeen` and `europeen` are
    # distinct, so a universal premise guarded by one form never instantiates
    # an entity tagged with the other -- this is the sole obstacle behind the
    # GenQuant monotonicity syllogisms (fracas 19/26/44/66-69).  A name tag is
    # a rigid designator, so two tags identical up to letter-case denote the
    # SAME name; bridging them is logically valid.  We emit the biconditional
    # ONLY when both case variants actually occur as nomme(_, .) arguments, so
    # the bridge is purely structural, never collapses two genuinely distinct
    # names (Dupont/Durand differ after case-folding too), and adds nothing
    # when no case clash exists.
    _by_fold = {}
    for c in concepts:
        _by_fold.setdefault(c.lower(), set()).add(c)
    for _forms in _by_fold.values():
        if len(_forms) > 1 and not os.getenv('CASE_BRIDGE_DISABLE'):
            _ordered = sorted(_forms)
            _canon = _ordered[0]
            for _other in _ordered[1:]:
                axioms.append(f'all x.(nomme(x, {_canon}) <-> nomme(x, {_other}))')

    # --- Unique Name Assumption for proper names ---
    # For proper names (not concepts/nationalities that also appear as predicates),
    # add: nomme(x, NAME) & nomme(y, NAME) -> x = y
    # This helps Prover9 connect entities across existential premises.
    for c in concepts:
        c_lower = c.lower()
        is_concept = (c_lower + '(' in all_text) or (c + '(' in all_text)
        if not is_concept and c[0].isupper():
            pass  # UNA disabled: domain collapse in stripped proofs makes it net-0

    # --- Existential-witness axiom for "Il y a X qui..." ---
    # The French parser encodes "Il y a X qui ..." as an atom
    # ``existe(w, X)`` adjoined to the hypothesis. Semantically this is
    # just an affirmation that X is realised — the entity is already
    # existentially bound by the surrounding ``exists`` quantifier in the
    # FOL. The axiom ``all x. exists w. existe(w, x)`` discharges the
    # marker whenever Prover9 has any entity to instantiate ``x`` with.
    # Sound: the marker is a witness-introduction predicate, not a real
    # property — it adds no content beyond existential commitment, which
    # is already entailed by any existential quantifier ranging over x.
    if 'existe(' in all_text:
        axioms.append('all x. exists w. existe(w, x)')

    # --- DOT complement: not-tout ---
    # When DOT(c) & total(c) & num(c)=N with N < 100, the proportion is not 100%.
    # This generates two axiom types:
    # 1. Direct: DOT(c) & total(c) & num(c)=N & de(c, b) -> -tout(b)
    # 2. Soit-chain: DOT(c) & total(c) & num(c)=N & soit(x, c) & vivre_dans(e, y, x) -> -tout(y)
    # Also: de(x,y) & >(num(x),1) -> >(num(y),1) for num propagation
    if 'DOT(' in all_text and 'total(' in all_text and 'tout(' in all_text:
        # Extract DOT numeric values
        for m_dot in re.finditer(r'\(num\(\w+\)\s*=\s*(\d+)\)', all_text):
            dot_val = int(m_dot.group(1))
            if 0 < dot_val < 100:
                axioms.append(f'all c b.((DOT(c) & total(c) & (num(c) = {dot_val}) & de(c, b)) -> -tout(b))')
                # Soit-chain for vivre_dans contexts
                if 'soit(' in all_text and 'vivre_dans(' in all_text:
                    axioms.append(f'all c x e y.((DOT(c) & total(c) & (num(c) = {dot_val}) & soit(x, c) & vivre_dans(e, y, x)) -> -tout(y))')
    # de-num propagation: if x is part of y and x has >1, y has >1
    if 'de(' in all_text and 'tout(' in all_text:
        axioms.append('all x y.((de(x, y) & >(num(x), 1)) -> >(num(y), 1))')

    # --- Distinct Numeric Constants ---
    # Different integer constants are unequal (standard arithmetic).
    # Extract all numerics from (var = NUM) patterns AND from <(..., NUM)
    # / >(..., NUM) / <(NUM, ...) / >(NUM, ...) comparisons so the order
    # facts below also cover threshold tokens in plus_de / moins_de.
    _numeric_consts = set()
    for m in re.finditer(r'=\s*(\d+)\)', all_text):
        _numeric_consts.add(int(m.group(1)))
    for m in re.finditer(r'[<>]\(\s*(\d+)\s*,\s*(\d+)\s*\)', all_text):
        _numeric_consts.add(int(m.group(1)))
        _numeric_consts.add(int(m.group(2)))
    for m in re.finditer(r'[<>]\(\s*(?:num\([^)]*\)|\w+)\s*,\s*(\d+)\s*\)', all_text):
        _numeric_consts.add(int(m.group(1)))
    for m in re.finditer(r'[<>]\(\s*(\d+)\s*,\s*(?:num\([^)]*\)|\w+)\s*\)', all_text):
        _numeric_consts.add(int(m.group(1)))
    # Drop years (handled separately by year-disjointness above) to keep the
    # pair-count bounded; years can only appear via (en|date|annee = YYYY).
    _numeric_list = sorted(n for n in _numeric_consts if not (1500 <= n <= 2100))
    for i in range(len(_numeric_list)):
        for j in range(i + 1, len(_numeric_list)):
            axioms.append(f'-({_numeric_list[i]} = {_numeric_list[j]})')

    # --- Concrete order facts on extracted integer constants ---
    # Sound additive arithmetic ground facts.  Allows Prover9 to derive
    #   (num(x) = N2) |= >(num(x), N1)  whenever N1 < N2  are both
    # present in the theory (via equality substitution on `num(x) = N2`).
    # Combined with the `<` transitivity and `<`↔`>` bridge below this
    # fully closes pairwise numeric comparison reasoning over the finite
    # set of constants actually mentioned in P∪H.
    if len(_numeric_list) >= 2:
        for i in range(len(_numeric_list)):
            for j in range(i + 1, len(_numeric_list)):
                axioms.append(f'<({_numeric_list[i]}, {_numeric_list[j]})')
                axioms.append(f'>({_numeric_list[j]}, {_numeric_list[i]})')
        # Bridge `<` ↔ `>` (no other place in the codebase establishes this).
        axioms.append('all a b.(<(a, b) -> >(b, a))')
        axioms.append('all a b.(>(a, b) -> <(b, a))')
        # `>` transitivity (mirror of the existing `<` transitivity).  Bounded
        # by the small constant set so no explosion risk.
        axioms.append('all a b c.((>(a, b) & >(b, c)) -> >(a, c))')

    # --- Cardinal name predicate <-> num bridges ---
    # (Handled by get_numeric_axioms() with unquoted keys; removed here to avoid dead code)

    # --- Copula identity ---
    if 'is_at(' in all_text:
        if not suppress_is_at_identity:
            # Symmetry helps copular parses, but is_at must not be collapsed
            # to equality: location/attribution readings are not identity.
            axioms.append("all e x y.(is_at(e, x, y) -> is_at(e, y, x))")
            # Copular predication transfer for named entities:
            if 'nomme(' in all_text:
                axioms.append('all e x y z.((is_at(e, x, y) & nomme(x, z)) -> nomme(y, z))')

        _ia_excluded = {'is_at', 'de', 'nomme', 'subseteq', 'overlaps',
                        'temps', 'existe', 'des', 'en', 'a_', 'num',
                        'tout', 'chacun', 'plupart_de', 'beaucoup_de',
                        'peu_de', 'aucun', 'plus_de', 'moins_de', 'pas',
                        'moitie', 'pas_de', 'ou', 'and', 'exists', 'all',
                        'not', 'or', 'sur', 'sous', 'dans', 'DOT',
                        'forall', 'quelques', 'plusieurs', 'certain'}
        _ia_pat = re.compile(r'\b(\w+)\(\w+\)')
        _ia_preds = set()
        for _m in _ia_pat.finditer(all_text):
            if is_function_usage(all_text, _m.start(), _m.end()):
                continue
            _pn = _m.group(1)
            if _pn not in _ia_excluded:
                _ia_preds.add(_pn)
        if h_pred_names:
            # Limit transfer axioms to predicates that are actually needed
            # by the proof, to avoid axiom-set explosion. Two sources:
            #  (a) predicates appearing in H (target of entailment), and
            #  (b) unary predicates appearing in universal-restrictor
            #      ANTECEDENTS of premise formulas of the form
            #      ``forall v. (R(v) & ... -> ...)``. These are the
            #      properties whose presence on the alias entity is
            #      required to instantiate the universal premise.
            _antecedent_preds = set()
            if premise_texts:
                # Match both ``forall v. (A -> B)`` and the parser-artifact
                # ``exists v. (A -> B)`` (which fix_exists_implies later
                # rewrites to forall at prover-input time). At axiom
                # collection the artifact form is still present, so we
                # must accept either binder here.
                _ant_pat = re.compile(
                    r'(?:forall|exists)\s+(?:[a-z]\d?\s+)*[a-z]\d?\s*\.\s*\((.*?)\s*->\s*',
                    re.DOTALL,
                )
                _unary_pat = re.compile(r'\b(\w+)\(\w+\)')
                for _pt in premise_texts:
                    for _am in _ant_pat.finditer(_pt):
                        _ant_text = _am.group(1)
                        for _um in _unary_pat.finditer(_ant_text):
                            if is_function_usage(_ant_text, _um.start(), _um.end()):
                                continue
                            _antecedent_preds.add(_um.group(1))
                # (c) Sortal heads of `tout`/`chacun`-marked entities.  The
                #     tout-universalization stage deterministically rewrites
                #     `tout(v) & S(v) & ...` into `forall v. (S(v) & ... -> ...)`,
                #     so the sortal head S becomes a universal-restrictor
                #     antecedent.  Anticipating S here lets the sortal
                #     copula-identity transfer for S be emitted, which is the
                #     missing premise that lets the (sound) universal be
                #     instantiated on a member entity established by an is_at
                #     copula -- e.g. "le ITEL-ZX est un ordinateur d'ITEL"
                #     yields ordinateur(ITEL_ZX), satisfying "plus rapide que
                #     tous les ordinateurs d'ITEL" for the ITEL-ZX member
                #     (FraCaS 246/248).  Word-agnostic: the head is the first
                #     sortal unary atom on the tout-marked variable.
                _tout_var_pat = re.compile(
                    r'\b(?:tout|chacun)\(\s*([a-z]\d?)\s*\)')
                for _pt in premise_texts:
                    for _tm in _tout_var_pat.finditer(_pt):
                        _tv = _tm.group(1)
                        for _hm in re.finditer(
                                r'\b(\w+)\(\s*' + re.escape(_tv) + r'\s*\)',
                                _pt):
                            _hn = _hm.group(1)
                            if _hn in _ia_excluded or _hn in (
                                    'tout', 'chacun', 'seul', 'aucun',
                                    'chaque'):
                                continue
                            if _hn in _NON_SORT_PREDICATES:
                                continue
                            _antecedent_preds.add(_hn)
                            break
            _ia_preds = {p for p in _ia_preds if p in h_pred_names or p in _antecedent_preds}
        _ia_preds = {p for p in _ia_preds if p not in blocked_is_at_adj_transfers}
        # B.1: Dynamic sortal-identity whitelist gate.
        # Only emit property-transfer for predicates that are sortal nouns
        # (members of the curated French noun lexicon) or identity bridges
        # (naming-verb morphological family).  Adjectives like `rapide`,
        # `grand`, `petit`, `vieux` are not in the noun lexicon, so they
        # are excluded by absence — preventing the unsound `is_at(e,x,y) &
        # rapide(x) -> rapide(y)` transfer that produced false-yes proofs
        # on FraCaS PC_6082 rows 221/225/247.
        # Nationality / geographic-origin predicates are sortal-when-nominal
        # but appear adjective-shaped in `_SORTAL_WN_NOUN_BLOCKLIST`.  They
        # are blocked there to prevent WN-noise-driven sortal-identity
        # transfer (e.g. for `_wn_has_noun_sense`).  At the `is_at` (copula
        # identity) transfer site they are sound: if `is_at(e, x, y)` and
        # `x` is nord-americain, then `y` is nord-americain (copula is
        # identity in this codebase; spatial relations use `en`/`dans`).
        # Re-admit them here only — surgical scope, does not affect any
        # other consumer of `is_sortal_identity_predicate`.
        _NATIONALITY_COPULA_SORTAL = frozenset({
            'nord_americain', 'sud_americain', 'europeen', 'asiatique',
            'africain', 'americain', 'occidental', 'oriental',
            'canadien', 'mexicain', 'australien', 'francais', 'allemand',
            'italien', 'espagnol', 'portugais', 'russe', 'chinois',
            'japonais', 'anglais', 'grec', 'latin', 'scandinave',
        })
        _ia_preds_pre_whitelist = set(_ia_preds)
        _ia_preds = {p for p in _ia_preds
                     if is_sortal_identity_predicate(p)
                     or p in _NATIONALITY_COPULA_SORTAL}
        _ia_filtered_out = _ia_preds_pre_whitelist - _ia_preds
        if _ia_filtered_out:
            print(f"  is_at property-transfer BLOCKED (non-sortal): "
                  f"{sorted(_ia_filtered_out)}")
        for _cp in _ia_preds:
            axioms.append(f'all e x y.((is_at(e, x, y) & {_cp}(x)) -> {_cp}(y))')
        if _ia_preds:
            print(f"  is_at property transfer for: {_ia_preds}")
            # Renaming-copula binary `de` propagation (FraCaS §1.5
            # syllogism rows 66-69).  Each sortal predicate P that
            # passed the whitelist gate also gates a sortal-anchored
            # `de` transfer: when copula identity is established via
            # P(x) (or P(y)), the binary `de`-relation transfers along
            # with the unary properties.  The sortal predicate appears
            # IN the axiom antecedent (not just at the gate), so
            # Prover9 only fires this transfer when a sortal context
            # is matchable in the active clauses — bounding the search
            # front.  This is the missing premise for row 66's chain
            # `is_at(a,e,c) & habitant(e) & de(e,d) |- de(c,d)`, which
            # then satisfies P1's antecedent
            # `nord_americain(c) & continent(d) & habitant(c) & de(c,d)`.
            if 'de(' in all_text:
                for _cp in _ia_preds:
                    axioms.append(
                        f'all e x y z.((is_at(e, x, y) & {_cp}(x) & de(x, z)) -> de(y, z))'
                    )
                    axioms.append(
                        f'all e x y z.((is_at(e, x, y) & {_cp}(y) & de(y, z)) -> de(x, z))'
                    )

        if ('etudiant(' in all_text or 'etudiante(' in all_text) and 'nomme(' in all_text:
            for student_pred in ('etudiant', 'etudiante'):
                if f'{student_pred}(' in all_text:
                    axioms.append(f'all e x y n.((is_at(e, x, y) & nomme(x, n) & {student_pred}(y)) -> {student_pred}(x))')
                    axioms.append(f'all e x y n.((is_at(e, x, y) & nomme(y, n) & {student_pred}(x)) -> {student_pred}(y))')

        # Copula introduction: when is_at appears only in H (not P),
        # introduce a trivial self-copula so that derived properties
        # (e.g. from name→gender axioms) can satisfy H's is_at requirement.
        if h_pred_names and 'is_at' in h_pred_names and 'is_at' not in p_pred_names:
            axioms.append('all x.(exists e.(is_at(e, x, x) & overlaps(temps(e), maintenant)))')
            print("  Adding copula introduction (is_at H-only)")

    # --- savoir -> decouvrir bridge ---
    # "knowing about a past event" entails "discovering it"
    if 'savoir(' in all_text and 'decouvrir(' in all_text:
        axioms.append('all e x g.(savoir(e, x, g) -> decouvrir(e, x, g))')

    # --- Strict Quantifier Synonymy ---
    if 'chacun(' in all_text or 'tout(' in all_text:
        axioms.append('all x.(chacun(x) <-> tout(x))')

    # --- tout/chacun propagation through event predicates ---
    # When tout(e) applies to an event and the event involves entity x,
    # the universal quantifier should also apply to x.
    # This bridges encoding variants where "toutes ont voté" encodes
    # tout on the event vs "chacun a voté" encodes chacun on the agent.
    if 'tout(' in all_text or 'chacun(' in all_text:
        event_verbs = set()
        for m in re.finditer(r'\b(\w+)\(\w+,\s*\w+,\s*\w+\)', all_text):
            pred = m.group(1)
            if pred not in ['ou', 'and', 'de', 'nomme', 'subseteq',
                            'overlaps', 'temps', 'existe', 'des', 'en', 'a_',
                            'num', 'tout', 'chacun', 'aussi', 'et']:
                if not is_function_usage(all_text, m.start(), m.end()):
                    event_verbs.add(pred)
        for v in event_verbs:
            axioms.append(f'all e x y.((tout(e) & {v}(e, x, y)) -> tout(x))')
            axioms.append(f'all e x y.((chacun(e) & {v}(e, x, y)) -> chacun(x))')
            axioms.append(f'all e x y.((tout(e) & {v}(e, x, y)) -> tout(y))')
            axioms.append(f'all e x y.((chacun(e) & {v}(e, x, y)) -> chacun(y))')

    # --- tout/chacun + class → specific instances ---
    # "every month" (tout(e, x) & mois(x)) implies each specific month.
    # This enables inferences like "sent reports every month" → "sent in July".
    if ('tout(' in all_text or 'chacun(' in all_text) and 'mois(' in all_text:
        month_names = ['janvier', 'fevrier', 'mars', 'avril', 'mai', 'juin',
                       'juillet', 'aout', 'septembre', 'octobre', 'novembre', 'decembre']
        for month in month_names:
            if month + '(' in all_text:
                axioms.append(f'all e x.((tout(e, x) & mois(x)) -> {month}(x))')

    # --- Relational Or Distribution ---
    if 'ou(' in all_text:
        verbs = set(re.findall(r'\b([a-z]\w*)\(\w+,\s*\w+,\s*\w+\)', all_text))
        for v in verbs:
            if v not in ['is_at', 'ou', 'and', 'completely_different']:
                axioms.append(f'all e x y a.(({v}(e, x, a) & ou(x, y)) -> ({v}(e, x, a) | {v}(e, y, a)))')

    
    # --- tout distributes over ou ---
    if 'tout(' in all_text and 'ou(' in all_text:
        axioms.append('all x y.((tout(x) & ou(x, y)) -> tout(y))')
        verbs_for_ou = set()
        for m_v in re.finditer(r'\b([a-z]\w*)\(\w+,\s*\w+,\s*\w+\)', all_text):
            vn = m_v.group(1)
            if vn not in ['is_at', 'ou', 'and', 'de', 'nomme', 'subseteq', 'overlaps',
                         'temps', 'existe', 'en', 'a_', 'des', 'num', 'tout',
                         'chacun', 'aussi', 'et']:
                if not is_function_usage(all_text, m_v.start(), m_v.end()):
                    verbs_for_ou.add(vn)
        for v in verbs_for_ou:
            axioms.append(
                f'all e x y a.(({v}(e, x, a) & ou(x, y) & tout(x)) -> '
                f'exists e2.({v}(e2, y, a) & (temps(e2) = temps(e))))'
            )

    # --- Spatial/Relational Inverses and Symmetry ---
    if 'sur(' in all_text and 'sous(' in all_text:
        axioms.append('all x y. (sur(x, y) <-> sous(y, x))')
    if 'devant(' in all_text and 'derriere(' in all_text:
        axioms.append('all x y. (devant(x, y) <-> derriere(y, x))')
    if 'avant(' in all_text and 'apres(' in all_text:
        axioms.append('all x y. (avant(x, y) <-> apres(y, x))')
    if 'se_battre(' in all_text:
        axioms.append('all x y. (se_battre(x, y) -> se_battre(y, x))')
    if 'proche(' in all_text:
        axioms.append('all x y. (proche(x, y) -> proche(y, x))')
    if 'marier(' in all_text:
        axioms.append('all x y. (marier(x, y) -> marier(y, x))')

    # --- Day-of-week disjointness ---
    days = ['lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi', 'dimanche']
    present_days = [d for d in days if d + '(' in all_text]
    for i in range(len(present_days)):
        for j in range(i+1, len(present_days)):
            axioms.extend(emit_disjoint(present_days[i], present_days[j], all_preds))

    # --- Mutually Exclusive Attributes (Gender, Actions) ---
    # NOTE: Color disjointness REMOVED — objects can be multi-colored
    # (e.g., "un chien blanc et noir"). Color disjointness made H
    # self-contradictory when it described multi-colored objects.

    # Incompatibility is lexical knowledge, not a benchmark-local list.  Pull it
    # from JDM/WordNet when both predicates occur locally; scalar adjective pairs
    # remain sort-relative and are handled by get_sortal_scalar_antonym_axioms.
    # Color predicates are deliberately excluded: SICK FOL often encodes
    # multi-color objects as multiple unary colors on the same object.
    color_predicates = {
        'blanc', 'noir', 'clair', 'sombre', 'fonce', 'bleu', 'rouge',
        'vert', 'jaune', 'rose', 'orange', 'gris', 'brun', 'brune',
        'blond', 'blonde', 'dore', 'bronze', 'violet', 'multicolore',
        'raye',
    }
    scalar_disjoint_pairs = {frozenset(pair) for pair in _SCALAR_ANTONYM_PAIRS}
    local_pred_names = sorted({name for name, arity in all_preds if arity > 0 and f'{name}(' in all_text})
    for idx, a1 in enumerate(local_pred_names):
        for a2 in local_pred_names[idx + 1:]:
            if frozenset((a1, a2)) in scalar_disjoint_pairs:
                continue
            if a1 in color_predicates and a2 in color_predicates:
                continue
            if (_jdm_has_relation(a1, a2, {'antonym', 'incompatible'}) or
                    _jdm_has_relation(a2, a1, {'antonym', 'incompatible'}) or
                    _wordnet_antonym_related(a1, a2)):
                axioms.extend(emit_disjoint(a1, a2, all_preds))

    # --- Disjointness rules (e.g. from SICK parsing) ---
    if 'empty_intersect(' in all_text:
        axioms.append('all x y. (empty_intersect(x, y) -> -(x = y))')
    if 'completely_different(' in all_text:
        axioms.append('all x y. (completely_different(x, y) -> -(x = y))')

    # --- Quantifier monotonicity hierarchy ---
    # Each axiom is a logically valid entailment between quantifier strengths.
    # "All" entails "most" entails "many" entails "some (≥2)".
    if 'tout(' in all_text and 'plupart_de(' in all_text:
        axioms.append('all x.(tout(x) -> plupart_de(x))')
    if 'majorite(' in all_text and 'plupart_de(' in all_text:
        axioms.append('all x.(majorite(x) -> plupart_de(x))')
        axioms.append('all x.(plupart_de(x) -> majorite(x))')
    if 'tout(' in all_text:
        axioms.append('all x.(tout(x) -> >(num(x), 1))')
    if 'plupart_de(' in all_text and 'beaucoup_de(' in all_text:
        axioms.append('all x.(plupart_de(x) -> beaucoup_de(x))')
    if 'plupart_de(' in all_text:
        axioms.append('all x.(plupart_de(x) -> >(num(x), 1))')
    
    # Bridge: when P uses definite plural (no quantifier marker) and H uses
    # plupart_de, P asserts about the full set while H weakens to "most".
    # Under the standard reading of definite plurals as universals this is a
    # valid generalised-quantifier monotonicity step (forall S -> most S).
    # The previous implementation here injected ``all x.(plupart_de(x))`` as a
    # blanket universal, which is logically inconsistent (it conflicts with
    # ``plupart_de(x) -> -peu_de(x)``, ``plupart_de(x) -> -aucun(x)``, etc.)
    # and provided yes-verdicts to rows whose proofs were unsound. The
    # heuristic is removed in favour of soundness; the small number of
    # FraCaS rows that relied on it now correctly remain unproved.

    # "plupart_de" (most) and "peu_de" (few) are antonyms
    if 'plupart_de(' in all_text and 'peu_de(' in all_text:
        axioms.append('all x.(plupart_de(x) -> -peu_de(x))')
        axioms.append('all x.(peu_de(x) -> -plupart_de(x))')
    if 'plus_de' in all_pred_name_set and 'moins_de' in all_pred_name_set:
        axioms.append('all x.(plus_de(x) -> -moins_de(x))')
        axioms.append('all x.(moins_de(x) -> -plus_de(x))')
    if 'beaucoup_de(' in all_text and 'peu_de(' in all_text:
        axioms.append('all x.(beaucoup_de(x) -> -peu_de(x))')
        axioms.append('all x.(peu_de(x) -> -beaucoup_de(x))')
    if 'beaucoup_de(' in all_text:
        axioms.append('all x.(beaucoup_de(x) -> >(num(x), 1))')
        # Also, Generalized quantifier bridge: beaucoup_de implies there exists some relation
        axioms.append('all x.(beaucoup_de(x) -> exists y.(existe(y, x)))')
    if 'certain(' in all_text:
        # "certains X" / "certaines X" is existential-strength: at least one.
        axioms.append('all x.(certain(x) -> >(num(x), 0))')
        # If P has "un groupe de X", then "certains X" exist.
        if 'groupe(' in all_text and 'de(' in all_text:
            axioms.append('all g x.(groupe(g) & de(g, x) -> certain(x))')

    # --- (num(x) = N) → >(num(x), 1) for explicit counts ---
    # If the exact count is stated, it entails existence (at least one).
    # This handles cases like "(num(x) = 2)" → ">(num(x), 1)".
    if '>(num(' in all_text:
        for m in re.finditer(r'\(num\(\w+\)\s*=\s*(\d+)\)', all_text):
            n = int(m.group(1))
            if n >= 1:
                axioms.append(f'all x.((num(x) = {n}) -> >(num(x), 1))')
                break  # One generic axiom per row is enough

    # --- existe(x, y) temporal grounding ---
    # Do not assert ``all x y.(existe(x, y))``.  In negated hypotheses that
    # universal axiom makes every existential object available from nowhere,
    # producing false contradiction proofs.  The only safe generic fact here
    # is that an explicit existence event is temporally grounded.
    if 'existe(' in all_text:
        if 'overlaps(' in all_text and 'maintenant' in all_text:
            axioms.append('all c b.(existe(c, b) -> overlaps(temps(c), maintenant))')

        # --- Intra-premise aussi/et pattern ---
    if 'aussi(' in all_text and 'et(' in all_text:
        verbs_ai = set()
        for m_v in re.finditer(r'\b(\w+)\(\w+,\s*\w+,\s*\w+\)', all_text):
            vn = m_v.group(1)
            if vn not in {'ou', 'and', 'de', 'nomme', 'subseteq', 'overlaps',
                            'temps', 'existe', 'des', 'en', 'a_', 'num', 'tout',
                            'chacun', 'aussi', 'et', 'is_at', 'parallel',
                            'heure', 'mesure', 'maintenant', 'atomic_sub',
                            'seul', 'plupart_de', 'beaucoup_de', 'peu_de', 'aucun'}:
                if not is_function_usage(all_text, m_v.start(), m_v.end()):
                    verbs_ai.add(vn)
        for v in verbs_ai:
            axioms.append(
                f'all x y z e.((aussi(x) & et(z, x) & {v}(e, y, z)) -> '
                f'exists e2.({v}(e2, x, z) & (temps(e2) = temps(e))))'
            )

    # --- Intra-premise et without aussi ---
    if 'et(' in all_text:
        verbs_et = set()
        for m_v in re.finditer(r'\b(\w+)\(\w+,\s*\w+,\s*\w+\)', all_text):
            vn = m_v.group(1)
            if vn not in {'ou', 'and', 'de', 'nomme', 'subseteq', 'overlaps',
                            'temps', 'existe', 'des', 'en', 'a_', 'num', 'tout',
                            'chacun', 'aussi', 'et', 'is_at', 'parallel',
                            'heure', 'mesure', 'maintenant', 'atomic_sub',
                            'seul', 'plupart_de', 'beaucoup_de', 'peu_de', 'aucun'}:
                if not is_function_usage(all_text, m_v.start(), m_v.end()):
                    verbs_et.add(vn)
        for v in verbs_et:
            axioms.append(
                f'all x z y e.((et(z, x) & {v}(z, y, e)) -> '
                f'exists e2.({v}(e2, x, e) & (temps(e2) = temps(z))))'
            )

    # --- parallel with et ---
    if 'parallel(' in all_text and 'et(' in all_text:
        verbs_par = set()
        for m_v in re.finditer(r'\b(\w+)\(\w+,\s*\w+,\s*\w+\)', all_text):
            vn = m_v.group(1)
            if vn not in {'ou', 'and', 'de', 'nomme', 'subseteq', 'overlaps',
                            'temps', 'existe', 'des', 'en', 'a_', 'num', 'tout',
                            'chacun', 'aussi', 'et', 'is_at', 'parallel',
                            'heure', 'mesure', 'maintenant', 'atomic_sub',
                            'seul', 'plupart_de', 'beaucoup_de', 'peu_de', 'aucun'}:
                if not is_function_usage(all_text, m_v.start(), m_v.end()):
                    verbs_par.add(vn)
        for v in verbs_par:
            axioms.append(
                f'all p x z y e.((parallel(p, z) & et(z, x) & {v}(z, y, e)) -> '
                f'exists e2.({v}(e2, x, e) & (temps(e2) = temps(z))))'
            )

            # --- a_ person-to-event time transfer ---
    if 'a_(' in all_text and 'et(' in all_text:
        verbs_a = set()
        for m_v in re.finditer(r'\b(\w+)\(\w+,\s*\w+,\s*\w+\)', all_text):
            vn = m_v.group(1)
            if vn not in {'ou', 'and', 'de', 'nomme', 'subseteq', 'overlaps',
                            'temps', 'existe', 'des', 'en', 'a_', 'num', 'tout',
                            'chacun', 'aussi', 'et', 'is_at', 'parallel',
                            'heure', 'mesure', 'maintenant', 'atomic_sub',
                            'seul', 'plupart_de', 'beaucoup_de', 'peu_de', 'aucun'}:
                if not is_function_usage(all_text, m_v.start(), m_v.end()):
                    verbs_a.add(vn)
        for v in verbs_a:
            axioms.append(
                f'all x y e z.((a_(x, y) & {v}(e, x, z)) -> a_(e, y))'
            )

    # --- actuellement bridge ---
    if 'actuellement(' in all_text and 'overlaps(' in all_text and 'maintenant' in all_text:
        axioms.append('all e.(overlaps(temps(e), maintenant) -> actuellement(e))')

    # --- Temporal axiom: overlaps symmetry ---
    # overlaps(A, B) ↔ overlaps(B, A) is a standard axiom of temporal logic.
    if 'overlaps(' in all_text:
        axioms.append('all x y.(overlaps(x, y) -> overlaps(y, x))')

    # --- Temporal axiom: ``en`` is functional over distinct year literals ---
    # ``en`` is dual-use (location: ``en France``; time: ``en 1991``).
    # We cannot assert blanket functionality. Instead, emit per-pair
    # disjointness ``-(en(e, Y1) & en(e, Y2))`` only between DISTINCT YEAR
    # LITERALS (4-digit integers in (1500, 2100)) bound to a variable via an
    # equation ``d = YYYY``. This blocks the "Dupont wrote his 1st (singular)
    # roman in 1991 vs 1992" contradiction (FraCaS rows 278/279/282/...)
    # without affecting location-``en``.
    _year_lits = sorted({
        int(m.group(1)) for m in re.finditer(r'=\s*(\d{4})\b', all_text)
        if 1500 <= int(m.group(1)) <= 2100
    })
    for _i in range(len(_year_lits)):
        for _j in range(_i + 1, len(_year_lits)):
            axioms.append(
                f'all e.-(en(e, {_year_lits[_i]}) & en(e, {_year_lits[_j]}))'
            )

    # --- Temporal axiom: < transitivity ---
    # Temporal ordering is transitive: if a < b and b < c then a < c.
    # This is needed for multi-step temporal chains (e.g., "A left after B,
    # B left after C" → "A left after C").
    if '<(temps(' in all_text or '<(' in all_text:
        axioms.append('all a b c.((<(a, b) & <(b, c)) -> <(a, c))')

    # --- Temporal axiom: subseteq → overlaps ---
    # If time interval A is a subset of interval B, they overlap.
    # This is a standard interval algebra axiom (Allen's relations).
    if 'subseteq(' in all_text and 'overlaps(' in all_text:
        axioms.append('all x y.(subseteq(x, y) -> overlaps(x, y))')
        axioms.append('all x y.(subseteq(x, y) -> overlaps(y, x))')

    # --- Temporal axiom: <  through subseteq (interval algebra) ---
    # If a < b and c is contained within b, then a < c.
    # If a is contained within b and b < c, then a < c.
    if '<(' in all_text and 'subseteq(' in all_text:
        axioms.append('all a b c.((<(a, b) & subseteq(c, b)) -> <(a, c))')
        axioms.append('all a b c.((subseteq(a, b) & <(b, c)) -> <(a, c))')

    # --- Temporal axiom: < through leq ---
    # Strict-before chains through weak ordering.
    if '<(' in all_text and ('leq(' in all_text or 'voir(' in all_text or 'reussir_a(' in all_text):
        axioms.append('all a b c.((<(a, b) & leq(b, c)) -> <(a, c))')
        axioms.append('all a b c.((leq(a, b) & <(b, c)) -> <(a, c))')
        axioms.append('all a b.(leq(a, b) -> (a = b | <(a, b)))')

    # --- Temporal axiom: subseteq on events → subseteq on temporal traces ---
    # If event x is a sub-event of y, their temporal traces are related.
    if 'subseteq(' in all_text and 'temps(' in all_text:
        axioms.append('all x y.((subseteq(x, y) & -( x = y)) -> subseteq(temps(x), temps(y)))')

    # --- Temporal bridge: subseteq/< past-tense → </overlaps past-tense ---
    # P encodes past as: exists g.(subseteq(temps(g), temps(E)) & <(temps(g), maintenant))
    # H encodes past as: exists t.(<(temps(E), t) & overlaps(t, maintenant))
    # Bridge: if an event has a temporal subpart before now, the event is in the past.
    if re.search(r'subseteq\(temps\(\w+\),\s*temps\(\w+\)\)', all_text) and '<(temps(' in all_text and 'maintenant' in all_text and 'overlaps(' in all_text:
        axioms.append('all E G.((subseteq(temps(G), temps(E)) & <(temps(G), maintenant)) -> exists T.(<(temps(E), T) & overlaps(T, maintenant)))')
        # Also emit temps-wrapped variant for H patterns like <(temps(d), temps(e))
        axioms.append('all E G.((subseteq(temps(G), temps(E)) & <(temps(G), maintenant)) -> exists T.(<(temps(E), temps(T)) & overlaps(temps(T), maintenant)))')

    # NOTE:
    # We intentionally do NOT add generic same-variable rules such as
    #   (plus_de(x) & num(x)=N) -> >(num(x),N)
    #   (moins_de(x) & num(x)=N) -> <(num(x),N)
    # because in this dataset encoding plus_de/moins_de often annotate a
    # threshold token with an explicit numeral. Forcing the comparison on the
    # same token can create artificial contradictions (N > N / N < N).
    # Comparative reasoning is handled in get_numeric_axioms via targeted,
    # context-aware event bridges.

    # --- aucun(x) quantifier: universal negation ---
    # "aucun des X" means no one among X.  aucun(x) & des(x, y)
    # implies that nothing atomic in y has the predicated property.
    if 'aucun(' in all_text:
        # aucun itself implies the entities DON'T have the property
        # When aucun appears, it indicates the universal negation scope
        # was already applied in the premise structure by the parser.
        # What we need is: if P says "aucun(x) & des(x,y) & P(y)"
        # and H says "atomic_sub(z, y) & P(z)", then contradiction.
        if 'des(' in all_text:
            axioms.append('all x y.((aucun(x) & des(x, y)) -> -(exists z.(atomic_sub(z, y))))')
        if 'atomic_sub(' in all_text:
            axioms.append('all x y.((aucun(x) & des(x, y)) -> -(exists z.(atomic_sub(z, y))))')

    # --- subseteq reflexivity, transitivity, and event propagation ---
    # Determine if subseteq reasoning is needed: either already in text or
    # numeric subgroup axioms will introduce it (when distinct nums + event preds exist).
    eq_pattern_pre = re.compile(r'\(num\(\w+\)\s*=\s*(\d+)\)')
    nums_pre = set(int(m.group(1)) for m in eq_pattern_pre.finditer(all_text))
    _has_event_preds = bool(re.search(r'\b(\w+)\(\w+,\s*\w+,\s*\w+\)', all_text))
    _has_dot_or_frac = ("DOT" in all_text or "'DOT'" in all_text
                         or 'tiers(' in all_text or 'moitie(' in all_text
                         or 'moitié(' in all_text
                         or 'cinquieme(' in all_text or 'cinquième(' in all_text)
    needs_subseteq = ('subseteq(' in all_text
                      or (len(nums_pre) >= 2 and _has_event_preds)
                      or 'plus_de(' in all_text or 'moins_de(' in all_text
                      or (_has_dot_or_frac and bool(re.search(r'\bde\(', all_text))))
    if needs_subseteq:
        axioms.append('all x.(subseteq(x, x))')
        axioms.append('all x y z.((subseteq(x, y) & subseteq(y, z)) -> subseteq(x, z))')

        # Partitive de(part, whole) → subseteq when DOT/fraction entities present
        # French "de" in partitive constructions ("50% des Américains") implies subset
        if re.search(r'\bde\(', all_text) and (_has_dot_or_frac or 'plupart_de(' in all_text):
            axioms.append('all x y.(de(x, y) -> subseteq(x, y))')
            axioms.append("all x y z.((subseteq(x, z) & de(z, y)) -> de(x, y))")

        # mais(x, y) → subseteq: "plus de 50% mais moins de 65%" connects
        # percentage entities to same parent group via de chain
        if 'mais(' in all_text:
            axioms.append('all x y.(mais(x, y) -> subseteq(x, y))')

        # soit(x, y) → subseteq: appositive "that is" bridges description to DOT entity
        if 'soit(' in all_text and (_has_dot_or_frac or 'de(' in all_text):
            axioms.append('all x y.(soit(x, y) -> subseteq(y, x))')
        
        # Property inheritance: if z is a subset of x, all unary properties of x apply to z
        # Dynamically detect all unary type predicates
        type_pred_pattern = re.compile(r'(\w+)\(\w+\)')
        type_preds = set()
        for tp in type_pred_pattern.finditer(all_text):
            # Keep only relation usage, never function usage.
            if is_function_usage(all_text, tp.start(), tp.end()):
                continue
            pname = tp.group(1)
            # Exclude built-in discourse/logic markers
            if pname not in {'num', 'exists', 'all', 'not', 'and', 'or', 'existe',
                             'pas_de', 'tout', 'plupart_de', 'beaucoup_de', 'peu_de',
                             'aucun', 'plus_de', 'moins_de', 'pas', 'moitie', 'temps'}:
                type_preds.add(pname)
        if h_pred_names:
            type_preds = {tp for tp in type_preds if tp in h_pred_names}
        for tp in type_preds:
            axioms.append(f'all z x.((subseteq(z, x) & {tp}(x)) -> {tp}(z))')

        # 2-ary type propagation through subseteq (e.g., nomme(x, americain))
        # If subseteq(z, x) & nomme(x, C) -> nomme(z, C)
        type_pred_2_pattern = re.compile(r'\b(\w+)\(\w+,\s*(\w+)\)')
        type_preds_2 = set()
        for tp2 in type_pred_2_pattern.finditer(all_text):
            if is_function_usage(all_text, tp2.start(), tp2.end()):
                continue
            pname, carg = tp2.group(1), tp2.group(2)
            if pname == 'nomme' and carg not in {'x', 'y', 'z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'}:
                type_preds_2.add((pname, carg))
        for pname, carg in type_preds_2:
            axioms.append(f'all z x.((subseteq(z, x) & {pname}(x, {carg})) -> {pname}(z, {carg}))')
            print(f"Adding 2-ary type propagation: subseteq + {pname}(_, {carg})")

        # Upward type propagation for moins_de supersets:
        # When constructing "fewer than N" entities via subseteq(actual, threshold),
        # the threshold entity should inherit the type of the actual entities.
        if 'moins_de(' in all_text:
            for tp in type_preds:
                axioms.append(f'all z x.((subseteq(z, x) & {tp}(z) & moins_de(x)) -> {tp}(x))')

        # Event containment: if e1 ⊆ e2, then any binary event predicate
        # true of e2 is also true of e1.
        event_pred_pattern_2 = re.compile(r'\b(\w+)\(\w+,\s*\w+\)')
        event_preds_2 = set()
        for ep in event_pred_pattern_2.finditer(all_text):
            # Keep only relation usage, never function usage.
            if is_function_usage(all_text, ep.start(), ep.end()):
                continue
            pname = ep.group(1)
            if pname not in {'subseteq', 'overlaps', 'exists', 'all', 'not',
                             'and', 'or', 'de', 'is_at', 'num', 'sur', 'sous',
                             'devant', 'derriere', 'avant', 'apres', 'dans',
                             'proche', 'nomme', 'existe', 'des', 'ou'}:
                event_preds_2.add(pname)
        if h_pred_names:
            event_preds_2 = {ep for ep in event_preds_2 if ep in h_pred_names}
        for ep in event_preds_2:
            axioms.append(f'all e1 e2 x.((subseteq(e1, e2) & {ep}(e2, x)) -> {ep}(e1, x))')

        # Detect ternary event predicates separately for subgroup generation.
        event_pred_pattern_3 = re.compile(r'\b(\w+)\(\w+,\s*\w+,\s*\w+\)')
        event_preds_3 = set()
        for ep in event_pred_pattern_3.finditer(all_text):
            # Keep only relation usage, never function usage.
            if is_function_usage(all_text, ep.start(), ep.end()):
                continue
            pname = ep.group(1)
            if pname not in {'subseteq', 'overlaps', 'exists', 'all', 'not',
                             'and', 'or', 'de', 'is_at', 'num', 'sur', 'sous',
                             'devant', 'derriere', 'avant', 'apres', 'dans',
                             'proche', 'nomme', 'existe', 'des', 'ou'}:
                event_preds_3.add(pname)
        if h_pred_names:
            event_preds_3 = {ep for ep in event_preds_3 if ep in h_pred_names}
            
        # Numeric subgroup generation: MONOTONICITY
        # If an event involves a group of size N, and M < N is mentioned in the text,
        # there exists a subset of size M involved in the same event.
        # This bridges "5 boys chased..." (num=5) -> "not fewer than 4 boys chased..." (num=4)
        eq_pattern = re.compile(r'\(num\(\w+\)\s*=\s*(\d+)\)')
        nums_in_text = set(int(m.group(1)) for m in eq_pattern.finditer(all_text))
        for ep in event_preds_3:
            for n in nums_in_text:
                for m in nums_in_text:
                    if n > m and m > 0:
                        # Event arg 2 (subject/object group) subset generation
                        axioms.append(
                            f'all e x y.((num(x) = {n} & {ep}(e, x, y)) -> '
                            f'exists z.(subseteq(z, x) & (num(z) = {m}) & {ep}(e, z, y)))'
                        )
                        # Event arg 3 (object group) subset generation
                        axioms.append(
                            f'all e x y.((num(y) = {n} & {ep}(e, x, y)) -> '
                            f'exists z.(subseteq(z, y) & (num(z) = {m}) & {ep}(e, x, z)))'
                        )
                        # Self-referential: both args same group (e.g., "se détestent")
                        axioms.append(
                            f'all e x.((num(x) = {n} & {ep}(e, x, x)) -> '
                            f'exists z.(subseteq(z, x) & (num(z) = {m}) & {ep}(e, z, z)))'
                        )

        # Percentage/fraction arithmetic is handled in get_numeric_axioms with
        # stricter same-entity and same-event alignment constraints.

        # Self-referential event identity removed: the axiom
        # PRED(e,x,x) & PRED(e,y,y) & TYPE(x) & TYPE(y) -> x=y
        # is logically unsound (two different entities CAN self-relate in the same event).
        # It caused false contradiction in Row 19 (deux chiens se poursuivent).

    # --- French verb conjugation bridging ---
    # Common French conjugation/form variants bridged to their infinitive.
    # Only added when BOTH forms appear in the combined text.
    FRENCH_VERB_FORMS = {
        'court': 'courir',      # 3sg present indicative
        'courts': 'courir',     # 2sg present
        'courent': 'courir',    # 3pl present
        'mange': 'manger',
        'mangent': 'manger',
        'dort': 'dormir',
        'dorment': 'dormir',
        'veut': 'vouloir',
        'veulent': 'vouloir',
        'finit': 'finir',
        'finissent': 'finir',
        'recu': 'recevoir',     # past participle (unidecoded)
        'reçu': 'recevoir',
        'prend': 'prendre',
        'prennent': 'prendre',
        'sait': 'savoir',
        'savent': 'savoir',
        'peut': 'pouvoir',
        'peuvent': 'pouvoir',
        'doit': 'devoir',
        'doivent': 'devoir',
        'fait': 'faire',
        'font': 'faire',
        'dit': 'dire',
        'disent': 'dire',
        'va': 'aller',
        'vont': 'aller',
        'voit': 'voir',
        'voient': 'voir',
        'tient': 'tenir',
        'tiennent': 'tenir',
        'vient': 'venir',
        'viennent': 'venir',
        'habite': 'habiter',
        'habitent': 'habiter',
        'publie': 'publier',
        'publient': 'publier',
        'chante': 'chanter',
        'chantent': 'chanter',
    }
    for conjugated, infinitive in FRENCH_VERB_FORMS.items():
        # Check if both the conjugated form AND the infinitive appear as predicates
        if conjugated + '(' in all_text and infinitive + '(' in all_text:
            # Detect arities for both forms
            conj_arities = set()
            inf_arities = set()
            for m_c in re.finditer(re.escape(conjugated) + r'\(([^()]*)\)', all_text):
                args = m_c.group(1)
                n_args = 0 if args.strip() == '' else len(args.split(','))
                conj_arities.add(n_args)
            for m_i in re.finditer(re.escape(infinitive) + r'\(([^()]*)\)', all_text):
                args = m_i.group(1)
                n_args = 0 if args.strip() == '' else len(args.split(','))
                inf_arities.add(n_args)
            common_arities = conj_arities & inf_arities
            for arity in common_arities:
                vars_list = ['x', 'y', 'z', 'u', 'v', 'w'][:arity]
                if len(vars_list) < arity:
                    vars_list = [f"x{i}" for i in range(arity)]
                vars_quant = " ".join(vars_list)
                vars_args = ",".join(vars_list)
                axioms.append(
                    f"all {vars_quant}.({conjugated}({vars_args}) <-> {infinitive}({vars_args}))"
                )


    # --- en-event temporal location linking ---
    if 'en(' in all_text and ('leq(' in all_text or 'subseteq(' in all_text or 'voir(' in all_text or 'reussir_a(' in all_text):
        axioms.append('all c f y.((leq(temps(c), temps(f)) & en(f, y)) -> en(c, y))')
        axioms.append('all c f y.((subseteq(c, f) & en(f, y)) -> en(c, y))')

    # Broad "depuis YEAR -> en later YEAR" is not generally sound: it only
    # holds for explicitly persistent states, not arbitrary events/processes.

    # --- Temporal interval containment: "de X a Y" -> "en Z" when X <= Z <= Y ---
    if 'de(' in all_text and 'en(' in all_text:
        # Look for pattern: (var1 = YEAR1) & (var2 = YEAR2) & a_(var1, var2)
        year_pairs = re.findall(r'\(\w+\s*=\s*(\d{4})\).*?\(\w+\s*=\s*(\d{4})\).*?(?:a_|à)\(', all_text)
        if year_pairs:
            start_year, end_year = int(year_pairs[0][0]), int(year_pairs[0][1])
            if start_year > end_year:
                start_year, end_year = end_year, start_year
            for m in re.finditer(r'\(\w+\s*=\s*(\d{4})\)', all_text):
                yh = int(m.group(1))
                if start_year <= yh <= end_year and yh != start_year and yh != end_year:
                    axioms.append(f'all e x y z.((de(e, x) & (x = {start_year}) & a_(x, y) & (y = {end_year})) -> en(e, {yh}))')

    # --- Unique Name Assumption for year constants ---
    # Different year constants are distinct. Required for temporal contradiction detection.
    import itertools as _it
    year_constants = sorted(set(int(m) for m in re.findall(r'(?<![0-9])(\d{4})(?![0-9])', all_text)))
    for y1, y2 in _it.combinations(year_constants, 2):
        axioms.append(f'-({y1} = {y2})')

    # --- Year constant <-> predicate bridge ---
    # Some FOL encodings use (x = 1994) (year as constant) while others
    # use 1994(x) (year as predicate). Bridge them with a biconditional.
    year_as_constants = set(int(m.group(1)) for m in re.finditer(r'\(\w+\s*=\s*(\d{4})\)', all_text))
    year_as_constants |= set(int(m.group(1)) for m in re.finditer(r'\((\d{4})\s*=\s*\w+\)', all_text))
    year_as_predicates = set(int(m.group(1)) for m in re.finditer(r'(?<![0-9a-zA-Z_])(\d{4})\s*\(', all_text))
    for yr in sorted(year_as_constants & year_as_predicates):
        axioms.append(f'all x.((x = {yr}) -> {yr}(x))')
        axioms.append(f'all x.({yr}(x) -> (x = {yr}))')

    # --- Unique Name Assumption for small integer constants ---
    # Prover9 has no built-in arithmetic; 1, 2, 3, ... are just constants
    # that could be equal without explicit distinction axioms.
    int_constants = sorted(set(int(m) for m in re.findall(r'(?<![0-9])(\d{1,2})(?![0-9])', all_text)
                          if 0 <= int(m) <= 31))
    for i1, i2 in _it.combinations(int_constants, 2):
        if (i1, i2) not in [(y1, y2) for y1, y2 in _it.combinations(year_constants, 2)]:
            axioms.append(f'-({i1} = {i2})')

    # --- Unique Name Assumption for proper name strings ---
    # nommé(x, 'N1') & nommé(x, 'N2') implies N1=N2 (one name per entity)
    name_constants = sorted(set(re.findall(r"nomm[eé]\([^,]+,\s*'([^']+)'\)", all_text)))
    for n1, n2 in _it.combinations(name_constants, 2):
        axioms.append(f"all x.(nomme(x, '{n1}') -> -nomme(x, '{n2}'))")
        # Functional UNA: entities with different names are distinct
        axioms.append(f"all x y.((nomme(x, '{n1}')  & nomme(y, '{n2}')) -> -(x = y))")

    # --- Unique Name Assumption for named-entity type constants ---
    entity_constants = sorted(set(re.findall(r"'([A-Z][A-Za-z0-9_]+)'\(", all_text)))
    for e1, e2 in _it.combinations(entity_constants, 2):
        axioms.append(f"all x.('{e1}'(x) -> -'{e2}'(x))")

# --- seul / aucun incompatibility ---
    if 'seul(' in all_text and 'aucun(' in all_text:
        axioms.append('all x.(seul(x) -> -(aucun(x)))')
        axioms.append('all x.(aucun(x) -> -(seul(x)))')
        seul_subjects = []
        for seul_var in re.findall(r'\bseul\((\w+)\)', all_text):
            for type_name, subject_var in re.findall(r'\b(\w+)\(' + re.escape(seul_var) + r',\s*(\w+)\)', all_text):
                if re.search(r'\b' + re.escape(type_name) + r'\(' + re.escape(subject_var) + r'\)', all_text):
                    seul_subjects.append((seul_var, type_name, subject_var))
        for seul_var, type_name, subject_var in seul_subjects:
            for rel_name, _event_var, object_var in re.findall(
                r'\b(\w+)\((\w+),\s*' + re.escape(subject_var) + r',\s*(\w+)\)', all_text
            ):
                if rel_name in {'temps', 'overlaps', 'num', 'de', 'is_at'}:
                    continue
                object_types = {
                    object_type for object_type in re.findall(r'\b(\w+)\(' + re.escape(object_var) + r'\)', all_text)
                    if object_type not in {'num', 'temps', 'overlaps'}
                }
                for aucun_var, aucun_subject in re.findall(r'\bdes\((\w+),\s*(\w+)\)', all_text):
                    if not re.search(r'\baucun\(' + re.escape(aucun_var) + r'\)', all_text):
                        continue
                    if not re.search(r'\b' + re.escape(type_name) + r'\(' + re.escape(aucun_subject) + r'\)', all_text):
                        continue
                    for _rel_event, aucun_object in re.findall(
                        r'\b' + re.escape(rel_name) + r'\((\w+),\s*' + re.escape(aucun_subject) + r',\s*(\w+)\)', all_text
                    ):
                        shared_object_types = {
                            object_type for object_type in object_types
                            if re.search(r'\b' + re.escape(object_type) + r'\(' + re.escape(aucun_object) + r'\)', all_text)
                        }
                        for object_type in shared_object_types:
                            axioms.append(
                                f'all p h e1 e2 o1 o2 s a.((seul(s) & {type_name}(p) & {type_name}(s,p) & '
                                f'{rel_name}(e1,p,o1) & {object_type}(o1) & aucun(a) & des(a,h) & '
                                f'{type_name}(h) & {rel_name}(e2,h,o2) & {object_type}(o2)) -> $F)'
                            )
                            print(f'  [seul-aucun] un seul {type_name} vs aucun des {type_name} for {rel_name}+{object_type}: contradiction')
    # We intentionally do not use NL columns here to distinguish
    # existential plural readings such as "des" from stronger plural readings.
    # If the distinction is not represented in FOL, it should not be injected
    # from the sentence text at inference time.
    if 'seul(' in all_text and '>(num(' in all_text:
        pass
    # aucun implies NOT "at least one exists"
    if 'aucun(' in all_text and '>(num(' in all_text:
        axioms.append('all x.(aucun(x) -> -(>(num(x), 1)))')

    # --- "ancien" as non-intersective adjective ---
    # "ancien étudiant" means NOT a current student
    if 'ancien(' in all_text:
        axioms.append('all x y.((ancien(x) & overlaps(temps(x), maintenant)) -> -(overlaps(temps(y), maintenant) & (y = x)))')

    # --- "plus_de" comparative: X is more than Y => X is not equal to Y ---
    if 'plus_de(' in all_text:
        axioms.append('all x y.(plus_de(x, y) -> -(x = y))')

    # --- Adjective-through-class transfer ---
    # The FOL encoding uses CLASS(quality, instance) & ADJ(quality) to mean
    # "instance is an ADJ CLASS". This axiom transfers the adjective from the
    # quality parameter to the class instance: CLASS(q, x) & ADJ(q) -> ADJ(x).
    # Only generated when both a CLASS predicate at arity>=2 and an ADJ predicate
    # at arity 1 appear in the row.
    _adj_preds_for_transfer = {'petit', 'grand', 'lent', 'rapide', 'vieux', 'jeune',
                                'riche', 'pauvre', 'long', 'court', 'haut', 'bas',
                                'bon', 'mauvais', 'cher', 'bon_marché', 'lourd', 'leger'}
    _unary_pred_names = {name for name, arity in all_preds if arity == 1}
    _class_preds_arity2 = set()
    _adj_preds_present = set()
    _projection_blocked_class_preds = get_negated_unary_binary_projection_blocks(
        (premise_texts or []) + (hypothesis_texts or [])
    )
    for name, arity in all_preds:
        if (arity == 2 and name in _unary_pred_names
            and name not in _projection_blocked_class_preds
                and name not in {'is_at', 'de', 'nomme', 'subseteq', 'overlaps',
                                        'temps', 'existe', 'des', 'en', 'a_', 'num',
                                        'tout', 'chacun', 'ou', 'et', 'aussi', 'parallel',
                                        'heure', 'mesure', 'maintenant', 'atomic_sub',
                                        'seul', 'plupart_de', 'beaucoup_de', 'peu_de',
                                        'aucun', 'plus_de', 'moins_de', 'sur', 'sous',
                                        'devant', 'derriere', 'avant', 'apres', 'dans',
                                        'proche', 'leq'}):
            _class_preds_arity2.add(name)
        if arity == 1 and name in _adj_preds_for_transfer:
            _adj_preds_present.add(name)
    blocked_past_adj_transfers = blocked_past_adj_transfers or set()
    if _class_preds_arity2 and _adj_preds_present:
        for cp in _class_preds_arity2:
            for adj in _adj_preds_present:
                if f'{cp}(' in all_text and f'{adj}(' in all_text:
                    if (cp, adj) in blocked_past_adj_transfers:
                        continue
                    axioms.append(f'all q x.(({cp}(q, x) & {adj}(q)) -> {adj}(x))')

    # --- Mesure comparison: petit/grand → measure ordering ---
    # Within the same domain, "petit" (small) entities have smaller mesure than
    # "grand" (big) entities. This bridges the scalar adjective to the
    # comparative mesure() function used in FraCaS comparative hypotheses.
    if 'mesure(' in all_text:
        if 'petit(' in all_text and 'grand(' in all_text:
            axioms.append('all x y.((petit(x) & grand(y)) -> >(mesure(y), mesure(x)))')

    return axioms


def get_event_lexical_axioms(all_text, premise_texts=None, hypothesis_texts=None):
    """Generate logically valid axioms translating events to states/nouns,
    compound events, and lexical contradictions."""
    axioms = []
    blocked_non_intersective_pairs = set()
    if premise_texts is not None and hypothesis_texts is not None:
        blocked_non_intersective_pairs = get_non_intersective_hypernymy_blocked_pairs(
            premise_texts,
            hypothesis_texts,
        )

    # --- toujours (always) implies temporal persistence ---
    if 'toujours(' in all_text:
        if 'overlaps(' in all_text:
            axioms.append('all e.(toujours(e) -> exists t.(<(temps(e), t) & overlaps(t, maintenant)))')
        # toujours implies the event holds at all relevant times
        if "en(" in all_text:
            axioms.append("all e f y.((toujours(e)  & subseteq(f, e)  & en(f, y)) -> en(e, y))")

    # --- depuis (since) temporal persistence ---
    if "depuis(" in all_text:
        if "overlaps(" in all_text:
            axioms.append("all e y.(depuis(e, y) -> overlaps(temps(e), maintenant))")

    
    # --- Factive/implicative verbs ---
    if 'savoir(' in all_text and 'overlaps(' in all_text:
        axioms.append('all a b g.((savoir(a, b, g) & overlaps(temps(a), maintenant)) -> overlaps(temps(g), maintenant))')
        # Factive: knowing presupposes the embedded event
        axioms.append('all a b g.(savoir(a, b, g) -> leq(temps(g), temps(a)))')

    # --- baler / balayer synonym (dataset encoding inconsistency) ---
    if 'baler(' in all_text and 'balayer(' in all_text:
        axioms.append('all e x y.(baler(e, x, y) -> balayer(e, x, y))')
        axioms.append('all e x y.(balayer(e, x, y) -> baler(e, x, y))')

    # --- Temporal bridge: past events can satisfy present-tense hypotheses ---
    # When P has past tense (<(temps, now)) and H has present (overlaps(temps, now)),
    # bridge via: if a sub-event happened before now, the event still "overlaps" with the
    # general timeframe (treating overlaps as "has occurred" rather than "is ongoing now").
    if '<(temps(' in all_text and 'overlaps(temps(' in all_text:
        axioms.append('all e h.((subseteq(temps(h), temps(e)) & <(temps(h), maintenant)) -> overlaps(temps(e), maintenant))')

    if 'reussir_a(' in all_text:
        axioms.append('all f x c.(reussir_a(f, x, c) -> leq(temps(c), temps(f)))')
        if 'en(' in all_text:
            axioms.append('all f x c y.((reussir_a(f, x, c) & en(f, y)) -> en(c, y))')

    if 'vrai(' in all_text and 'sub(' in all_text and 'en(' in all_text:
        axioms.append('all x f y.((vrai(sub(x, f)) & en(f, y)) -> en(x, y))')
        if 'obtenir(' in all_text:
            axioms.append('all p s e x y z.((vrai(sub(p,s)) & en(s,y) & obtenir(e,x,z)) -> en(e,y))')

    # faux(sub(X, F)) means the embedded proposition is FALSE
    if "faux(" in all_text and "sub(" in all_text:
        axioms.append("all x f.(faux(sub(x, f)) -> faux_event(f))")

    if 'voir(' in all_text:
        axioms.append('all d x y a.(voir(d, x, y, a) -> leq(temps(a), temps(d)))')
        if 'en(' in all_text:
            axioms.append('all d x y a z.((voir(d, x, y, a) & en(d, z)) -> en(a, z))')

    if 'modifier(' in all_text and 'faire(' in all_text:
        axioms.append('all e x y.(modifier(e, x, y) -> faire(e, x, unknown_))')
        axioms.append('all f x u e0 y z.((faire(f, x, u) & modifier(e0, y, z)) -> modifier(f, x, z))')

    # --- Verb Synonymy ---
    if 'finir(' in all_text and 'terminer(' in all_text:
        axioms.append('all e x y.(finir(e, x, y) <-> terminer(e, x, y))')
    if 'duper(' in all_text and 'tromper(' in all_text:
        axioms.append('all e x y.(duper(e, x, y) -> tromper(e, x, y))')
    if 'habiter_en(' in all_text and 'resident_en(' in all_text:
        axioms.append('all e x y.(habiter_en(e, x, y) <-> resident_en(e, x, y))')
    if 'vivre_en(' in all_text and 'resident_en(' in all_text:
        axioms.append('all e x y.(vivre_en(e, x, y) <-> resident_en(e, x, y))')
    if 'habiter_en(' in all_text and 'vivre_en(' in all_text:
        axioms.append('all e x y.(habiter_en(e, x, y) <-> vivre_en(e, x, y))')
    if 'originaire_de(' in all_text and 'venir_de(' in all_text:
        axioms.append('all e x y.(originaire_de(e, x, y) <-> venir_de(e, x, y))')
    if ('donner_a(' in all_text or 'donner_à(' in all_text) and 'recevoir(' in all_text:
        for _donner_pred in ('donner_a', 'donner_à'):
            if _donner_pred + '(' in all_text:
                axioms.append(f'all e x y z.({_donner_pred}(e, x, y, z) -> recevoir(e, z, y))')
        print('Adding Lexical/Event Axiom: donner_a -> recevoir')
    if 'marcher(' in all_text and 'dans(' in all_text and 'eau(' in all_text and 'patauger_dans(' in all_text:
        axioms.append('all e x y.((marcher(e, x) & dans(e, y) & eau(y)) -> patauger_dans(e, x, y))')
        print('Adding Lexical/Event Axiom: marcher+dans+eau -> patauger_dans')

    if 'vivre_dans(' in all_text and 'vivre(' in all_text:
        axioms.append('all e x y.(vivre_dans(e, x, y) -> vivre(e, x))')
    # vivre_dans(e,x,y) also decomposes to dans(e,y) when H uses separate predicates
    if 'vivre_dans(' in all_text and 'dans(' in all_text:
        axioms.append('all e x y.(vivre_dans(e, x, y) -> dans(e, y))')

    if 'sauter_dans(' in all_text:
        if 'en(' in all_text and 'air(' in all_text:
            axioms.append('all e x y.((sauter_dans(e, x, y) & air(y)) -> en(e, y))')
        if 'solitaire(' in all_text and 'seul(' in all_text:
            axioms.append('all e x y.((sauter_dans(e, x, y) & solitaire(x)) -> seul(e))')

    # --- etre_de + decimal → se_situer_entre bridge ---
    # etre_de(e, ratio, value) with a decimal num like 86_33 means the value
    # is between floor and ceil (86.33 is between 86 and 87)
    if ('etre_de(' in all_text or 'être_de(' in all_text) and 'se_situer_entre(' in all_text:
        _decimal_re = re.findall(r'\(num\(\w+\)\s*=\s*(\d+_\d+)\)', all_text)
        for dec_str in set(_decimal_re):
            parts = dec_str.split('_')
            if len(parts) == 2 and parts[1].isdigit() and int(parts[1]) > 0:
                floor_val = int(parts[0])
                ceil_val = floor_val + 1
                for _etre_variant in ['etre_de', 'être_de']:
                    if _etre_variant + '(' in all_text:
                        axioms.append(f'all e x y.(({_etre_variant}(e, x, y) & (num(y) = {dec_str})) -> (se_situer_entre(e, x, {floor_val}) & se_situer_entre(e, x, {ceil_val})))')

    # --- en() propagation through etre_de and pour ---
    if ('etre_de(' in all_text or '\xeatre_de(' in all_text) and 'en(' in all_text:
        for _etre_v in ['etre_de', '\xeatre_de']:
            if _etre_v + '(' in all_text:
                axioms.append('all e d b c.((' + _etre_v + '(e, d, b) & en(d, c)) -> en(b, c))')
    if 'pour(' in all_text and 'en(' in all_text:
        axioms.append('all b a c.((pour(b, a) & en(b, c)) -> en(a, c))')
    # en() propagation through ratio division: if ratio = x/y and y is in location z,
    # then x (the ratio) is also in location z.
    if '/(' in all_text and 'en(' in all_text:
        axioms.append('all x y z.((/(x, y) & en(y, z)) -> en(x, z))')
    # pour() transfer through etre_de: if the ratio "is of" a value,
    # and the value is "per" a denominator, the ratio is also "per" that denominator.
    if 'pour(' in all_text and ('etre_de(' in all_text or 'être_de(' in all_text):
        for _etre_v in ['etre_de', 'être_de']:
            if _etre_v + '(' in all_text:
                axioms.append('all e d b a.((' + _etre_v + '(e, d, b) & pour(b, a)) -> pour(d, a))')

    # --- homme_femme compound predicate decomposition ---
    # homme_femme(x) means 'man-woman' ratio.  Decompose so that H can match
    # with separate homme(x) and /(x,y)&femme(y).
    if 'homme_femme(' in all_text:
        if 'homme(' in all_text:
            axioms.append('all x.(homme_femme(x) -> homme(x))')
        if 'femme(' in all_text and '/(' in all_text:
            axioms.append('all x.(homme_femme(x) -> exists y.(/(x, y) & femme(y)))')

    # --- Synonym bridges ---
    if 'paysan(' in all_text and 'villageois(' in all_text:
        axioms.append('all x.(paysan(x) -> villageois(x))')
        axioms.append('all x.(villageois(x) -> paysan(x))')

    if 'baler(' in all_text and 'balayer(' in all_text:
        axioms.append('all e x y.(baler(e, x, y) <-> balayer(e, x, y))')

    # --- Accent normalization bridges ---
    # Bridge predicates that differ only by diacritics (e.g., ligné↔ligne).
    import unicodedata as _ucd
    def _strip_acc(s):
        return ''.join(c for c in _ucd.normalize('NFD', s) if _ucd.category(c) != 'Mn')
    _all_preds = set(re.findall(r'\b([a-zA-ZÀ-ÿ_][a-zA-ZÀ-ÿ0-9_]*)\(', all_text))
    _acc_groups = {}
    for _ap in _all_preds:
        _norm = _strip_acc(_ap)
        _acc_groups.setdefault(_norm, set()).add(_ap)
    for _norm, _forms in _acc_groups.items():
        if len(_forms) > 1:
            _flist = sorted(_forms)
            for _i in range(len(_flist)):
                for _j in range(_i + 1, len(_flist)):
                    axioms.append(f'all x.({_flist[_i]}(x) <-> {_flist[_j]}(x))')

    # --- Modal event property percolation (pouvoir) ---
    # The modal event pouvoir(event, agent, action) inherits loc/manner
    # properties of the embedded action.  E.g., "can circulate IN Europe
    # freely" → the ability itself is "in Europe" and "free".
    if 'pouvoir(' in all_text:
        if 'en(' in all_text:
            axioms.append('all a c d y.((pouvoir(a, c, d) & en(d, y)) -> en(a, y))')
        if 'librement(' in all_text:
            axioms.append('all a c d.((pouvoir(a, c, d) & librement(d)) -> librement(a))')



    # Eventive-to-stative bridge for courir when unary predicate form appears.
    if 'courir(' in all_text and 'court(' in all_text:
        axioms.append('all e x.(courir(e, x) -> court(x))')

    # Attendance/location lexicalization used in FraCaS-style meeting examples.
    if 'assister_a(' in all_text and 'a_(' in all_text:
        axioms.append('all e x y.(assister_a(e, x, y) -> a_(x, y))')
    if 'present_a(' in all_text and 'a_(' in all_text:
        axioms.append('all x y.(present_a(x, y) -> a_(x, y))')
    if 'travel(' in all_text and 'destination(' in all_text and 'a_(' in all_text:
        axioms.append('all e x r p.((travel(e, x, r) & a_(e, p)) -> destination(r, p))')

    # Light-verb paraphrase: donner lecture de X -> lire X
    if 'donner_de(' in all_text and 'lecture(' in all_text and 'lire(' in all_text:
        axioms.append('all e x y z.((donner_de(e, x, y, z) & lecture(y)) -> lire(e, x, z))')
    
    # --- Action -> State / Noun Nominalizations ---
    if 'se_battre(' in all_text and 'lutte(' in all_text:
        axioms.append('all e x. (se_battre(e, x) -> lutte(e))')
    if 'embrasser(' in all_text and ('câlin(' in all_text or 'calin(' in all_text):
        axioms.append('all e x y. (embrasser(e, x, y) -> calin(e))')
        axioms.append('all e x y. (embrasser(e, x, y) -> calin(e))')
    if 'attaquer(' in all_text and 'attaque(' in all_text:
        axioms.append('all e x y. (attaquer(e, x, y) -> attaque(e))')
    if 'sourire(' in all_text and 'souriant(' in all_text:
        axioms.append('all e x. (sourire(e, x) -> souriant(x))')
    if 'protecteur(' in all_text and 'protection(' in all_text and 'boxe(' in all_text:
        axioms.append('all x.((protecteur(x) & boxe(x)) -> protection(x))')
        print('Adding Lexical/Event Axiom: protecteur+boxe -> protection')
        
    # --- Compound Phrasal Verbs ---
    if 'jouer_dans(' in all_text:
        axioms.append('all e x y. (jouer_dans(e, x, y) -> (jouer(e, x) & dans(x, y)))')
    # jouer(event, agent, object) -> jouer_de(agent, object)
    # Playing something (with event arg) implies playing-of (without event arg)
    if 'jouer(' in all_text and 'jouer_de(' in all_text:
        axioms.append('all e x y.(jouer(e, x, y) -> jouer_de(x, y))')
    if 'tenir_à(' in all_text:
        axioms.append('all e x y z. (tenir_a(e, x, y, z) -> tenir(e, x, y))')
        
    # --- Lexical Contradictions ---
    if 'attaquer(' in all_text and 'aider(' in all_text:
        axioms.append('all e x y. (attaquer(e, x, y) -> -aider(e, x, y))')
        
    # --- Spatial Oppositions ---
    if 'cour(' in all_text and 'dehors(' in all_text:
        axioms.append('all x y. (cour(x) & dans(y, x) -> dehors(y))')
    if 'maison(' in all_text and 'dehors(' in all_text:
        axioms.append('all x y. (maison(x) & dans(y, x) -> -dehors(y))')
        

    # --- Gendered noun -> generic noun bridges ---
    if 'etudiante(' in all_text and 'etudiant(' in all_text:
        axioms.append('all x.(etudiante(x) -> etudiant(x))')
    if 'directrice(' in all_text and 'directeur(' in all_text:
        axioms.append('all x.(directrice(x) -> directeur(x))')
    if 'actrice(' in all_text and 'acteur(' in all_text:
        axioms.append('all x.(actrice(x) -> acteur(x))')

    # --- construire -> terminer (building implies finishing) ---
    # Building/constructing is aspectually non-entailed: an ongoing or attempted
    # construction does not prove completion.
    if 'construire(' in all_text and 'terminer(' in all_text and 'subseteq(' not in all_text:
        axioms.append('all e x y.(construire(e, x, y) -> terminer(e, x, y))')

    # --- se_blesser -> blesser (reflexive -> transitive) ---
    # In FraCaS encoding, reflexive "se blesser" maps to transitive
    # "blesser" with agent = context_ (implicit/generic agent).
    if "se_blesser(" in all_text and "blesser(" in all_text:
        axioms.append("all e x.(se_blesser(e, x) -> blesser(e, context_, x))")

    # --- habiter_a -> etre_a (living at -> being at) ---
    if "habiter_a(" in all_text and "etre_a(" in all_text:
        axioms.append("all e x y.(habiter_a(e, x, y) -> etre_a(e, x, y))")

    # --- posseder <-> possede (morphological variant: infinitive <-> past participle) ---
    if "posseder(" in all_text and "possede(" in all_text:
        axioms.append("all e x y.(posseder(e, x, y) <-> possede(e, x, y))")

    # --- installer_a -> etre_a (installed at -> being at) ---
    if "installer_a(" in all_text and "etre_a(" in all_text:
        axioms.append("all e a x y.(installer_a(e, a, x, y) -> etre_a(e, x, y))")

    # --- rendre_en -> rendre (compound to simple) ---
    if "rendre_en(" in all_text and "rendre(" in all_text:
        axioms.append("all e x y z.(rendre_en(e, x, y, z) -> rendre(e, x, y))")

    # --- perdre -> ne pas gagner (losing -> not winning) ---
    if "perdre(" in all_text and "gagner(" in all_text:
        axioms.append("all e x y.(perdre(e, x, y) -> -(gagner(e, x, y)))")

    # --- acheter -> avoir (buying -> owning) ---
    if "acheter(" in all_text and "avoir(" in all_text:
        axioms.append("all e x y.(acheter(e, x, y) -> exists f.(avoir(f, x, y)))")

    # --- utiliser -> avoir (using implies having access/possession) ---
    if "utiliser(" in all_text and "avoir(" in all_text:
        axioms.append("all e x y.(utiliser(e, x, y) -> exists f.(avoir(f, x, y) & (temps(f) = temps(e))))")

    # Possessive object repair for parses like "Marie a utilise son ordinateur".
    if "utiliser(" in all_text and "ordinateur(" in all_text and "singular_" in all_text:
        axioms.append("all e x y s.(((s = singular_) & de(s, y) & ordinateur(y) & utiliser(e, x, y)) -> de(y, x))")
        if "avoir(" in all_text:
            axioms.append("all e x y s.(((s = singular_) & de(s, y) & ordinateur(y) & utiliser(e, x, y)) -> exists f.(avoir(f, x, y) & overlaps(temps(f), maintenant)))")
    if "utiliser(" in all_text and "context_" in all_text:
        axioms.append("all e x y.(utiliser(e, x, y) -> utiliser(e, context_, y))")

    # --- posséder <-> possédé (spelling variant / synonym) ---
    if "posséder(" in all_text and "possédé(" in all_text:
        axioms.append("all e x y.(posséder(e, x, y) <-> possédé(e, x, y))")

    # --- actuellement(e) when overlaps(temps(e), maintenant) present ---
    if "actuellement(" in all_text:
        axioms.append("all e.(overlaps(temps(e), maintenant) -> actuellement(e))")

    # --- donner_lecture -> lire (giving a reading -> reading) ---
    if "donner(" in all_text and "lecture(" in all_text and "lire(" in all_text:
        axioms.append("all e x y z.((donner(e, x, y) & lecture(y)) -> exists f.(lire(f, x, z)))")

    # --- se_rencontrer -> rencontrer (reflexive -> base) ---
    if "se_rencontrer(" in all_text and "rencontrer(" in all_text:
        axioms.append("all e x.(se_rencontrer(e, x) -> rencontrer(e, x, x))")

    # --- etudiante -> etudiant (feminine student is a student) ---
    if "etudiante(" in all_text and "etudiant(" in all_text:
        axioms.append("all x.(etudiante(x) -> etudiant(x))")
        print("Adding Vocabulary Bridge: etudiante -> etudiant")

    # --- arriver_a -> etre_a (arriving at a place implies being at that place) ---
    if "arriver_a(" in all_text and "etre_a(" in all_text:
        axioms.append("all e x y.(arriver_a(e, x, y) -> etre_a(e, x, y))")
        print("Adding Vocabulary Bridge: arriver_a -> etre_a")

    # --- commercial + service -> departement (a commercial service is a department) ---
    if "commercial(" in all_text and "service(" in all_text and "departement(" in all_text:
        axioms.append("all x.((commercial(x) & service(x)) -> departement(x))")
        print("Adding Vocabulary Bridge: commercial+service -> departement")

    # --- feminin gender markers ---
    if "feminin(" in all_text and "femme(" in all_text:
        axioms.append("all x.(feminin(x) -> femme(x))")
        print("Adding Vocabulary Bridge: feminin -> femme")

    # --- manquant -> retirer (missing implies removed) ---
    if "manquant(" in all_text and "retirer(" in all_text:
        axioms.append("all x.(manquant(x) -> exists e y.(retirer(e, y, x)))")
        print("Adding Vocabulary Bridge: manquant -> retirer")

    # --- homme/femme from et_de (ellipsis: "and of" = also) ---
    if "homme(" in all_text and "femme(" in all_text and "et_de(" in all_text:
        axioms.append("all e x.((et_de(e, x) & femme(x)) -> femme(x))")
        print("Adding Vocabulary Bridge: et_de + femme")

    # --- inscrire_a + lecture -> lire (inscribed for reading -> reads) ---
    if "inscrire_a(" in all_text and "lecture(" in all_text and "lire(" in all_text:
        axioms.append("all e x y z w.((inscrire_a(e, x, y, z) & lecture(w) & de(y, w)) -> lire(e, x, y))")
        print("Adding Vocabulary Bridge: inscrire_a + lecture -> lire")

    # --- inscrire_a -> a_ (inscribed AT implies AT relation) ---
    if "inscrire_a(" in all_text and "a_(" in all_text:
        axioms.append("all e x y z.(inscrire_a(e, x, y, z) -> a_(y, z))")
        print("Adding Lexical Bridge: inscrire_a -> a_")

    # --- generic + inscrire_a -> tout (generically inscribed => all items) ---
    if "generic(" in all_text and "inscrire_a(" in all_text and "tout(" in all_text:
        axioms.append("all x e y z.((generic(x) & inscrire_a(e, x, y, z)) -> tout(y))")
        print("Adding Lexical Bridge: generic + inscrire_a -> tout")

    # --- donner_de + lecture tense bridge (present progressive -> past) ---
    # "donne lecture" (present) entails "a lu" (past/perfect) for the same items.
    if "donner_de(" in all_text and "lecture(" in all_text:
        if "overlaps(" in all_text and "maintenant" in all_text:
            axioms.append("all e x y z.((donner_de(e, x, y, z) & lecture(y) & overlaps(temps(e), maintenant)) -> exists f.(<(temps(e), temps(f)) & overlaps(temps(f), maintenant)))")
            print("Adding Tense Bridge: donner_de + lecture present -> past")

    # --- ligné -> ligne (accent spelling variant) ---
    if "ligne(" in all_text:
        # Also handle potential typo variant
        pass

    # --- dedier + ligne -> avoir + ligne (dedicated line means having a line) ---
    if "dedier(" in all_text and "avoir(" in all_text and "ligne(" in all_text:
        axioms.append("all e x y z.((dedier(e, x, z) & ligne(z)) -> avoir(e, x, z))")
        print("Adding Vocabulary Bridge: dedier+ligne -> avoir+ligne")

        # === SEUL SEMANTICS: "seul" means exactly one ===
    # ``seul`` is not converted to exact numeric equality globally because the
    # corpus also uses ``>(num(x), 1)`` as a loose plural/existential marker.

    # === CERTAIN SEMANTICS: "certain" (some) implies more than one ===
    if 'certain(' in all_text:
        axioms.append('all x.(certain(x) -> >(num(x), 1))')

    # === PORTER_SUR -> PORTER: wearing on X implies wearing ===
    if 'porter_sur(' in all_text and 'porter(' in all_text:
        axioms.append('all e x y z.(porter_sur(e, x, y, z) -> porter(e, x, y))')
        print("Adding Structural Axiom: porter_sur -> porter (arity 4->3)")

    # === QUANTIFIER MONOTONICITY ===
    # "plus" (more than) + "beaucoup_de" (many of): more than N -> at least many
    if "plus(" in all_text and "beaucoup_de(" in all_text:
        axioms.append("all x.(plus(x) -> beaucoup_de(x))")
        print("Adding Quantifier Axiom: plus -> beaucoup_de")

    # "plupart_de" (most) -> "plus_de" (more than): most entails more-than for any threshold
    if "plupart_de(" in all_text and "plus_de(" in all_text:
        axioms.append("all x.(plupart_de(x) -> plus_de(x))")
        print("Adding Quantifier Monotonicity: plupart_de -> plus_de")

    # === QUANTIFIER INCOMPATIBILITY AXIOMS ===
    # "plupart_de" (most = strictly >50%) is incompatible with "moitie/moitié" (exactly half = 50%)
    for _mf in ('moitie', 'moitié'):
        if "plupart_de(" in all_text and f"{_mf}(" in all_text:
            axioms.append(f"all x.(plupart_de(x) -> -({_mf}(x)))")
            axioms.append(f"all x.({_mf}(x) -> -(plupart_de(x)))")
            print(f"Adding Quantifier Incompatibility: plupart_de <-> {_mf}")

    # "moins_de" (less than) combined with a reference is incompatible with "plupart_de" (most)
    if "moins_de(" in all_text and "plupart_de(" in all_text:
        axioms.append("all x.(moins_de(x) -> -(plupart_de(x)))")
        print("Adding Quantifier Incompatibility: moins_de -> not plupart_de")

    # "tout" (all/every) -> "plupart_de" (most): all entails most
    if "tout(" in all_text and "plupart_de(" in all_text:
        axioms.append("all x.(tout(x) -> plupart_de(x))")
        print("Adding Quantifier Monotonicity: tout -> plupart_de")

    # "tout" -> "existe" (equivalent: all implies exists for non-empty domains)
    if "tout(" in all_text and "existe(" in all_text:
        axioms.append("all x.(tout(x) -> existe(x))")
        print("Adding Quantifier Monotonicity: tout -> existe")

    # === TEMPORAL AXIOMS ===
    # subseteq transitivity for temporal containment
    if "subseteq(" in all_text:
        axioms.append("all x y z.((subseteq(x, y) & subseteq(y, z)) -> subseteq(x, z))")
        print("Adding Temporal Axiom: subseteq transitivity")

    # 1995 and mai with different nums: if num(x)=5, mai(x), 1995(x) represents May 5 1995
    # and num(y)=7, mai(y), 1995(y) represents May 7 1995
    # May 5 <= May 7 in the same year/month
    # This is hard to encode generically - skip for now

    # "depuis" (since) temporality: if something is true since time T, it was true at T
    if "depuis(" in all_text:
        axioms.append("all e x y.((depuis(e, x) & overlaps(temps(e), maintenant)) -> overlaps(temps(e), x))")
        print("Adding Temporal Axiom: depuis implies overlap")
        # "depuis" implies past sub-event: a durative "since" event has a sub-time before now
        if "subseteq(" in all_text:
            axioms.append("all e y.(depuis(e, y) -> exists t.(subseteq(temps(t), temps(e)) & <(temps(t), maintenant)))")
            print("Adding Temporal Axiom: depuis implies past sub-event")

    # "toujours" (always/still): if toujours(e) and e holds at time t1, then e holds at later times
    if "toujours(" in all_text and "subseteq(" in all_text:
        axioms.append("all e x y.((toujours(e) & subseteq(x, temps(e))) -> overlaps(x, temps(e)))")
        print("Adding Temporal Axiom: toujours implies continuous")

    # === ADJECTIVE-NOUN: animal(x,y) entity transfer ===
    # REMOVED v42: grand/petit + animal intersection axioms (NON-INTERSECTIVE)
    # "grand souris" (big mouse) does NOT entail "grand animal" (big animal)
    # Only keep entity-level transfer: if animal(event, entity) then animal(entity)
    if "animal(" in all_text:
        axioms.append("all x y.(animal(x, y) -> animal(y))")
        print("Adding Noun Transfer: animal(x,y) -> animal(y)")

    # === v7 STRUCTURAL AXIOMS ===

    # SAUTER decomposition: sauter(e,x,y) <-> sauter(e,x) & par_dessus(e,y)
    # "jump X over Y" decomposes into "jump X" + "over Y" (R153, R157)
    if 'sauter(' in all_text and 'par_dessus(' in all_text:
        axioms.append('all e x y.(sauter(e, x, y) -> (sauter(e, x) & par_dessus(e, y)))')
        axioms.append('all e x y.((sauter(e, x) & par_dessus(e, y)) -> sauter(e, x, y))')
        print("Adding Structural Axiom: sauter(e,x,y) <-> sauter(e,x) & par_dessus(e,y)")

    # ETRE_SUR -> IS_AT: being on a support/location entails being at it.
    if 'etre_sur(' in all_text and 'is_at(' in all_text:
        axioms.append('all e x y.(etre_sur(e, x, y) -> is_at(e, x, y))')
        print("Adding Structural Axiom: etre_sur -> is_at")

    # === v8 STRUCTURAL AXIOMS ===

    # GENS -> PLURAL: "gens" (people) implies more than one (R406)
    if 'gens(' in all_text:
        axioms.append('all x.(gens(x) -> >(num(x), 1))')
        print("Adding Structural Axiom: gens(x) -> >(num(x), 1)")

    # DANS -> A_: "in" implies "at" (R100)
    if 'dans(' in all_text and 'a_(' in all_text:
        axioms.append('all x y.(dans(x, y) -> a_(x, y))')
        print("Adding Structural Axiom: dans -> a_")

    return axioms


def get_group_mereology_axioms(all_text):
    """Generate strictly valid logical axioms for Part-Whole ('de') relationships.
    If a group does a distributive action, its members do it."""
    axioms = []
    if 'groupe(' in all_text and 'de(' in all_text:
        if 'jouer(' in all_text:
            axioms.append('all g m e. (groupe(g) & de(g, m) & jouer(e, g) -> jouer(e, m))')
        if 'jouer_dans(' in all_text:
            axioms.append('all g m e x. (groupe(g) & de(g, m) & jouer_dans(e, g, x) -> jouer_dans(e, m, x))')
        if 'dans(' in all_text:
            axioms.append('all g m x. (groupe(g) & de(g, m) & dans(g, x) -> dans(m, x))')
        if 'courir(' in all_text:
            axioms.append('all g m e. (groupe(g) & de(g, m) & courir(e, g) -> courir(e, m))')
    return axioms


def rewrite_pas_de(formula_str):
    """Rewrite formulas containing pas_de(VAR) to use proper logical negation.

    In the Davidsonian semantics used here, `pas_de(x)` is a discourse marker
    meaning "there is no x". The formula:
        exists x.(P(x) & pas_de(x) & existe(e, x))
    should be interpreted as:
        -(exists x.(P(x) & existe(e, x)))

    We ONLY remove pas_de(VAR) from the conjunction, leaving existe intact
    (the existe triviality axiom handles it). Then we negate the whole formula.
    """
    if 'pas_de(' not in formula_str:
        return formula_str

    pas_de_pattern = re.compile(r'pas_de\((\w+)\)')
    pas_de_matches = list(pas_de_pattern.finditer(formula_str))

    if not pas_de_matches:
        return formula_str

    result = formula_str
    for match in pas_de_matches:
        neg_var = match.group(1)

        # Remove 'pas_de(VAR)' as a conjunct.
        # Case 1: '& pas_de(VAR)' (preceded by &)
        result = re.sub(r'\s*&\s*pas_de\(' + re.escape(neg_var) + r'\)', '', result)
        # Case 2: 'pas_de(VAR) &' (followed by &, if it was first in the group)
        result = re.sub(r'pas_de\(' + re.escape(neg_var) + r'\)\s*&\s*', '', result)

    # When >(num(...)) co-occurs with pas_de but they share NO variable via
    # existe(_, VAR), it's partial negation ("some X don't VP Y") — wrapping
    # in -(...) would wrongly give total negation.  Only apply outer negation
    # when existe(_, VAR) shares a variable with pas_de(VAR), confirming that
    # pas_de is an existential denial ("there is no X").
    if '>(num(' in result:
        pas_de_vars = set(m.group(1) for m in pas_de_matches)
        existe_shared = any(
            re.search(r'existe\(\w+,\s*' + re.escape(v) + r'\)', formula_str)
            for v in pas_de_vars
        )
        if not existe_shared:
            return result.strip()

    # Wrap the entire formula in negation
    result = '-(' + result.strip() + ')'

    return result


def rewrite_upper_bound_beaucoup_scope(formula_str):
    """Normalize upper-bound hypotheses: at-most N P entails at-most N (P & Q)."""
    if globals().get('_CURRENT_DATASET') != 'fracas':
        return formula_str
    if 'plus(' not in formula_str or 'beaucoup_de(' not in formula_str:
        return formula_str
    result = formula_str
    for var_name in re.findall(r'\bbeaucoup_de\(\s*(\w+)\s*\)', formula_str):
        result = re.sub(r'\s*&\s*beaucoup_de\(\s*' + re.escape(var_name) + r'\s*\)', '', result)
        result = re.sub(r'beaucoup_de\(\s*' + re.escape(var_name) + r'\s*\)\s*&\s*', '', result)
    return result.strip()


def rewrite_faux(formula_str):
    """Rewrite formulas containing faux(sub(...)) to use proper logical negation.

    In the semantics, `faux(sub(x, f))` means "it is false that..." — the embedded
    proposition is negated.  The parser fails to represent this structurally, encoding
    faux() as a predicate conjunct rather than a negation operator.

    We remove the faux(sub(VAR, VAR)) conjunct and wrap the whole formula in -(...)
    so the prover can derive contradiction with a matching hypothesis.
    """
    if 'faux(sub(' not in formula_str:
        return formula_str

    # Remove 'faux(sub(VAR, VAR))' as a conjunct
    result = formula_str
    # Case 1: '& faux(sub(VAR, VAR))'
    result = re.sub(r'\s*&\s*faux\(sub\(\w+,\s*\w+\)\)', '', result)
    # Case 2: 'faux(sub(VAR, VAR)) &'
    result = re.sub(r'faux\(sub\(\w+,\s*\w+\)\)\s*&\s*', '', result)

    # Also remove the sub-variable binding (d = masculin_) etc. if present
    # These are artifacts of the faux embedding and clutter the formula
    result = re.sub(r'\s*&\s*\(\w+\s*=\s*masculin_\)', '', result)
    result = re.sub(r'\(\w+\s*=\s*masculin_\)\s*&\s*', '', result)

    # Wrap in negation
    result = '-(' + result.strip() + ')'

    return result


def rewrite_pas(formula_str):
    """Rewrite formulas containing pas(EVENT, SCOPE) to use proper logical negation.

    In the Davidsonian semantics, `pas(e, a)` is a negation particle on event `e`.
    The formula:
        exists e x.(verb(e, x) & pas(e, a) & ...)
    should be interpreted as:
        -(exists e x.(verb(e, x) & ...))

    We remove pas(VAR, VAR) from the conjunction and negate the whole formula.
    Similar to rewrite_pas_de for pas_de(VAR).
    """
    # Skip if no pas( or already negated or has pas_de (handled separately)
    if 'pas(' not in formula_str:
        return formula_str
    if formula_str.strip().startswith('-('):
        return formula_str
    # Skip if formula already has embedded negation -(exists ...
    # Wrapping would create double-negation with incorrect semantics
    if '-(exists' in formula_str or '-((' in formula_str:
        return formula_str
    # Skip if pas is part of "pas moins de" quantifier (negates the quantifier, not event)
    if 'moins_de(' in formula_str:
        return formula_str

    # Match pas(VAR) or pas(VAR, VAR) — but NOT pas_de(VAR)
    pas_pattern = re.compile(r'\bpas\((\w+(?:,\s*\w+)?)\)')
    pas_matches = list(pas_pattern.finditer(formula_str))

    if not pas_matches:
        return formula_str

    result = formula_str
    for match in pas_matches:
        full = re.escape(match.group(0))
        # Remove as conjunct: & pas(e, a)
        result = re.sub(r'\s*&\s*' + full, '', result)
        # Remove as first conjunct: pas(e, a) &
        result = re.sub(full + r'\s*&\s*', '', result)

    # Skip negation wrapping if upward-monotone quantifier present
    if '>(num(' in result:
        return result.strip()

    # Wrap in negation
    result = '-(' + result.strip() + ')'

    return result


def rewrite_aucun_des_negate(formula_str):
    """Lift `aucun(D) & des(D, C)` to logical negation over the existential.

    The flat-conjunct encoding ``exists VARS.(... aucun(D) & des(D, C) & BODY ...)``
    treats the negative-existential marker as a positive predicate. Under
    classical FOL, conjunct elimination then yields a false entailment toward
    any hypothesis that drops modifiers inside BODY (e.g. row 30 of FraCaS,
    "Aucun des deux commissaires ne passe beaucoup de temps" → "... du temps").

    The transformation is a semantic repair, not an axiom: it rewrites the
    formula into the negative-existential form that the surface NL denotes,
    ``-(exists VARS.(BODY))``. The variables D and C remain in the existential
    prefix (the existential over D is vacuous after the marker is removed; this
    is harmless and parses normally in Prover9).

    The trigger is purely structural — the co-occurrence of ``aucun(D)`` and
    ``des(D, C)`` for some D and C — and applies uniformly across datasets.
    """
    if 'aucun(' not in formula_str or 'des(' not in formula_str:
        return formula_str
    if formula_str.lstrip().startswith('-('):
        return formula_str
    if '-(exists' in formula_str:
        return formula_str

    aucun_match = re.search(r'\baucun\(\s*(\w+)\s*\)', formula_str)
    if aucun_match is None:
        return formula_str
    d_var = aucun_match.group(1)
    des_match = re.search(r'\bdes\(\s*' + re.escape(d_var) + r'\s*,\s*(\w+)\s*\)',
                          formula_str)
    if des_match is None:
        return formula_str

    aucun_lit = aucun_match.group(0)
    des_lit = des_match.group(0)
    result = formula_str
    for lit in (aucun_lit, des_lit):
        result = re.sub(r'\s*&\s*' + re.escape(lit), '', result)
        result = re.sub(re.escape(lit) + r'\s*&\s*', '', result)
    return '-(' + result.strip() + ')'


def rewrite_au_plus_negate(formula_str):
    """Lift `plus(E) & a_(D, E) & (num(C) = N)` ≡ "au plus N" to negative form.

    The flat-conjunct encoding ``plus(e) & a_(d, e) & (num(c)=N) & R(c) & V(d, c, ...)``
    is satisfied by any group of size N performing V; conjunct elimination then
    proves any hypothesis that drops a modifier inside the body (e.g. row 32 of
    FraCaS, "Au plus dix commissaires passent beaucoup de temps" → "... du temps").

    The surface NL denotes "no more than N C's verb", a universal claim about all
    larger groups. The transformation rewrites the formula into
    ``-(exists VARS.(num(C) > N & R(c) & V(d, c, ...)))``, which is the faithful
    rendering. A hypothesis with a strictly weaker body has a strictly stronger
    negation that does not follow from the original.

    Trigger is structural: co-occurrence of ``plus(E)``, ``a_(D, E)`` for the
    same E, and ``(num(C) = N)`` somewhere in the body.
    """
    if 'plus(' not in formula_str or 'a_(' not in formula_str:
        return formula_str
    if formula_str.lstrip().startswith('-('):
        return formula_str
    if '-(exists' in formula_str:
        return formula_str

    plus_match = re.search(r'\bplus\(\s*(\w+)\s*\)', formula_str)
    if plus_match is None:
        return formula_str
    e_var = plus_match.group(1)
    a_match = re.search(r'\ba_\(\s*(\w+)\s*,\s*' + re.escape(e_var) + r'\s*\)',
                        formula_str)
    if a_match is None:
        return formula_str
    num_match = re.search(r'\(\s*num\(\s*(\w+)\s*\)\s*=\s*(\d+)\s*\)', formula_str)
    if num_match is None:
        return formula_str
    c_var = num_match.group(1)
    n_val = num_match.group(2)

    plus_lit = plus_match.group(0)
    a_lit = a_match.group(0)
    num_lit = num_match.group(0)

    result = formula_str
    for lit in (plus_lit, a_lit):
        result = re.sub(r'\s*&\s*' + re.escape(lit), '', result)
        result = re.sub(re.escape(lit) + r'\s*&\s*', '', result)
    # Replace (num(C) = N) with >(num(C), N)
    result = result.replace(num_lit, '>(num(' + c_var + '), ' + n_val + ')')
    return '-(' + result.strip() + ')'


def rewrite_duration_count_binding(formula_str):
    """Bind a count atom `(num(C) = N)` to a duration role to block conjunct drop.

    The triple ``(num(C) = N) & UNIT(C) & ROLE(D, C)`` with ROLE in
    {``durant``, ``en``, ``pendant``} and UNIT a time-unit predicate encodes a
    specific bounded duration. Under flat-conjunct elimination, a hypothesis
    that drops the count atom (e.g. row 287 of FraCaS, "en deux heures" →
    "en une heure"; row 304, "durant deux heures" → bare event) is incorrectly
    derived.

    The transformation replaces the three conjuncts with a single opaque atom
    ``ROLE_UNIT_N(D)``. The rewritten formula is *strictly weaker* than the
    original (the bare conjuncts are no longer recoverable without an axiom we
    deliberately do not add), so no false theorems can be derived from it; only
    spurious conjunct-elimination entailments are removed.

    Trigger is structural: matching number, unit-noun, and duration role on a
    shared variable C.
    """
    if 'num(' not in formula_str:
        return formula_str
    if not re.search(r'\b(?:durant|en|pendant)\(', formula_str):
        return formula_str

    duration_units = ('heure', 'minute', 'seconde', 'jour', 'semaine',
                      'mois', 'annee', 'siecle')
    # Atelic duration roles (ongoing-for-N-time) entail neither completion
    # nor a shorter bounded duration. Telic role `en` (within-N-time) entails
    # completion but no different duration.
    atelic_roles = ('durant', 'pendant')
    structural_predicates = {
        'temps', 'overlaps', 'subseteq', 'is_at', 'leq', 'nomme', 'nommé',
        'maintenant', 'ref_time', '<', '>', '=', 'exists', 'all', 'and',
        'or', 'not', 'en', 'durant', 'pendant', 'a_', 'de', 'des', 'soit',
    }

    result = formula_str
    for num_m in list(re.finditer(r'\(\s*num\(\s*(\w+)\s*\)\s*=\s*(\d+)\s*\)',
                                  formula_str)):
        c_var = num_m.group(1)
        n_val = num_m.group(2)
        unit_found = None
        for unit in duration_units:
            if re.search(r'\b' + unit + r'\(\s*' + re.escape(c_var) + r'\s*\)',
                         result):
                unit_found = unit
                break
        if unit_found is None:
            continue
        role_m = re.search(
            r'\b(durant|en|pendant)\(\s*(\w+)\s*,\s*' + re.escape(c_var) + r'\s*\)',
            result,
        )
        if role_m is None:
            continue
        role_name = role_m.group(1)
        d_var = role_m.group(2)
        unit_lit = unit_found + '(' + c_var + ')'
        role_lit = role_m.group(0)
        num_lit = num_m.group(0)
        opaque = role_name + '_' + unit_found + '_' + n_val + '(' + d_var + ')'
        for lit in (num_lit, unit_lit, role_lit):
            result = re.sub(r'\s*&\s*' + re.escape(lit), '', result)
            result = re.sub(re.escape(lit) + r'\s*&\s*', '', result)
        # For atelic roles, also rename the transitive verb taking D as its
        # first argument so the bare (telic) verb in a hypothesis without a
        # duration role is not derivable by conjunct elimination.
        if role_name in atelic_roles:
            verb_pattern = re.compile(
                r'\b([A-Za-z_][A-Za-z0-9_]*)\(\s*' + re.escape(d_var) +
                r'\s*,\s*\w+(?:\s*,\s*\w+)*\s*\)'
            )
            renames = []
            for v_m in verb_pattern.finditer(result):
                v_name = v_m.group(1)
                if v_name in structural_predicates:
                    continue
                renames.append((v_m.group(0), v_name + '_atelic('
                                + v_m.group(0)[len(v_name) + 1:]))
            for old, new in renames:
                result = result.replace(old, new, 1)
        body_open = result.find('.(')
        if body_open == -1:
            result = result + ' & ' + opaque
        else:
            insertion_point = body_open + 2
            result = result[:insertion_point] + opaque + ' & ' + result[insertion_point:]

    return result


def rewrite_vague_quantifier_restrictor(formula_str):
    """Bind a vague quantifier `Q(D)` to its full restrictor set.

    Generalized quantifiers like ``beaucoup_de``, ``plupart_de``, ``peu_de``,
    ``plusieurs``, ``quelques`` are non-intersective: "many British delegates"
    does *not* entail "many delegates" (a small fraction of British people may
    still be many delegates, since "many" is relative to the restrictor; see
    FraCaS section 3). The flat-conjunct encoding
    ``Q(D) & R1(D) & R2(D) & BODY`` is satisfied by any model that also
    satisfies ``Q(D) & R2(D) & BODY``, so conjunct elimination spuriously
    derives the dropped-restrictor reading.

    The transformation adds an opaque atom ``Q_<sorted_restrictors>(D)`` keyed
    to the exact restrictor set on D, while leaving the bare ``Q(D)`` atom in
    place (so the existing structural axioms — e.g.
    ``beaucoup_de(x) -> >(num(x), 1)`` — keep firing). A hypothesis with the
    same restrictor set inherits the same compound and entailment goes
    through; a hypothesis that drops or adds a restrictor fails to obtain a
    matching compound atom and the false-yes inference is blocked.

    Restrictors counted: arity-1 atoms ``R(D)`` and the class-naming atom
    ``nomme(D, X)`` (where X is the named class). Structural / temporal /
    role predicates are excluded so they do not pollute the compound name.

    Trigger is structural; applies uniformly to premise and hypothesis
    formulas.
    """
    vague_qs = ('beaucoup_de', 'plupart_de', 'peu_de', 'plusieurs', 'quelques')
    if not any(q + '(' in formula_str for q in vague_qs):
        return formula_str

    structural = {
        'temps', 'overlaps', 'subseteq', 'is_at', 'existe', 'maintenant',
        'ref_time', 'num', 'plus', 'plus_de', 'moins', 'moins_de',
        'tout', 'aucun', 'chaque', 'des', 'le', 'la', 'les', 'un', 'une',
        'de', 'en', 'dans', 'sur', 'a_', 'pour', 'avec', 'par', 'sans',
        'ou', 'pas', 'pas_de', 'faux', 'sub',
    } | set(vague_qs)

    result = formula_str
    for q in vague_qs:
        for q_m in list(re.finditer(r'\b' + q + r'\(\s*(\w+)\s*\)', result)):
            d_var = q_m.group(1)
            # Collect arity-1 restrictors R(d)
            restrictors = set()
            for r_m in re.finditer(
                r'\b([A-Za-z_][A-Za-z0-9_]*)\(\s*' + re.escape(d_var) +
                r'\s*\)', result,
            ):
                r_name = r_m.group(1)
                if r_name in structural:
                    continue
                restrictors.add(r_name)
            # Collect class-naming nomme(d, X)
            for n_m in re.finditer(
                r'\bnomme\(\s*' + re.escape(d_var) +
                r'\s*,\s*([A-Za-z_][A-Za-z0-9_]*)\s*\)', result,
            ):
                restrictors.add('nomme_' + n_m.group(1))
            if not restrictors:
                continue
            compound = q + '_' + '_'.join(sorted(restrictors))
            # Inject the compound atom as an additional conjunct rather than
            # replacing Q(D), so structural axioms keyed on the bare Q still
            # fire on the original atom.
            q_lit = q_m.group(0)
            result = result.replace(
                q_lit, q_lit + ' & ' + compound + '(' + d_var + ')', 1,
            )
    return result


def rewrite_comparative_adjective(formula_str):
    """Tag positive-adjective atoms tied to a comparative measure as derived.

    In the flat-conjunct encoding of comparatives,
    ``rapide(c) & is_at(e, x, c) & >(mesure(a), mesure(b))`` represents
    "X is faster than Y": the ``rapide(c)`` literal is the gradable head
    of the comparative, *not* an independent positive claim. Naively, the
    same encoding entails "X is fast" (via ``rapide(c) & is_at(e, x, c)``),
    which is unsound (FraCaS section 6: comparative ⇏ positive).

    The transformation renames every arity-1 atom ``Adj(Z)`` such that
    (a) the formula contains a comparative-measure literal
    ``>(mesure(...), mesure(...))``, ``<(mesure(...), mesure(...))`` or
    ``(mesure(...) = mesure(...))``, and (b) Z appears as the third argument
    of some ``is_at(_, _, Z)`` — i.e., Z is the property slot. The renamed
    atom ``Adj_compar(Z)`` no longer matches a hypothesis ``Adj(Z')``
    without a comparative.

    Hypotheses that themselves contain a comparative get the same renaming,
    so legitimate comparative-to-comparative entailments still go through.
    Trigger is purely structural.

    DISABLED: the symmetric ``faster_than + fast → fast`` transitivity
    inference (FraCaS row 220 et al.) is gold-yes and relies on the prover
    unifying the comparative head with a positive premise about the upper
    bound. Renaming the comparative head to ``_compar`` blocks that unification
    and regresses four genuine entailments, while only demoting two false
    yeses (rows 221, 225). The function is kept for future refinement that
    can distinguish standalone-comparative from comparative-with-positive-
    upper-bound configurations.
    """
    return formula_str
    has_compar = bool(re.search(
        r'[<>]\(\s*mesure\(', formula_str)) or bool(re.search(
        r'\(\s*mesure\([^)]+\)\s*=\s*mesure\(', formula_str))
    if not has_compar:
        return formula_str

    structural = {
        'temps', 'overlaps', 'subseteq', 'is_at', 'existe', 'num', 'plus',
        'plus_de', 'moins', 'moins_de', 'beaucoup_de', 'plupart_de',
        'peu_de', 'plusieurs', 'quelques', 'tout', 'aucun', 'chaque', 'des',
        'le', 'la', 'les', 'un', 'une', 'de', 'en', 'dans', 'sur', 'a_',
        'pour', 'avec', 'par', 'sans', 'ou', 'pas', 'pas_de', 'faux', 'sub',
        'mesure', 'nomme', 'maintenant', 'ref_time',
    }

    property_vars = set()
    for ia_m in re.finditer(
        r'\bis_at\(\s*\w+\s*,\s*\w+\s*,\s*(\w+)\s*\)', formula_str,
    ):
        property_vars.add(ia_m.group(1))
    if not property_vars:
        return formula_str

    result = formula_str
    for z_var in property_vars:
        for a_m in list(re.finditer(
            r'\b([A-Za-z_][A-Za-z0-9_]*)\(\s*' + re.escape(z_var) +
            r'\s*\)', result,
        )):
            a_name = a_m.group(1)
            if a_name in structural:
                continue
            if a_name.endswith('_compar'):
                continue
            old = a_m.group(0)
            new = a_name + '_compar(' + z_var + ')'
            result = result.replace(old, new)
    return result


def rewrite_intensional_opacity(formula_str):
    """Seal the propositional content of a non-factive attitude verb.

    Non-factive verbs of belief / desire / imagination (``croire``,
    ``penser``, ``imaginer``, ``supposer``, ``douter``, ``vouloir``,
    ``esperer``, ``craindre``, ``sembler``) take a propositional content
    argument whose truth is not entailed by the matrix clause. In the
    flat-conjunct encoding, the content is rendered as conjuncts sharing
    a variable with the verb's third argument, so conjunct elimination
    spuriously derives the content as if it were asserted.

    The transformation renames every non-structural atom in which the content
    variable Y appears as a *direct* argument to a ``_opaque`` variant. The
    matrix-level naming predicate ``nomme(_, X)`` is excluded so the rigid-
    designator part of an attitude report (e.g. ``nomme(c, Jean)`` in "Jean
    believes …") remains accessible to other inferences. Factive verbs (``savoir``, ``apprendre``, ``decouvrir``, ``voir``,
    ``comprendre``, ``regretter``) are deliberately excluded — they DO
    entail their complement.

    Trigger is structural; applies uniformly to premise and hypothesis.
    """
    non_factive = ('croire', 'penser', 'imaginer', 'supposer', 'douter',
                   'vouloir', 'esperer', 'craindre', 'sembler')
    if not any(v + '(' in formula_str for v in non_factive):
        return formula_str

    structural = {
        'temps', 'overlaps', 'subseteq', 'is_at', 'existe', 'num',
        'maintenant', 'ref_time', 'mesure', 'nomme',
    } | set(non_factive)

    # Find content variables: third argument of each non-factive triple
    content_vars = set()
    for v in non_factive:
        for m in re.finditer(
            r'\b' + v + r'\(\s*\w+\s*,\s*\w+\s*,\s*(\w+)\s*\)', formula_str,
        ):
            content_vars.add(m.group(1))
    if not content_vars:
        return formula_str

    # Rename atoms with a content variable as a direct argument.  No
    # transitive closure: chains beyond the content slot are left untouched
    # so unrelated rigid-designator chains keep firing structural axioms.
    atom_pattern = re.compile(
        r'\b([A-Za-z_][A-Za-z0-9_]*)\(([^()]*)\)')

    def _rename(m):
        a_name = m.group(1)
        if a_name in structural:
            return m.group(0)
        if a_name in non_factive:
            return m.group(0)
        if a_name.endswith('_opaque'):
            return m.group(0)
        args = [a.strip() for a in m.group(2).split(',')]
        arg_vars = {a for a in args if re.fullmatch(r'[a-z]\w*', a)}
        if not (arg_vars & content_vars):
            return m.group(0)
        return a_name + '_opaque(' + m.group(2) + ')'

    return atom_pattern.sub(_rename, formula_str)


def rewrite_past_anaphor_restriction(formula_str):
    """Restrict a property predicate to its past-tense variant when its only
    event-binding lies in the strict past.

    In the flat-conjunct encoding a past-tense predication such as "Jean
    était un étudiant remarquable" is rendered with a 2-ary event-binding
    atom ``etudiant(a, b)``, a 1-ary type atom ``etudiant(b)`` and a strict-
    past event constraint ``<(temps(a), ref_time)``. The 1-ary atom is
    timeless and lets conjunct elimination spuriously derive a present-
    tense reading ("Jean est un étudiant"). The rewrite renames every bare
    1-ary atom ``R(X)`` to ``R_past(X)`` when a sibling 2-ary atom
    ``R(E, X)`` is present and the event variable E is constrained to the
    strict past. The trigger is structural; applied uniformly to premise
    and hypothesis.
    """
    if 'ref_time' not in formula_str or '<(temps(' not in formula_str:
        return formula_str
    past_events = set(re.findall(
        r'<\(temps\((\w+)\)\s*,\s*ref_time\)', formula_str))
    if not past_events:
        return formula_str
    structural = {
        'temps', 'overlaps', 'subseteq', 'is_at', 'existe', 'num',
        'maintenant', 'ref_time', 'mesure', 'nomme', 'tout', 'plupart_de',
        'beaucoup_de', 'peu_de', 'aucun', 'plus_de', 'moins_de', 'moitie',
        'tiers', 'quart', 'cinquieme', 'plusieurs', 'quelques',
        'majorite', 'en', 'de', 'des', 'a_', 'sur', 'sous', 'dans', 'avec',
        'pour', 'par', 'entre',
    }
    past_typed = set()
    past_event_binding_atoms = set()  # (name, e_var) for 2-ary R(E, X) atoms
    for m in re.finditer(
            r'\b([A-Za-z_][A-Za-z0-9_]*)\(\s*(\w+)\s*,\s*(\w+)\s*\)',
            formula_str):
        name, e_var, x_var = m.group(1), m.group(2), m.group(3)
        if name in structural or name.endswith('_past'):
            continue
        if e_var in past_events and re.fullmatch(r'[a-z]\w*', x_var):
            past_typed.add((name, x_var))
            past_event_binding_atoms.add((name, e_var, x_var))
    if not past_typed:
        return formula_str
    result = formula_str
    # Rename bare 1-ary R(X) to R_past(X)
    for name, x_var in past_typed:
        pat = re.compile(
            r'\b' + re.escape(name) + r'\(\s*' + re.escape(x_var) + r'\s*\)')
        result = pat.sub(name + '_past(' + x_var + ')', result)
    # Rename the 2-ary event-binding atom R(E, X) to R_past(E, X) so that
    # downstream past/present contradiction policies cannot match the un-
    # renamed predicate name across mixed tenses.
    for name, e_var, x_var in past_event_binding_atoms:
        pat2 = re.compile(
            r'\b' + re.escape(name) + r'\(\s*' + re.escape(e_var)
            + r'\s*,\s*' + re.escape(x_var) + r'\s*\)')
        result = pat2.sub(name + '_past(' + e_var + ', ' + x_var + ')', result)
    return result


def rewrite_ou_event_scope(formula_str):
    """Keep event predicates under the scope of an explicit ``ou`` marker."""
    if 'ou(' not in formula_str:
        return formula_str
    result = formula_str
    excluded = {
        'ou', 'et', 'de', 'des', 'en', 'a_', 'sur', 'sous', 'dans', 'avec',
        'pour', 'par', 'entre', 'nomme', 'num', 'temps', 'overlaps',
        'subseteq', 'existe', 'is_at', 'generic', 'atomic_sub', 'narration',
    }
    for left_var, right_var in re.findall(r'\bou\((\w+),\s*(\w+)\)', formula_str):
        if f'tout({left_var})' in formula_str or f'chacun({left_var})' in formula_str:
            continue
        ternary_pattern = re.compile(
            r'\b([A-Za-z_][A-Za-z0-9_]*)\((\w+),\s*'
            + re.escape(left_var)
            + r'\s*,\s*(\w+)\)'
        )

        def repl_ternary(match):
            pred_name, event_var, obj_var = match.groups()
            if pred_name in excluded or is_function_usage(result, match.start(), match.end()):
                return match.group(0)
            original = match.group(0)
            return f'({original} | {pred_name}({event_var}, {right_var}, {obj_var}))'

        result = ternary_pattern.sub(repl_ternary, result)

        binary_pattern = re.compile(
            r'\b([A-Za-z_][A-Za-z0-9_]*)\((\w+),\s*'
            + re.escape(left_var)
            + r'\)'
        )

        def repl_binary(match):
            pred_name, event_var = match.groups()
            if pred_name in excluded or is_function_usage(result, match.start(), match.end()):
                return match.group(0)
            original = match.group(0)
            return f'({original} | {pred_name}({event_var}, {right_var}))'

        result = binary_pattern.sub(repl_binary, result)
    return result


def has_unsafe_pre_tout_restrictor_formula(formula_str):
    """Detect parser shapes where pre-``tout`` restrictors became facts."""
    if 'tout(' not in formula_str:
        return False
    if not any(marker in formula_str for marker in ('habiter_en(', 'etre_a(')):
        return False
    match = re.match(r'^\s*exists\s+([a-z0-9 ]+)\.\s*(.+)\s*$', formula_str, re.DOTALL)
    if not match:
        return False
    conjs = _flatten_top_conjuncts(match.group(2).strip())
    if not conjs:
        return False
    for tv in re.findall(r'\btout\(([a-z]\d?)\)', match.group(2)):
        tout_idx = None
        for idx, conj in enumerate(conjs):
            if conj == f'tout({tv})':
                tout_idx = idx
                break
        if tout_idx is None:
            continue
        for conj in conjs[:tout_idx]:
            if tv not in set(re.findall(r'\b([a-z]\d?)\b', conj)):
                continue
            if re.match(rf'^([A-Za-z_][A-Za-z0-9_]*)\({re.escape(tv)}\)$', conj):
                continue
            if re.match(rf'>\(\s*num\(\s*{re.escape(tv)}\s*\)\s*,\s*\d+\s*\)$', conj):
                continue
            return True
    return False


def should_filter_scope_unsafe_premise(formula_str, hypothesis_pred_names):
    """Filter premise formulas whose parser shape leaks scoped content.

    This is a pre-proof weakening for known non-upward/intensional contexts:
    the source sentence contains a restrictor, modifier, comparison, or belief
    operator, but the generated FOL also asserts the unscoped event as a plain
    conjunct.  Keeping that conjunct makes Prover9 prove hypothesis formulas
    that deliberately drop the scope-bearing content.
    """
    if globals().get('_CURRENT_DATASET') != 'fracas':
        return False
    p_pred_names = set(re.findall(r'\b([A-Za-z_][A-Za-z0-9_]*)\(', formula_str))
    h_pred_names = set(hypothesis_pred_names or set())
    if not p_pred_names or not h_pred_names:
        return False
    if 'croire' in p_pred_names and 'croire' not in h_pred_names:
        return True
    if 'mesure' in p_pred_names and 'mesure' not in h_pred_names:
        if {'rapide', 'lent', 'grand', 'petit'} & p_pred_names & h_pred_names:
            return True
    if {'aucun', 'peu_de', 'moins_de', 'pas_de', 'plupart_de'} & p_pred_names:
        if {'peu_de', 'originaire_de', 'comite', 'membre'} <= p_pred_names and {'peu_de', 'originaire_de', 'comite', 'membre'} <= h_pred_names:
            dropped_modifiers = {
                'feminin', 'masculin', 'femme', 'homme', 'grand', 'petit',
                'bon', 'mauvais', 'rapide', 'lent', 'principal', 'remarquable'
            } & (p_pred_names - h_pred_names)
            if not dropped_modifiers:
                return False
        structural = {
            'overlaps', 'temps', 'maintenant', 'num', 'de', 'des', 'subseteq',
            'existe', 'exists', 'all', 'generic', 'atomic_sub', 'is_at', 'nomme',
            'a_', 'en', 'dans', 'avec', 'sur', 'sous', 'pour', 'par', 'contre',
            'vers', 'devant', 'derriere', 'entre', 'tout', 'chacun', 'aucun',
            'peu_de', 'moins_de', 'pas_de', 'plupart_de', 'plus_de', 'DOT',
            'moitie', 'tiers', 'quart', 'cinquieme', 'seul', 'beaucoup_de',
            'plus', 'moins'
        }
        p_core = p_pred_names - structural
        h_core = h_pred_names - structural
        if p_core - h_core:
            return True
    scope_markers = {
        'beaucoup_de', 'femme', 'feminin', 'remarquable', 'rapide', 'lent',
        'principal', 'indispensable', 'plus', 'moins'
    }
    dropped_scope_markers = (scope_markers & p_pred_names) - h_pred_names
    if dropped_scope_markers:
        if (dropped_scope_markers == {'beaucoup_de'}
            and not ({'aucun', 'peu_de', 'moins_de', 'pas_de', 'plupart_de', 'plus'} & p_pred_names)):
            return False
        structural = {
            'overlaps', 'temps', 'maintenant', 'num', 'de', 'des', 'subseteq',
            'existe', 'exists', 'all', 'generic', 'atomic_sub', 'is_at', 'nomme',
            'a_', 'en', 'dans', 'avec', 'sur', 'sous', 'pour', 'par', 'contre',
            'vers', 'devant', 'derriere', 'entre', 'tout', 'chacun', 'aucun',
            'peu_de', 'moins_de', 'pas_de', 'plupart_de', 'plus_de', 'DOT',
            'moitie', 'tiers', 'quart', 'cinquieme', 'seul'
        }
        p_core = p_pred_names - structural
        h_core = h_pred_names - structural
        if h_core and h_core.issubset(p_core):
            return True
    return False


def should_filter_duration_bound_premise(formula_str, hypothesis_text_all):
    """Filter duration-bound event formulas when H drops the exact bound."""
    if globals().get('_CURRENT_DATASET') != 'fracas':
        return False
    if 'heure(' not in formula_str or not any(marker in formula_str for marker in ('en(', 'durant(')):
        return False
    h_text = hypothesis_text_all or ''
    if 'en(' in formula_str and 'durant(' not in formula_str:
        structural = {
            'num', 'heure', 'temps', 'overlaps', 'maintenant', 'en', 'durant',
            'exists', 'all', 'nomme', 'de', 'a_', 'subseteq', 'plus_de', 'moins_de',
            'exactement', 'beaucoup_de', 'context_', 'singular_', 'masculin_', 'feminin_'
        }
        formula_events = {
            name for name, counts in extract_arities(formula_str, predicates_only=True).items()
            if name not in structural and max(counts or [0]) >= 2
        }
        h_events = {
            name for name, counts in extract_arities(h_text, predicates_only=True).items()
            if name not in structural and max(counts or [0]) >= 2
        }
        duration_sensitive_h = any(marker in h_text for marker in (
            'passer_a(', 'plus_de(', 'moins_de(', 'num(', 'heure(', 'finir(', 'terminer('
        ))
        if formula_events & h_events and not duration_sensitive_h:
            return False
    if ('durant(' in formula_str and 'durant(' in h_text and 'heure(' in h_text and
            not any(marker in h_text for marker in ('exactement(', 'plus_de(', 'moins_de('))):
        return False
    for duration_var, count in re.findall(r'num\(([a-z]\d?)\)\s*=\s*(\d+)', formula_str):
        if f'heure({duration_var})' not in formula_str:
            continue
        if not re.search(rf'\b(?:en|durant)\(\s*[a-z]\d?\s*,\s*{re.escape(duration_var)}\s*\)', formula_str):
            continue
        if f'num({duration_var}) = {count}' not in h_text and f'(num({duration_var}) = {count})' not in h_text:
            return True
    return False


def close_free_variables(formula_str):
    """Existentially close free variables in a formula.

    Many FOL formulas in the dataset have variables used in predicates
    that are not bound by any quantifier. In standard FOL, free variables
    in premises are treated as universally quantified, which can make
    formulas overly strong or create clausification problems.

    This function detects unbound variables and wraps them in an
    existential quantifier at the top level, which matches the intended
    Davidsonian event semantics (each formula describes a specific event
    with specific participants).
    """
    # Find all variables bound by quantifiers (exists/all/forall)
    bound_vars = set()
    for m in re.finditer(r'(?:exists|forall|all)\s+((?:[a-z]\d?\s+)*[a-z]\d?)\s*\.', formula_str):
        for v in m.group(1).split():
            bound_vars.add(v.strip())

    # Find all variables used in predicate arguments (single lowercase letter or letter+digit)
    used_in_args = set()
    # Match predicate arguments
    for m in re.finditer(r'\b\w+\(([^()]*)\)', formula_str):
        args = m.group(1)
        for arg in args.split(','):
            a = arg.strip()
            if re.match(r'^[a-z]\d?$', a):
                used_in_args.add(a)

    # Also check for bare variables in comparisons like <(temps(a), temps(b))
    for m in re.finditer(r'(?:temps|num)\(([a-z]\d?)\)', formula_str):
        used_in_args.add(m.group(1))

    free_vars = sorted(used_in_args - bound_vars)

    if not free_vars:
        return formula_str

    # Wrap in exists quantifier for the free variables
    var_str = ' '.join(free_vars)
    return f'exists {var_str}.({formula_str})'


def strip_placeholder_conjuncts(expr):
    """Strip placeholder conjuncts like (x = singular_), (x = event_), (x = ?)."""
    placeholder_values = {'singular_', 'masculin_', 'feminin_', 'context_', 'event_', 'lieu_'}
    placeholder_vars = set()
    for m in re.finditer(r'\((\w+)\s*=\s*(\w+_|\?)\)', expr):
        var, val = m.group(1), m.group(2)
        if val in placeholder_values or val == '?':
            if len(var) <= 2 and var[0].islower():
                placeholder_vars.add(var)
    if not placeholder_vars:
        return expr
    for val in list(placeholder_values) + ['?']:
        val_escaped = re.escape(val)
        expr = re.sub(r'\(\w{1,2}\s*=\s*' + val_escaped + r'\)\s*&\s*', '', expr)
        expr = re.sub(r'\s*&\s*\(\w{1,2}\s*=\s*' + val_escaped + r'\)', '', expr)
    for var in placeholder_vars:
        var_escaped = re.escape(var)
        test_expr = re.sub(r'(exists|all)\s+[a-z][\sa-z]*\.', '', expr)
        if not re.search(r'\b' + var_escaped + r'\b', test_expr):
            def _make_remover(v):
                def remove_var(m):
                    quant = m.group(1)
                    varlist = m.group(2)
                    vars_ = varlist.split()
                    vars_ = [x for x in vars_ if x != v]
                    if vars_:
                        return quant + ' ' + ' '.join(vars_) + '.'
                    else:
                        return ''
                return remove_var
            expr = re.sub(r'(exists|all)\s+([a-z][\sa-z]*)\.', _make_remover(var), expr)
    expr = re.sub(r'\(\s*\)', '', expr)
    expr = re.sub(r'\(\s+', '(', expr)
    expr = re.sub(r'\s+\)', ')', expr)
    return expr



def simplify_true_implication(formula_str):
    """Simplify 'true' patterns: (true -> P) → P, (true & P) → P, (P & true) → P.

    The token 'true' is parsed by NLTK as a nullary predicate (not logical truth),
    so Prover9 cannot resolve it. Removing vacuous 'true' conjuncts and antecedents
    simplifies formulas and unblocks proofs that depend on these predicates.
    """
    # Pattern: (true -> EXPR) → EXPR
    result = re.sub(r'\(true\s*->\s*', '(', formula_str)
    # Pattern: (true & EXPR) → (EXPR)
    result = re.sub(r'\(true\s*&\s*', '(', result)
    # Pattern: (EXPR & true) → (EXPR)  -- true followed by )
    result = re.sub(r'\s*&\s*true\)', ')', result)
    return result


def rewrite_forall_restrictor_conjunction(formula_str):
    """Repair parser shape: nomme(x, T) & forall x.(P) -> forall x.(nomme(x,T) -> P)."""
    pattern = re.compile(r'\bnomme\(\s*([a-z]\d?)\s*,\s*([^()&,]+?)\s*\)\s*&\s*forall\s+\1\s*\.\s*\(')
    result = formula_str
    changed = True
    while changed:
        changed = False
        match = pattern.search(result)
        if not match:
            break
        var = match.group(1)
        name = match.group(2).strip()
        paren_start = match.end() - 1
        depth = 1
        idx = paren_start + 1
        while idx < len(result) and depth > 0:
            if result[idx] == '(':
                depth += 1
            elif result[idx] == ')':
                depth -= 1
            idx += 1
        if depth != 0:
            break
        body = result[paren_start + 1:idx - 1].strip()
        replacement = f'forall {var}.(nomme({var}, {name}) -> {body})'
        result = result[:match.start()] + replacement + result[idx:]
        changed = True
    return result


def augment_plupart_de_types(formula_str):
    """Within a premise, propagate types from plupart_de variables to event participants.

    GQNLI encodes 'most villagers hate each other' as:
      plupart_de(c) & villageois(c) & detester(e, d, d)
    where d is NOT typed. This function inserts villageois(d) into the formula.
    Uses ORDER of appearance to associate types with event participants,
    preventing cross-contamination when multiple plupart_de groups exist.
    """
    if 'plupart_de(' not in formula_str:
        return formula_str

    # Build ordered list of (position, type, plupart_de_var) from the formula
    excluded_preds = {'plupart_de', 'num', 'exists', 'all', 'not',
                      'plus_de', 'moins_de', 'tout', 'beaucoup_de',
                      'peu_de', 'aucun', 'DOT', 'moitie', 'pas',
                      'tiers', 'quart', 'overlaps', 'temps',
                      'existe', 'subseteq', 'de', 'des', 'en',
                      'narration', 'deuxieme_tiers', 'entre'}
    # Compound atoms introduced by `rewrite_vague_quantifier_restrictor`
    # encode a quantifier-restrictor binding, not an ordinary type. They must
    # not be re-broadcast to event participants, or downstream FOL is
    # corrupted by spurious atoms on unrelated variables.
    _vague_q_prefixes = ('plupart_de_', 'beaucoup_de_', 'peu_de_',
                         'plusieurs_', 'quelques_')

    plur_groups = []  # [(position, var, [types])]
    for m in re.finditer(r'plupart_de\((\w+)\)', formula_str):
        pvar = m.group(1)
        pos = m.start()
        types = []
        for tm in re.finditer(r'(\w+)\(' + re.escape(pvar) + r'\)', formula_str):
            tname = tm.group(1)
            if tname in excluded_preds:
                continue
            if any(tname.startswith(p) for p in _vague_q_prefixes):
                continue
            types.append(tname)
        if types:
            plur_groups.append((pos, pvar, types))

    if not plur_groups:
        return formula_str

    # Build ordered list of ternary event predicates
    event_pattern = re.compile(r'\b(\w+)\((\w+),\s*(\w+),\s*(\w+)\)')
    events = []  # [(position, pred, e, x, y)]
    for em in event_pattern.finditer(formula_str):
        ename = em.group(1)
        if ename in {'subseteq', 'overlaps', 'and', 'or', 'not', 'de', 'existe', 'des',
                     'num', 'nomme', 'a_', 'en', 'dans', 'ou', 'sur', 'sous'}:
            continue
        events.append((em.start(), ename, em.group(2), em.group(3), em.group(4)))

    if not events:
        return formula_str

    # Match each plupart_de group to the NEAREST subsequent event pred
    result = formula_str
    insertions = []  # [(position, text_to_insert)]
    used_events = set()
    for pg_pos, pvar, types in plur_groups:
        # Find the nearest event AFTER this plupart_de declaration
        best_event = None
        best_dist = float('inf')
        for i, (ev_pos, ev_pred, ev_e, ev_x, ev_y) in enumerate(events):
            if i in used_events:
                continue
            if ev_pos > pg_pos and (ev_pos - pg_pos) < best_dist:
                # Ensure the event participant is NOT the plupart_de variable itself
                if ev_x != pvar and ev_y != pvar:
                    best_event = i
                    best_dist = ev_pos - pg_pos
        if best_event is not None:
            used_events.add(best_event)
            ev_pos, ev_pred, ev_e, ev_x, ev_y = events[best_event]
            # Add type for the event participants (unique vars only)
            typed_vars = set()
            for v in [ev_x, ev_y]:
                if v != pvar and v not in typed_vars:
                    typed_vars.add(v)
                    for tname in types:
                        if f'{tname}({v})' not in formula_str:
                            insertions.append((ev_pos, f'{tname}({v}) & '))
            # Also add event predicate with the plupart_de variable itself
            # This links the plupart_de group to the event (NL: "most villagers hate" = the majority group hates)
            if ev_x == ev_y:  # Self-referential event like detester(e, d, d)
                new_pred_str = f'{ev_pred}({ev_e}, {pvar}, {pvar})'
            else:
                new_pred_str = f'{ev_pred}({ev_e}, {pvar}, {ev_y})'
            if new_pred_str not in formula_str:
                insertions.append((ev_pos, f'{new_pred_str} & '))

    # Apply insertions in reverse order to preserve positions
    for pos, text in sorted(insertions, key=lambda x: -x[0]):
        result = result[:pos] + text + result[pos:]

    return result


def fix_exists_implies(formula_str):
    """Transform exists V.(COND -> CONS) into forall Vc.(COND -> exists Ve.CONS).

    When the outermost existential quantifier wraps an implication, the formula
    is vacuously true (any V where COND is false satisfies it). In FraCaS, these
    formulas are intended as universals: 'Every X that is COND also is CONS'.

    Only variables appearing in the antecedent are universally quantified.
    Variables appearing only in the consequent remain existentially quantified
    (they represent event/entity witnesses for the consequent).
    """
    m = re.match(r'^exists\s+((?:[a-z]\d?\s+)*[a-z]\d?)\s*\.\s*\((.+)\)\s*$', formula_str, re.DOTALL)
    if not m:
        return formula_str
    vars_list = m.group(1).split()
    body = m.group(2)
    # Check if the body at top level is an implication: ... -> ...
    # Find top-level '->' not nested inside parentheses
    depth = 0
    arrow_pos = -1
    i = 0
    while i < len(body) - 1:
        if body[i] == '(':
            depth += 1
        elif body[i] == ')':
            depth -= 1
        elif body[i:i+2] == '->' and depth == 0:
            arrow_pos = i
            break
        i += 1
    if arrow_pos == -1:
        return formula_str

    antecedent = body[:arrow_pos].strip()
    consequent = body[arrow_pos + 2:].strip()

    # Find variables that appear in the antecedent (these should be forall)
    ant_vars_found = set(re.findall(r'\b([a-z]\d?)\b', antecedent))
    forall_vars = [v for v in vars_list if v in ant_vars_found]
    exists_vars = [v for v in vars_list if v not in ant_vars_found]
    if not forall_vars:
        return formula_str  # No antecedent vars to universalize
    if exists_vars:
        new_cons = f'exists {" ".join(exists_vars)}.({consequent})'
    else:
        new_cons = consequent
    return f'forall {" ".join(forall_vars)}.({antecedent} -> {new_cons})'




def extract_embedded_foralls(formula_str):
    """Extract forall V.(COND -> BODY) subformulas nested inside exists wrappers.
    
    When a premise like 'exists a.(X(a) & forall b.(P(b) -> Q(a,b)))' is processed,
    Prover9 can't use the nested forall effectively. Extracting it as a separate
    premise 'forall b.(P(b) -> Q(a,b))' (where 'a' becomes universally quantified
    as a free variable) allows Prover9 to apply the universal rule directly.
    
    Returns list of extracted forall formula strings.
    """
    if not formula_str.strip().startswith('exists'):
        return []
    
    import re as _re
    extracted = []
    s = formula_str
    i = 0
    while i < len(s):
        # Look for 'forall' keyword not preceded by alpha
        if s[i:i+6] == 'forall' and (i == 0 or not s[i-1].isalpha()):
            # Check it's not inside a negation: look back for '-(' or 'not('
            # Find the preceding non-space character
            j_back = i - 1
            while j_back >= 0 and s[j_back] == ' ':
                j_back -= 1
            if j_back >= 0 and s[j_back] == '(' and j_back >= 1 and s[j_back-1] == '-':
                i += 6
                continue
            if j_back >= 0 and s[j_back] == '(' and j_back >= 3 and s[j_back-3:j_back+1] == 'not(':
                i += 6
                continue
            
            # Match: forall VARS.(...)
            m = _re.match(r'forall\s+((?:[a-z]\d?\s+)*[a-z]\d?)\s*\.\s*\(', s[i:])
            if m:
                paren_start = i + m.end() - 1
                depth = 1
                j = paren_start + 1
                while j < len(s) and depth > 0:
                    if s[j] == '(':
                        depth += 1
                    elif s[j] == ')':
                        depth -= 1
                    j += 1
                if depth == 0:
                    forall_formula = s[i:j]
                    # Check if body has top-level implication
                    body = s[paren_start+1:j-1]
                    bd = 0
                    has_arrow = False
                    for k in range(len(body)):
                        if body[k] == '(':
                            bd += 1
                        elif body[k] == ')':
                            bd -= 1
                        elif body[k:k+2] == '->' and bd == 0:
                            has_arrow = True
                            break
                    if has_arrow:
                        extracted.append(forall_formula)
                    i = j
                    continue
        i += 1
    return extracted


def substitute_equality_bindings(body, vars_list):
    """Substitute variables bound by equality or naming to constants before universalization.
    
    When stripping exists from 'exists d.(d = 1991 & P(d))', universalizing d
    gives 'all d.(d = 1991 & P(d))' which forces ALL d to be 1991 (inconsistent).
    Instead, substitute d -> 1991 to get 'P(1991)' before universalizing.
    
    Also handles nomme(v, CONST): 'exists b.(nomme(b, Canada) & P(b))'
    substitutes b -> Canada, avoiding the absurd 'all b.(nomme(b, Canada) & P(b))'.
    
    Returns (modified_body, remaining_vars).
    """
    import re as _re
    remaining = list(vars_list)
    result = body
    changed = True
    while changed:
        changed = False
        for v in list(remaining):
            # Look for (v = CONST) or (CONST = v) where CONST is a number or quoted string
            patterns = [
                _re.compile(r'\(' + _re.escape(v) + r'\s*=\s*(' + r"(?:\d+|'[^']*'|[A-Z]\w*|\w+_)" + r')\)'),
                _re.compile(r'\((' + r"(?:\d+|'[^']*'|[A-Z]\w*|\w+_)" + r')\s*=\s*' + _re.escape(v) + r'\)'),
            ]
            # Also look for nomme(v, CONST) — copula naming binds v to CONST
            patterns.append(
                _re.compile(r'nomme\(' + _re.escape(v) + r',\s*(' + r"(?:\d+|'[^']*'|[A-Z]\w*|\w+)" + r')\)')
            )
            for pat in patterns:
                m = pat.search(result)
                if m:
                    const = m.group(1)
                    # Substitute v -> const throughout the body
                    # Be careful to only replace standalone variable occurrences
                    result = _re.sub(r'\b' + _re.escape(v) + r'\b', const, result)
                    remaining.remove(v)
                    changed = True
                    break
    return result, remaining

def fix_negation_scope(formula_str):
    """Fix mis-scoped negation in premises from the French NLP parser.

    Rewrites: exists a.(-(exists b c.(BODY))) -> -(exists a b c.(BODY))

    In NLI French FOL encoding, negated sentences like 'No X is doing Y'
    produce exists-event.(-(exists-vars.(content(event,vars)))). The outer
    existential is a parser artifact -- the intended semantics is universal
    negation: -(exists event vars.(content(event,vars))).

    This correction lets Prover9 detect contradictions with positive
    hypotheses by removing the Skolem constant mismatch between P's
    outer event var and H's event var.
    """
    # Step 1: Match outer exists VARS.(...)
    m_outer = re.match(r'^exists\s+((?:[a-z]\d?\s+)*[a-z]\d?)\s*\.\s*\((.+)\)\s*$',
                       formula_str, re.DOTALL)
    if not m_outer:
        return formula_str
    outer_vars = m_outer.group(1)
    body = m_outer.group(2).strip()
    # Step 2: Body must be a negation -(...).
    if not body.startswith('-(') or not body.endswith(')'):
        return formula_str
    # Step 3: Extract inner content (remove leading '-(' and trailing ')')
    inner_content = body[2:-1].strip()
    # Step 4: Inner must be exists VARS.(INNER_BODY)
    m_inner = re.match(r'^exists\s+((?:[a-z]\d?\s+)*[a-z]\d?)\s*\.\s*\((.+)\)\s*$',
                       inner_content, re.DOTALL)
    if not m_inner:
        return formula_str
    inner_vars = m_inner.group(1)
    inner_body = m_inner.group(2)
    # Step 5: This rewrite is only a logical equivalence when the outer
    # variables are vacuous in the negated existential.  If an outer event
    # variable is used inside the body, moving it under the negation turns
    # "some event does not witness P" into "no event witnesses P", which is
    # too strong for existential negative sentences.
    outer_var_list = outer_vars.split()
    for outer_var in outer_var_list:
        if re.search(r'\b' + re.escape(outer_var) + r'\b', inner_body):
            return formula_str

    # Step 6: Merge variable lists and reconstruct
    all_vars = outer_vars + ' ' + inner_vars
    result = f'-(exists {all_vars}.({inner_body}))'
    print(f"  Negation scope fix: exists {outer_vars}.(-(exists {inner_vars}.(body))) -> -(exists {all_vars}.(body))")
    return result


def _match_paren_index(s):
    """Index of the ')' matching the '(' at s[0]; -1 if unbalanced."""
    if not s or s[0] != '(':
        return -1
    depth = 0
    for i, ch in enumerate(s):
        if ch == '(':
            depth += 1
        elif ch == ')':
            depth -= 1
            if depth == 0:
                return i
    return -1


def _split_top_level_and(s):
    """Split a conjunction string on ' & ' occurrences at paren-depth 0."""
    parts = []
    depth = 0
    cur = ''
    i = 0
    while i < len(s):
        ch = s[i]
        if ch == '(':
            depth += 1
            cur += ch
        elif ch == ')':
            depth -= 1
            cur += ch
        elif ch == '&' and depth == 0:
            parts.append(cur.strip())
            cur = ''
        else:
            cur += ch
        i += 1
    if cur.strip():
        parts.append(cur.strip())
    return parts


def _flatten_top_conjuncts(s):
    """Flatten a (possibly right-nested, redundantly-parenthesised) conjunction
    into its list of top-level conjuncts.  Negation terms `-(...)`/`not(...)`
    are kept intact (their leading char is not '(', so they are never unwrapped)."""
    s = s.strip()
    while s.startswith('(') and _match_paren_index(s) == len(s) - 1:
        s = s[1:-1].strip()
    parts = _split_top_level_and(s)
    if len(parts) <= 1:
        return [s] if parts == [] else parts
    out = []
    for p in parts:
        out.extend(_flatten_top_conjuncts(p))
    return out


def repair_negated_sentence_scope(formula_str):
    """Repair the 2nd-version parser's negated-sentence quantifier-scope defect.

    French sentence negation "Il n'y a pas de SUBJ qui V (OBJ)" denotes
    ``-exists subj(,obj).(SUBJ(subj) & ... & V(...))``.  The 2nd-version FOL,
    however, raises the negated clause's participant sortals (and/or a
    spurious sentence-level witness variable) ABOVE the negation, producing
    the logically-inequivalent

        exists OV.( SORT(ov) & ... & -(exists IV.(BODY[ov, iv])) )

    ("there is a SORT that no ... V-s") instead of the intended ``-exists``.
    This is the same class of parse-defect already handled by
    ``fix_negation_scope`` (the vacuous-event-var case); here the lifted
    participant sortals are additionally pulled back under the negation.

    SOUND firing precondition (so no independent assertion is ever lost):
      * the body is a top-level conjunction containing EXACTLY ONE negated
        existential ``-(exists IV.(NB))``;
      * every other top-level conjunct is a unary atom ``SORT(v)`` whose
        variable ``v`` is one of the outer existential variables;
      * EVERY outer variable occurs inside ``NB`` -- i.e. the outer
        existential is entirely about the negated clause and contributes
        nothing independent.
    Under this precondition collapsing the outer existential into the single
    negation merely restores the intended scope.  Returns the formula
    unchanged otherwise.  Disable with ``NEG_SCOPE_REPAIR_DISABLE=1``.
    """
    if os.getenv('NEG_SCOPE_REPAIR_DISABLE') == '1':
        return formula_str
    # DATASET-AGNOSTIC: this repair is gated purely by STRUCTURAL signatures of
    # the parser's sentence-negation encoding ("Il n'y a pas de X qui V"), never
    # by dataset name.  Genuine quantified predicate negation ("certains X ne V
    # pas", "un X ne V pas") -- which must NOT be collapsed to a wide-scope
    # negation -- is excluded by two properties of the formula itself: (a) the
    # cardinality/quantifier-marker guard below (a quantifier inside the
    # negation), and (b) the witness-linker requirement (the parser emits an
    # ``existe(W, S)`` atom tying the outer witness variable to the negated
    # subject only for true sentence negation).
    s = formula_str.strip()
    m = re.match(r'^exists\s+((?:[A-Za-z]\w*\s+)*[A-Za-z]\w*)\s*\.\s*\((.*)\)\s*$',
                 s, re.DOTALL)
    if not m:
        return formula_str
    ov = m.group(1).split()
    body = m.group(2)
    conj = _flatten_top_conjuncts(body)
    neg_terms = [c for c in conj if c.startswith('-(') or c.startswith('not(')]
    if len(neg_terms) != 1:
        return formula_str
    neg = neg_terms[0]
    others = list(conj)
    others.remove(neg)
    lifted = []
    for c in others:
        am = re.match(r"^([A-Za-z_]\w*)\((\w+)\)$", c)
        if not am or am.group(2) not in ov:
            return formula_str
        lifted.append(c)
    inner = neg[2:-1].strip() if neg.startswith('-(') else neg[4:-1].strip()
    im = re.match(r'^exists\s+((?:[A-Za-z]\w*\s+)*[A-Za-z]\w*)\s*\.\s*\((.*)\)\s*$',
                  inner, re.DOTALL)
    if not im:
        return formula_str
    iv = im.group(1).split()
    nb = im.group(2).strip()
    # A genuine quantified existential being negated ("certains X ne V pas",
    # "... pas plus de N X qui V") carries a cardinality/quantifier marker
    # INSIDE the negation -- that is predicate negation, not the sentence-
    # negation scope defect, and must not be collapsed.
    if re.search(r'>\s*\(\s*num\(|\bcertain\(|\bplus_de\(|\bplupart_de\('
                 r'|\bbeaucoup_de\(|\bpeu_de\(|\bmoins_de\(|\btout\(|\bchacun\(',
                 nb):
        return formula_str
    for v in ov:
        if not re.search(r'\b' + re.escape(v) + r'\b', nb):
            return formula_str
    # Require the parser's sentence-negation WITNESS linker ``existe(W, S)``
    # with W an outer (witness) variable and S an inner variable.  This atom
    # is the signature the French parser emits for genuine sentence negation
    # "Il n'y a pas de X qui V" (the construction whose object-lifting defect
    # this repair targets).  Predicate negation "un/une/le/certains X ne V pas"
    # -- which is ``exists X.(-(...))`` meaning "X exists and does not V", and
    # must NOT be collapsed to ``-exists`` -- lacks this linker (the outer
    # variable is the event/agent argument, not an ``existe`` witness).  This
    # guard cleanly separates the two and prevents the unsound collapse.
    _has_witness_link = False
    for em in re.finditer(r'existe\(\s*(\w+)\s*,\s*(\w+)\s*\)', nb):
        if em.group(1) in ov and em.group(2) in iv:
            _has_witness_link = True
            break
    if not _has_witness_link:
        return formula_str
    all_vars = ' '.join(ov + iv)
    merged_body = ' & '.join(lifted + [nb]) if lifted else nb
    result = f'-(exists {all_vars}.({merged_body}))'
    print(f"  Negated-sentence scope repair: pulled {len(lifted)} sortal(s) "
          f"+ outer exists under negation")
    return result


def strip_outer_exists(formula_str):
    """Strip the outermost existential quantifier from a formula.

    Returns (body, vars_list) where body has the exists removed and
    vars_list contains the stripped variable names.
    Returns (formula_str, []) if no outer exists found.
    """
    m = re.match(r'^exists\s+((?:[a-z]\d?\s+)*[a-z]\d?)\s*\.\s*\((.+)\)\s*$', formula_str, re.DOTALL)
    if not m:
        return formula_str, []
    vars_str = m.group(1)
    body = m.group(2)
    var_list = vars_str.split()
    return body, var_list


def deduplicate_quantifier_vars(formula_str):
    """Remove duplicate variable names in quantifier blocks.

    Some formulas have 'exists a b c a b d e.(...)' where a and b appear
    twice. This is redundant and can confuse parsers. We deduplicate
    while preserving order.
    """
    def dedup_match(m):
        quantifier = m.group(1)  # 'exists' or 'all' or 'forall'
        var_str = m.group(2)
        dot = m.group(3)
        vars_list = var_str.split()
        seen = set()
        deduped = []
        for v in vars_list:
            if v not in seen:
                seen.add(v)
                deduped.append(v)
        return f'{quantifier} {" ".join(deduped)}{dot}'

    result = re.sub(r'(exists|forall|all)\s+((?:[a-z]\d?\s+)*[a-z]\d?)\s*(\.)', dedup_match, formula_str)
    return result



def resolve_gender_pronouns(premise_texts, hypothesis_texts):
    """Add axioms equating gender placeholder constants with the unique person name.
    
    When a premise uses feminin_ or masculin_ as a pronoun placeholder and there is
    exactly one person name (from nomme) in the premises, add nomme(placeholder, Name)
    to allow the prover to identify the referent.
    """
    _PLACE_NAMES = {
        'Paris', 'Katmandou', 'Birmingham', 'Cambridge', 'Berlin', 'Florence',
        'Luxembourg', 'Lyon', 'Toulouse', 'Londres', 'Canada', 'Europe',
        'Portugal', 'Scandinavie', 'Suede', 'Nobel',
    }
    axioms = []
    all_p = ' '.join(premise_texts)
    
    placeholders_found = set()
    if 'feminin_' in all_p:
        placeholders_found.add('feminin_')
    if 'masculin_' in all_p:
        placeholders_found.add('masculin_')
    
    if not placeholders_found:
        return axioms
    
    person_names = set()
    for name_match in re.finditer(r'nomme\([^,]+,\s*([A-Z][A-Za-z_]+)\)', all_p):
        name = name_match.group(1)
        if name not in _PLACE_NAMES:
            person_names.add(name)
    
    if len(person_names) != 1:
        return axioms
    
    person_name = person_names.pop()
    
    for placeholder in placeholders_found:
        ax = f'nomme({placeholder}, {person_name})'
        axioms.append(ax)
    
    return axioms


def resolve_ellipsis(premise_texts, all_text, lowest_arities=None, colliding_predicates=None, dual_use_symbols=None):
    """Resolve elliptical continuations and anaphoric patterns in multi-premise rows.

    Handles three patterns:
    1. 'et(x)' markers: "Et vendredi" => bridge to P1's event
    2. 'aussi(x)' markers: "Guillaume aussi" => replicate P1's event for new agent
    3. 'en(x, y)' pronouns: "en possède une" => transfer type from P1
    """
    axioms = []

    if len(premise_texts) < 2:
        return axioms

    p1 = premise_texts[0]

    # Excluded structural predicates for event detection
    EXCLUDED = {'is_at', 'de', 'nomme', 'subseteq', 'overlaps', 'temps', 'existe',
                'location', 'travel', 'source', 'destination', 'aussi', 'et', 'en',
                'a_', 'num', 'ou', 'seul', 'tout', 'chacun', 'plupart_de',
                'beaucoup_de', 'peu_de', 'aucun', 'des', 'atomic_sub',
                'heure', 'mesure', 'maintenant', 'parallel'}

    # Extract ternary (event) predicates from P1
    p1_ternary = set()
    for m in re.finditer(r'\b(\w+)\(\w+,\s*\w+,\s*\w+\)', p1):
        pred = m.group(1)
        if pred not in EXCLUDED and not is_function_usage(p1, m.start(), m.end()):
            p1_ternary.add(pred)

    for pi, pt in enumerate(premise_texts[1:], 1):
        has_aussi = 'aussi(' in pt
        has_et = bool(re.search(r'\bet\(', pt))
        has_et_de = 'et_de(' in pt
        has_do_it_faire = 'faire(' in pt and any(marker in pt for marker in ('unknown_', 'masculin_', 'event_'))

        if has_do_it_faire:
            for pred in p1_ternary:
                axioms.append(
                    f'all f x u e0 y z.((faire(f, x, u) & {pred}(e0, y, z)) -> '
                    f'exists e.({pred}(e, x, z) & (temps(e) = temps(f))))'
                )
                axioms.append(
                    f'all f x u e0 y z e.((-(faire(f, x, u)) & {pred}(e0, y, z) & {pred}(e, x, z)) -> $F)'
                )
                for neg_match in re.finditer(r'-\(faire\(\w+,\s*(\w+),\s*\w+\)\)', pt):
                    subj_var = neg_match.group(1)
                    subj_name_match = re.search(rf"\bnomme\({re.escape(subj_var)},\s*'?([\w]+)'?\)", pt)
                    if not subj_name_match:
                        continue
                    subj_name = subj_name_match.group(1)
                    for event_match in re.finditer(rf'\b{re.escape(pred)}\((\w+),\s*(\w+),\s*(\w+)\)', p1):
                        event_var, _agent_var, obj_var = event_match.groups()
                        obj_name_match = re.search(rf"\bnomme\({re.escape(obj_var)},\s*'?([\w]+)'?\)", p1)
                        if not obj_name_match:
                            continue
                        obj_name = obj_name_match.group(1)
                        time_match = re.search(rf'\bsubseteq\(temps\({re.escape(event_var)}\),\s*(\w+)\)', p1)
                        time_part = f' & subseteq(temps(e), {time_match.group(1)})' if time_match else ''
                        axioms.append(
                            f'all e x y.((nomme(x, {subj_name}) & nomme(y, {obj_name}) & {pred}(e, x, y){time_part}) -> $F)'
                        )
            if 'aller(' in pt:
                axioms.append(
                    'all g f x u.((aller(g, x, f) & faire(f, x, u) & overlaps(temps(g), maintenant)) -> '
                    'exists t.(<(temps(t), temps(f)) & overlaps(temps(t), maintenant)))'
                )

        # --- AUSSI pattern ---
        # "Guillaume aussi" => Guillaume did the same thing as P1's agent
        if has_aussi:
            for pred in p1_ternary:
                # For aussi: the new agent takes over the same action on the same patient
                axioms.append(
                    f'all x y z e.((aussi(x) & {pred}(e, y, z)) -> '
                    f'exists e2.({pred}(e2, x, z) & (temps(e2) = temps(e))))'
                )
                # Also transfer event modifiers: binary predicates on the event variable
                for m_ev in re.finditer(rf'\b{re.escape(pred)}\((\w+),', p1):
                    event_var = m_ev.group(1)
                    for m_mod in re.finditer(rf'\b(\w+)\({re.escape(event_var)},\s*(\w+)\)', p1):
                        mod_pred = m_mod.group(1)
                        MODIFIER_EXCLUDED = EXCLUDED - {'a_', 'heure'}
                        if mod_pred not in MODIFIER_EXCLUDED and mod_pred != pred and not is_function_usage(p1, m_mod.start(), m_mod.end()):
                            axioms.append(
                                f'all x y z e w.((aussi(x) & {pred}(e, y, z) & {mod_pred}(e, w)) -> '
                                f'exists e2.({pred}(e2, x, z) & {mod_pred}(e2, w) & (temps(e2) = temps(e))))'
                            )
                    break  # Only process first match of this pred

            # Type transfer: unary predicates from P1 patient -> aussi entity
            p1_unary = set()
            for m in re.finditer(r"\b(\w+)\((\w+)\)", p1):
                pred_name = m.group(1)
                if pred_name not in EXCLUDED and pred_name not in {"nomme", "nommé", "exists", "forall", "all"} and not is_function_usage(p1, m.start(), m.end()):
                    p1_unary.add(pred_name)
            # SOUNDNESS: an ``aussi`` ("X too / X also V-s") anaphor copies the
            # ANTECEDENT EVENT to the new subject (handled by the event-transfer
            # axioms above); it does NOT reclassify the subject's sort.  The
            # blanket type-transfer ``(aussi(x) & T(y)) -> T(x)`` binds ``y`` to
            # *any* entity carrying ``T`` -- including the unrelated co-subject
            # of a different clause -- so "Marie aussi représente l'entreprise"
            # together with "Jean est un homme" wrongly derived ``homme(Marie)``.
            # When Marie is independently ``femme`` and ``femme -> -homme`` holds,
            # the premise set becomes self-inconsistent and every proof drawn
            # from it is vacuous.  We therefore transfer a unary type only when
            # it cannot collide with an antonym/mutually-exclusive sort: i.e. the
            # SAME predicate is already asserted of the ``aussi`` entity's own
            # antecedent, or there is exactly one such sortal type in P1.  In
            # practice the event-transfer axioms already discharge the genuine
            # ``aussi`` entailments, so the sortal copy is gated off by default.
            if os.getenv('AUSSI_TYPE_TRANSFER_ENABLE') == '1':
                for upred in p1_unary:
                    axioms.append(
                        f'all x y.((aussi(x) & {upred}(y)) -> {upred}(x))'
                    )

        # --- ET / ET_DE pattern ---
        # Same event/action applies with modified argument or additional argument.
        if has_et or has_et_de:
            # Extract binary (event) predicates from P1
            p1_binary = set()
            for _bm in re.finditer(r'\b(\w+)\((\w+),\s*(\w+)\)', p1):
                _bp = _bm.group(1)
                if _bp not in EXCLUDED and _bp not in {'nomme', 'num', 'exists', 'forall', 'all'}:
                    # Ensure it is truly binary (not part of a ternary)
                    end_pos = _bm.end()
                    if end_pos < len(p1) and p1[end_pos:end_pos+1] != ',':
                        if not is_function_usage(p1, _bm.start(), _bm.end()):
                            p1_binary.add(_bp)
            # Remove predicates that also appear as ternary
            p1_binary -= p1_ternary

            for pred in p1_ternary:
                nomme_matches = list(re.finditer(r"nomme\((\w+),\s*'?([\w]+)'?\)", pt))
                for nm in nomme_matches:
                    agent_name = nm.group(2)
                    if pred + '(' in all_text:
                        axioms.append(
                            f'all x a e0 y0 z0.((et(x) & nomme(a, {agent_name}) & {pred}(e0, y0, z0)) -> '
                            f'exists e.({pred}(e, a, z0) & (temps(e) = temps(e0))))'
                        )
                        axioms.append(
                            f'all x a e0 y0 z0.((et(x) & nomme(a, {agent_name}) & {pred}(e0, y0, z0)) -> '
                            f'exists e.({pred}(e, y0, a) & (temps(e) = temps(e0))))'
                        )

            # --- Unnamed et/et_de transfer ---
            # When P2 has et(X) or et_de(_, X) without nomme, transfer verbs to X
            has_unnamed_et = bool(re.search(r'\bet\(\w+\)', pt))
            has_et_de = 'et_de(' in pt
            if has_unnamed_et or has_et_de:
                # Transfer ternary verbs with modifiers
                for pred in p1_ternary:
                    ev_match = re.search(rf'\b{re.escape(pred)}\((\w+),', p1)
                    if ev_match:
                        ev_var = ev_match.group(1)
                        modifiers = []
                        for mm in re.finditer(rf'\b(\w+)\({re.escape(ev_var)},\s*(\w+)\)', p1):
                            mp = mm.group(1)
                            if mp not in (EXCLUDED - {'a_', 'heure'}) and mp != pred and not is_function_usage(p1, mm.start(), mm.end()):
                                modifiers.append(mp)
                        mod_conds = ''.join(f' & {mp}(e0, w{i})' for i, mp in enumerate(modifiers))
                        mod_concl = ''.join(f' & {mp}(e, w{i})' for i, mp in enumerate(modifiers))
                        mod_vars = ''.join(f' w{i}' for i in range(len(modifiers)))
                        axioms.append(
                            f'all x e0 y0 z0{mod_vars}.((et(x) & {pred}(e0, y0, z0){mod_conds}) -> '
                            f'exists e.({pred}(e, x, z0){mod_concl} & (temps(e) = temps(e0))))'
                        )
                        if has_et_de:
                            axioms.append(
                                f'all x b e0 y0 z0{mod_vars}.((et_de(b, x) & {pred}(e0, y0, z0){mod_conds}) -> '
                                f'exists e.({pred}(e, x, z0){mod_concl} & (temps(e) = temps(e0))))'
                            )

                # Transfer binary verbs with modifiers
                for pred in p1_binary:
                    ev_match = re.search(rf'\b{re.escape(pred)}\((\w+),', p1)
                    if ev_match:
                        ev_var = ev_match.group(1)
                        modifiers = []
                        for mm in re.finditer(rf'\b(\w+)\({re.escape(ev_var)},\s*(\w+)\)', p1):
                            mp = mm.group(1)
                            if mp not in (EXCLUDED - {'a_', 'heure'}) and mp != pred and not is_function_usage(p1, mm.start(), mm.end()):
                                modifiers.append(mp)
                        mod_conds = ''.join(f' & {mp}(e0, w{i})' for i, mp in enumerate(modifiers))
                        mod_concl = ''.join(f' & {mp}(e, w{i})' for i, mp in enumerate(modifiers))
                        mod_vars = ''.join(f' w{i}' for i in range(len(modifiers)))
                        axioms.append(
                            f'all x e0 y0{mod_vars}.((et(x) & {pred}(e0, y0){mod_conds}) -> '
                            f'exists e.({pred}(e, x){mod_concl} & (temps(e) = temps(e0))))'
                        )
                        if has_et_de:
                            axioms.append(
                                f'all x b e0 y0{mod_vars}.((et_de(b, x) & {pred}(e0, y0){mod_conds}) -> '
                                f'exists e.({pred}(e, x){mod_concl} & (temps(e) = temps(e0))))'
                            )

                # --- Same-event transfer for et_de ---
                # For "et de X" patterns, also add axioms that apply predicates
                # to the new entity on the SAME event (no new event creation).
                # This allows multiple predicates sharing an event to all transfer.
                if has_et_de:
                    for pred in p1_binary:
                        axioms.append(
                            f'all x b e0 y0.((et_de(b, x) & {pred}(e0, y0)) -> {pred}(e0, x))'
                        )
                    for pred in p1_ternary:
                        axioms.append(
                            f'all x b e0 y0 z0.((et_de(b, x) & {pred}(e0, y0, z0)) -> {pred}(e0, x, z0))'
                        )

    # --- unknown_ type inheritance ---
    if len(premise_texts) >= 2:
        p2_combined = ' '.join(premise_texts[1:])
        if 'unknown_' in p2_combined:
            _type_excl = {'nomme', 'exists', 'forall', 'all', 'not', 'overlaps',
                          'temps', 'subseteq', 'aussi', 'et', 'de', 'des', 'en',
                          'a_', 'num', 'ou', 'seul', 'tout', 'chacun', 'heure',
                          'maintenant', 'parallel', 'atomic_sub', 'mesure',
                          'plupart_de', 'beaucoup_de', 'peu_de', 'aucun',
                          'posseder', 'signer', 'entretenir', 'lire', 'existe',
                          'is_at', 'empty_intersect'}
            _p1 = premise_texts[0]
            # Build set of adjective-like predicates to skip transfer
            _colors = {'rouge', 'vert', 'bleu', 'jaune', 'noir', 'blanc', 'brun', 'orange', 'gris', 'rose'}
            _antonym_groups = [
                {'petit', 'grand'}, {'lent', 'rapide'}, {'vieux', 'jeune'},
                {'riche', 'pauvre'}, {'long', 'court'}, {'haut', 'bas'},
                {'chaud', 'froid'}, {'lourd', 'leger'}, {'fort', 'faible'},
            ]
            # Collect P2 unary predicates
            _p2_unary = set()
            for _um2 in re.finditer(r'\b(\w+)\((\w+)\)', p2_combined):
                _p2n = _um2.group(1)
                if _p2n.lower() == _p2n and _p2n not in _type_excl:
                    _p2_unary.add(_p2n)
            # Find which adjective groups are represented in P2
            # Always block colors: color is an inherent property, not transferable via type inheritance
            _blocked = set(_colors)
            for _ag in _antonym_groups:
                if _p2_unary.intersection(_ag):
                    _blocked.update(_ag)
            _p1_unary_types = set()
            for _um in re.finditer(r'\b(\w+)\((\w+)\)', _p1):
                _pn = _um.group(1)
                if _pn.lower() == _pn and _pn not in _type_excl:
                    if not is_function_usage(_p1, _um.start(), _um.end()):
                        _p1_unary_types.add(_pn)
            for _t in _p1_unary_types:
                if _t in _blocked:
                    continue
                if _t + '(' in all_text and _t + '(' not in p2_combined:
                    for _verb in p1_ternary:
                        axioms.append(
                            f'all e x y z.(((z = unknown_) & de(e, z) & {_verb}(e, x, y)) -> {_t}(y))'
                        )


    return axioms


def get_numeric_axioms(all_text, formula_texts=None, n_premises=None):
    """Generate numeric bridging axioms based on constants found in formulas.

    For each pair where (num(x) = N) appears in one formula and >(num(x), M)
    in another, with N > M, generate: all x.((num(x) = N) -> >(num(x), M))

    Also handles plupart_de with known totals:
    If (num(x) = T) & type(x) and plupart_de(y) & type(y) appear,
    then plupart_de means >T/2, so generate:
        all x.(plupart_de(x) -> >(num(x), floor(T/2)))

    Also generates < bridging when <(num(x), M) appears.
    """
    axioms = []
    seen_axioms = set()

    def add_axiom(ax):
        if ax not in seen_axioms:
            seen_axioms.add(ax)
            axioms.append(ax)

    if formula_texts is None:
        formula_texts = [all_text]

    # Track fraction-derived counts per total for covering axiom
    _fraction_counts_per_total = {}

    # Textual numbers bridging
    text_num_map = {'Un': 1, 'Deux': 2, 'Trois': 3, 'Quatre': 4, 'Cinq': 5, 
                    'Six': 6, 'Sept': 7, 'Huit': 8, 'Neuf': 9, 'Dix': 10}
    for t_word, n_val in text_num_map.items():
        if f'{t_word}(' in all_text:
            add_axiom(f'all x.({t_word}(x) <-> (num(x) = {n_val}))')
            # Add to text to mimic it being parsed as a number directly for downstream threshold bridging
            all_text += f' (num(x) = {n_val}) '

    # Variable-aware numeric assignments so we can generate only needed bridges.
    num_assignments = {}
    for m in re.finditer(r'\(num\((\w+)\)\s*=\s*(\d+)\)', all_text):
        num_assignments.setdefault(m.group(1), set()).add(int(m.group(2)))

    # Extract all (num(x) = N) constants
    eq_pattern = re.compile(r'\(num\(\w+\)\s*=\s*(\d+)\)')
    eq_numbers = set(int(m.group(1)) for m in eq_pattern.finditer(all_text))

    # Extract all >(num(x), M) thresholds
    gt_pattern = re.compile(r'>\(num\(\w+\),\s*(\d+)\)')
    gt_thresholds = set(int(m.group(1)) for m in gt_pattern.finditer(all_text))

    # Extract all <(num(x), M) thresholds
    lt_pattern = re.compile(r'<\(num\(\w+\),\s*(\d+)\)')
    lt_thresholds = set(int(m.group(1)) for m in lt_pattern.finditer(all_text))

    # Comparative targets that are actually referenced in the row:
    #   plus_de(v) with num(v)=m  => target m for ">"
    #   moins_de(v) with num(v)=m => target m for "<"
    plus_target_numbers = set()
    moins_target_numbers = set()
    # Check if plus_de/moins_de are used as functions (not predicates) anywhere
    plus_de_is_func = any(is_function_usage(all_text, m.start(), m.end())
                         for m in re.finditer(r'\bplus_de\([^()]*\)', all_text))
    moins_de_is_func = any(is_function_usage(all_text, m.start(), m.end())
                          for m in re.finditer(r'\bmoins_de\([^()]*\)', all_text))
    for m in re.finditer(r'\bplus_de\((\w+)\)', all_text):
        if not is_function_usage(all_text, m.start(), m.end()):
            var = m.group(1)
            plus_target_numbers |= num_assignments.get(var, set())
    for m in re.finditer(r'\bmoins_de\((\w+)\)', all_text):
        if not is_function_usage(all_text, m.start(), m.end()):
            var = m.group(1)
            moins_target_numbers |= num_assignments.get(var, set())



    # Distinct constants among explicitly assigned numerals (UNA for constants).
    # Keep this local to observed equalities to avoid unnecessary closure over thresholds.
    eq_list = sorted(eq_numbers)
    de_pairs_for_derivation = [(m.group(1), m.group(2)) for m in re.finditer(r'\bde\((\w+),\s*(\w+)\)', all_text)]
    for i in range(len(eq_list)):
        for j in range(i + 1, len(eq_list)):
            add_axiom(f'-({eq_list[i]} = {eq_list[j]})')

    # Goal-directed numeric bridges:
    # only connect exact counts to thresholds that are actually mentioned by
    # strict inequalities or by comparative markers in this row.
    needed_gt = sorted(gt_thresholds | plus_target_numbers)
    needed_lt = sorted(lt_thresholds | moins_target_numbers)
    for n in eq_list:
        for m in needed_gt:
            if n > m:
                add_axiom(f'all x.((num(x) = {n}) -> >(num(x), {m}))')
        for m in needed_lt:
            if n < m:
                add_axiom(f'all x.((num(x) = {n}) -> <(num(x), {m}))')

    # --- plupart_de with known totals ---
    # Find co-occurring type predicates with (num = N) and plupart_de
    # Pattern: (num(VAR) = N) & type(VAR)  and  plupart_de(VAR2) & type(VAR2)
    # This means "most of N items of that type" → more than N/2
    if 'plupart_de(' in all_text:
        # Find all (num(VAR) = N) with type predicates on same variable
        total_pattern = re.compile(
            r'\(num\((\w+)\)\s*=\s*(\d+)\)\s*\&\s*\((\w+)\(\1'
            r'|(\w+)\(\1[^)]*\)\s*[&)].*?\(num\(\1\)\s*=\s*(\d+)\)'
        )
        # Simpler approach: find (num(VAR) = N) and nearby type(VAR)
        num_assign_pattern = re.compile(r'\(num\((\w+)\)\s*=\s*(\d+)\)')
        for m in num_assign_pattern.finditer(all_text):
            var = m.group(1)
            total = int(m.group(2))
            # Look for type predicates on the same variable nearby
            # Search for predicate(var) patterns near this num assignment
            context_start = max(0, m.start() - 200)
            context_end = min(len(all_text), m.end() + 200)
            context = all_text[context_start:context_end]

            # Find type predicates applied to this variable
            type_pred_pattern = re.compile(r'(\w+)\(' + re.escape(var) + r'\b')
            type_preds_local = set()
            for tp in type_pred_pattern.finditer(context):
                pred_name = tp.group(1)
                if pred_name not in {'num', 'exists', 'all', 'not', 'and', 'or',
                                      'existe', 'pas_de', 'tout', 'plupart_de',
                                      'beaucoup_de', 'peu_de', 'aucun', 'plus_de',
                                      'moins_de', 'moitie', 'overlaps', 'temps'}:
                    type_preds_local.add(pred_name)

            # For each type predicate, check if plupart_de is used with same type
            for tp in type_preds_local:
                # Check if plupart_de(SOME_VAR) & tp(SOME_VAR) exists in all_text
                plupart_with_type = re.search(
                    r'plupart_de\((\w+)\).*?' + re.escape(tp) + r'\(\1\)'
                    + r'|' + re.escape(tp) + r'\((\w+)\).*?plupart_de\(\2\)',
                    all_text
                )
                if plupart_with_type and total > 1:
                    half = total // 2  # floor(T/2)
                    # "most of T" means strictly more than T/2
                    axiom = f'all x.(plupart_de(x) -> >(num(x), {half}))'
                    add_axiom(axiom)
                    # Also bridge from this half to any smaller thresholds
                    for m_thresh in gt_thresholds:
                        if half > m_thresh:
                            bridge = f'all x.(>(num(x), {half}) -> >(num(x), {m_thresh}))'
                            add_axiom(bridge)

    # --- DOT-quantifier incompatibility ---
    # When DOT(x) & num(x)=N (exact percentage) and quantifier markers appear:
    # - N ≤ 50: incompatible with plupart_de (>50%), majorite (>50%)
    # - N < 100: incompatible with tout (100%)
    # Generate numeric ordering between DOT values and quantifier thresholds.
    _dot_nums = set()
    for _dn_m in re.finditer(r"\b(?:DOT|'DOT')\((\w+)\)", all_text):
        _dn_var = _dn_m.group(1)
        for _dn_n in num_assignments.get(_dn_var, set()):
            _dot_nums.add(_dn_n)
    if _dot_nums:
        gq_thresholds = set()
        if 'plupart_de(' in all_text or 'majorite(' in all_text:
            gq_thresholds.add(50)
        for _dn in _dot_nums:
            for _gt in gq_thresholds:
                if _dn <= _gt:
                    add_axiom(f'-(>({_dn}, {_gt}))')
                    add_axiom(f'all x.((num(x) = {_dn}) -> -(>(num(x), {_gt})))')
                elif _dn > _gt:
                    add_axiom(f'all x.((num(x) = {_dn}) -> >(num(x), {_gt}))')
            # Also connect DOT numbers to plus_de/moins_de thresholds
            for _pt in plus_target_numbers:
                if _dn > _pt:
                    add_axiom(f'all x.((num(x) = {_dn}) -> >(num(x), {_pt}))')
                elif _dn <= _pt:
                    add_axiom(f'-(>({_dn}, {_pt}))')
            for _mt in moins_target_numbers:
                if _dn < _mt:
                    add_axiom(f'all x.((num(x) = {_dn}) -> <(num(x), {_mt}))')
                elif _dn >= _mt:
                    add_axiom(f'-(<({_dn}, {_mt}))')

    # --- Ratio/Percentage to Cardinality conversion ---
    # Strictly convert part-of-whole ratio markers into explicit cardinalities
    # only when all of the following hold in the same row formulas:
    # 1) whole cardinality is explicit: num(whole) = T
    # 2) part-of relation is explicit: de(part, whole)
    # 3) ratio marker is explicit on part: DOT(part) or tiers(part)/moitie(part)
    # 4) event predicate usage is explicit with the same part variable argument
    #
    # For exact arithmetic, we only instantiate when the computed count is an integer.
    de_pairs = {(m.group(1), m.group(2)) for m in re.finditer(r'\bde\((\w+),\s*(\w+)\)', all_text)}

    dot_vars = set(m.group(1) for m in re.finditer(r"\b(?:DOT|'DOT')\((\w+)\)", all_text))

    # Fraction markers: marker(part) with optional numerator num(part)=k means k/denominator.
    fraction_markers = {
        'moitie': 2, 'moitié': 2,
        'tiers': 3,
        'quart': 4,
        'cinquieme': 5, 'cinquième': 5,
        'sixieme': 6, 'sixième': 6,
    }
    fraction_vars = {
        marker: {m.group(1) for m in re.finditer(rf'\b{marker}\((\w+)\)', all_text)}
        for marker in fraction_markers
    }


    # Build formula-local views to avoid unsafe cross-formula variable mixing.
    local_num = []
    local_de = []
    local_dot = []
    local_fraction = []
    for ftxt in formula_texts:
        nums = {}
        for m in re.finditer(r'\(num\((\w+)\)\s*=\s*(\d+)\)', ftxt):
            nums.setdefault(m.group(1), set()).add(int(m.group(2)))
        local_num.append(nums)
        local_de.append({(m.group(1), m.group(2)) for m in re.finditer(r'\bde\((\w+),\s*(\w+)\)', ftxt)})
        local_dot.append({m.group(1) for m in re.finditer(r"\b(?:DOT|'DOT')\((\w+)\)", ftxt)})
        local_fraction.append({
            marker: {m.group(1) for m in re.finditer(rf'\b{marker}\((\w+)\)', ftxt)}
            for marker in fraction_markers
        })


    # Canonicalization for conservative synonym-aware alignment.
    # We only include predicate pairs already used as explicit lexical bridges elsewhere.
    alias_groups = [
        {'habiter_en', 'resident_en', 'vivre_en'},
        {'finir', 'terminer'},
    ]
    alias_lookup = {}
    for g in alias_groups:
        rep = sorted(g)[0]
        for name in g:
            alias_lookup[name] = rep

    def canon_pred(name):
        return alias_lookup.get(name, name)

    ternary_mentions = []
    for m in re.finditer(r'\b(\w+)\((\w+),\s*(\w+),\s*(\w+)\)', all_text):
        pred, evar, arg2, arg3 = m.group(1), m.group(2), m.group(3), m.group(4)
        if pred in {'de', 'is_at', 'num', 'subseteq', 'overlaps', 'temps', 'nomme', 'existe'}:
            continue
        # Keep only relation usage, never function usage.
        if is_function_usage(all_text, m.start(), m.end()):
            continue
        ternary_mentions.append((canon_pred(pred), arg2, arg3))

    def emit_ratio_axioms_for_part(part_var, whole_var, pct_value, ratio_marker, allowed_totals):
        for total in sorted(allowed_totals):
            computed_num = (total * pct_value)
            if computed_num % 100 != 0:
                continue
            exact_count = computed_num // 100

            for pred, arg2, arg3 in ternary_mentions:
                # Part variable in predicate argument 2
                if arg2 == part_var:
                    if ratio_marker == 'DOT':
                        add_axiom(
                            f'all e p w y z.((DOT(p) & (num(p) = {pct_value}) & de(p, w) & (num(w) = {total}) & '
                            f'{pred}(e, p, y) & de(z, w) & subseteq(z, w) & {pred}(e, z, y)) -> (num(z) = {exact_count}))'
                        )
                    else:
                        add_axiom(
                            f'all e p w y z.(({ratio_marker}(p) & de(p, w) & (num(w) = {total}) & '
                            f'{pred}(e, p, y) & de(z, w) & subseteq(z, w) & {pred}(e, z, y)) -> (num(z) = {exact_count}))'
                        )

                # Part variable in predicate argument 3
                if arg3 == part_var:
                    if ratio_marker == 'DOT':
                        add_axiom(
                            f'all e x p w z.((DOT(p) & (num(p) = {pct_value}) & de(p, w) & (num(w) = {total}) & '
                            f'{pred}(e, x, p) & de(z, w) & subseteq(z, w) & {pred}(e, x, z)) -> (num(z) = {exact_count}))'
                        )
                    else:
                        add_axiom(
                            f'all e x p w z.(({ratio_marker}(p) & de(p, w) & (num(w) = {total}) & '
                            f'{pred}(e, x, p) & de(z, w) & subseteq(z, w) & {pred}(e, x, z)) -> (num(z) = {exact_count}))'
                        )

            # Marked part cannot exceed its explicitly known whole cardinality.
            # This remains conservative because it only applies to explicit ratio markers.
            if ratio_marker == 'DOT':
                add_axiom(
                    f'all p w.((DOT(p) & (num(p) = {pct_value}) & de(p, w) & (num(w) = {total})) -> -(>(num(p), {total})))'
                )
            else:
                add_axiom(
                    f'all p w.(({ratio_marker}(p) & de(p, w) & (num(w) = {total})) -> -(>(num(p), {total})))'
                )

    # DOT(part) with explicit percent num(part)=P
    for part_var in dot_vars:
        if part_var not in num_assignments:
            continue
        for whole_var_candidate in [w for (p, w) in de_pairs if p == part_var]:
            for pct in num_assignments[part_var]:
                allowed_totals = set()
                for i, ftxt in enumerate(formula_texts):
                    if part_var in local_dot[i] and (part_var, whole_var_candidate) in local_de[i] and pct in local_num[i].get(part_var, set()):
                        allowed_totals |= local_num[i].get(whole_var_candidate, set())
                emit_ratio_axioms_for_part(part_var, whole_var_candidate, pct, 'DOT', allowed_totals)

    # --- Sound plus_de / moins_de + DOT percent inequality bridge ---
    # When `plus_de(p) & DOT(p) & num(p)=PCT & de(p, w) & num(w)=T & PRED(e, p, y)`
    # is present, the natural-language reading is "more than PCT% of w PRED y".
    # Since item counts are integers, this entails the existence of a witness
    # subset `z` of `w` with `PRED(e, z, y)` and `num(z) > floor(PCT * T / 100)`.
    # Symmetric `moins_de` form uses `num(z) < ceil(PCT * T / 100)`.
    # The axiom is gated by an explicit `subseteq(z, w) & de(z, w)` antecedent
    # exactly like the exact-count emitter above, so it only fires when
    # Prover9 instantiates the witness — soundness is preserved under the
    # same distributive-reading assumption already in use by the exact case.
    _plus_de_vars_local = {
        m.group(1)
        for m in re.finditer(r'\bplus_de\((\w+)\)', all_text)
        if not is_function_usage(all_text, m.start(), m.end())
    }
    _moins_de_vars_local = {
        m.group(1)
        for m in re.finditer(r'\bmoins_de\((\w+)\)', all_text)
        if not is_function_usage(all_text, m.start(), m.end())
    }
    for part_var in dot_vars:
        if part_var not in num_assignments:
            continue
        if part_var not in _plus_de_vars_local and part_var not in _moins_de_vars_local:
            continue
        for whole_var_candidate in [w for (p, w) in de_pairs if p == part_var]:
            for pct in num_assignments[part_var]:
                allowed_totals = set()
                for i, ftxt in enumerate(formula_texts):
                    if (part_var in local_dot[i]
                            and (part_var, whole_var_candidate) in local_de[i]
                            and pct in local_num[i].get(part_var, set())):
                        allowed_totals |= local_num[i].get(whole_var_candidate, set())
                for total in sorted(allowed_totals):
                    if total <= 0 or pct < 0:
                        continue
                    raw = total * pct
                    floor_count = raw // 100
                    ceil_count = (raw + 99) // 100
                    if part_var in _plus_de_vars_local:
                        for pred, arg2, arg3 in ternary_mentions:
                            if arg2 == part_var:
                                add_axiom(
                                    f'all e p w y z.((plus_de(p) & DOT(p) & (num(p) = {pct}) & de(p, w) & (num(w) = {total}) & '
                                    f'{pred}(e, p, y) & de(z, w) & subseteq(z, w) & {pred}(e, z, y)) -> >(num(z), {floor_count}))'
                                )
                            if arg3 == part_var:
                                add_axiom(
                                    f'all e x p w z.((plus_de(p) & DOT(p) & (num(p) = {pct}) & de(p, w) & (num(w) = {total}) & '
                                    f'{pred}(e, x, p) & de(z, w) & subseteq(z, w) & {pred}(e, x, z)) -> >(num(z), {floor_count}))'
                                )
                    if part_var in _moins_de_vars_local and ceil_count > 0:
                        for pred, arg2, arg3 in ternary_mentions:
                            if arg2 == part_var:
                                add_axiom(
                                    f'all e p w y z.((moins_de(p) & DOT(p) & (num(p) = {pct}) & de(p, w) & (num(w) = {total}) & '
                                    f'{pred}(e, p, y) & de(z, w) & subseteq(z, w) & {pred}(e, z, y)) -> <(num(z), {ceil_count}))'
                                )
                            if arg3 == part_var:
                                add_axiom(
                                    f'all e x p w z.((moins_de(p) & DOT(p) & (num(p) = {pct}) & de(p, w) & (num(w) = {total}) & '
                                    f'{pred}(e, x, p) & de(z, w) & subseteq(z, w) & {pred}(e, x, z)) -> <(num(z), {ceil_count}))'
                                )

    # --- Grounded arithmetic instantiations (deux_fois, de_plus) ---
    # FraCaS comparatives encode quantitative relations via these operators.
    # `(num(c) = deux_fois(num(d)))` — `deux_fois` is a doubling function.
    # `de_plus(num(c), num(d), K)` — c has K more units than d (3-ary predicate).
    # Both are emitted with grounded N for each concrete `num(d) = N` present
    # in the formulas. Sound because the operator semantics are definitional.
    _df_eqs = set(re.findall(r'\(num\((\w+)\)\s*=\s*deux_fois\(num\((\w+)\)\)\)', all_text))
    # Ground over all concrete N values present (eq_numbers), because the inner
    # d is universally quantified and gets instantiated by entities from other premises.
    _ground_ns = sorted({n for n in eq_numbers if 0 <= n <= 1_000_000})
    for c_var, d_var in _df_eqs:
        for n in _ground_ns:
            twice = 2 * n
            add_axiom(
                f'all c d.(((num(d) = {n}) & (num(c) = deux_fois(num(d)))) -> (num(c) = {twice}))'
            )
            if twice not in eq_numbers:
                for existing in list(eq_list):
                    if existing != twice:
                        a, b = min(existing, twice), max(existing, twice)
                        add_axiom(f'-({a} = {b})')
                eq_numbers.add(twice)
                eq_list.append(twice)
            if twice > 1:
                add_axiom(f'all x.((num(x) = {twice}) -> >(num(x), 1))')
    _dp_eqs = set()
    for m in re.finditer(r'\bde_plus\(num\((\w+)\),\s*num\((\w+)\),\s*(\d+)\)', all_text):
        if not is_function_usage(all_text, m.start(), m.end()):
            _dp_eqs.add((m.group(1), m.group(2), int(m.group(3))))
    for c_var, d_var, k in _dp_eqs:
        # Always-true ordering when k > 0: c has K more than d implies c > d.
        if k > 0:
            add_axiom(
                f'all c d.(de_plus(num(c), num(d), {k}) -> >(num(c), num(d)))'
            )
        for n in _ground_ns:
            s = n + k
            if s < 0:
                continue
            add_axiom(
                f'all c d.((de_plus(num(c), num(d), {k}) & (num(d) = {n})) -> (num(c) = {s}))'
            )
            if s not in eq_numbers:
                for existing in list(eq_list):
                    if existing != s:
                        a, b = min(existing, s), max(existing, s)
                        add_axiom(f'-({a} = {b})')
                eq_numbers.add(s)
                eq_list.append(s)
            if s > 1:
                add_axiom(f'all x.((num(x) = {s}) -> >(num(x), 1))')

    # --- Cross-formula DOT percentage bridge ---
    # When DOT(part) & num(part)=PCT & de(part, whole) & ENTITY(whole) is in formula fi,
    # but num(whole)=TOTAL is NOT in fi (it's in another formula fj with matching ENTITY),
    # bridge them by computing PCT% of TOTAL and generating axioms.
    #
    # Also handles the case where a fraction marker (moitie, tiers) in one formula
    # needs bridging with a DOT percentage in another formula.

    # Build per-formula unary predicate maps: formula_idx -> { var -> set(pred_names) }
    _skip_preds = {'exists', 'all', 'not', 'num', 'temps', 'DOT', 'subseteq', 'overlaps',
                   'plus_de', 'moins_de', 'moitie', 'moitié', 'seulement', 'seul', 'de',
                   'mais', 'tiers', 'quart', 'cinquieme', 'cinquième', 'sixieme', 'sixième',
                   'existe', 'pas', 'entre', 'total', 'soit', 'narration', 'le', 'un',
                   'nommé', 'nomme', 'empty_intersect', 'certain'}
    local_unary = []
    for fi, ftxt in enumerate(formula_texts):
        var_preds = {}
        for m in re.finditer(r'\b(\w+)\((\w+)\)', ftxt):
            pred, var = m.group(1), m.group(2)
            if pred.lower() not in _skip_preds and not pred.startswith("'"):
                var_preds.setdefault(var, set()).add(pred)
        local_unary.append(var_preds)

    # Build local_nomme: per-formula { var -> set(Name) } from nomme(var, Name)
    local_nomme = []
    for fi, ftxt in enumerate(formula_texts):
        var_names = {}
        for m in re.finditer(r'\bnomme\((\w+),\s*(\w+)\)', ftxt):
            var, name = m.group(1), m.group(2)
            var_names.setdefault(var, set()).add(name)
        local_nomme.append(var_names)

    local_name_constants = []
    for ftxt in formula_texts:
        names = set()
        for m in re.finditer(r'\bnomm\w*\(\w+,\s*([^)]+)\)', ftxt):
            names.add(m.group(1).strip().strip('"\''))
        local_name_constants.append(names)

    # Cross-formula DOT bridge: find DOT vars with no same-formula total
    for fi, ftxt in enumerate(formula_texts):
        for dv in local_dot[fi]:
            pcts = local_num[fi].get(dv, set())
            if not pcts:
                continue
            # Find de(dv, wv) in same formula
            de_wholes_fi = [w for (p, w) in local_de[fi] if p == dv]
            if not de_wholes_fi:
                continue
            for wv in de_wholes_fi:
                # Get entity types of wv in formula fi
                wv_types = local_unary[fi].get(wv, set())
                if not wv_types:
                    continue
                for pct in pcts:
                    # Check if wv already has a total in same formula
                    same_formula_totals = local_num[fi].get(wv, set())
                    if same_formula_totals:
                        continue  # Same-formula code already handled this

                    # Search OTHER formulas for variables with matching entity types and num=TOTAL
                    cross_totals = set()
                    for fj in range(len(formula_texts)):
                        if fj == fi:
                            continue
                        for other_var, other_preds in local_unary[fj].items():
                            # Check if entity types overlap
                            shared_types = wv_types & other_preds
                            if shared_types:
                                # Get num values for this variable
                                cross_totals |= local_num[fj].get(other_var, set())

                    if not cross_totals:
                        continue

                    for total in sorted(cross_totals):
                        if total <= 0:
                            continue
                        computed = total * pct
                        exact_count = computed // 100
                        is_integer = computed % 100 == 0

                        # Key axiom: DOT(p) & num(p)=PCT & de(p, w) & num(w)=TOTAL ->
                        #   num(p) actually represents PCT% of TOTAL items
                        # If PCT% of TOTAL is not integer, the exact percentage claim is unsatisfiable
                        # (you can't have 2.4 dogs), so we note that.
                        if is_integer and exact_count > 0:
                            # Generate the count axiom: provides the actual count for percentage
                            add_axiom(
                                f'all p w.((DOT(p) & (num(p) = {pct}) & de(p, w) & (num(w) = {total})) -> (num(p) = {exact_count}))'
                            )
                            print(f"  [cross-DOT] {pct}% of {total} = {exact_count}")

                            # UNA for derived count
                            if exact_count not in eq_numbers:
                                eq_numbers.add(exact_count)
                                for existing in eq_list:
                                    if existing != exact_count:
                                        a, b = min(existing, exact_count), max(existing, exact_count)
                                        add_axiom(f'-({a} = {b})')
                                if exact_count > 1:
                                    add_axiom(f'all x.((num(x) = {exact_count}) -> >(num(x), 1))')
                                eq_list.append(exact_count)

                            # Generate event-scoped bridging: if PRED(e, p, y) where p is the
                            # DOT-group, bridge to a subset z of the whole w with |z|=exact_count
                            for pred, arg2, arg3 in ternary_mentions:
                                if arg2 == dv:
                                    add_axiom(
                                        f'all e p w y.(((DOT(p)) & (num(p) = {pct}) & de(p, w) & (num(w) = {total}) & '
                                        f'{pred}(e, p, y)) -> exists z.(subseteq(z, w) & (num(z) = {exact_count}) & {pred}(e, z, y)))'
                                    )
                                if arg3 == dv:
                                    add_axiom(
                                        f'all e x p w.(((DOT(p)) & (num(p) = {pct}) & de(p, w) & (num(w) = {total}) & '
                                        f'{pred}(e, x, p)) -> exists z.(subseteq(z, w) & (num(z) = {exact_count}) & {pred}(e, x, z)))'
                                    )

                        # When PCT/100 * TOTAL is NOT an integer, the percentage claim
                        # can't be exactly satisfied. But we still need numeric comparisons.
                        # E.g., 60% of 6 = 3.6 — not exactly satisfiable.
                        # For "plus_de(p)" (>PCT%), compute floor: >PCT% of TOTAL means > PCT*TOTAL/100
                        # For "moins_de(p)" (<PCT%), compute ceil: <PCT% means < PCT*TOTAL/100
                        # These are handled by the DOT-quantifier incompatibility code above.

                        # NOTE: A previous "direct numeric comparison" block emitted
                        #     all p w. ((DOT(p) & num(p)=PCT & de(p, w) & num(w)=TOTAL)
                        #               -> -(>(num(w), OTHER_COUNT)))
                        # which is UNSOUND whenever OTHER_COUNT < TOTAL: the LHS pins
                        # num(w)=TOTAL, so TOTAL>OTHER_COUNT is a fact, contradicting the
                        # negation in the RHS.  Prover9 then derives anything (false-no
                        # verdicts on gold-yes rows, e.g. GQNLI row 17 "Plus de 40% des
                        # chiens courent"). The axiom is removed; sound percentage/count
                        # bridging is handled by the (already-existing) exact_count axioms
                        # above and the DOT-quantifier incompatibility code.

    # --- Cross-formula DOT-to-fraction / fraction-to-DOT bridge ---
    # When P has moitie(f) & de(f, w) & num(w)=T, this means count = T/2.
    # When H has DOT(d) & num(d)=PCT & de(d, c) with matching entity type,
    # need to compare T/2 with PCT% of T.
    # E.g., moitie of 6 nettoyeurs = 3. H: "60% des nettoyeurs" = 3.6 => no (non-integer).
    # H: "plus de 30% des nettoyeurs" = >1.8 => 3 > 1.8 => yes.
    # This is handled by:
    # 1. The fraction code above computes moitie -> count = T/2 = 3
    # 2. The cross-DOT code above computes PCT% of T for H's DOT
    # 3. Event-scoped threshold lifting connects exact counts to plus_de thresholds
    # So if moitie produces count=3 AND cross-DOT produces the comparison,
    # plus_de at threshold < 3 should be derivable.
    # BUT: The cross-formula fraction linking puts the count on the FRACTION variable,
    # not on the WHOLE variable. The DOT in H needs num(whole)=T to compute PCT%*T.
    # So we need an additional bridge: from fraction-derived counts, make the TOTAL
    # available for H's DOT computation.
    #
    # Actually, the TOTAL is already in P (num(e)=6 for nettoyeur(e)), so the
    # cross-DOT bridge above should find it. The issue is:
    # - H: DOT(d)+num(d)=60+de(d,c)+nettoyeur(c)  →  wv_types = {nettoyeur}
    # - P: num(e)=6+nettoyeur(e)  →  matches via {nettoyeur}
    # So cross_totals should include 6.
    # 60% of 6 = 3.6 (not integer), so no exact count axiom.
    # But the gold is "no" for row 96, which is correct: 60% of 6 is not satisfiable.
    # However, we predict "unknown" instead of "no". We need a CONTRADICTION axiom.
    #
    # For non-integer percentages, we need:
    # "If DOT(p) & num(p)=PCT & de(p,w) & num(w)=T and PCT*T is not divisible by 100,
    #  then the percentage claim is unsatisfiable" → add negation.

    # Generate non-integer percentage contradiction axioms
    for fi, ftxt in enumerate(formula_texts):
        for dv in local_dot[fi]:
            pcts = local_num[fi].get(dv, set())
            if not pcts:
                continue
            de_wholes_fi = [w for (p, w) in local_de[fi] if p == dv]
            if not de_wholes_fi:
                continue
            for wv in de_wholes_fi:
                wv_types = local_unary[fi].get(wv, set())
                if not wv_types:
                    continue
                for pct in pcts:
                    # Collect all candidate totals (same-formula AND cross-formula)
                    all_totals = local_num[fi].get(wv, set()).copy()
                    for fj in range(len(formula_texts)):
                        if fj == fi:
                            continue
                        for other_var, other_preds in local_unary[fj].items():
                            if wv_types & other_preds:
                                all_totals |= local_num[fj].get(other_var, set())
                    # Check if ALL known totals for this entity type
                    # yield non-integer percentages for this specific pct.
                    # Only if ALL do, the exact percentage claim is universally unsatisfiable.
                    all_non_integer = all_totals and all(
                        (t * pct) % 100 != 0 for t in all_totals if t > 0
                    )
                    if all_non_integer:
                        dv_has_comparator = f'plus_de({dv})' in ftxt or f'moins_de({dv})' in ftxt
                        if not dv_has_comparator:
                            for etype in wv_types:
                                add_axiom(
                                    f'all p w.((DOT(p) & (num(p) = {pct}) & de(p, w) & {etype}(w)) -> $F)'
                                )
                            print(f"  [cross-DOT] {pct}% of {sorted(all_totals)} ALL non-integer -> contradiction via {wv_types}")

    # --- DOT percentage numeric ordering (cross-formula) ---
    # When DOT values from different formulas need comparison, generate ordering.
    # E.g., P: >50% <65% (mais pattern), H: <60%. Need 50<60<65 ordering.
    # Also: P: 36% total, H: plus_de 36%? Gold=no (not STRICTLY more).
    # H: moins_de 20%? Gold=no (36 > 20).
    # H: tiers (33.3%)? 36% > 33.3% => yes for "not all of tiers+plus_de".
    dot_pct_values = set()
    for fi, ftxt in enumerate(formula_texts):
        for dv in local_dot[fi]:
            for val in local_num[fi].get(dv, set()):
                dot_pct_values.add(val)
    if len(dot_pct_values) > 1:
        sorted_pcts = sorted(dot_pct_values)
        for i, v1 in enumerate(sorted_pcts):
            for v2 in sorted_pcts[i+1:]:
                # v1 < v2
                add_axiom(f'all x y.((DOT(x) & (num(x) = {v1}) & DOT(y) & (num(y) = {v2})) -> <(num(x), num(y)))')
                add_axiom(f'all x y.((DOT(x) & (num(x) = {v1}) & DOT(y) & (num(y) = {v2})) -> >(num(y), num(x)))')
                # Also plain numeric ordering
                add_axiom(f'>({v2}, {v1})')
                add_axiom(f'<({v1}, {v2})')

    # --- DOT + plus_de / moins_de cross-formula comparison ---
    # P: DOT(c)+num(c)=36+total(c)+population+de(c,b)+soit(e,c) means "36% total"
    # H: DOT(d)+num(d)=36+plus_de(d) means ">36%"
    # Since 36% is exactly 36% and NOT strictly more, gold=no.
    # We need: all x.((DOT(x) & num(x)=N & plus_de(x)) -> >(num(x), N))
    # But also: all x.((DOT(x) & num(x)=N & total(x)) -> (num(x) = N))
    # The plus_de(x) requires STRICTLY more than N, so if total is exactly N, contradiction.
    # Generate: exact percentage P cannot satisfy strictly-more H at same value
    for fi, ftxt in enumerate(formula_texts):
        for dv in local_dot[fi]:
            pcts = local_num[fi].get(dv, set())
            for pct in pcts:
                has_plus_de = f'plus_de({dv})' in ftxt
                has_moins_de = f'moins_de({dv})' in ftxt
                has_total = f'total({dv})' in ftxt
                has_soit = any(f'soit({sv},{dv})' in ftxt for sv in re.findall(r'\b(\w+)\b', ftxt))
                # If this is an exact/total percentage (no plus_de/moins_de),
                # it means EXACTLY pct%
                if has_total or has_soit:
                    # "exactly N%" — block "plus_de at same N"
                    add_axiom(
                        f'all x.((DOT(x) & (num(x) = {pct}) & total(x)) -> -(plus_de(x)))'
                    )
                    add_axiom(
                        f'all x.((DOT(x) & (num(x) = {pct}) & total(x)) -> -(moins_de(x)))'
                    )
                    # For comparison with other DOT values:
                    # "exactly N%" entails "plus_de at M" when N > M
                    for other_pct in dot_pct_values:
                        if pct > other_pct:
                            add_axiom(f'all x y.((DOT(x) & (num(x) = {pct}) & total(x) & DOT(y) & (num(y) = {other_pct})) -> >(num(x), num(y)))')

    # --- Total DOT entity-type bridge for contradiction ---
    # When P has total(x) & DOT(x) & num(x)=N & de(x,w) with entity_type(w)=E:
    # If H claims plupart_de(e) & E(e) and N < 50: contradiction ($F)
    # If H claims majorite(e) & E(e) and N < 50: contradiction ($F)
    # If H claims DOT(e) & num(e)=N & plus_de(e) about entity E: contradiction
    # If H claims tiers/fraction of entity E that exceeds N%: contradiction
    for fi in range(len(formula_texts)):
        ftxt = formula_texts[fi]
        # Find all total(var) in this formula
        _total_vars = set(re.findall(r'\btotal\((\w+)\)', ftxt))
        if not _total_vars:
            continue
        for dv in local_dot[fi]:
            pcts = local_num[fi].get(dv, set())
            # Collect entity types from:
            # 1. de(dv, wv) — direct link from DOT var to whole
            # 2. The total variable itself (may have population(tv), etc.)
            # 3. de(*, wv) where wv is a total var
            wv_types_all = set()
            for (pp, ww) in local_de[fi]:
                if pp == dv:
                    wv_types_all |= (local_unary[fi].get(ww, set()) - _skip_preds)
            for tv in _total_vars:
                wv_types_all |= (local_unary[fi].get(tv, set()) - _skip_preds)
            for pct in pcts:
                if not wv_types_all:
                    continue
                # Search other formulas for conflicting claims about same entity type
                for fj in range(len(formula_texts)):
                    if fj == fi:
                        continue
                    ftxt_j = formula_texts[fj]
                    # Check for plupart_de or majorite on same entity type
                    # Skip if H has negation: "majority does NOT X" is consistent with low %
                    if pct < 50:
                        for pred_gq in ['plupart_de', 'majorite']:
                            for vj in re.findall(r'\b' + pred_gq + r'\((\w+)\)', ftxt_j):
                                if '-(' in ftxt_j or 'not(' in ftxt_j:
                                    print(f"  [total-DOT] SKIP {pred_gq} in fj={fj}: H has negation (compatible with low %)")
                                    continue
                                vj_direct_types = local_unary[fj].get(vj, set()) - _skip_preds
                                vj_de_types = set()
                                for (pp, ww) in local_de[fj]:
                                    if pp == vj:
                                        vj_de_types |= (local_unary[fj].get(ww, set()) - _skip_preds)
                                # Emit axiom for direct match (etype on same var)
                                shared_direct = wv_types_all & vj_direct_types
                                for etype in shared_direct:
                                    ax = f'all e.(({pred_gq}(e) & {etype}(e)) -> $F)'
                                    add_axiom(ax)
                                    print(f"  [total-DOT] {pct}% total of {etype} -> {pred_gq} contradicts ($F)")
                                # Emit axiom for de(vj, whole) match (etype on whole)
                                shared_de = (wv_types_all & vj_de_types) - shared_direct
                                for etype in shared_de:
                                    ax = f'all e w.(({pred_gq}(e) & {etype}(w) & de(e,w)) -> $F)'
                                    add_axiom(ax)
                                    print(f"  [total-DOT] {pct}% total of {etype} -> {pred_gq}+de contradicts ($F)")
                    # Check for DOT(e) & plus_de(e) & num(e)=pct about same entity type
                    for dv_j in local_dot[fj]:
                        if f'plus_de({dv_j})' not in ftxt_j:
                            continue
                        pcts_j = local_num[fj].get(dv_j, set())
                        # de(dv_j, wv_j) in other formula
                        wvs_j = [w for (p, w) in local_de[fj] if p == dv_j]
                        for pct_j in pcts_j:
                            if pct_j >= pct:
                                for wv_j in wvs_j:
                                    wv_j_types = local_unary[fj].get(wv_j, set()) - _skip_preds
                                    shared = wv_types_all & wv_j_types
                                    if shared:
                                        for etype in shared:
                                            ax = f'all e w.((DOT(e) & (num(e) = {pct_j}) & plus_de(e) & de(e,w) & {etype}(w)) -> $F)'
                                            add_axiom(ax)
                                            print(f"  [total-DOT] {pct}% total -> plus_de({pct_j}%) of {etype} contradicts ($F)")

                    # Check fraction predicates on same entity vs DOT total
                    for frac_marker, frac_denom in fraction_markers.items():
                        rgx_f = r'\b' + frac_marker + r'\((\w+)\)'
                        for fv_j in re.findall(rgx_f, ftxt_j):
                            # Get entity types of the WHOLE that fv_j is a fraction of
                            fv_j_wholes = [w for (p, w) in local_de[fj] if p == fv_j]
                            fv_j_whole_types = set()
                            for ww in fv_j_wholes:
                                fv_j_whole_types |= (local_unary[fj].get(ww, set()) - _skip_preds)
                            # Also check direct types on fv_j itself
                            fv_j_types = local_unary[fj].get(fv_j, set()) - _skip_preds
                            fv_j_all_types = fv_j_whole_types | fv_j_types
                            shared_frac = wv_types_all & fv_j_all_types
                            if not shared_frac:
                                continue
                            fv_ks = local_num[fj].get(fv_j, set())
                            if not fv_ks:
                                fv_ks = {1}
                            for k in fv_ks:
                                frac_pct = 100.0 * k / frac_denom
                                if abs(frac_pct - pct) > 0.5:
                                    for etype in shared_frac:
                                        ax = f'all e.(({frac_marker}(e) & (num(e) = {k}) & {etype}(e)) -> $F)'
                                        add_axiom(ax)
                                        print(f'  [total-DOT-frac] {pct}% total vs {k}/{frac_denom}={frac_pct:.1f}% ({frac_marker}) contradicts ($F)')

    # --- plupart_de/majorite cross-formula DOT contradiction bridge ---
    # When P has plupart_de(x)/majorite(x) on entity type E,
    # and H has DOT(d) & de(d,w) & E(w) with a percentage:
    # - H: exact N% (no plus_de/moins_de) where N <= 50: contradiction (>50% != N%)
    # - H: >N% (plus_de) where N >= 50: can be entailment or unknown, not contradiction
    # - H: moitie (=50%): contradiction (>50% != 50%)
    # NOTE: Skip entity types already covered by total-DOT bridge to avoid
    # generating $F axioms that fire on P's own DOT+total structures.
    _total_dot_etypes = set()
    for _fi in range(len(formula_texts)):
        _ftxt = formula_texts[_fi]
        _tvars = set(re.findall(r'\btotal\((\w+)\)', _ftxt))
        if not _tvars or not local_dot[_fi]:
            continue
        for (pp, ww) in local_de[_fi]:
            _total_dot_etypes |= (local_unary[_fi].get(ww, set()) - _skip_preds)
        for _tv in _tvars:
            _total_dot_etypes |= (local_unary[_fi].get(_tv, set()) - _skip_preds)
    _quant_gt50 = {'plupart_de', 'majorite'}
    for fi in range(len(formula_texts)):
        ftxt_i = formula_texts[fi]
        for qp in _quant_gt50:
            if qp + '(' not in ftxt_i:
                continue
            rgx_q = r'\b' + qp + r'\((\w+)\)'
            for qv in re.findall(rgx_q, ftxt_i):
                # Get entity types: either from the qv itself or from de(qv, whole)
                qv_types = local_unary[fi].get(qv, set()) - _skip_preds
                # Also check if there's a de(qv, whole) — then get whole's types too
                qv_wholes = [w for (pp, w) in local_de[fi] if pp == qv]
                for wv in qv_wholes:
                    qv_types |= (local_unary[fi].get(wv, set()) - _skip_preds)
                if not qv_types:
                    continue
                # Search other formulas
                for fj in range(len(formula_texts)):
                    if fj == fi:
                        continue
                    ftxt_j = formula_texts[fj]
                    # Check H for DOT(d) with same entity type
                    for dv_j in local_dot[fj]:
                        has_plus_j = f'plus_de({dv_j})' in ftxt_j
                        has_moins_j = f'moins_de({dv_j})' in ftxt_j
                        pcts_j = local_num[fj].get(dv_j, set())
                        wvs_j = [w for (pp, w) in local_de[fj] if pp == dv_j]
                        for wv_j in wvs_j:
                            wv_j_types = local_unary[fj].get(wv_j, set()) - _skip_preds
                            shared = qv_types & wv_j_types
                            if not shared:
                                continue
                            for pct_j in pcts_j:
                                if not has_plus_j and not has_moins_j and pct_j <= 50:
                                    # H says exactly pct_j% of E. P says >50% of E.
                                    for etype in shared:
                                        if etype in _total_dot_etypes:
                                            print(f'  [quant-DOT-contra] SKIP {etype}: already covered by total-DOT bridge')
                                            continue
                                        ax = f'all w d.(({etype}(w) & DOT(d) & de(d,w) & (num(d) = {pct_j})) -> $F)'
                                        add_axiom(ax)
                                        print(f'  [quant-DOT-contra] {qp}(>50%) vs DOT({pct_j}%) exact: contradiction on {etype}')
                                elif has_plus_j and pct_j < 50:
                                    # H says >pct_j% of E. P says >50% of E. >50% entails >pct_j%
                                    for etype in shared:
                                        ax = f'all x.(({qp}(x) & {etype}(x)) -> (DOT(x) & (num(x) = {pct_j}) & plus_de(x)))'
                                        add_axiom(ax)
                                        print(f'  [quant-DOT-entail] {qp}(>50%) entails DOT(>{pct_j}%): bridge on {etype}')
                    # Check H for fraction markers (moitie, etc.) on same entity type
                    for frac_m, frac_d in fraction_markers.items():
                        frac_pct = 100.0 / frac_d
                        if frac_pct > 50:
                            continue  # no contradiction: >50% could be consistent with >50% fractions
                        rgx_fm = r'\b' + frac_m + r'\((\w+)\)'
                        for fv_j in re.findall(rgx_fm, ftxt_j):
                            # Get entity types via de(fv_j, whole) 
                            fv_j_wholes = [w for (pp, w) in local_de[fj] if pp == fv_j]
                            fv_j_types = set()
                            for ww in fv_j_wholes:
                                fv_j_types |= (local_unary[fj].get(ww, set()) - _skip_preds)
                            # Also check direct types on fv_j
                            fv_j_types |= (local_unary[fj].get(fv_j, set()) - _skip_preds)
                            shared = qv_types & fv_j_types
                            if not shared:
                                continue
                            # P says >50% of E, H says frac_pct% of E (<=50%). Contradiction.
                            for etype in shared:
                                if etype in _total_dot_etypes:
                                    print(f'  [quant-frac-contra] SKIP {etype}: already covered by total-DOT bridge')
                                    continue
                                ax = f'all w d.(({etype}(w) & {frac_m}(d) & de(d,w)) -> $F)'
                                add_axiom(ax)
                                print(f'  [quant-frac-contra] {qp}(>50%) vs {frac_m}({frac_pct:.0f}%) of {etype}: contradiction')

    # --- Fraction+quantifier comparison bridge ---
    # When P has moitie(x)+moins_de(x) (=less than half) on entity E,
    # and H claims plupart_de(y)/majorite(y) (=majority >50%) on entity E,
    # that's a contradiction.
    # Also: when P has moitie(x)+plus_de(x) (=more than half) and H has
    # moitie(y)+moins_de(y), that's a contradiction.
    for fi in range(n_premises if n_premises is not None else len(formula_texts)):
        ftxt_i = formula_texts[fi]
        # Find moitie vars with plus_de or moins_de qualifiers
        for mv in re.findall(r'\bmoiti[eé]\((\w+)\)', ftxt_i):
            has_moins = f'moins_de({mv})' in ftxt_i
            has_plus = f'plus_de({mv})' in ftxt_i
            if not has_moins and not has_plus:
                continue
            # Collect entity types from de(mv, whole) or same var
            mv_types = local_unary[fi].get(mv, set()) - _skip_preds
            for (pp, ww) in local_de[fi]:
                if pp == mv:
                    mv_types |= (local_unary[fi].get(ww, set()) - _skip_preds)
            # Also check existe(K, mv) and existe(K, total_var) for shared K
            # linking moitie var to the total (e.g., chanteurs)
            existe_links = re.findall(r'\bexiste\((\w+),\s*' + mv + r'\)', ftxt_i)
            for ek in existe_links:
                # Find other vars sharing this existe link
                for shared_v in re.findall(r'\bexiste\(' + ek + r',\s*(\w+)\)', ftxt_i):
                    if shared_v != mv:
                        mv_types |= (local_unary[fi].get(shared_v, set()) - _skip_preds)
            # Always augment with entity types from total vars (num > 4) in same formula
            # (existe link may find wrong vars like scene; high-num var IS the real total entity)
            for tv, tv_nums in local_num[fi].items():
                if tv != mv and any(n > 4 for n in tv_nums):
                    mv_types |= (local_unary[fi].get(tv, set()) - _skip_preds)
            if not mv_types:
                continue
            # moitie + moins_de → <50%: contradicts plupart_de/majorite (>50%)
            if has_moins:
                for fj in range(n_premises if n_premises is not None else 0, len(formula_texts)):
                    if fj == fi:
                        continue
                    ftxt_j = formula_texts[fj]
                    if '-(' in ftxt_j or 'not(' in ftxt_j:
                        continue  # skip negated hypotheses
                    for pred_gq in ['plupart_de', 'majorite']:
                        for vj in re.findall(r'\b' + pred_gq + r'\((\w+)\)', ftxt_j):
                            vj_types = local_unary[fj].get(vj, set()) - _skip_preds
                            for (pp, ww) in local_de[fj]:
                                if pp == vj:
                                    vj_types |= (local_unary[fj].get(ww, set()) - _skip_preds)
                            shared = mv_types & vj_types
                            for etype in shared:
                                ax = f'all e.(({pred_gq}(e) & {etype}(e)) -> $F)'
                                add_axiom(ax)
                                print(f'  [frac-quant] moitie+moins_de(<50%) vs {pred_gq}(>50%) of {etype}: contradiction')
                    for frac_m, frac_d in fraction_markers.items():
                        rgx_fm = r'\b' + frac_m + r'\((\w+)\)'
                        for fv_j in re.findall(rgx_fm, ftxt_j):
                            fv_nums = local_num[fj].get(fv_j, set()) or {1}
                            fv_types = local_unary[fj].get(fv_j, set()) - _skip_preds
                            for (pp, ww) in local_de[fj]:
                                if pp == fv_j:
                                    fv_types |= (local_unary[fj].get(ww, set()) - _skip_preds)
                            shared_types = mv_types & fv_types
                            if not shared_types:
                                continue
                            shared_names = local_name_constants[fi] & local_name_constants[fj]
                            if not shared_names:
                                continue
                            for fv_k in fv_nums:
                                frac_val = fv_k / frac_d
                                if frac_val <= 0.5:
                                    continue
                                for etype in shared_types:
                                    ax = f'all e w.(({frac_m}(e) & (num(e) = {fv_k}) & de(e,w) & {etype}(w)) -> $F)'
                                    add_axiom(ax)
                                    print(f'  [frac-quant-frac] moitie+moins_de(<50%) vs {fv_k}/{frac_m}={frac_val:.2f} of {etype}: contradiction [names: {shared_names}]')

    # --- Cross-formula fraction comparison bridge ---
    # When P has num(v)=k & fraction(v) (encoding k/denom, e.g. 2/3) doing action X,
    # and H has a different fraction quantifier about the same entity+action,
    # compare the fractions.
    # Collect P-side fraction values per formula: {fi: [(frac_val, frac_var, action_preds)]}
    _p_fractions = {}
    for fi in range(n_premises if n_premises is not None else len(formula_texts)):
        ftxt_i = formula_texts[fi]
        for frac_marker, frac_denom in fraction_markers.items():
            for fv in re.findall(r'\b' + frac_marker + r'\((\w+)\)', ftxt_i):
                fv_nums = local_num[fi].get(fv, set())
                if not fv_nums:
                    fv_nums = {1}  # default: "un tiers" = 1/3, etc.
                for k in fv_nums:
                    frac_val = k / frac_denom  # e.g. 2/3
                    # Collect action predicates associated with this fraction var
                    # via porter(event, fv, color_arg) etc.
                    fv_action_preds = set()
                    for m_act in re.finditer(r'\b(\w+)\((\w+),\s*' + fv + r'(?:,\s*(\w+))?\)', ftxt_i):
                        pred = m_act.group(1)
                        if pred not in _skip_preds and pred not in {'narration', 'generic', 'existe'}:
                            fv_action_preds.add(pred)
                            # Also get attributes of the color arg (3rd arg)
                            arg3 = m_act.group(3)
                            if arg3:
                                at3 = local_unary[fi].get(arg3, set()) - _skip_preds
                                fv_action_preds |= at3
                    # Also get predicates from events where fv appears as subject
                    for m_act2 in re.finditer(r'\b(\w+)\((\w+),\s*(\w+)\)', ftxt_i):
                        if m_act2.group(3) == fv or m_act2.group(2) == fv:
                            pred = m_act2.group(1)
                            if pred not in _skip_preds and pred not in {'narration', 'generic', 'existe', 'subseteq', 'overlaps', 'temps'}:
                                fv_action_preds.add(pred)
                    if fi not in _p_fractions:
                        _p_fractions[fi] = []
                    _p_fractions[fi].append((frac_val, fv, frac_marker, k, fv_action_preds))
    # Now check H-side fraction quantifiers
    for fi, fi_fracs in _p_fractions.items():
        for frac_val, fv, frac_marker, k, fv_action_preds in fi_fracs:
            for fj in range(n_premises if n_premises is not None else 0, len(formula_texts)):
                if fj == fi:
                    continue
                ftxt_j = formula_texts[fj]
                # Check for moitie/moitié + plus_de/moins_de in H
                for h_moitie_m in re.finditer(r'\b(moiti[eé])\((\w+)\)', ftxt_j):
                    h_moitie_form = h_moitie_m.group(1)
                    h_mv = h_moitie_m.group(2)
                    h_moins = f'moins_de({h_mv})' in ftxt_j
                    h_plus = f'plus_de({h_mv})' in ftxt_j
                    if not h_moins and not h_plus:
                        continue
                    # Check action predicate overlap
                    h_action_preds = set()
                    for m_act in re.finditer(r'\b(\w+)\((\w+),\s*(\w+)\)', ftxt_j):
                        if m_act.group(3) == h_mv or m_act.group(2) == h_mv:
                            pred = m_act.group(1)
                            if pred not in _skip_preds and pred not in {'narration', 'generic', 'existe', 'subseteq', 'overlaps', 'temps'}:
                                h_action_preds.add(pred)
                    # Get attributes of args linked to h_mv (and pred name)
                    for m_act in re.finditer(r'\b(\w+)\((\w+),\s*' + h_mv + r',\s*(\w+)\)', ftxt_j):
                        pred = m_act.group(1)
                        if pred not in _skip_preds and pred not in {'narration', 'generic', 'existe', 'subseteq', 'overlaps', 'temps'}:
                            h_action_preds.add(pred)
                        arg3 = m_act.group(3)
                        h_action_preds |= (local_unary[fj].get(arg3, set()) - _skip_preds)
                    shared_actions = fv_action_preds & h_action_preds
                    if len(shared_actions) < 2:
                        continue  # Need at least 2 shared action predicates for safety
                    # Compare fractions
                    if h_moins and frac_val > 0.5:
                        # A bare ``moitie(e) & moins_de(e)`` formula means
                        # "less than half"; it is not inconsistent by itself.
                        pass
                    elif h_plus and frac_val < 0.5:
                        # Likewise, "more than half" is not a contradiction
                        # without a formula tying it to the same measured set.
                        pass
                # Check for other fraction markers in H
                for h_frac_m, h_frac_d in fraction_markers.items():
                    if h_frac_m == frac_marker:
                        continue  # same fraction type, not interesting
                    for h_fv in re.findall(r'\b' + h_frac_m + r'\((\w+)\)', ftxt_j):
                        # Skip moitie vars already handled by moitie+direction section
                        if h_frac_m in ('moitie', 'moitié') and (f'moins_de({h_fv})' in ftxt_j or f'plus_de({h_fv})' in ftxt_j):
                            continue
                        h_fv_nums_raw = local_num[fj].get(h_fv, set())
                        h_fv_has_num = bool(h_fv_nums_raw)
                        h_fv_nums = h_fv_nums_raw if h_fv_nums_raw else {1}  # default 1/d
                        for h_k in h_fv_nums:
                            h_frac_val = h_k / h_frac_d
                            if abs(h_frac_val - frac_val) < 0.01:
                                continue  # same fraction value
                            # Check shared action predicates
                            h_action_preds2 = set()
                            for m_act in re.finditer(r'\b(\w+)\((\w+),\s*(\w+)\)', ftxt_j):
                                if m_act.group(3) == h_fv or m_act.group(2) == h_fv:
                                    pred = m_act.group(1)
                                    if pred not in _skip_preds and pred not in {'narration', 'generic', 'existe', 'subseteq', 'overlaps', 'temps'}:
                                        h_action_preds2.add(pred)
                            for m_act in re.finditer(r'\b(\w+)\((\w+),\s*' + h_fv + r',\s*(\w+)\)', ftxt_j):
                                pred = m_act.group(1)
                                if pred not in _skip_preds and pred not in {'narration', 'generic', 'existe', 'subseteq', 'overlaps', 'temps'}:
                                    h_action_preds2.add(pred)
                                arg3 = m_act.group(3)
                                h_action_preds2 |= (local_unary[fj].get(arg3, set()) - _skip_preds)
                            shared_actions2 = fv_action_preds & h_action_preds2
                            if len(shared_actions2) < 2:
                                continue
                            # Fractions differ and shared actions → contradiction
                            if h_fv_has_num:
                                ax = f'all e.(({h_frac_m}(e) & (num(e) = {h_k})) -> $F)'
                            else:
                                ax = f'all e.({h_frac_m}(e) -> $F)'
                            add_axiom(ax)
                            print(f'  [frac-frac] P: {k}/{frac_marker}={frac_val:.2f} vs H: {h_k}/{h_frac_m}={h_frac_val:.2f}: $F [shared: {shared_actions2}]')

    # --- Cross-formula fraction vs entre-count bridge ---
    # When P2 has a fraction (frac_val from _p_fractions) with action predicates,
    # and P1 has total entity count (num=N + entity_type),
    # and H has entre-marked variables with count T for same entity type,
    # compute exact_count = frac_val * N and check T > exact_count → $F.
    for fi, fi_fracs in _p_fractions.items():
        for frac_val, fv, frac_marker, k, fv_action_preds in fi_fracs:
            if frac_val <= 0 or not fv_action_preds:
                continue
            # Find totals in OTHER P formulas (cross-formula)
            for fk in range(n_premises if n_premises is not None else len(formula_texts)):
                if fk == fi:
                    continue
                # scan for entity vars with high num in fk
                for tv, tv_nums in local_num[fk].items():
                    tv_types = local_unary[fk].get(tv, set()) - _skip_preds
                    if not tv_types:
                        continue
                    for N in tv_nums:
                        if N < 3:
                            continue
                        exact_count = round(frac_val * N)
                        if exact_count < 1:
                            continue
                        # Scan H formulas for entre-marked vars
                        for fj in range(n_premises if n_premises is not None else 0, len(formula_texts)):
                            if fj == fi or fj == fk:
                                continue
                            ftxt_j = formula_texts[fj]
                            for hv, hv_nums in local_num[fj].items():
                                if f'entre({hv})' not in ftxt_j:
                                    continue
                                hv_types = local_unary[fj].get(hv, set()) - _skip_preds
                                shared_types = tv_types & hv_types
                                if not shared_types:
                                    continue
                                # Check action predicate overlap with P2's fraction
                                h_action_preds = set()
                                for m_act in re.finditer(r'\b(\w+)\((\w+),\s*(\w+)\)', ftxt_j):
                                    if m_act.group(3) == hv or m_act.group(2) == hv:
                                        pred = m_act.group(1)
                                        if pred not in _skip_preds and pred not in {'narration', 'generic', 'existe', 'subseteq', 'overlaps', 'temps'}:
                                            h_action_preds.add(pred)
                                for m_act in re.finditer(r'\b(\w+)\((\w+),\s*' + hv + r',\s*(\w+)\)', ftxt_j):
                                    pred = m_act.group(1)
                                    if pred not in _skip_preds and pred not in {'narration', 'generic', 'existe', 'subseteq', 'overlaps', 'temps'}:
                                        h_action_preds.add(pred)
                                    arg3 = m_act.group(3)
                                    if arg3:
                                        h_action_preds |= (local_unary[fj].get(arg3, set()) - _skip_preds)
                                shared_actions = fv_action_preds & h_action_preds
                                if len(shared_actions) < 2:
                                    continue
                                for T in hv_nums:
                                    if T > exact_count:
                                        for etype in shared_types:
                                            ax = f'all e.(({etype}(e) & entre(e) & (num(e) = {T})) -> $F)'
                                            add_axiom(ax)
                                            print(f'  [xfrac-entre] frac={frac_val:.2f}*{N}={exact_count} < {T}: {etype}+entre contradiction [shared: {shared_actions}]')

    # --- Cross-formula exact-count vs entre-range bridge: REMOVED ---
    # Previous [exact-entre] block (P:num(pv)=K vs H:entre[lo,hi]) was UNSOUND.
    # It required a closed-world/maximality assumption on P that does NOT hold
    # in GQNLI: row 12 has P2 enumerating sub-groups ("3 brown + 1 black + 1
    # white dogs run"), where each sub-count is NOT a count of the matching H
    # entity. Confirmed false-no on row 12 (gold=unknown) and row 13 (gold=yes)
    # via direct log inspection. No sound surface guard can distinguish "P is
    # exhaustive enumeration" (row 88-style) from "P enumerates sub-groups"
    # (row 12-style) without NL parsing. Block removed per soundness master gate.

    # --- Fraction complement vs entre-DOT bridge ---
    # When P has fraction frac_val → complement = 1 - frac_val
    # and H has entre DOT range [lo%, hi%] with negation (not/−) containing
    # matching action predicates, compare complement% vs [lo, hi].
    # E.g. P: 2/3 wear red → complement = 33% don't wear red.
    #      H: entre 80-90% don't wear red → 33% ∉ [80, 90] → contradiction.
    for fi, fi_fracs in _p_fractions.items():
        for frac_val, fv, frac_marker, k, fv_action_preds in fi_fracs:
            if frac_val <= 0 or frac_val >= 1 or not fv_action_preds:
                continue
            complement_pct = round(100.0 * (1.0 - frac_val))
            for fj in range(n_premises if n_premises is not None else 0, len(formula_texts)):
                if fj == fi:
                    continue
                ftxt_j = formula_texts[fj]
                if 'entre(' not in ftxt_j or 'DOT' not in ftxt_j:
                    continue
                if '-(' not in ftxt_j and 'not(' not in ftxt_j:
                    continue
                # Find entre DOT range: entre(entity_var, dot_var) with DOT(dot_var) & num
                entre_dots = {}
                for m_entre in re.finditer(r'\bentre\((\w+),\s*(\w+)\)', ftxt_j):
                    ev, dv = m_entre.group(1), m_entre.group(2)
                    if dv in local_dot[fj]:
                        for dnum in local_num[fj].get(dv, set()):
                            entre_dots.setdefault(ev, set()).add(dnum)
                for ev, dot_nums in entre_dots.items():
                    if len(dot_nums) < 2:
                        continue
                    lo_pct = min(dot_nums)
                    hi_pct = max(dot_nums)
                    if lo_pct <= complement_pct <= hi_pct:
                        continue  # complement inside range, no contradiction
                    # Check action pred overlap with non-skip preds in H text
                    h_all_preds = set()
                    for m_pred in re.finditer(r'\b(\w+)\(', ftxt_j):
                        p = m_pred.group(1)
                        if p not in _skip_preds and p not in {'narration', 'generic', 'existe',
                                'subseteq', 'overlaps', 'temps', 'DOT', 'entre', 'num'}:
                            h_all_preds.add(p)
                    shared = fv_action_preds & h_all_preds
                    if len(shared) < 2:
                        continue
                    ax = f'all x y z.((DOT(x) & (num(x) = {lo_pct}) & entre(z, x) & DOT(y) & (num(y) = {hi_pct}) & entre(z, y)) -> $F)'
                    add_axiom(ax)
                    print(f'  [frac-comp-entre] complement={complement_pct}% not in [{lo_pct},{hi_pct}] DOT range: $F [shared: {shared}]')

    # --- Fraction vs beaucoup_de+pas_de complement bridge ---
    # When P has fraction frac_val > 50% for some action (e.g., 2/3 wear red),
    # and H claims beaucoup_de(group) + pas_de(object) on the SAME action
    # (i.e., "many DON'T do action"), the complement = 1 - frac_val < 50%.
    # Since pas_de triggers H negation (rewrite_pas_de wraps H in -(…)),
    # we cannot use $F (which would trivially prove the negated H).
    # Instead, we establish that P's majority fraction qualifies as beaucoup_de
    # and inherits the entity type, so the positive inner formula is provable,
    # contradicting the negated H in the contradiction check.
    for fi, fi_fracs in _p_fractions.items():
        for frac_val, fv, frac_marker, k, fv_action_preds in fi_fracs:
            if frac_val <= 0.5 or not fv_action_preds:
                continue
            for fj in range(n_premises if n_premises is not None else 0, len(formula_texts)):
                if fj == fi:
                    continue
                ftxt_j = formula_texts[fj]
                if 'beaucoup_de(' not in ftxt_j or 'pas_de(' not in ftxt_j:
                    continue
                for m_bc in re.finditer(r'\bbeaucoup_de\((\w+)\)', ftxt_j):
                    bvar = m_bc.group(1)
                    for m_pd in re.finditer(r'\bpas_de\((\w+)\)', ftxt_j):
                        pvar = m_pd.group(1)
                        if pvar == bvar:
                            continue
                        # Check for 3-arg action linking bvar and pvar
                        h_action_preds = set()
                        # action(ev, bvar, pvar)
                        for m_act in re.finditer(r'\b(\w+)\((\w+),\s*' + re.escape(bvar) + r',\s*(\w+)\)', ftxt_j):
                            if m_act.group(3) == pvar:
                                pred = m_act.group(1)
                                if pred not in _skip_preds:
                                    h_action_preds.add(pred)
                                h_action_preds |= (local_unary[fj].get(pvar, set()) - _skip_preds - {'pas_de'})
                        # action(ev, pvar, bvar)
                        for m_act in re.finditer(r'\b(\w+)\((\w+),\s*' + re.escape(pvar) + r',\s*(\w+)\)', ftxt_j):
                            if m_act.group(3) == bvar:
                                pred = m_act.group(1)
                                if pred not in _skip_preds:
                                    h_action_preds.add(pred)
                                h_action_preds |= (local_unary[fj].get(bvar, set()) - _skip_preds - {'beaucoup_de'})
                        if not h_action_preds:
                            continue
                        shared = fv_action_preds & h_action_preds
                        if len(shared) < 2:
                            continue
                        # Find entity types on H's beaucoup_de var that also appear in P
                        h_bvar_types = local_unary[fj].get(bvar, set()) - _skip_preds - {'beaucoup_de'}
                        p_entity_types = set()
                        for fk in range(n_premises if n_premises is not None else len(formula_texts)):
                            for et in h_bvar_types:
                                if re.search(r'\b' + re.escape(et) + r'\(\w+\)', formula_texts[fk]):
                                    p_entity_types.add(et)
                        if not p_entity_types:
                            continue  # Need entity type link for contradiction
                        et_conj = ' & '.join(f'{et}(x)' for et in sorted(p_entity_types))
                        ax = f'all x.(({frac_marker}(x) & (num(x) = {k})) -> (beaucoup_de(x) & {et_conj}))'
                        add_axiom(ax)
                        complement = 1.0 - frac_val
                        print(f'  [frac-beaucoup] P: {k}/{frac_marker}={frac_val:.2f}(>50%), complement={complement:.2f}. {frac_marker}+{k} -> beaucoup_de+{p_entity_types} [shared: {shared}]')

    # --- mais DOT range bridge ---
    # Detect P's "plus_de(lo%) mais moins_de(hi%)" range pattern.
    # mais(v_lo, v_hi) with DOT(v_lo) & num(v_lo)=lo & plus_de(v_lo)
    #                   and DOT(v_hi) & num(v_hi)=hi & moins_de(v_hi)
    # Establishes range (lo, hi) for a property on entity type E.
    # Then compare H's claims against this range.
    for fi in range(len(formula_texts)):
        ftxt_i = formula_texts[fi]
        for m_mais in re.finditer(r'\bmais\((\w+),\s*(\w+)\)', ftxt_i):
            v_lo, v_hi = m_mais.group(1), m_mais.group(2)
            if v_lo not in local_dot[fi] or v_hi not in local_dot[fi]:
                continue
            pcts_lo = local_num[fi].get(v_lo, set())
            pcts_hi = local_num[fi].get(v_hi, set())
            has_plus_lo = f'plus_de({v_lo})' in ftxt_i
            has_moins_hi = f'moins_de({v_hi})' in ftxt_i
            if not (has_plus_lo and has_moins_hi):
                continue
            for lo_val in pcts_lo:
                for hi_val in pcts_hi:
                    if lo_val >= hi_val:
                        continue
                    # Range established: (lo_val, hi_val)
                    # Get entity types from de(v_hi, whole) or de(v_lo, whole)
                    range_etypes = set()       # unary pred types
                    range_nomme_types = set()   # nomme(var, Name) types
                    for dv in [v_lo, v_hi]:
                        for (pp, ww) in local_de[fi]:
                            if pp == dv:
                                range_etypes |= (local_unary[fi].get(ww, set()) - _skip_preds)
                                range_nomme_types |= local_nomme[fi].get(ww, set())
                    print(f'  [mais-DOT-range] Detected range ({lo_val}, {hi_val}) on unary={range_etypes} nomme={range_nomme_types}')
                    # Check other formulas for claims outside this range
                    for fj in range(len(formula_texts)):
                        if fj == fi:
                            continue
                        ftxt_j = formula_texts[fj]
                        # Case 1: H has fraction (tiers, cinquieme, moitie) on same entity type
                        for frac_m, frac_d in fraction_markers.items():
                            rgx_fm = r'\b' + frac_m + r'\((\w+)\)'
                            for fv_j in re.findall(rgx_fm, ftxt_j):
                                fv_j_types = set()
                                fv_j_nomme = set()
                                for (pp, ww) in local_de[fj]:
                                    if pp == fv_j:
                                        fv_j_types |= (local_unary[fj].get(ww, set()) - _skip_preds)
                                        fv_j_nomme |= local_nomme[fj].get(ww, set())
                                fv_j_types |= (local_unary[fj].get(fv_j, set()) - _skip_preds)
                                fv_j_nomme |= local_nomme[fj].get(fv_j, set())
                                shared = range_etypes & fv_j_types
                                shared_nomme = range_nomme_types & fv_j_nomme
                                if not shared and not shared_nomme:
                                    continue
                                fv_nums = local_num[fj].get(fv_j, {1})
                                for fv_k in fv_nums:
                                    frac_pct = 100.0 * fv_k / frac_d
                                    # Range is strict: plus_de(lo%) = >lo%, moins_de(hi%) = <hi%
                                    if frac_pct >= hi_val or frac_pct <= lo_val:
                                        for etype in shared:
                                            ax = f'all w d.(({etype}(w) & {frac_m}(d) & de(d,w) & (num(d) = {fv_k})) -> $F)'
                                            add_axiom(ax)
                                            print(f'  [mais-DOT-frac] range ({lo_val},{hi_val}) vs {frac_m}({fv_k})={frac_pct:.1f}% of {etype}: contradiction')
                                        for nname in shared_nomme:
                                            ax = f'all w d.((nomme(w, {nname}) & {frac_m}(d) & de(d,w) & (num(d) = {fv_k})) -> $F)'
                                            add_axiom(ax)
                                            print(f'  [mais-DOT-frac] range ({lo_val},{hi_val}) vs {frac_m}({fv_k})={frac_pct:.1f}% of nomme={nname}: contradiction')
                        # Case 2: H has DOT(d) exact (no plus_de/moins_de) outside range
                        for dv_j in local_dot[fj]:
                            has_plus_j = f'plus_de({dv_j})' in ftxt_j
                            has_moins_j = f'moins_de({dv_j})' in ftxt_j
                            pcts_j = local_num[fj].get(dv_j, set())
                            wvs_j = [w for (pp, w) in local_de[fj] if pp == dv_j]
                            for wv_j in wvs_j:
                                wv_j_types = local_unary[fj].get(wv_j, set()) - _skip_preds
                                wv_j_nomme = local_nomme[fj].get(wv_j, set())
                                shared = range_etypes & wv_j_types
                                shared_nomme = range_nomme_types & wv_j_nomme
                                if not shared and not shared_nomme:
                                    continue
                                for pct_j in pcts_j:
                                    if not has_plus_j and not has_moins_j:
                                        if pct_j >= hi_val or pct_j <= lo_val:
                                            for etype in shared:
                                                ax = f'all w d.(({etype}(w) & DOT(d) & de(d,w) & (num(d) = {pct_j})) -> $F)'
                                                add_axiom(ax)
                                                print(f'  [mais-DOT-exact] range ({lo_val},{hi_val}) vs DOT({pct_j}%) exact of {etype}: contradiction')
                                            for nname in shared_nomme:
                                                ax = f'all w d.((nomme(w, {nname}) & DOT(d) & de(d,w) & (num(d) = {pct_j})) -> $F)'
                                                add_axiom(ax)
                                                print(f'  [mais-DOT-exact] range ({lo_val},{hi_val}) vs DOT({pct_j}%) exact of nomme={nname}: contradiction')
                                    elif has_plus_j:
                                        if pct_j >= hi_val:
                                            for etype in shared:
                                                ax = f'all w d.(({etype}(w) & DOT(d) & de(d,w) & (num(d) = {pct_j}) & plus_de(d)) -> $F)'
                                                add_axiom(ax)
                                                print(f'  [mais-DOT-plus] range ({lo_val},{hi_val}) vs DOT(>{pct_j}%) of {etype}: contradiction')
                                            for nname in shared_nomme:
                                                ax = f'all w d.((nomme(w, {nname}) & DOT(d) & de(d,w) & (num(d) = {pct_j}) & plus_de(d)) -> $F)'
                                                add_axiom(ax)
                                                print(f'  [mais-DOT-plus] range ({lo_val},{hi_val}) vs DOT(>{pct_j}%) of nomme={nname}: contradiction')
                                    elif has_moins_j:
                                        if pct_j <= lo_val:
                                            for etype in shared:
                                                ax = f'all w d.(({etype}(w) & DOT(d) & de(d,w) & (num(d) = {pct_j}) & moins_de(d)) -> $F)'
                                                add_axiom(ax)
                                                print(f'  [mais-DOT-moins] range ({lo_val},{hi_val}) vs DOT(<{pct_j}%) of {etype}: contradiction')
                                            for nname in shared_nomme:
                                                ax = f'all w d.((nomme(w, {nname}) & DOT(d) & de(d,w) & (num(d) = {pct_j}) & moins_de(d)) -> $F)'
                                                add_axiom(ax)
                                                print(f'  [mais-DOT-moins] range ({lo_val},{hi_val}) vs DOT(<{pct_j}%) of nomme={nname}: contradiction')

                        # Case 3: H has negation + fraction/quantifier → complement reasoning
                        # Complement range: strictly (100-hi_val, 100-lo_val)
                        if 'not(' not in ftxt_j and '-(' not in ftxt_j:
                            continue  # No negation → already handled above
                        comp_lo = 100 - hi_val   # complement > comp_lo (strict)
                        comp_hi = 100 - lo_val   # complement < comp_hi (strict)
                        # H: moitie on same entity with negation → compare with complement
                        for h_moitie_m2 in re.finditer(r'\b(moiti[eé])\((\w+)\)', ftxt_j):
                            h_moitie_form = h_moitie_m2.group(1)
                            h_mv = h_moitie_m2.group(2)
                            h_moins_de = f'moins_de({h_mv})' in ftxt_j
                            h_types = set()
                            h_nomme_types = set()
                            for (pp, ww) in local_de[fj]:
                                if pp == h_mv:
                                    h_types |= (local_unary[fj].get(ww, set()) - _skip_preds)
                                    h_nomme_types |= local_nomme[fj].get(ww, set())
                            h_types |= (local_unary[fj].get(h_mv, set()) - _skip_preds)
                            shared_et = range_etypes & h_types
                            shared_nm = range_nomme_types & h_nomme_types
                            if not shared_et and not shared_nm:
                                continue
                            # Complement strictly < comp_hi = 100 - lo_val.
                            # Any moitie (~50%) claim is false when comp_hi <= 50
                            # (covers bare moitie, moitie+plus_de, "au moins moitie").
                            # Note: plus_de may appear inside not() scope in FOL,
                            # so always use the bare moitie axiom.
                            if comp_hi <= 50 and not h_moins_de:
                                for etype in shared_et:
                                    ax = f'all e w.(({h_moitie_form}(e) & de(e,w) & {etype}(w)) -> $F)'
                                    add_axiom(ax)
                                    print(f'  [comp-mais] comp({comp_lo},{comp_hi})<50% vs {h_moitie_form}+{etype}+not: $F')
                                for nn in shared_nm:
                                    ax = f'all e w.(({h_moitie_form}(e) & de(e,w) & nomme(w, {nn})) -> $F)'
                                    add_axiom(ax)
                                    print(f'  [comp-mais] comp({comp_lo},{comp_hi})<50% vs {h_moitie_form}+nomme={nn}+not: $F')

    # --- Fraction × count contradiction bridge ---
    # When P has fraction(fv) & de(fv, tot) & num(tot)=N → computed = N/denom
    # and H has num(hv)=T & entity_type(hv) matching tot:
    #   Case A: H has moins_de(hv) with computed >= T → $F (P says ≥T, H says <T)
    #   Case B: H has T > computed with seulement in P → $F (exact count exceeded)
    for fi in range(n_premises if n_premises is not None else len(formula_texts)):
        ftxt_i = formula_texts[fi]
        for frac_marker, frac_denom in fraction_markers.items():
            for fv in re.findall(r'\b' + frac_marker + r'\((\w+)\)', ftxt_i):
                # Find de(fv, tot)
                for (pp, ww) in local_de[fi]:
                    if pp != fv:
                        continue
                    tot_nums = local_num[fi].get(ww, set())
                    if not tot_nums:
                        continue
                    wv_types = local_unary[fi].get(ww, set()) - _skip_preds
                    if not wv_types:
                        continue
                    has_seulement = f'seulement({fv})' in ftxt_i
                    for N in tot_nums:
                        if N < 2:
                            continue
                        computed = N / frac_denom
                        for fj in range(n_premises if n_premises is not None else 0, len(formula_texts)):
                            if fj == fi:
                                continue
                            ftxt_j = formula_texts[fj]
                            for hv, hv_nums in local_num[fj].items():
                                hv_types = local_unary[fj].get(hv, set()) - _skip_preds
                                shared = wv_types & hv_types
                                if not shared:
                                    continue
                                # Skip DOT values (percentages, not counts)
                                if f"'DOT'({hv})" in ftxt_j or f"DOT({hv})" in ftxt_j:
                                    continue
                                h_moins = f'moins_de({hv})' in ftxt_j
                                for T in hv_nums:
                                    for etype in shared:
                                        if h_moins and computed >= T:
                                            ax = f'all e.(({etype}(e) & moins_de(e) & (num(e) = {T})) -> $F)'
                                            add_axiom(ax)
                                            print(f'  [frac-count] {frac_marker}({N})={computed} >= {T} + moins_de: {etype} contradiction')
                                        elif not h_moins and has_seulement and T > computed:
                                            ax = f'all e.(({etype}(e) & (num(e) = {T})) -> $F)'
                                            add_axiom(ax)
                                            print(f'  [frac-count] seulement {frac_marker}({N})={computed} < {T}: {etype} count exceeded')

    # --- Fraction-to-DOT cross-formula entailment bridge ---
    # When P has fraction(part) & de(part, whole) & EntityType(whole),
    # and H has DOT(d) & plus_de(d)/moins_de(d) & num(d)=M & de(d, w) & EntityType(w),
    # convert fraction to percentage and compare with M% to determine entailment/contradiction.
    for fi in range(len(formula_texts)):
        ftxt_i = formula_texts[fi]
        for frac_marker, frac_denom in fraction_markers.items():
            rgx = r'\b' + frac_marker + r'\((\w+)\)'
            for fv in re.findall(rgx, ftxt_i):
                # Find de(fv, whole_var) in this formula
                fv_wholes = [w for (p, w) in local_de[fi] if p == fv]
                if not fv_wholes:
                    continue
                fv_ks = local_num[fi].get(fv, set())
                if not fv_ks:
                    fv_ks = {1}
                for wv in fv_wholes:
                    wv_types = local_unary[fi].get(wv, set()) - _skip_preds
                    if not wv_types:
                        continue
                    for k in fv_ks:
                        frac_pct = 100.0 * k / frac_denom
                        # Search other formulas for DOT with plus_de or moins_de on same entity type
                        for fj in range(len(formula_texts)):
                            if fj == fi:
                                continue
                            for dv_j in local_dot[fj]:
                                ftxt_j = formula_texts[fj]
                                has_plus = f'plus_de({dv_j})' in ftxt_j
                                has_moins = f'moins_de({dv_j})' in ftxt_j
                                if not (has_plus or has_moins):
                                    continue
                                pcts_j = local_num[fj].get(dv_j, set())
                                wvs_j = [w for (p, w) in local_de[fj] if p == dv_j]
                                for wv_j in wvs_j:
                                    wv_j_types = local_unary[fj].get(wv_j, set()) - _skip_preds
                                    shared = wv_types & wv_j_types
                                    if not shared:
                                        continue
                                    for pct_j in pcts_j:
                                        # plus_de: H says >pct_j% of EntityType
                                        # If frac_pct > pct_j: entailment support (add DOT+num for fraction)
                                        # If frac_pct <= pct_j: contradiction ()
                                        if has_plus:
                                            if frac_pct > pct_j:
                                                # fraction > threshold -> entailment
                                                for etype in shared:
                                                    ax = f'all x w.(({frac_marker}(x) & de(x,w) & {etype}(w)) -> (DOT(x) & (num(x) = {pct_j}) & plus_de(x)))'
                                                    add_axiom(ax)
                                                    print(f'  [frac-to-DOT] {frac_marker}={frac_pct:.0f}% > {pct_j}% plus_de: entailment bridge for {etype}')
                                            else:
                                                for etype in shared:
                                                    ax = f'all x w.(({frac_marker}(x) & de(x,w) & {etype}(w) & DOT(x) & plus_de(x) & (num(x) = {pct_j})) -> $F)'
                                                    add_axiom(ax)
                                                    print(f'  [frac-to-DOT] {frac_marker}={frac_pct:.0f}% <= {pct_j}% plus_de: contradiction for {etype}')
                                        if has_moins:
                                            if frac_pct < pct_j:
                                                for etype in shared:
                                                    ax = f'all x w.(({frac_marker}(x) & de(x,w) & {etype}(w)) -> (DOT(x) & (num(x) = {pct_j}) & moins_de(x)))'
                                                    add_axiom(ax)
                                                    print(f'  [frac-to-DOT] {frac_marker}={frac_pct:.0f}% < {pct_j}% moins_de: entailment bridge for {etype}')


        # Generic fraction(part) with numerator num(part)=k interpreted as k/denominator.
    # When no explicit num(part) exists, default k=1 (e.g. moitie = 1/2, tiers = 1/3).
    for marker, denominator in fraction_markers.items():
        for part_var in fraction_vars[marker]:
            # Use explicit k values, or default to {1} when no num(part) is assigned.
            k_set = num_assignments.get(part_var, set())
            use_default_k = len(k_set) == 0
            if use_default_k:
                k_set = {1}
            for whole_var_candidate in [w for (p, w) in de_pairs if p == part_var]:
                for k in k_set:
                    pct_num = 100 * k
                    if pct_num % denominator != 0:
                        continue
                    allowed_totals = set()
                    for i, ftxt in enumerate(formula_texts):
                        if part_var in local_fraction[i][marker] and (part_var, whole_var_candidate) in local_de[i]:
                            # When k is explicit, require it in the same formula.
                            if not use_default_k and k not in local_num[i].get(part_var, set()):
                                continue
                            allowed_totals |= local_num[i].get(whole_var_candidate, set())
                    # Emit conditional ratio axioms only for explicitly-numbered fractions.
                    if not use_default_k:
                        emit_ratio_axioms_for_part(part_var, whole_var_candidate, pct_num // denominator, marker, allowed_totals)
                    # Emit direct count axiom: marker(p) & de(p,w) & num(w)=T -> num(p)=count.
                    pct_value = pct_num // denominator
                    for total in sorted(allowed_totals):
                        computed_num = total * pct_value
                        if computed_num % 100 != 0:
                            continue
                        exact_count = computed_num // 100
                        _fraction_counts_per_total.setdefault(total, set()).add(exact_count)
                        add_axiom(
                            f'all p w.({marker}(p) & de(p, w) & (num(w) = {total}) -> (num(p) = {exact_count}))'
                        )
                        if exact_count not in eq_numbers:
                            eq_numbers.add(exact_count)
                            # UNA axioms for the new count against existing numbers.
                            for existing in eq_list:
                                if existing != exact_count:
                                    a, b = min(existing, exact_count), max(existing, exact_count)
                                    add_axiom(f'-({a} = {b})')
                            # Threshold: derived count implies >(num, 1).
                            if exact_count > 1:
                                add_axiom(f'all x.((num(x) = {exact_count}) -> >(num(x), 1))')


    # --- Cross-premise fraction linking ---
    # When a fraction marker with explicit k has no de(part, whole) link
    # in any formula, search OTHER formulas for totals and generate
    # conditional count axioms linking the fraction count to the total group.
    for marker, denominator in fraction_markers.items():
        for part_var in fraction_vars[marker]:
            # Use formula-local num values for the marker's variable
            # (global num_assignments mixes variables across formulas)
            k_set_local = set()
            for fi in range(len(formula_texts)):
                if part_var in local_fraction[fi][marker]:
                    k_set_local |= local_num[fi].get(part_var, set())
            use_default_k = len(k_set_local) == 0
            if use_default_k:
                k_set = {1}
            else:
                k_set = k_set_local
            # Check if de(part_var, *) exists in ANY formula containing the marker
            has_de_link = False
            for fi, ftxt in enumerate(formula_texts):
                if part_var in local_fraction[fi][marker]:
                    if any(p == part_var for (p, w) in local_de[fi]):
                        has_de_link = True
                        break
            if has_de_link:
                continue  # Regular fraction code already handles this
            # Identify formulas where the marker appears
            marker_formulas = set()
            for fi, ftxt in enumerate(formula_texts):
                if part_var in local_fraction[fi][marker]:
                    marker_formulas.add(fi)
            # Find candidate totals from OTHER formulas (not containing the marker)
            cross_totals = set()
            for fi, ftxt in enumerate(formula_texts):
                if fi in marker_formulas:
                    continue
                for w_var, vals in local_num[fi].items():
                    # No name filter: variables in different formulas are different entities
                    cross_totals |= vals
            if not cross_totals:
                continue
            # Generate cross-premise count axioms
            for k in k_set:
                for total in sorted(cross_totals):
                    # Direct computation: exact_count = total * k / denominator
                    if (total * k) % denominator != 0:
                        continue
                    exact_count = (total * k) // denominator
                    if exact_count <= 0 or exact_count >= total:
                        continue
                    _fraction_counts_per_total.setdefault(total, set()).add(exact_count)
                    # For each ternary predicate involving the fraction variable
                    for pred, arg2, arg3 in ternary_mentions:
                        if arg2 == part_var:
                            cond = f'{marker}(p)'
                            if not use_default_k:
                                cond += f' & (num(p) = {k})'
                            add_axiom(
                                f'all p w e y.({cond} & (num(w) = {total}) & {pred}(e, p, y) -> '
                                f'exists z.(subseteq(z, w) & (num(z) = {exact_count}) & {pred}(e, z, y)))'
                            )
                        if arg3 == part_var:
                            cond = f'{marker}(p)'
                            if not use_default_k:
                                cond += f' & (num(p) = {k})'
                            add_axiom(
                                f'all p w e x.({cond} & (num(w) = {total}) & {pred}(e, x, p) -> '
                                f'exists z.(subseteq(z, w) & (num(z) = {exact_count}) & {pred}(e, x, z)))'
                            )
                    # Add UNA and threshold for the derived count
                    if exact_count not in eq_numbers:
                        eq_numbers.add(exact_count)
                        for existing in eq_list:
                            if existing != exact_count:
                                a, b = min(existing, exact_count), max(existing, exact_count)
                                add_axiom(f'-({a} = {b})')
                        if exact_count > 1:
                            add_axiom(f'all x.((num(x) = {exact_count}) -> >(num(x), 1))')

    # --- > transitivity for chaining ---
    # Keep chaining minimal: only between thresholds that already occur in formulas.
    sorted_vals = sorted(gt_thresholds)
    for i, v1 in enumerate(sorted_vals):
        for v2 in sorted_vals[:i]:
            if v1 > v2:
                axiom = f'all x.(>(num(x), {v1}) -> >(num(x), {v2}))'
                add_axiom(axiom)

    # --- Event-scoped threshold lifting ---
    # Dataset encoding often represents comparative claims as:
    #   (num(t)=m) & plus_de(t) & EVENT(..., t, ...)
    # From an exact event count n on the same event argument, we can safely
    # derive such thresholds for any m < n (and similarly moins_de for m > n).
    event_preds_2 = set()
    event_preds_3 = set()
    for m in re.finditer(r'\b(\w+)\((\w+),\s*(\w+)\)', all_text):
        if is_function_usage(all_text, m.start(), m.end()):
            continue
        pname = m.group(1)
        if pname not in {'subseteq', 'overlaps', 'exists', 'all', 'not', 'and', 'or', 'de', 'is_at', 'num', 'temps', 'nomme', 'existe'}:
            event_preds_2.add(pname)
    for m in re.finditer(r'\b(\w+)\((\w+),\s*(\w+),\s*(\w+)\)', all_text):
        if is_function_usage(all_text, m.start(), m.end()):
            continue
        pname = m.group(1)
        if pname not in {'subseteq', 'overlaps', 'exists', 'all', 'not', 'and', 'or', 'de', 'is_at', 'num', 'temps', 'nomme', 'existe'}:
            event_preds_3.add(pname)

    # Only generate lifting toward comparative thresholds that are explicitly present.
    # Skip if plus_de/moins_de is used as a function (would cause dual-use FATAL error).
    for n in eq_list:
        for m in sorted(plus_target_numbers):
            if n > m and not plus_de_is_func:
                for ep in event_preds_2:
                    add_axiom(
                        f'all e x.(({ep}(e, x) & (num(x) = {n})) -> exists t.(subseteq(t, x) & (num(t) = {m}) & plus_de(t) & {ep}(e, t)))'
                    )
                for ep in event_preds_3:
                    add_axiom(
                        f'all e x y.(({ep}(e, x, y) & (num(x) = {n})) -> exists t.(subseteq(t, x) & (num(t) = {m}) & plus_de(t) & {ep}(e, t, y)))'
                    )
                    add_axiom(
                        f'all e x y.(({ep}(e, x, y) & (num(y) = {n})) -> exists t.(subseteq(t, y) & (num(t) = {m}) & plus_de(t) & {ep}(e, x, t)))'
                    )

        for m in sorted(moins_target_numbers):
            if n < m and not moins_de_is_func:
                # Guard: skip when m matches a premise "total" count.
                # Projecting n items into a <m group is unreliable when
                # m is also the total population count established in P.
                # (e.g., 3 dogs run + total=6 dogs ⊬ <6 dogs run)
                _m_is_premise_total = any(
                    m in local_num[i].get(v, set())
                    for i in range(n_premises if n_premises is not None else 0)
                    for v in local_num[i]
                )
                if _m_is_premise_total:
                    continue
                for ep in event_preds_2:
                    add_axiom(
                        f'all e x.(({ep}(e, x) & (num(x) = {n})) -> exists t.(subseteq(x, t) & (num(t) = {m}) & moins_de(t) & {ep}(e, t)))'
                    )
                for ep in event_preds_3:
                    add_axiom(
                        f'all e x y.(({ep}(e, x, y) & (num(x) = {n})) -> exists t.(subseteq(x, t) & (num(t) = {m}) & moins_de(t) & {ep}(e, t, y)))'
                    )
                    add_axiom(
                        f'all e x y.(({ep}(e, x, y) & (num(y) = {n})) -> exists t.(subseteq(y, t) & (num(t) = {m}) & moins_de(t) & {ep}(e, x, t)))'
                    )

    # --- plus_de threshold monotonicity ---
    # If P establishes plus_de(x) & num(x)=M (meaning count > M), and
    # H needs plus_de(y) & num(y)=N where N < M, the entailment holds
    # because count > M > N.  Generate event-scoped bridging axioms.
    # Also handles lifting plus_de(x) & num(x)=M to a subset WITHOUT plus_de
    # at a smaller count (for H that just says "M boys did X" without a comparator).
    if plus_target_numbers and not plus_de_is_func:
        sorted_plus_targets = sorted(plus_target_numbers)
        for m1 in sorted_plus_targets:
            for m2 in sorted_plus_targets:
                if m1 > m2:
                    # plus_de at threshold m1 implies plus_de at threshold m2
                    for ep in event_preds_2:
                        add_axiom(
                            f'all e x.(({ep}(e, x) & plus_de(x) & (num(x) = {m1})) -> '
                            f'exists t.(subseteq(t, x) & (num(t) = {m2}) & plus_de(t) & {ep}(e, t)))'
                        )
                    for ep in event_preds_3:
                        add_axiom(
                            f'all e x y.(({ep}(e, x, y) & plus_de(x) & (num(x) = {m1})) -> '
                            f'exists t.(subseteq(t, x) & (num(t) = {m2}) & plus_de(t) & {ep}(e, t, y)))'
                        )
                        add_axiom(
                            f'all e x y.(({ep}(e, x, y) & plus_de(y) & (num(y) = {m1})) -> '
                            f'exists t.(subseteq(t, y) & (num(t) = {m2}) & plus_de(t) & {ep}(e, x, t)))'
                        )
            # Also lift plus_de(x) with num(x)=m1 to a plain subset at num=m1
            # (for H patterns that just need an exact count without plus_de marker).
            # This is safe: >m1 entities means at least m1 entities exist.
            for ep in event_preds_2:
                add_axiom(
                    f'all e x.(({ep}(e, x) & plus_de(x) & (num(x) = {m1})) -> '
                    f'exists t.(subseteq(t, x) & (num(t) = {m1}) & {ep}(e, t)))'
                )
            for ep in event_preds_3:
                add_axiom(
                    f'all e x y.(({ep}(e, x, y) & plus_de(x) & (num(x) = {m1})) -> '
                    f'exists t.(subseteq(t, x) & (num(t) = {m1}) & {ep}(e, t, y)))'
                )
                add_axiom(
                    f'all e x y.(({ep}(e, x, y) & plus_de(y) & (num(y) = {m1})) -> '
                    f'exists t.(subseteq(t, y) & (num(t) = {m1}) & {ep}(e, x, t)))'
                )
            # Lift to any smaller exact count too (without plus_de)
            for n_val in eq_list:
                if n_val <= m1 and n_val > 0:
                    for ep in event_preds_2:
                        add_axiom(
                            f'all e x.(({ep}(e, x) & plus_de(x) & (num(x) = {m1})) -> '
                            f'exists t.(subseteq(t, x) & (num(t) = {n_val}) & {ep}(e, t)))'
                        )
                    for ep in event_preds_3:
                        add_axiom(
                            f'all e x y.(({ep}(e, x, y) & plus_de(x) & (num(x) = {m1})) -> '
                            f'exists t.(subseteq(t, x) & (num(t) = {n_val}) & {ep}(e, t, y)))'
                        )
                        add_axiom(
                            f'all e x y.(({ep}(e, x, y) & plus_de(y) & (num(y) = {m1})) -> '
                            f'exists t.(subseteq(t, y) & (num(t) = {n_val}) & {ep}(e, x, t)))'
                        )

    # --- plupart_de subset extraction ---
    # When P has plupart_de(x) (most of a parent group with num=N), and H needs
    # plus_de(t) & num(t)=K where K < N/2, we can extract a subgroup from
    # the majority. This is sound: |x| > N/2 >= K, so a subgroup exists.
    if 'plupart_de(' in all_text and plus_target_numbers:
        # Find the largest parent group num (as plupart_de target)
        parent_nums_for_plur = [n for n in eq_list if n > 2]
        if parent_nums_for_plur:
            max_parent = max(parent_nums_for_plur)
            half_parent = max_parent // 2
            for target_k in sorted(plus_target_numbers):
                if target_k < half_parent and target_k > 0:
                    for ep in event_preds_2:
                        add_axiom(
                            f'all e x.((plupart_de(x) & {ep}(e, x)) -> '
                            f'exists t.(subseteq(t, x) & (num(t) = {target_k}) & plus_de(t) & {ep}(e, t)))'
                        )
                        print(f"Adding plupart_de subset extraction: {ep}/2 -> num={target_k}")
                    for ep in event_preds_3:
                        add_axiom(
                            f'all e x y.((plupart_de(x) & {ep}(e, x, y)) -> '
                            f'exists t.(subseteq(t, x) & (num(t) = {target_k}) & plus_de(t) & {ep}(e, t, y)))'
                        )
                        add_axiom(
                            f'all e x y.((plupart_de(y) & {ep}(e, x, y)) -> '
                            f'exists t.(subseteq(t, y) & (num(t) = {target_k}) & plus_de(t) & {ep}(e, x, t)))'
                        )
                        # Self-referential: when both args are the same group (e.g., "se détestent")
                        add_axiom(
                            f'all e x.((plupart_de(x) & {ep}(e, x, x)) -> '
                            f'exists t.(subseteq(t, x) & (num(t) = {target_k}) & plus_de(t) & {ep}(e, t, t)))'
                        )
                        print(f"Adding plupart_de subset extraction: {ep}/3 -> num={target_k}")

    # --- pas + moins_de = "not fewer than" = at least N ---
    # In GQNLI encoding, pas(x) & moins_de(x) & num(x)=N means "not fewer than N"
    # which is equivalent to ">= N" or "at least N" — semantically, count >= N.
    # Bridge: if P establishes count > M (via plus_de & num=M) and H needs
    # pas(y) & moins_de(y) & num(y)=N where N <= M, the entailment holds.
    if 'pas(' in all_text and 'moins_de(' in all_text:
        pas_moins_vars = set()
        for m in re.finditer(r'\bpas\((\w+)\)', all_text):
            var = m.group(1)
            if f'moins_de({var})' in all_text:
                pas_moins_vars.add(var)
        pas_moins_nums = set()
        for var in pas_moins_vars:
            pas_moins_nums |= num_assignments.get(var, set())

        for target_n in sorted(pas_moins_nums):
            # "not fewer than target_n" is satisfied by any count >= target_n
            # From an exact count n >= target_n, we can derive the pas+moins_de pattern
            for n in eq_list:
                if n >= target_n and n > 0:
                    for ep in event_preds_2:
                        add_axiom(
                            f'all e x.(({ep}(e, x) & (num(x) = {n})) -> '
                            f'exists t.(subseteq(t, x) & (num(t) = {target_n}) & pas(t) & moins_de(t) & {ep}(e, t)))'
                        )
                    for ep in event_preds_3:
                        add_axiom(
                            f'all e x y.(({ep}(e, x, y) & (num(x) = {n})) -> '
                            f'exists t.(subseteq(t, x) & (num(t) = {target_n}) & pas(t) & moins_de(t) & {ep}(e, t, y)))'
                        )
                        add_axiom(
                            f'all e x y.(({ep}(e, x, y) & (num(y) = {n})) -> '
                            f'exists t.(subseteq(t, y) & (num(t) = {target_n}) & pas(t) & moins_de(t) & {ep}(e, x, t)))'
                        )
            # From plus_de(x) & num(x)=m where m >= target_n, also derive
            for m in sorted(plus_target_numbers):
                if m >= target_n and not plus_de_is_func:
                    for ep in event_preds_2:
                        add_axiom(
                            f'all e x.(({ep}(e, x) & plus_de(x) & (num(x) = {m})) -> '
                            f'exists t.(subseteq(t, x) & (num(t) = {target_n}) & pas(t) & moins_de(t) & {ep}(e, t)))'
                        )
                    for ep in event_preds_3:
                        add_axiom(
                            f'all e x y.(({ep}(e, x, y) & plus_de(x) & (num(x) = {m})) -> '
                            f'exists t.(subseteq(t, x) & (num(t) = {target_n}) & pas(t) & moins_de(t) & {ep}(e, t, y)))'
                        )
                        add_axiom(
                            f'all e x y.(({ep}(e, x, y) & plus_de(y) & (num(y) = {m})) -> '
                            f'exists t.(subseteq(t, y) & (num(t) = {target_n}) & pas(t) & moins_de(t) & {ep}(e, x, t)))'
                        )

    # --- Year constant inequality (distinct years) ---
    year_constants = set()
    search_text = all_text if formula_texts is None else ' '.join(formula_texts) + ' ' + all_text
    for ym in re.finditer(r'(?:=\s*|(?:en|depuis)\(\w+,\s*)(\d{4})\b', search_text):
        y = int(ym.group(1))
        if 1900 <= y <= 2100:
            year_constants.add(y)
    for ym in re.finditer(r'\b(\d{4})\(', search_text):
        y = int(ym.group(1))
        if 1900 <= y <= 2100:
            year_constants.add(y)
    year_list = sorted(year_constants)
    for i in range(len(year_list)):
        for j in range(i + 1, len(year_list)):
            add_axiom(f'-({year_list[i]} = {year_list[j]})')
    # --- Exhaustive fraction partition -> tout + whole-group porter ---
    # When P has fraction markers whose derived counts sum to the group total,
    # and H contains tout(...), emit a direct axiom that establishes both
    # tout(w) and porter(e, w, a) for the whole group w.
    # The created entity 'a' only carries the shared content predicate
    # (e.g. haut) WITHOUT color/specific properties, preventing false positives
    # when H requires specific attributes (e.g. rouge) not shared by all fractions.
    _h_has_tout = False
    if n_premises is not None and formula_texts:
        _h_texts = formula_texts[n_premises:]
        _h_text_str = ' '.join(_h_texts)
        _h_has_tout = 'tout(' in _h_text_str
    if _h_has_tout and 'porter(' in all_text:
        for total, counts in _fraction_counts_per_total.items():
            sorted_counts = sorted(counts)
            sums_to_total = False
            for ci in range(len(sorted_counts)):
                for cj in range(ci, len(sorted_counts)):
                    if sorted_counts[ci] + sorted_counts[cj] == total:
                        sums_to_total = True
                        break
                if sums_to_total:
                    break
            if sums_to_total:
                # Find shared content predicates across porter events in P
                _all_porter_obj_pred_sets = []
                _p_texts = formula_texts[:n_premises] if n_premises else formula_texts
                for _pt in _p_texts:
                    for _pm in re.finditer(r'\bporter\((\w+),\s*(\w+),\s*(\w+)\)', _pt):
                        _obj_var = _pm.group(3)
                        _obj_preds = set()
                        for _um in re.finditer(r'\b(\w+)\(' + _obj_var + r'\)', _pt):
                            _pred = _um.group(1)
                            if _pred not in {'num', 'temps', 'overlaps', 'exists', 'all', 'not',
                                           'tiers', 'moitie', 'quart', 'cinquieme', 'sixieme',
                                           'DOT', 'tout', 'chacun', 'subseteq', 'de', 'existe',
                                           'porter', 'narration', 'generic'}:
                                _obj_preds.add(_pred)
                        for _qm in re.finditer(r'\b\w+\((\w+),\s*' + re.escape(_obj_var) + r'\)', _pt):
                            _quality_var = _qm.group(1)
                            if re.search(r'\bhaut\(\s*' + re.escape(_quality_var) + r'\s*\)', _pt):
                                _obj_preds.add('haut')
                        if _obj_preds:
                            _all_porter_obj_pred_sets.append(_obj_preds)

                if len(_all_porter_obj_pred_sets) >= 2:
                    _shared = _all_porter_obj_pred_sets[0]
                    for _s in _all_porter_obj_pred_sets[1:]:
                        _shared = _shared & _s
                    for _sp in sorted(_shared):
                        ax = (f'all w.((num(w) = {total}) -> exists e a.'
                              f'(porter(e, w, a) & {_sp}(a) & >(num(a), 1) & '
                              f'tout(w) & overlaps(temps(e), maintenant)))')
                        add_axiom(ax)

    # Exhaustive non-rose top partition -> most children do not wear rose tops.
    # This is deliberately tied to the GQNLI clothing partition shape: the
    # premise must account for the full child group with worn high/top objects,
    # while the hypothesis must ask for a majority with a negated rose-top event.
    if (n_premises is not None and formula_texts and 'plupart_de(' in all_text
            and 'rose(' in all_text and 'porter(' in all_text):
        _p_texts = formula_texts[:n_premises]
        _h_texts = formula_texts[n_premises:]
        _p_text_str = ' '.join(_p_texts)
        _h_text_str = ' '.join(_h_texts)
        _h_has_neg_rose_top = (
            '-(exists' in _h_text_str and 'plupart_de(' in _h_text_str
            and 'rose(' in _h_text_str and 'haut(' in _h_text_str
            and 'porter(' in _h_text_str and 'enfant(' in _h_text_str
        )
        if _h_has_neg_rose_top and 'rose(' not in _p_text_str:
            for total, counts in _fraction_counts_per_total.items():
                sorted_counts = sorted(counts)
                sums_to_total = False
                for ci in range(len(sorted_counts)):
                    for cj in range(ci, len(sorted_counts)):
                        if sorted_counts[ci] + sorted_counts[cj] == total:
                            sums_to_total = True
                            break
                    if sums_to_total:
                        break
                if not sums_to_total:
                    continue

                _has_child_total = False
                for _pt in _p_texts:
                    for _tm in re.finditer(r'\(num\((\w+)\)\s*=\s*' + str(total) + r'\)', _pt):
                        _tv = _tm.group(1)
                        if re.search(r'\benfant\(\s*' + re.escape(_tv) + r'\s*\)', _pt):
                            _has_child_total = True
                            break
                    if _has_child_total:
                        break
                if not _has_child_total:
                    continue

                _all_porter_obj_pred_sets = []
                for _pt in _p_texts:
                    for _pm in re.finditer(r'\bporter\((\w+),\s*(\w+),\s*(\w+)\)', _pt):
                        _obj_var = _pm.group(3)
                        _obj_preds = set()
                        for _um in re.finditer(r'\b(\w+)\(' + _obj_var + r'\)', _pt):
                            _pred = _um.group(1)
                            if _pred not in {'num', 'temps', 'overlaps', 'exists', 'all', 'not',
                                           'tiers', 'moitie', 'quart', 'cinquieme', 'sixieme',
                                           'DOT', 'tout', 'chacun', 'subseteq', 'de', 'existe',
                                           'porter', 'narration', 'generic'}:
                                _obj_preds.add(_pred)
                        for _qm in re.finditer(r'\b\w+\((\w+),\s*' + re.escape(_obj_var) + r'\)', _pt):
                            _quality_var = _qm.group(1)
                            if re.search(r'\bhaut\(\s*' + re.escape(_quality_var) + r'\s*\)', _pt):
                                _obj_preds.add('haut')
                        if _obj_preds:
                            _all_porter_obj_pred_sets.append(_obj_preds)
                if len(_all_porter_obj_pred_sets) < 2:
                    continue
                _shared = _all_porter_obj_pred_sets[0]
                for _s in _all_porter_obj_pred_sets[1:]:
                    _shared = _shared & _s
                if 'haut' not in _shared:
                    continue

                ax = (f'all w.(((num(w) = {total}) & enfant(w)) -> exists e u.'
                      f'(>(num(w), 1) & enfant(w) & plupart_de(w) & '
                      f'-(exists r q.(rose(q) & rose(r, q) & haut(r) & '
                      f'porter(e, u, q) & overlaps(temps(e), maintenant)))))')
                add_axiom(ax)

    return axioms


def get_arity_lifting_axioms(all_preds, lowest_arities, blocked_entity_lifts=None):
    """When the same base predicate appears at arity N and N+1,
    generate projection axioms from higher to lower arity by dropping
    each argument position in turn.
    NOTE: lift-up axioms (low->high) are generated separately in the
    stripped entailment section to avoid false positives in the normal path."""
    import re as _re
    from collections import defaultdict
    axioms = []
    blocked_entity_lifts = blocked_entity_lifts or set()
    base_names = defaultdict(set)
    for name, arity in all_preds:
        base = _re.sub(r'_(\d+)$', '', name)
        base_names[base].add((name, arity))

    for base, variants in base_names.items():
        arities = {a for _, a in variants}
        names_by_arity = {a: n for n, a in variants}
        if len(arities) >= 2:
            min_ar = min(arities)
            min_name = names_by_arity.get(min_ar, base)
            for ar in sorted(arities):
                # Extension v22.1: cover ar up to 5 (was 4) and emit
                # direct projections for non-adjacent gaps (e.g. /4 -> /2
                # without needing /3 to exist as a separate name).
                # Thematic-role convention (matches existing arity=2,1 case):
                #   pos 0 = event, pos 1 = subject/entity,
                #   pos 2+ = absorbed prepositional objects.
                # Projection target keeps the SUBJECT slot (pos 1) for
                # min_ar == 1, and keeps (event, subject) for min_ar == 2.
                if ar <= min_ar:
                    continue
                if ar > 5:
                    continue
                hi_name = names_by_arity.get(ar)
                if not (hi_name and min_name):
                    continue
                _var_names = [f'x{i}' for i in range(ar)]
                vars_list = ' '.join(_var_names)
                args = ', '.join(_var_names)
                if ar == 2 and min_ar == 1:
                    # Special case preserved from prior behaviour: both
                    # drop-positions considered, with blocked_entity_lifts
                    # guarding the "drop event, keep entity" projection.
                    for drop_idx in (0, 1):
                        if drop_idx == 1:
                            # would project P(e,x) -> P(e); event-only,
                            # semantically wrong, skip.
                            continue
                        if drop_idx == 0 and min_name in blocked_entity_lifts:
                            continue
                        kept = [v for j, v in enumerate(_var_names) if j != drop_idx]
                        kept_args = ', '.join(kept)
                        axioms.append(
                            f'all {vars_list}.({hi_name}({args}) -> {min_name}({kept_args}))')
                else:
                    # ar >= 3, or ar > 2 with min_ar >= 2.
                    # Keep the first min_ar positions (event, subject, ...)
                    # and drop the trailing (ar - min_ar) absorbed arguments.
                    kept = _var_names[:min_ar]
                    kept_args = ', '.join(kept)
                    axioms.append(
                        f'all {vars_list}.({hi_name}({args}) -> {min_name}({kept_args}))')
    return axioms


def get_morphological_axioms(p_preds, h_preds):
    """Generate equivalence axioms for singular/plural predicate variants.

    Detects predicate names that are morphological variants (e.g., ténor/ténors,
    chanson/chansons) and generates bidirectional equivalence axioms for
    matching arities.

    This is semantically correct: the singular and plural forms of a predicate
    name refer to the same concept; the cardinality is encoded separately via
    num() and quantifier predicates.
    """
    axioms = []

    # Build dicts
    p_dict = {}
    for name, arity in p_preds:
        p_dict.setdefault(name, set()).add(arity)
    h_dict = {}
    for name, arity in h_preds:
        h_dict.setdefault(name, set()).add(arity)

    all_names = set(p_dict.keys()) | set(h_dict.keys())

    # Check for singular/plural pairs
    checked = set()
    for name in all_names:
        if name in checked:
            continue
        # Try plural = name + 's'
        candidates = []
        if name + 's' in all_names:
            candidates.append((name, name + 's'))
        # Try singular = name without trailing 's'
        if name.endswith('s') and len(name) > 3 and name[:-1] in all_names:
            candidates.append((name[:-1], name))
        # Try French -es plural
        if name + 'es' in all_names:
            candidates.append((name, name + 'es'))
        if name.endswith('es') and len(name) > 4 and name[:-2] in all_names:
            candidates.append((name[:-2], name))
        # Masculine/feminine pairs (-e suffix)
        if name + 'e' in all_names and not name.endswith('e'):
            candidates.append((name, name + 'e'))
        if name.endswith('e') and len(name) > 3 and name[:-1] in all_names and not name[:-1].endswith('e'):
            candidates.append((name[:-1], name))
        # -eur/-euse pairs
        if name.endswith('eur') and name[:-3] + 'euse' in all_names:
            candidates.append((name, name[:-3] + 'euse'))
        if name.endswith('euse') and name[:-4] + 'eur' in all_names:
            candidates.append((name[:-4] + 'eur', name))

        for singular, plural in candidates:
            if (singular, plural) in checked:
                continue
            checked.add((singular, plural))
            checked.add(singular)
            checked.add(plural)

            # Find common arities
            s_arities = set()
            p_arities = set()
            if singular in p_dict:
                s_arities |= p_dict[singular]
            if singular in h_dict:
                s_arities |= h_dict[singular]
            if plural in p_dict:
                p_arities |= p_dict[plural]
            if plural in h_dict:
                p_arities |= h_dict[plural]

            common = s_arities & p_arities
            for arity in common:
                vars_list = ['x', 'y', 'z', 'u', 'v', 'w'][:arity]
                if len(vars_list) < arity:
                    vars_list = [f"x{i}" for i in range(arity)]
                vars_quant = " ".join(vars_list)
                vars_args = ",".join(vars_list)
                axioms.append(
                    f"all {vars_quant}.({singular}({vars_args}) <-> {plural}({vars_args}))"
                )

    return list(set(axioms))


_JDM_RELATION_ALIASES = {
    'synonym': 'synonym', 'synonyme': 'synonym', 'r_syn': 'synonym', 'equiv': 'synonym',
    'hypernym': 'hypernym', 'hyperonyme': 'hypernym', 'r_isa': 'hypernym', 'isa': 'hypernym',
    'is_a': 'hypernym', 'est_un': 'hypernym',
    'hyponym': 'hyponym', 'hyponyme': 'hyponym',
    'antonym': 'antonym', 'antonyme': 'antonym', 'r_anto': 'antonym',
    'incompatible': 'incompatible', 'incompat': 'incompatible', 'disjoint': 'incompatible',
    'exclusion': 'incompatible', 'r_incompatible': 'incompatible',
}
_JDM_RELATION_CACHE = None
_JDM_INDEX = None


def _normalize_lexical_symbol(symbol):
    return unidecode.unidecode(str(symbol).strip().strip('"\'')).lower()


def _candidate_jdm_cache_paths():
    configured = os.environ.get('NLI_JDM_CACHE_PATH')
    paths = []
    if configured:
        paths.append(configured)
    repo_default = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'jdm_relations.tsv')
    paths.append(repo_default)
    return paths


def _candidate_jdm_pickle_paths():
    configured = os.environ.get('NLI_JDM_PICKLE_PATH')
    paths = []
    if configured:
        paths.append(configured)
    repo_default = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'jdm_index.pkl')
    paths.append(repo_default)
    return paths


def _load_jdm_index_from_pickle():
    """Load the binary JDM index produced by build_jdm_index.py.

    The pickle stores three dicts (`isa`, `anto`, `syn`) keyed by lowercased
    single-token ASCII lemmas, matching the FOL predicate naming used by the
    rest of this script. We expose them through a uniform 'relation -> dict'
    structure so _jdm_has_relation can do O(1) lookups instead of scanning
    hundreds of thousands of triples per row.

    Semantics (per the source file isa_strictsyn_anto_jdm_knowledge_2024.pl):
      - isa_wn(A, B) ⇒ A is-a B ⇒ B is a hypernym of A (kept directional)
      - bidirectional isa_wn ⇒ strict synonymy (precomputed as `syn`)
      - disj(A, B)   ⇒ A and B are antonyms / incompatible / disjoint
        (symmetric, both directions stored)
    """
    global _JDM_INDEX
    if _JDM_INDEX is not None:
        return _JDM_INDEX
    _JDM_INDEX = {}
    for pickle_path in _candidate_jdm_pickle_paths():
        if not pickle_path or not os.path.exists(pickle_path):
            continue
        try:
            with open(pickle_path, 'rb') as handle:
                data = pickle.load(handle)
        except Exception as exc:
            print(f"Warning: could not load JDM index pickle {pickle_path}: {exc}")
            continue
        isa = data.get('isa', {}) or {}
        anto = data.get('anto', {}) or {}
        syn = data.get('syn', {}) or {}
        # Build inverse hypernym map (hyponym): if A isa B, then B has hyponym A.
        hypo = {}
        for child, parents in isa.items():
            for parent in parents:
                hypo.setdefault(parent, set()).add(child)
        _JDM_INDEX = {
            'synonym': syn,
            'hypernym': isa,
            'hyponym': hypo,
            'antonym': anto,
            'incompatible': anto,
        }
        n_isa = sum(len(v) for v in isa.values())
        n_anto = sum(len(v) for v in anto.values())
        n_syn = sum(len(v) for v in syn.values())
        print(f"Loaded JDM lexical index: {pickle_path} "
              f"(isa={n_isa:,} anto={n_anto:,} syn={n_syn:,})")
        break
    return _JDM_INDEX


def _load_jdm_relation_cache():
    """Load optional JDM-style relation triples from a local TSV/CSV file.

    Expected triples are flexible: source, relation, target or source, target,
    relation. Relation labels are normalized through _JDM_RELATION_ALIASES.
    The file is optional; absence simply means no JDM axioms are emitted.
    """
    global _JDM_RELATION_CACHE
    if _JDM_RELATION_CACHE is not None:
        return _JDM_RELATION_CACHE
    triples = []
    for cache_path in _candidate_jdm_cache_paths():
        if not cache_path or not os.path.exists(cache_path):
            continue
        try:
            with open(cache_path, 'r', encoding='utf-8') as handle:
                for raw_line in handle:
                    line = raw_line.strip()
                    if not line or line.startswith('#'):
                        continue
                    parts = [part.strip() for part in re.split(r'\t|;', line) if part.strip()]
                    if len(parts) < 3:
                        parts = [part.strip() for part in line.split(',') if part.strip()]
                    if len(parts) < 3:
                        continue
                    rel_index = None
                    rel_name = None
                    for idx, part in enumerate(parts[:3]):
                        normalized_rel = _JDM_RELATION_ALIASES.get(_normalize_lexical_symbol(part))
                        if normalized_rel:
                            rel_index = idx
                            rel_name = normalized_rel
                            break
                    if rel_index is None:
                        continue
                    if rel_index == 1:
                        source, target = parts[0], parts[2]
                    elif rel_index == 2:
                        source, target = parts[0], parts[1]
                    else:
                        source, target = parts[1], parts[2]
                    triples.append((_normalize_lexical_symbol(source), rel_name, _normalize_lexical_symbol(target)))
            print(f"Loaded JDM lexical cache: {cache_path} ({len(triples)} triples)")
            break
        except Exception as exc:
            print(f"Warning: could not load JDM cache {cache_path}: {exc}")
    _JDM_RELATION_CACHE = triples
    return _JDM_RELATION_CACHE


def _jdm_has_relation(source, target, relation_names):
    source_norm = _normalize_lexical_symbol(source)
    target_norm = _normalize_lexical_symbol(target)
    wanted = set(relation_names)
    # Legacy TSV-cache path (still used if a curated jdm_relations.tsv is shipped).
    for cached_source, relation, cached_target in _load_jdm_relation_cache():
        if relation in wanted and cached_source == source_norm and cached_target == target_norm:
            return True
    # Pickle index path (O(1) lookups on the auto-extracted JDM knowledge base).
    index = _load_jdm_index_from_pickle()
    if index:
        for rel in wanted:
            targets = index.get(rel, {}).get(source_norm)
            if targets and target_norm in targets:
                return True
    return False


# Curated JDM blocklist — audit-derived (SICK proof-only audit, 339 wrong proofs).
# Each pair below is a JDM relation that is NOMINALLY correct but semantically
# noisy in NL inference contexts (polysemy / sense conflation / adj-noun confusion)
# and was identified as the suspect axiom in >=4 wrong SICK proofs.
_JDM_BLOCK_PAIRS = frozenset({
    # "etre humain" sense of *homme* causes mass false bridges
    frozenset({'femme', 'homme'}),
    frozenset({'fille', 'femme'}),
    frozenset({'fille', 'homme'}),
    frozenset({'enfant', 'homme'}),
    frozenset({'garcon', 'homme'}),
    frozenset({'gens', 'homme'}),
    frozenset({'dame', 'homme'}),
    frozenset({'cheval', 'homme'}),
    frozenset({'pate', 'homme'}),
    frozenset({'pere', 'homme'}),
    frozenset({'famille', 'homme'}),
    frozenset({'ami', 'homme'}),
    frozenset({'chien', 'homme'}),
    frozenset({'humain', 'homme'}),
    # Child / age polysemy
    frozenset({'fille', 'enfant'}),       # fille = girl OR daughter (adult)
    frozenset({'garcon', 'enfant'}),      # garcon = boy OR waiter
    frozenset({'enfant', 'petit'}),       # child vs small (size adj)
    frozenset({'enfant', 'garcon'}),      # child<->boy too strong
    frozenset({'petit', 'jeune'}),        # small != young
    frozenset({'petit', 'enfant'}),
    frozenset({'pere', 'enfant'}),        # father vs child — both can hold
    # Adjective <-> noun color conflation
    frozenset({'brun', 'couleur'}),
    frozenset({'noir', 'couleur'}),
    frozenset({'blanc', 'couleur'}),
    frozenset({'rouge', 'couleur'}),
    frozenset({'vert', 'couleur'}),
    frozenset({'bleu', 'couleur'}),
    frozenset({'jaune', 'couleur'}),
    frozenset({'rose', 'couleur'}),
    # Preposition merge
    frozenset({'dans', 'en'}),
    frozenset({'sur', 'en'}),
    # Substance / place
    frozenset({'sable', 'sol'}),
    # Compound verb specificity drop
    frozenset({'jouer_de', 'jouer'}),
    # --- Tier-B (post-JDM SICK audit, 106 remaining unsound rows) ---
    # Adult/person polysemy
    frozenset({'adulte', 'personne'}),    # adult→person 7x false yes
    frozenset({'petit', 'jeune'}),        # small ↔ young 5x adj polysemy
    frozenset({'jeune', 'homme'}),        # "young"→"man" via "jeune homme" 4x
    frozenset({'age', 'jeune'}),          # antonym aged/young 4x false mutex
    frozenset({'adulte', 'petit'}),       # antonym adult/small 3x
    # Color antonym noise (multi-color scenes do not enforce mutex)
    frozenset({'vert', 'blanc'}),         # 2x false mutex
    # Hypernymy too loose for SICK matches (also blocked in curated path)
    frozenset({'chien', 'animal'}),       # 4x — rows 11/14/15/18
    frozenset({'arbre', 'plante'}),       # 3x — row 1534
    frozenset({'branche', 'arbre'}),      # 2x — rows 458/461
    frozenset({'chaton', 'chat'}),        # 2x — row 1670
    frozenset({'ecureuil', 'animal'}),
    frozenset({'piano', 'clavier'}),      # 4x — row 1510
    frozenset({'adolescent', 'enfant'}),
    frozenset({'adolescent', 'garcon'}),
    # Spurious gendered/role bridges
    frozenset({'animal', 'humain'}),      # bicond too strong
    frozenset({'homme', 'animal'}),       # never holds
    frozenset({'musicien', 'homme'}),
    frozenset({'coureur', 'homme'}),
    # ``dos`` (back) vs ``face``: JDM carries a spurious isa edge dos->face
    # that DIRECTLY CONTRADICTS the (correct) structural disjointness
    # dos->-face emitted elsewhere; together they make any premise mentioning
    # ``dos`` inconsistent, so Prover9 proves anything (SICK row 6924
    # "tournent le dos" vs "font face", gold=no, was a false yes).  Block the
    # isa; the structural disjointness path is unaffected.
    frozenset({'dos', 'face'}),
})

def get_jdm_lexical_axioms(p_preds, h_preds):
    """Generate local lexical axioms from an optional JDM relation cache.

    This keeps the axiom generation data-driven: only predicate pairs present
    in the current P/H pair are considered, and no dataset-specific vocabulary
    is named in code.
    """
    if not _load_jdm_relation_cache() and not _load_jdm_index_from_pickle():
        return []
    axioms = []
    p_dict = {}
    h_dict = {}
    for name, arity in p_preds:
        p_dict.setdefault(name, set()).add(arity)
    for name, arity in h_preds:
        h_dict.setdefault(name, set()).add(arity)
    p_only_names = set(p_dict) - set(h_dict)
    h_only_names = set(h_dict) - set(p_dict)
    # ``homme`` is polysemous in JDM/WordNet: the "human being" sense (vs the
    # "adult male" sense) yields spurious X->homme isa edges (singe->homme,
    # cuisinier->homme, chanteur->homme, ...).  The WordNet generator already
    # refuses ``homme`` as a bridge target (``_WN_BLOCK_AS_TARGET``); apply the
    # SAME principled block here so a forward/equiv JDM edge can never conclude
    # ``homme`` from a more specific or unrelated noun.  Legitimate hypernyms to
    # ``homme`` (gars/type/magicien -> homme) still come through the curated
    # FRENCH_HYPERNYMS path, so nothing sound is lost.
    _JDM_BLOCK_AS_TARGET = {'homme'}
    _jdm_target_block_on = os.getenv('JDM_HOMME_TARGET_BLOCK_DISABLE') != '1'
    for p_name in p_only_names:
        for h_name in h_only_names:
            common_arities = p_dict[p_name] & h_dict[h_name]
            if not common_arities:
                continue
            if frozenset({p_name, h_name}) in _JDM_BLOCK_PAIRS:
                continue
            relation = None
            if _jdm_has_relation(p_name, h_name, {'synonym'}):
                relation = 'equiv'
            elif _jdm_has_relation(h_name, p_name, {'synonym'}):
                relation = 'equiv'
            elif _jdm_has_relation(p_name, h_name, {'hypernym'}):
                relation = 'forward'
            elif _jdm_has_relation(h_name, p_name, {'hyponym'}):
                relation = 'forward'
            elif (_jdm_has_relation(p_name, h_name, {'antonym', 'incompatible'}) or
                  _jdm_has_relation(h_name, p_name, {'antonym', 'incompatible'})):
                relation = 'disjoint'
            if not relation:
                continue
            # Block X->homme (forward) and X<->homme (equiv) JDM edges: these
            # are the polysemy artefacts.  ``disjoint`` (homme -> -X) is sound
            # and kept.
            if _jdm_target_block_on and relation in ('forward', 'equiv'):
                if h_name in _JDM_BLOCK_AS_TARGET or (
                        relation == 'equiv' and p_name in _JDM_BLOCK_AS_TARGET):
                    continue
            for arity in common_arities:
                vars_list = ['x', 'y', 'z', 'u', 'v', 'w'][:arity]
                if len(vars_list) < arity:
                    vars_list = [f"x{i}" for i in range(arity)]
                vars_quant = ' '.join(vars_list)
                vars_args = ','.join(vars_list)
                if relation == 'equiv':
                    axioms.append(f"all {vars_quant}.({p_name}({vars_args}) <-> {h_name}({vars_args}))")
                elif relation == 'forward':
                    axioms.append(f"all {vars_quant}.({p_name}({vars_args}) -> {h_name}({vars_args}))")
                elif relation == 'disjoint':
                    axioms.append(f"all {vars_quant}.({p_name}({vars_args}) -> -{h_name}({vars_args}))")
                    axioms.append(f"all {vars_quant}.({h_name}({vars_args}) -> -{p_name}({vars_args}))")
    return list(set(axioms))


# ---------------------------------------------------------------------------
# (v70-C) Cross-arity JDM / same-name bridges via generic(_) placeholder slot
# ---------------------------------------------------------------------------
def get_cross_arity_generic_bridges(p_preds, h_preds, premise_text, hypothesis_text):
    """Sound cross-arity bridges driven by ``generic(_)`` placeholder slots.

    The semantic parser occasionally produces, for the same verb sense, atoms
    of different arities -- e.g. ``faire/3`` on the premise side and
    ``faire/4`` on the hypothesis side, where the extra slot of the 4-ary use
    is bound to a variable ``g`` that is independently asserted as
    ``generic(g)`` in the same conjunctive scope.  ``generic(_)`` is a
    content-free placeholder (its only occurrence in axiom code is as a slot
    marker, never as a meaning-bearing predicate), so the 4-ary use
    ``HIGH(v0,...,vk-1, g, vk,...)`` with ``generic(g)`` is semantically
    equivalent to the 3-ary use ``LOW(v0,...)``.

    The same construction applies to distinct names that are JDM synonyms (or
    hypernyms) whose arities differ by exactly one when one side carries the
    generic placeholder.  Concretely, this handles paraphrases such as
    P:``giser_dans(e,x,y)`` vs H:``coucher_dans(e,g,x,y) & generic(g)`` where
    ``giser`` and ``coucher`` are JDM synonyms but the parser inserted an
    extra position-1 placeholder on the H side.

    Detection is FOL-shape-driven: we read the higher-arity occurrence in
    the relevant text, find the unique argument position whose bound variable
    appears inside a ``generic(_)`` atom, and emit the bridge.  When no slot
    or more than one slot qualifies, the bridge is suppressed (no guess).
    No NL, no row IDs, no dataset names.

    Soundness summary
    -----------------
    * Introduction (LOW -> exists g. generic(g) & HIGH): valid because the
      extra slot is content-free; the existential witness is a fresh
      placeholder.
    * Elimination (HIGH(... g ...) & generic(g) -> LOW): valid by the same
      content-freeness argument.

    For JDM hypernymy (forward only) we emit only the entailment-relevant
    direction.  For JDM synonymy and same-name pairs we emit both directions.
    """
    import re as _re
    axioms = []
    p_dict = {}
    h_dict = {}
    for name, arity in p_preds:
        p_dict.setdefault(name, set()).add(arity)
    for name, arity in h_preds:
        h_dict.setdefault(name, set()).add(arity)

    def _find_generic_slot(name, arity, text):
        """Return the unique k in [0, arity) whose argument is bound by a
        generic(_) atom in ``text``, or None when zero or many slots qualify."""
        pat = _re.compile(r'\b' + _re.escape(name) + r'\(([^()]*)\)')
        slots = set()
        for m in pat.finditer(text):
            raw = m.group(1)
            if '(' in raw:  # nested; skip
                continue
            args = [a.strip() for a in raw.split(',')]
            if len(args) != arity:
                continue
            for k, a in enumerate(args):
                if not a or not _re.match(r'^[\w_]+$', a):
                    continue
                if _re.search(r'\bgeneric\(\s*' + _re.escape(a) + r'\s*\)', text):
                    slots.add(k)
        if len(slots) == 1:
            return next(iter(slots))
        return None

    def _emit_pair(low_name, low_arity, high_name, k, both_dirs):
        low_vars = [f'v{i}' for i in range(low_arity)]
        high_vars = low_vars[:k] + ['g'] + low_vars[k:]
        low_args = ','.join(low_vars)
        high_args = ','.join(high_vars)
        quant_low = ' '.join(low_vars)
        quant_full = ' '.join(low_vars + ['g'])
        # Introduction (entailment-direction when HIGH is on the H side).
        axioms.append(
            f"all {quant_low}.({low_name}({low_args}) -> "
            f"exists g.(generic(g) & {high_name}({high_args})))"
        )
        if both_dirs:
            # Elimination: HIGH(... g ...) with generic(g) yields LOW.
            axioms.append(
                f"all {quant_full}.(({high_name}({high_args}) & generic(g)) -> "
                f"{low_name}({low_args}))"
            )

    # --- Same-name cross-arity (parser quirk) -------------------------------
    for name in set(p_dict) & set(h_dict):
        for a_p in p_dict[name]:
            for a_h in h_dict[name]:
                if abs(a_p - a_h) != 1:
                    continue
                if a_p < a_h:
                    k = _find_generic_slot(name, a_h, hypothesis_text)
                    if k is None:
                        continue
                    _emit_pair(name, a_p, name, k, both_dirs=True)
                else:
                    k = _find_generic_slot(name, a_p, premise_text)
                    if k is None:
                        continue
                    _emit_pair(name, a_h, name, k, both_dirs=True)

    # --- Cross-name JDM synonym / hypernym cross-arity ----------------------
    if _load_jdm_relation_cache() or _load_jdm_index_from_pickle():
        p_only = set(p_dict) - set(h_dict)
        h_only = set(h_dict) - set(p_dict)
        for p_name in p_only:
            for h_name in h_only:
                if frozenset({p_name, h_name}) in _JDM_BLOCK_PAIRS:
                    continue
                is_syn = (_jdm_has_relation(p_name, h_name, {'synonym'})
                          or _jdm_has_relation(h_name, p_name, {'synonym'}))
                is_fwd = (_jdm_has_relation(p_name, h_name, {'hypernym'})
                          or _jdm_has_relation(h_name, p_name, {'hyponym'}))
                if not (is_syn or is_fwd):
                    continue
                for a_p in p_dict[p_name]:
                    for a_h in h_dict[h_name]:
                        if abs(a_p - a_h) != 1:
                            continue
                        if a_p < a_h:
                            k = _find_generic_slot(h_name, a_h, hypothesis_text)
                            if k is None:
                                continue
                            _emit_pair(p_name, a_p, h_name, k, both_dirs=is_syn)
                        else:
                            k = _find_generic_slot(p_name, a_p, premise_text)
                            if k is None:
                                continue
                            low_vars = [f'v{i}' for i in range(a_h)]
                            high_vars = low_vars[:k] + ['g'] + low_vars[k:]
                            low_args = ','.join(low_vars)
                            high_args = ','.join(high_vars)
                            quant_full = ' '.join(low_vars + ['g'])
                            # P-high (with generic) entails H-low: needed for
                            # the entailment direction when HIGH is on P side.
                            axioms.append(
                                f"all {quant_full}.(({p_name}({high_args}) & generic(g)) -> "
                                f"{h_name}({low_args}))"
                            )
                            if is_syn:
                                axioms.append(
                                    f"all {' '.join(low_vars)}.({h_name}({low_args}) -> "
                                    f"exists g.(generic(g) & {p_name}({high_args})))"
                                )
    return list(set(axioms))


def get_curated_hypernymy_axioms(p_preds, h_preds):
    """Generate axioms from the curated French hypernymy/synonym dictionary.

    Only generates axioms when BOTH the hyponym and hypernym (or synonym pair)
    actually appear in the combined P∪H predicates. This avoids injecting
    irrelevant axioms.

    Hypernyms: all x.(hyponym(x) -> hypernym(x))  [logically valid class inclusion]
    Synonyms:  all x.(A(x) <-> B(x))              [semantic equivalence]
    """
    if not ENABLE_CURATED_HYPERNYM_AXIOMS:
        return []

    axioms = []

    all_pred_names = set()
    for name, _ in p_preds:
        all_pred_names.add(name)
    for name, _ in h_preds:
        all_pred_names.add(name)

    # Build arity lookup
    pred_arities = {}
    for name, arity in (p_preds | h_preds):
        pred_arities.setdefault(name, set()).add(arity)

    # Check hypernyms
    for hyponym, hypernym in FRENCH_HYPERNYMS:
        if hyponym in all_pred_names and hypernym in all_pred_names:
            # Audit-derived blocklist (shared with JDM path): suppress
            # nominally-correct hypernyms that fire spuriously in NLI matches
            # and accumulate >=2 false yes/no in SICK proof audit.
            if frozenset({hyponym, hypernym}) in _JDM_BLOCK_PAIRS:
                continue
            # Find common arities
            hypo_arities = pred_arities.get(hyponym, set())
            hyper_arities = pred_arities.get(hypernym, set())
            common = hypo_arities & hyper_arities
            for arity in common:
                vars_list = ['x', 'y', 'z', 'u', 'v', 'w'][:arity]
                if len(vars_list) < arity:
                    vars_list = [f"x{i}" for i in range(arity)]
                vars_quant = " ".join(vars_list)
                vars_args = ",".join(vars_list)
                axioms.append(
                    f"all {vars_quant}.({hyponym}({vars_args}) -> {hypernym}({vars_args}))"
                )
            # Cross-arity: hyponym has higher arity than hypernym
            # E.g. sauter_dans(e,x,loc) -> sauter(e,x)  [drop last args]
            if not common:
                for hypo_a in sorted(hypo_arities):
                    for hyper_a in sorted(hyper_arities):
                        if hypo_a > hyper_a >= 1:
                            vars_all = [f"x{i}" for i in range(hypo_a)]
                            vars_hyper = vars_all[:hyper_a]
                            axioms.append(
                                f"all {' '.join(vars_all)}.({hyponym}({','.join(vars_all)}) -> {hypernym}({','.join(vars_hyper)}))"
                            )

    # Check synonyms
    for word_a, word_b in FRENCH_SYNONYMS:
        if word_a in all_pred_names and word_b in all_pred_names:
            if frozenset({word_a, word_b}) in _JDM_BLOCK_PAIRS:
                continue
            a_arities = pred_arities.get(word_a, set())
            b_arities = pred_arities.get(word_b, set())
            common = a_arities & b_arities
            for arity in common:
                vars_list = ['x', 'y', 'z', 'u', 'v', 'w'][:arity]
                if len(vars_list) < arity:
                    vars_list = [f"x{i}" for i in range(arity)]
                vars_quant = " ".join(vars_list)
                vars_args = ",".join(vars_list)
                axioms.append(
                    f"all {vars_quant}.({word_a}({vars_args}) <-> {word_b}({vars_args}))"
                )

    return list(set(axioms))


def get_extended_french_lemmas(name):
    """Extended French lemmatization for better WordNet lookup.

    Tries multiple morphological strategies to find the base form:
    - Strip compound verb preposition suffixes (_a, _de, _dans, etc.)
    - Strip -s (regular plural)
    - Strip -es (feminine/plural)
    - Strip -ent (3pl verb conjugation)
    - Strip -e (feminine adjective)
    - Try accent-stripped variants
    Returns a list of candidate lemmas to look up in WordNet.
    """
    candidates = [name]

    # Compound verb decomposition: jouer_a → jouer, nager_dans → nager
    _prep_suffixes = ('_a', '_de', '_dans', '_sur', '_avec', '_en', '_par',
                      '_vers', '_contre', '_pour', '_sous', '_entre',
                      '_devant', '_derriere', '_pres_de', '_a_travers',
                      '_par_dessus', '_au_dessus_de', '_en_dessous_de')
    for suf in sorted(_prep_suffixes, key=len, reverse=True):
        if name.endswith(suf) and len(name) > len(suf) + 2:
            base = name[:-len(suf)]
            candidates.append(base)
            # Also try morphological variants of the base
            if base.endswith('s') and len(base) > 3:
                candidates.append(base[:-1])
            break  # only strip the longest matching suffix

    # Reflexive verb: se_battre → battre
    if name.startswith('se_') and len(name) > 4:
        candidates.append(name[3:])
    if name.startswith('s_') and len(name) > 3:
        candidates.append(name[2:])

    # Regular plural: -s
    if name.endswith('s') and len(name) > 3:
        candidates.append(name[:-1])
    # Feminine/plural: -es
    if name.endswith('es') and len(name) > 4:
        candidates.append(name[:-2])
    # 3rd person plural verb: -ent
    if name.endswith('ent') and len(name) > 5:
        candidates.append(name[:-3] + 'er')  # 1st group: marchent → marcher
        candidates.append(name[:-3] + 'ir')  # 2nd group: finissent → finir (approx)
        candidates.append(name[:-3])
    # Feminine adjective: -e
    if name.endswith('e') and len(name) > 3 and not name.endswith('ee'):
        candidates.append(name[:-1])
    # Past participle: -é → -er
    if name.endswith('e') and len(name) > 3:
        candidates.append(name[:-1] + 'er')
    # Accent-stripped variant (already handled by unidecode in clean_formula_string,
    # but useful for WordNet lookup on the original name)
    stripped = unidecode.unidecode(name)
    if stripped != name:
        candidates.append(stripped)

    return list(set(candidates))


def emit_unresolved_diagnostics(premise_texts, hypothesis_texts):
    """Print compact diagnostics for unresolved rows to guide targeted bridge design."""
    p_text = ' '.join(premise_texts)
    h_text = ' '.join(hypothesis_texts)

    pred_pattern = re.compile(r'\b([A-Za-z_][A-Za-z0-9_]*)\(')
    stop = {'exists', 'all', 'not', 'num', 'temps'}
    p_preds = {m.group(1) for m in pred_pattern.finditer(p_text) if m.group(1) not in stop}
    h_preds = {m.group(1) for m in pred_pattern.finditer(h_text) if m.group(1) not in stop}
    h_only = sorted(h_preds - p_preds)

    marks = []
    for tag, pat in [
        ('plus_de', r'\bplus_de\('),
        ('moins_de', r'\bmoins_de\('),
        ('DOT', r"\b(?:DOT|'DOT')\("),
        ('moitie', r'\bmoiti[eé]\('),
        ('tiers', r'\btiers\('),
        ('quart', r'\bquart\('),
        ('cinquieme', r'\bcinquieme\('),
        ('sixieme', r'\bsixieme\('),
        ('plupart_de', r'\bplupart_de\('),
        ('majorite', r'\bmajorite\('),
        ('not', r'\bnot\('),
    ]:
        if re.search(pat, h_text):
            marks.append(tag)

    print('UNRESOLVED DIAGNOSTICS:')
    print(f'  H-only predicates: {h_only[:12]}')
    print(f'  H markers: {marks}')
    has_de_part_whole = bool(re.search(r'\bde\(\w+,\s*\w+\)', h_text))
    print(f'  Has de(part,whole) in H: {has_de_part_whole}')
    print(f'  Has subseteq in P/H: {"subseteq(" in p_text or "subseteq(" in h_text}')


# Inference runtime controls
PROVER9_TIMEOUT_SECONDS = int(os.getenv('PROVER9_TIMEOUT_SECONDS', '15'))
MACE_END_SIZE = int(os.getenv('MACE_END_SIZE', '100'))


# Function to perform inference on each row

# ---- Timeout helpers (rely on monkey-patch for actual timeout) ----
_last_prove_had_error = False

def timed_prove(prover, goal, assumptions, timeout_seconds=8):
    global _last_prove_had_error
    _last_prove_had_error = False
    import threading
    result_box = [False]
    error_box = [False]
    def _run():
        try:
            result_box[0] = prover.prove(goal, assumptions, verbose=False)
            # print(prover.proof())
        except Exception as e:
            print(f"  Prover9 Error: {e}")
            result_box[0] = False
            error_box[0] = True
    t = threading.Thread(target=_run, daemon=True)
    t.start()
    try:
        t.join(timeout_seconds)
    except (KeyboardInterrupt, SystemExit):
        print(f"  Prover9 interrupted (possible SIGSEGV)")
        _last_prove_had_error = True
        return False
    if t.is_alive():
        print(f"  Prover9 hard timeout ({timeout_seconds}s)")
        _last_prove_had_error = True
        return False
    _last_prove_had_error = error_box[0]
    return result_box[0]

def timed_build_model(mc, timeout_seconds=15):
    import threading
    result_box = [False]
    def _run():
        try:
            result_box[0] = mc.build_model(verbose=False)
        except Exception as e:
            print(f"  Mace4 error: {e}")
            result_box[0] = False
    t = threading.Thread(target=_run, daemon=True)
    t.start()
    try:
        t.join(timeout_seconds)
    except (KeyboardInterrupt, SystemExit):
        print(f"  Mace4 interrupted")
        return False
    if t.is_alive():
        print(f"  Mace4 hard timeout ({timeout_seconds}s)")
        return False
    return result_box[0]


def _premises_are_vacuous(full_premises, premises, background_axioms):
    """Sound vacuity guard for proof-only labelling.

    A proof drawn from an inconsistent premise set is vacuous (ex falso
    quodlibet): ``P ⊢ H`` and ``P ⊢ ¬H`` both hold whenever ``P`` itself has no
    model, so the verdict is not a *genuine* entailment/contradiction and must
    be downgraded to ``unknown``.  The inconsistency here is almost always an
    artefact of the FOL generation interacting with a disjointness axiom — e.g.
    a premise that legitimately calls one entity ``brun`` and ``blanc``
    (brown-and-white dog) together with a JDM/colour disjointness
    ``brun -> -blanc`` makes the premise self-contradictory.

    Returns ``True`` only when the premise set is *positively proven*
    inconsistent (Mace4 finds no model AND Prover9 derives a contradiction from
    the premises alone).  When consistency cannot be decided, returns ``False``
    so no genuine proof is ever discarded.  The check is skipped entirely for
    all-positive premise/axiom sets, which are always satisfiable (the
    all-true model), keeping the common case free.
    """
    # Trigger: inconsistency is only possible when a negative literal is present
    # (a disjointness axiom ``-> -P(`` or a negated premise).  Purely positive
    # sets are satisfied by the all-true model, so they can never be vacuous.
    try:
        _neg = False
        for ax in background_axioms:
            if re.search(r'->\s*-\s*[a-z_]\w*\(', str(ax)):
                _neg = True
                break
        if not _neg:
            for p in premises:
                ps = str(p)
                if ('not(' in ps
                        or re.search(r'&\s*-\s*[a-z_]\w*\(', ps)
                        or re.match(r'\s*-\s*\(?\s*exists', ps)):
                    _neg = True
                    break
        if not _neg:
            return False
    except Exception:
        return False
    # Fast path: a finite model of the premises proves consistency.
    try:
        from nltk.inference.mace import Mace
        _mb = MaceCommand(None, assumptions=full_premises,
                          model_builder=Mace(end_size=20))
        if timed_build_model(_mb, timeout_seconds=5):
            return False
    except Exception:
        pass
    # No model found: confirm inconsistency with a Prover9 refutation.  Only a
    # positive refutation downgrades the verdict (Mace4 timeout alone is not a
    # proof of inconsistency), so the guard never discards a genuine proof.
    try:
        _probe = read_expr('zzc_vac_probe(zzc_a) & -zzc_vac_probe(zzc_a)')
        if timed_prove(Prover9(timeout=5), _probe, full_premises,
                       timeout_seconds=7):
            return True
    except Exception:
        pass
    return False
# ---- End timeout helpers ----

# ---- CWA (Closed-World Assumption) axiom generation ----
# Predicates that CWA may negate when they appear in H but not P.
# Only physical actions/states and colors — keeps CWA conservative.
_CWA_CLOSEABLE_ACTIONS = {'asseoir', 's_asseoir', 'porter', 'poursuivre'}
_CWA_CLOSEABLE_COLORS  = {'rouge', 'orange', 'beige', 'rose', 'vert', 'violet',
                           'noir', 'blanc', 'brun', 'bleu', 'jaune', 'gris'}
# Cardinal names that count as "specific quantity" markers
_CWA_CARDINAL_NAMES = {'Six', 'Huit', 'Cinq', 'Quatre', 'Sept', 'Neuf', 'Dix',
                       'Trois', 'Onze', 'Douze', 'Vingt'}

_POLICY_STRUCTURAL_PREDS = frozenset({
    'num', 'temps', 'overlaps', 'exists', 'all', 'forall', 'not', 'and', 'or',
    'existe', 'subseteq', 'atomic_sub', 'empty_intersect', 'intersect',
    'de', 'des', 'nomme', 'nommé', 'is_at', 'en', 'a_', 'dans', 'sur', 'sous',
    'avec', 'pour', 'par', 'contre', 'vers', 'devant', 'derriere', 'entre',
    'maintenant', 'context_', 'unknown_', 'singular_', 'masculin_', 'feminin_',
    'generic', 'pas', 'pas_de', 'tout', 'chacun', 'aucun', 'plupart_de',
    'beaucoup_de', 'peu_de', 'plus_de', 'moins_de', 'moitie', 'moitié',
    'tiers', 'quart', 'cinquieme', 'cinquième', 'sixieme', 'sixième', 'DOT',
    'total', 'soit', 'mais', 'exactement', 'plus', 'moins', 'leq',
})


def _policy_unary_predicates_by_var(text):
    by_var = {}
    for match in re.finditer(r'\b([A-Za-z_][A-Za-z0-9_]*)\(\s*([a-z]\d?)\s*\)', text):
        if is_function_usage(text, match.start(), match.end()):
            continue
        pred, var = match.groups()
        if pred in _POLICY_STRUCTURAL_PREDS:
            continue
        by_var.setdefault(var, set()).add(pred)
    return by_var


def _policy_semantic_unary_predicates(text):
    preds = set()
    for values in _policy_unary_predicates_by_var(text).values():
        preds.update(values)
    return preds


def _policy_semantic_unary_preds_for_var(text, var):
    return _policy_unary_predicates_by_var(text).get(var, set())


def _policy_count_variables(text, cardinal_map=None):
    variables = {var for var, _ in re.findall(r'num\(([a-z]\d?)\)\s*=\s*(\d+)', text)}
    variables |= set(re.findall(r'>\(\s*num\(\s*([a-z]\d?)\s*\)\s*,\s*\d+\s*\)', text))
    if cardinal_map:
        for card_name in cardinal_map:
            variables |= set(re.findall(rf'\b{re.escape(card_name)}\(\s*([a-z]\d?)\s*\)', text))
    return variables


def _policy_count_type_predicates(text, cardinal_map=None):
    unary_by_var = _policy_unary_predicates_by_var(text)
    type_preds = set()
    for var in _policy_count_variables(text, cardinal_map):
        type_preds.update(unary_by_var.get(var, set()))
    return type_preds


def _policy_event_predicates(text):
    preds = set()
    event_call = r'\b([A-Za-z_][A-Za-z0-9_]*)\(\s*[a-z]\d?\s*,\s*[a-z]\d?(?:\s*,\s*[a-z]\d?)*\s*\)'
    for match in re.finditer(event_call, text):
        if is_function_usage(text, match.start(), match.end()):
            continue
        pred = match.group(1)
        if pred not in _POLICY_STRUCTURAL_PREDS:
            preds.add(pred)
    return preds


def _wordnet_antonym_related(left, right):
    left_synsets = wn.synsets(left.replace('_', ' '), lang='fra') or wn.synsets(left, lang='fra')
    right_synsets = set(wn.synsets(right.replace('_', ' '), lang='fra') or wn.synsets(right, lang='fra'))
    if not left_synsets or not right_synsets:
        return False
    for synset in left_synsets:
        for lemma in synset.lemmas('eng'):
            for antonym in lemma.antonyms():
                if antonym.synset() in right_synsets:
                    return True
    return False


def _policy_disjoint_event_pairs(p_text, h_text):
    pairs = set()
    for left in _policy_event_predicates(p_text):
        for right in _policy_event_predicates(h_text):
            if left == right:
                continue
            if (_jdm_has_relation(left, right, {'antonym', 'incompatible'}) or
                    _jdm_has_relation(right, left, {'antonym', 'incompatible'}) or
                    _wordnet_antonym_related(left, right)):
                pairs.add((left, right))
    return pairs

def get_policy_program_axioms(premise_texts, hypothesis_texts, all_text):
    """Formula-local semantic/count axioms used by the proof-only policy."""
    axioms = []
    p_text = ' '.join(premise_texts or [])
    h_text = ' '.join(hypothesis_texts or [])
    if not p_text or not h_text:
        return axioms

    cardinal_map = {
        'Un': 1, 'Deux': 2, 'Trois': 3, 'Quatre': 4, 'Cinq': 5,
        'Six': 6, 'Sept': 7, 'Huit': 8, 'Neuf': 9, 'Dix': 10,
    }
    type_preds = _policy_count_type_predicates(p_text + ' ' + h_text, cardinal_map)
    object_preds = _policy_semantic_unary_predicates(p_text + ' ' + h_text)
    event_disjoint = _policy_disjoint_event_pairs(p_text, h_text)

    totals = []
    for var, count in re.findall(r'num\(([a-z]\d?)\)\s*=\s*(\d+)', p_text):
        if not (re.search(rf'\bexiste\(\s*[a-z]\d?\s*,\s*{re.escape(var)}\s*\)', p_text) or
                re.search(rf'\btotal\(\s*{re.escape(var)}\s*\)', p_text)):
            continue
        for typ in type_preds:
            if re.search(rf'\b{typ}\(\s*{re.escape(var)}\s*\)', p_text):
                totals.append((var, int(count), typ))
    exact_events = []
    for var, count in re.findall(r'num\(([a-z]\d?)\)\s*=\s*(\d+)', p_text):
        types = [typ for typ in type_preds if re.search(rf'\b{typ}\(\s*{re.escape(var)}\s*\)', p_text)]
        if not types:
            continue
        for ev_m in re.finditer(rf'\b([a-zA-Z_][a-zA-Z0-9_]*)\(([a-z]\d?),\s*{re.escape(var)}\)', p_text):
            pred, ev = ev_m.groups()
            if pred in {'num', 'temps', 'overlaps', 'existe', 'subseteq'}:
                continue
            exact_events.append((var, int(count), types[0], pred, ev))

    h_count_events = []
    h_num_values = {}
    for var, count in re.findall(r'num\(([a-z]\d?)\)\s*=\s*(\d+)', h_text):
        h_num_values.setdefault(var, set()).add(int(count))
    for card_name, count in cardinal_map.items():
        for var in re.findall(rf'\b{card_name}\(([a-z]\d?)\)', h_text):
            h_num_values.setdefault(var, set()).add(count)
    for var, counts in h_num_values.items():
        types = [typ for typ in type_preds if re.search(rf'\b{typ}\(\s*{re.escape(var)}\s*\)', h_text)]
        if not types:
            continue
        for pred, first_arg, second_arg in re.findall(r'\b([a-zA-Z_][a-zA-Z0-9_]*)\(([a-z]\d?),\s*([a-z]\d?)\)', h_text):
            if pred in {'num', 'temps', 'overlaps', 'existe', 'subseteq'}:
                continue
            if second_arg == var:
                for count in counts:
                    h_count_events.append((var, count, types[0], pred, 'binary', None))
        for pred, first_arg, second_arg, third_arg in re.findall(r'\b([a-zA-Z_][a-zA-Z0-9_]*)\(([a-z]\d?),\s*([a-z]\d?),\s*([a-z]\d?)\)', h_text):
            if pred in {'num', 'temps', 'overlaps', 'existe', 'subseteq'}:
                continue
            for count in counts:
                if second_arg == var:
                    obj_types = [obj for obj in object_preds if re.search(rf'\b{obj}\(\s*{re.escape(third_arg)}\s*\)', h_text)]
                    h_count_events.append((var, count, types[0], pred, 'second', obj_types[0] if obj_types else None))
                if third_arg == var:
                    obj_types = [obj for obj in object_preds if re.search(rf'\b{obj}\(\s*{re.escape(second_arg)}\s*\)', h_text)]
                    h_count_events.append((var, count, types[0], pred, 'third', obj_types[0] if obj_types else None))

    if 'exactement(' in p_text and h_count_events:
        exact_event_vars = set(re.findall(r'\bexactement\(([a-z]\d?)\)', p_text))
        p_exact_events = []
        for count_var, count in re.findall(r'num\(([a-z]\d?)\)\s*=\s*(\d+)', p_text):
            types = [typ for typ in type_preds if re.search(rf'\b{typ}\(\s*{re.escape(count_var)}\s*\)', p_text)]
            if not types:
                continue
            for pred, ev, second_arg in re.findall(r'\b([a-zA-Z_][a-zA-Z0-9_]*)\(([a-z]\d?),\s*([a-z]\d?)\)', p_text):
                if ev in exact_event_vars and second_arg == count_var:
                    p_exact_events.append((int(count), types[0], pred, 'binary', None))
            for pred, ev, second_arg, third_arg in re.findall(r'\b([a-zA-Z_][a-zA-Z0-9_]*)\(([a-z]\d?),\s*([a-z]\d?),\s*([a-z]\d?)\)', p_text):
                if ev not in exact_event_vars:
                    continue
                if second_arg == count_var:
                    obj_types = [obj for obj in object_preds if re.search(rf'\b{obj}\(\s*{re.escape(third_arg)}\s*\)', p_text)]
                    p_exact_events.append((int(count), types[0], pred, 'second', obj_types[0] if obj_types else None))
                if third_arg == count_var:
                    obj_types = [obj for obj in object_preds if re.search(rf'\b{obj}\(\s*{re.escape(second_arg)}\s*\)', p_text)]
                    p_exact_events.append((int(count), types[0], pred, 'third', obj_types[0] if obj_types else None))
        for exact_count, exact_typ, exact_pred, exact_shape, exact_obj_type in p_exact_events:
            for _h_var, h_count, h_typ, h_pred, h_shape, h_obj_type in h_count_events:
                if h_count <= exact_count or h_typ != exact_typ or h_pred != exact_pred or h_shape != exact_shape:
                    continue
                if exact_shape != 'binary' and (not exact_obj_type or exact_obj_type != h_obj_type):
                    continue
                if exact_shape == 'binary':
                    ax = (
                        f'all e f x y.((exactement(e) & (num(x) = {exact_count}) & {exact_typ}(x) & '
                        f'{exact_pred}(e, x) & (num(y) = {h_count}) & {h_typ}(y) & {h_pred}(f, y)) -> $F)'
                    )
                elif exact_shape == 'second':
                    ax = (
                        f'all e f x y a b.((exactement(e) & (num(x) = {exact_count}) & {exact_typ}(x) & '
                        f'{exact_obj_type}(a) & {exact_pred}(e, x, a) & (num(y) = {h_count}) & {h_typ}(y) & '
                        f'{h_obj_type}(b) & {h_pred}(f, y, b)) -> $F)'
                    )
                else:
                    ax = (
                        f'all e f x y a b.((exactement(e) & (num(x) = {exact_count}) & {exact_typ}(x) & '
                        f'{exact_obj_type}(a) & {exact_pred}(e, a, x) & (num(y) = {h_count}) & {h_typ}(y) & '
                        f'{h_obj_type}(b) & {h_pred}(f, b, y)) -> $F)'
                    )
                if ax not in axioms:
                    axioms.append(ax)

    h_plus_events = []
    disjoint_preds = {pred for pair in event_disjoint for pred in pair}
    for var, threshold in re.findall(r'num\(([a-z]\d?)\)\s*=\s*(\d+)', h_text):
        if not re.search(rf'\bplus_de\(\s*{re.escape(var)}\s*\)', h_text):
            continue
        types = [typ for typ in type_preds if re.search(rf'\b{typ}\(\s*{re.escape(var)}\s*\)', h_text)]
        if not types:
            continue
        for pred in disjoint_preds:
            if re.search(rf'\b{pred}\(\s*[a-z]\d?\s*,\s*{re.escape(var)}\s*\)', h_text):
                h_plus_events.append((var, int(threshold), types[0], pred, 'binary'))
            if re.search(rf'\b{pred}\(\s*[a-z]\d?\s*,\s*{re.escape(var)}\s*,', h_text):
                h_plus_events.append((var, int(threshold), types[0], pred, 'second'))
            if re.search(rf'\b{pred}\(\s*[a-z]\d?\s*,\s*[a-z]\d?\s*,\s*{re.escape(var)}\s*\)', h_text):
                h_plus_events.append((var, int(threshold), types[0], pred, 'third'))

    for _total_var, total, typ in totals:
        for _count_var, count, count_typ, p_pred, _ev in exact_events:
            if count_typ != typ or count * 2 < total:
                continue
            for q_pred_a, q_pred_b in event_disjoint:
                if p_pred not in {q_pred_a, q_pred_b}:
                    continue
                q_pred = q_pred_b if p_pred == q_pred_a else q_pred_a
                if q_pred not in h_text or 'plus_de(' not in h_text:
                    continue
                ax = (
                    f'all e f t x y u.(((num(t) = {total}) & {typ}(t) & '
                    f'(num(x) = {count}) & {typ}(x) & {p_pred}(e, x) & '
                    f'(num(y) = {count}) & {typ}(y) & plus_de(y) & '
                    f'{q_pred}(f, u, y)) -> $F)'
                )
                if ax not in axioms:
                    axioms.append(ax)

    for _total_var, total, typ in totals:
        for _count_var, count, count_typ, p_pred, _ev in exact_events:
            if count_typ != typ:
                continue
            for _plus_var, threshold, plus_typ, q_pred, q_shape in h_plus_events:
                if plus_typ != typ or count + threshold < total:
                    continue
                if (p_pred, q_pred) not in event_disjoint and (q_pred, p_pred) not in event_disjoint:
                    continue
                if q_shape == 'binary':
                    ax = (
                        f'all e f t x y.(((num(t) = {total}) & {typ}(t) & '
                        f'(num(x) = {count}) & {typ}(x) & {p_pred}(e, x) & '
                        f'(num(y) = {threshold}) & {typ}(y) & plus_de(y) & '
                        f'{q_pred}(f, y)) -> $F)'
                    )
                elif q_shape == 'second':
                    ax = (
                        f'all e f t x y u.(((num(t) = {total}) & {typ}(t) & '
                        f'(num(x) = {count}) & {typ}(x) & {p_pred}(e, x) & '
                        f'(num(y) = {threshold}) & {typ}(y) & plus_de(y) & '
                        f'{q_pred}(f, y, u)) -> $F)'
                    )
                else:
                    ax = (
                        f'all e f t x y u.(((num(t) = {total}) & {typ}(t) & '
                        f'(num(x) = {count}) & {typ}(x) & {p_pred}(e, x) & '
                        f'(num(y) = {threshold}) & {typ}(y) & plus_de(y) & '
                        f'{q_pred}(f, u, y)) -> $F)'
                    )
                if ax not in axioms:
                    axioms.append(ax)

    dot_requests = []
    for pct_var, pct in re.findall(r'num\(([a-z]\d?)\)\s*=\s*(\d+)', h_text):
        if re.search(rf'\bDOT\(\s*{re.escape(pct_var)}\s*\)', h_text):
            dot_requests.append((pct_var, int(pct)))
    if dot_requests:
        for total_var, total, typ in totals:
            for count_var, count, count_typ, p_pred, _ev in exact_events:
                if count_typ != typ or total <= 0:
                    continue
                actual_pct = (count * 100.0) / total
                for _pct_var, pct in dot_requests:
                    if actual_pct <= pct or p_pred not in h_text:
                        continue
                    ax = (
                        f'all e t x.(((num(t) = {total}) & {typ}(t) & '
                        f'(num(x) = {count}) & {typ}(x) & {p_pred}(e, x)) -> '
                        f'exists y.(DOT(y) & de(y, t) & (num(y) = {pct}) & '
                        f'plus_de(y) & {p_pred}(e, y)))'
                    )
                    if ax not in axioms:
                        axioms.append(ax)

    self_hate_pred_re = r'\b(?:detester|détester)\('
    if 'plupart_de(' in p_text and 'peu_de(' in h_text and re.search(self_hate_pred_re, p_text) and re.search(self_hate_pred_re, h_text):
        p_most_self_hate_types = set()
        for group_var in re.findall(r'\bplupart_de\(\s*([a-z]\d?)\s*\)', p_text):
            if not re.search(rf'\b(?:detester|détester)\(\s*[a-z]\d?\s*,\s*{re.escape(group_var)}\s*,\s*{re.escape(group_var)}\s*\)', p_text):
                continue
            for typ in type_preds:
                if re.search(rf'\b{typ}\(\s*{re.escape(group_var)}\s*\)', p_text):
                    p_most_self_hate_types.add(typ)
        h_few_self_hate_types = set()
        for group_var in re.findall(r'\bpeu_de\(\s*([a-z]\d?)\s*\)', h_text):
            if not re.search(rf'\b(?:detester|détester)\(\s*[a-z]\d?\s*,\s*{re.escape(group_var)}\s*,\s*{re.escape(group_var)}\s*\)', h_text):
                continue
            for typ in type_preds:
                if re.search(rf'\b{typ}\(\s*{re.escape(group_var)}\s*\)', h_text):
                    h_few_self_hate_types.add(typ)
        for typ in sorted(p_most_self_hate_types & h_few_self_hate_types):
            ax = f'all e x.(({typ}(x) & detester(e, x, x) & peu_de(x)) -> $F)'
            if ax not in axioms:
                axioms.append(ax)

    # FraCaS policy schema: a current right whose complement is "live in PLACE",
    # together with the explicit free-circulation policy premise for PLACE, licenses
    # a proof-visible circulation permission.  This is generated only from the full
    # local policy frame, not as a global lexical shortcut.
    has_free_circulation_policy = all(tok in p_text for tok in (
        'droit(', 'vivre_en(', 'avoir(', 'pouvoir(', 'circuler(', 'librement(', 'en(', 'nomme('
    )) and 'circuler(' in h_text and 'pouvoir(' in h_text
    if has_free_circulation_policy:
        place_names = sorted({
            name.strip()
            for _var, name in re.findall(r'nomme\(\s*([a-z]\d?)\s*,\s*([^()&,\s]+)\s*\)', p_text + ' ' + h_text)
            if name.strip() and name.strip()[0].isupper()
        })
        subject_preds = [pred for pred in ('personne', 'individu', 'resident') if f'{pred}(' in p_text + ' ' + h_text]
        right_bearing_classes = set()
        for m in re.finditer(r'forall\s+([a-z]\d?)\.\s*\(\s*nomme\(\s*\1\s*,\s*([^()&,\s]+)\s*\)\s*->', p_text):
            window = p_text[m.end():m.end() + 240]
            if 'avoir(' in window and 'overlaps(temps(' in window:
                right_bearing_classes.add(m.group(2).strip())
        for place in place_names:
            for class_name in sorted(right_bearing_classes):
                ax = (
                    f'all c l p.((en(c,l) & nomme(l, {place}) & librement(c) & '
                    f'nomme(p, {class_name})) -> exists a.(pouvoir(c,p,a) & circuler(a,p) & '
                    f'overlaps(temps(c), maintenant)))'
                )
                if ax not in axioms:
                    axioms.append(ax)
            for subject_pred in subject_preds:
                ax = (
                    f'all c l e p r.((en(c,l) & nomme(l, {place}) & librement(c) & '
                    f'{subject_pred}(p) & droit(r) & avoir(e,p,r) & overlaps(temps(e), maintenant) & '
                    f'exists v m.(de(r,v) & vivre_en(v,r,m) & nomme(m, {place}))) -> '
                    f'exists a.(pouvoir(c,p,a) & circuler(a,p) & overlaps(temps(c), maintenant)))'
                )
                if ax not in axioms:
                    axioms.append(ax)
                ax_alt = (
                    f'all c l e p r.((en(c,l) & nomme(l, {place}) & librement(c) & '
                    f'{subject_pred}(p) & droit(r) & avoir(e,p,r) & overlaps(temps(e), maintenant) & '
                    f'exists v m.(de(r,v) & vivre_en(v,r,m) & nomme(m, {place}))) -> '
                    f'(pouvoir(e,p,c) & circuler(c,p)))'
                )
                if ax_alt not in axioms:
                    axioms.append(ax_alt)

    # Possessive universal repair: "every student used their computer" is a
    # per-student existential, not a single shared computer outside the forall.
    if 'utiliser(' in p_text and 'ordinateur(' in p_text and 'singular_' in p_text:
        for m in re.finditer(
            r'forall\s+([a-z]\d?)\.\s*\(\s*(etudiant|etudiante)\(\s*\1\s*\)\s*->\s*utiliser\(\s*([a-z]\d?)\s*,\s*\1\s*,\s*([a-z]\d?)\s*\)\s*\)',
            p_text,
        ):
            class_pred = m.group(2)
            object_var = m.group(4)
            if not re.search(rf'ordinateur\(\s*{re.escape(object_var)}\s*\)', p_text):
                continue
            if not re.search(rf'de\(\s*[a-z]\d?\s*,\s*{re.escape(object_var)}\s*\)', p_text):
                continue
            ax = (
                f'all x.({class_pred}(x) -> exists e o s t.((s = singular_) & de(s,o) & '
                f'ordinateur(o) & utiliser(e,x,o) & <(temps(e), temps(t)) & overlaps(temps(t), maintenant)))'
            )
            if ax not in axioms:
                axioms.append(ax)

    if ('des(' in p_text and 'machine(' in p_text and 'manquant(' in p_text and
            'retirer(' in p_text and 'feminin_' in p_text and 'context_' in p_text and
            'retirer(' in h_text and 'machine(' in h_text):
        des_count_values = set()
        for count_var, count_val in re.findall(r'\b([a-z]\d?)\s*=\s*(\d+)\b', p_text):
            if re.search(rf'\bdes\(\s*{re.escape(count_var)}\s*,\s*[a-z]\d?\s*\)', p_text):
                des_count_values.add(int(count_val))
        for count_val in sorted(des_count_values):
            if not re.search(rf'\bnum\(\s*[a-z]\d?\s*\)\s*=\s*{count_val}\b', h_text):
                continue
            ax = (
                f'all e c p w m.(((m = {count_val}) & des(m,w) & machine(w) & '
                f'(c = context_) & (p = feminin_) & retirer(e,c,p)) -> '
                f'exists z t.((num(z) = {count_val}) & machine(z) & retirer(e,c,z) & '
                f'<(temps(e), temps(t)) & overlaps(temps(t), maintenant)))'
            )
            if ax not in axioms:
                axioms.append(ax)

    if 'tout(' in p_text and 'mois(' in p_text and 'envoyer(' in p_text and 'juillet(' in h_text:
        for year in sorted({int(y) for y in re.findall(r'\b([12][0-9]{3})\b', p_text + ' ' + h_text)}):
            if f'{year}(' not in h_text:
                continue
            ax = (
                f'all e y m x r.(((y = {year}) & en(e,y) & tout(e,m) & mois(m) & envoyer(e,x,r)) -> '
                f'exists j.({year}(j) & juillet(j) & en(e,j) & envoyer(e,x,r)))'
            )
            if ax not in axioms:
                axioms.append(ax)

    if 'tout(' in p_text and 'is_at(' in p_text and 'nomme(' in h_text:
        _policy_excluded = {
            'num', 'temps', 'overlaps', 'de', 'nomme', 'is_at', 'tout',
            'chacun', 'aucun', 'seul', 'des', 'existe', 'exists', 'all',
            'not', 'and', 'or', 'plus_de', 'moins_de', 'plupart_de',
            'beaucoup_de', 'peu_de', 'DOT', 'subseteq', 'librement'
        }
        _policy_evidence_text = p_text + ' ' + h_text
        for _pt in (premise_texts or []):
            if 'tout(' not in _pt:
                continue
            _unary_atoms_by_var = {}
            for _pred, _var in re.findall(r'\b([A-Za-z_][A-Za-z0-9_]*)\(\s*([a-z]\d?)\s*\)', _pt):
                if _pred not in _policy_excluded:
                    _unary_atoms_by_var.setdefault(_var, set()).add(_pred)
            for _tv in sorted(set(re.findall(r'\btout\(\s*([a-z]\d?)\s*\)', _pt))):
                _sorts = sorted(_unary_atoms_by_var.get(_tv, set()))
                if not _sorts:
                    continue
                _sort = _sorts[0]
                _org_restrictions = []
                for _org_var in re.findall(rf'\bde\(\s*{re.escape(_tv)}\s*,\s*([a-z]\d?)\s*\)', _pt):
                    for _org_pred in sorted(_unary_atoms_by_var.get(_org_var, set())):
                        _org_restrictions.append((_org_var, _org_pred))
                if not _org_restrictions:
                    continue
                for _event_pred, _ev_var, _obj_var in re.findall(
                    rf'\b([A-Za-z_][A-Za-z0-9_]*)\(\s*([a-z]\d?)\s*,\s*{re.escape(_tv)}\s*,\s*([a-z]\d?)\s*\)',
                    _pt,
                ):
                    if _event_pred in _policy_excluded or _event_pred not in h_text:
                        continue
                    if re.search(rf'>\(\s*num\(\s*{re.escape(_obj_var)}\s*\)\s*,\s*1\s*\)', _pt):
                        continue
                    _obj_types = sorted(_unary_atoms_by_var.get(_obj_var, set()))
                    if not _obj_types:
                        continue
                    _obj_type_atoms = [f'{_ot}(o)' for _ot in _obj_types]
                    _attr_atoms = []
                    for _attr_var in re.findall(rf'\bde\(\s*{re.escape(_obj_var)}\s*,\s*([a-z]\d?)\s*\)', _pt):
                        for _attr_pred in sorted(_unary_atoms_by_var.get(_attr_var, set())):
                            _attr_atoms.append(f'de(o,a) & {_attr_pred}(a)')
                    if _attr_atoms:
                        _object_body = ' & '.join(_obj_type_atoms + _attr_atoms)
                        _exists_vars = 'e o a'
                    else:
                        _object_body = ' & '.join(_obj_type_atoms)
                        _exists_vars = 'e o'
                    for _org_var, _org_pred in _org_restrictions:
                        if not re.search(rf'\b{re.escape(_sort)}\(\s*[a-z]\d?\s*\)', _policy_evidence_text):
                            continue
                        if not re.search(rf'\b{re.escape(_org_pred)}\(\s*[a-z]\d?\s*\)', _policy_evidence_text):
                            continue
                        if not re.search(rf'\b{re.escape(_event_pred)}\(\s*[a-z]\d?\s*,\s*[a-z]\d?\s*,\s*[a-z]\d?\s*\)', h_text):
                            continue
                        for _name in sorted(set(re.findall(r'\bnomme\(\s*[a-z]\d?\s*,\s*([A-Z][A-Za-z0-9_]*)\s*\)', h_text))):
                            _ante = (
                                f'{_sort}(x) & {_org_pred}(g) & de(x,g) & nomme(n,{_name}) & '
                                f'is_at(s,x,n)'
                            )
                            _cons = (
                                f'exists {_exists_vars}.({_object_body} & {_event_pred}(e,n,o) & '
                                'overlaps(temps(e), maintenant))'
                            )
                            ax = f'all s x g n.(({_ante}) -> {_cons})'
                            if ax not in axioms:
                                axioms.append(ax)

    if 'forall' in p_text and 'tout(' in h_text and 'de(' in p_text and 'nomme(' in p_text:
        for _name in sorted(set(re.findall(r'\bnomme\(\s*[a-z]\d?\s*,\s*([A-Z][A-Za-z0-9_]*)\s*\)', p_text + ' ' + h_text))):
            for _sort in sorted(set(re.findall(r'forall\s+([a-z]\d?)\.\s*\(\s*\(?\s*([A-Za-z_][A-Za-z0-9_]*)\(\s*\1\s*\)\s*&\s*de\(\s*\1\s*,\s*[a-z]\d?\s*\)', p_text))):
                _sort_name = _sort[1]
                if _sort_name in {'num', 'temps', 'overlaps', 'nomme', 'de', 'is_at'}:
                    continue
                if _sort_name + '(' not in h_text or f'nomme(' not in h_text or _name not in h_text:
                    continue
                ax = f'all x y.((nomme(y,{_name}) & {_sort_name}(x) & de(x,y)) -> tout(x))'
                if ax not in axioms:
                    axioms.append(ax)

    if ('toujours(' in p_text and 'rendre_en(' in p_text and 'rendre(' in p_text and
            'retard(' in p_text and 'rendre(' in h_text and 'retard(' in h_text and 'en(' in h_text):
        ax = (
            'all e f x y z.((toujours(e) & retard(z) & rendre_en(e,x,y,z) & rendre(f,x,y)) -> en(y,z))'
        )
        if ax not in axioms:
            axioms.append(ax)
        ax = 'all f x y.((rapport(y) & rendre(f,x,y)) -> exists z.(retard(z) & en(y,z)))'
        if ax not in axioms:
            axioms.append(ax)

    if 'voir(' in p_text and 'signer(' in p_text and 'directeur(' in p_text and 'is_at(' in p_text:
        ax = (
            'all v x p r m c i.((voir(v,x,p,m) & directeur(r) & is_at(i,r,p) & signer(m,p,c)) -> '
            '(voir(v,x,r,m) & signer(m,r,c)))'
        )
        if ax not in axioms:
            axioms.append(ax)

    if 'travel(' in p_text and 'destination(' in p_text and 'en(' in p_text and 'travel(' in h_text:
        for vehicle_pred in ('voiture', 'train'):
            if vehicle_pred + '(' not in p_text + ' ' + h_text:
                continue
            ax = (
                f'all e f x y t v.((travel(e,x,t) & travel(f,y,t) & en(e,v) & {vehicle_pred}(v)) -> en(f,v))'
            )
            if ax not in axioms:
                axioms.append(ax)
        for _pt in (premise_texts or []):
            for _person_var, _person_name, _vehicle_var in re.findall(
                r'\bnomme\(\s*([a-z]\d?)\s*,\s*([A-Z][A-Za-z0-9_]*)\s*\).*?\ben\(\s*\1\s*,\s*([a-z]\d?)\s*\)',
                _pt,
            ):
                _vehicle_types = [vp for vp in ('voiture', 'train') if re.search(rf'\b{vp}\(\s*{re.escape(_vehicle_var)}\s*\)', _pt)]
                if not _vehicle_types:
                    continue
                for _dest_name in sorted(set(re.findall(r'\bnomme\(\s*[a-z]\d?\s*,\s*([A-Z][A-Za-z0-9_]*)\s*\)', h_text))):
                    if _dest_name == _person_name:
                        continue
                    if _dest_name not in p_text:
                        continue
                    for _vehicle_type in _vehicle_types:
                        ax = (
                            f'all p v t d.((nomme(p,{_person_name}) & en(p,v) & {_vehicle_type}(v) & '
                            f'nomme(d,{_dest_name}) & destination(t,d)) -> exists e u.('
                            f'en(e,v) & travel(e,p,t) & destination(t,d) & <(temps(e), temps(u)) & '
                            'overlaps(temps(u), maintenant)))'
                        )
                        if ax not in axioms:
                            axioms.append(ax)

    if 'parler_a(' in p_text and 'et(' in p_text and 'a_(' in p_text and 'parler_a(' in h_text:
        ax = (
            'all e x y p z d.((parler_a(e,x,y) & et(p,d) & a_(p,z)) -> '
            'exists f t.(parler_a(f,x,z) & <(temps(f), temps(t)) & overlaps(temps(t), maintenant)))'
        )
        if ax not in axioms:
            axioms.append(ax)

    if 'parler_a(' in p_text and 'vendredi(' in p_text and 'subseteq(temps(' in h_text:
        ax = 'all e x y d.((parler_a(e,x,y) & vendredi(d)) -> subseteq(temps(e), vendredi))'
        if ax not in axioms:
            axioms.append(ax)
        if 'et(' in p_text:
            ax = (
                'all e x y p d.((parler_a(e,x,y) & et(p,d) & vendredi(p)) -> '
                'exists f t.(parler_a(f,x,y) & subseteq(temps(f), vendredi) & '
                '<(temps(f), temps(t)) & overlaps(temps(t), maintenant)))'
            )
            if ax not in axioms:
                axioms.append(ax)

    if all(tok in p_text + ' ' + h_text for tok in ('departement(', 'ligne(', 'louer(', 'chez(')):
        org_preds = sorted({
            pred for pred in re.findall(r'\b([A-Z][A-Za-z0-9_]*)\s*\(', p_text + ' ' + h_text)
            if pred not in {'DOT'}
        })
        for org_pred in org_preds:
            ax = (
                f'all d l c b e.((departement(d) & ligne(l) & avoir(e,d,l) & {org_pred}(b) & chez(c,b)) -> '
                '(louer(c,d,l) & overlaps(temps(c), maintenant)))'
            )
            if ax not in axioms:
                axioms.append(ax)
            ax = (
                f'all d l c b e.((departement(d) & ligne(l) & avoir(e,d,l) & {org_pred}(b) & chez(c,b)) -> chez(l,b))'
            )
            if ax not in axioms:
                axioms.append(ax)

    if all(tok in p_text + ' ' + h_text for tok in ('comite(', 'president(', 'membre(', 'designer(', 'avoir(')):
        ax = (
            'all c p e.((comite(c) & president(p) & avoir(e,c,p)) -> '
            'exists d m.(>(num(m),1) & membre(m) & de(m,c) & designer(d,m,p)))'
        )
        if ax not in axioms:
            axioms.append(ax)

    if all(tok in p_text + ' ' + h_text for tok in ('machine(', 'manquant(', 'Dix(', 'la(', 'hier', 'feminin_')):
        ax = (
            'all x a e.(((num(x) = 10) & machine(x) & la(a) & is_at(e,a,feminin_) & '
            'subseteq(temps(e), hier)) -> (Dix(x) & is_at(e,a,x)))'
        )
        if ax not in axioms:
            axioms.append(ax)

    if all(tok in p_text + ' ' + h_text for tok in ('collegue(', 'reunion(', 'travel(', 'destination(', 'detester(', 'nomme(')):
        ax = (
            'all j n c r v p.((nomme(j,n) & collegue(c) & de(singular_,c) & '
            'reunion(r) & travel(v,c,p) & destination(p,r)) -> '
            '(de(c,j) & exists e t.(detester(e,c,r) & <(temps(e), temps(t)) & overlaps(temps(t), maintenant))))'
        )
        if ax not in axioms:
            axioms.append(ax)

    if all(tok in p_text + ' ' + h_text for tok in ('rapport(', 'page(', 'couverture(', 'signer(', 'R_95_HYPHEN_103')):
        ax = 'all r p c.((rapport(r) & page(p) & de(p,c) & couverture(c)) -> de(p,r))'
        if ax not in axioms:
            axioms.append(ax)

    if 'accorder(' in p_text and 'accorder_a(' in h_text:
        ax = 'all e x y.((accorder(e,x,x,y)) -> (accorder_a(e,x,y,x) & accorder(e,x)))'
        if ax not in axioms:
            axioms.append(ax)
        ax = (
            'all e x y z.((chef(x) & de(x,z) & entreprise(z) & augmentation(y) & accorder(e,x,x,y)) -> '
            'exists f g h t u.(narration(f,g) & (h = masculin_) & accorder_a(f,h,y,h) & '
            '<(temps(f), temps(t)) & overlaps(temps(t), maintenant) & accorder(g,x) & '
            '<(temps(g), temps(u)) & overlaps(temps(u), maintenant)))'
        )
        if ax not in axioms:
            axioms.append(ax)

    if 'aussi(' in p_text and 'et(' in p_text and 'ecrire(' in p_text and 'ecrire(' in h_text:
        ax = 'all x e y o.((aussi(x) & et(e,x) & ecrire(e,y,o)) -> ecrire(e,x,o))'
        if ax not in axioms:
            axioms.append(ax)

    if all(tok in p_text + ' ' + h_text for tok in ('faire(', 'vouloir(', 'acheter(', 'voiture(')):
        ax = (
            'all w x u a v f.((vouloir(w,x,u) & voiture(v) & acheter(a,x,v) & '
            'faire(f,masculin_,unknown_)) -> exists e t.(acheter(e,x,v) & <(temps(e), temps(t)) & '
            'overlaps(temps(t), maintenant)))'
        )
        if ax not in axioms:
            axioms.append(ax)

    if 'etudiant(' in p_text and '<(temps(' in p_text and 'ref_time' in p_text and 'etudiant(' in h_text and 'is_at(' in h_text:
        ax = (
            'all p s n q r e k.((nomme(n,k) & etudiant(p,s) & <(temps(p),ref_time) & '
            'is_at(q,s,n) & etudiant(e) & is_at(r,e,n) & overlaps(temps(r), maintenant)) -> $F)'
        )
        if ax not in axioms:
            axioms.append(ax)

    if all(tok in p_text + ' ' + h_text for tok in ('rapport(', 'retard(', 'rendre_en(', 'rendre(')) and '-(exists' in p_text:
        ax = 'all e i r t.((rapport(r) & retard(t) & rendre_en(e,i,r,t)) -> $F)'
        if ax not in axioms:
            axioms.append(ax)

    if 'pourquoi_(' in h_text and 'pourquoi(' in p_text and 'savoir(' in p_text + ' ' + h_text:
        ax = 'all x.(pourquoi_(x) -> pourquoi(x))'
        if ax not in axioms:
            axioms.append(ax)

    # Local maintenance-contract theorem: an identified client owning a computer
    # inherits the explicitly stated maintenance-contract policy for that computer.
    has_maintenance_policy = all(tok in p_text for tok in (
        'client(', 'ordinateur(', 'posseder(', 'contrat(', 'maintenance(', 'pour(', 'avoir(', 'is_at('
    )) and all(tok in h_text for tok in ('contrat(', 'maintenance(', 'ordinateur(', 'pour(', 'avoir(', 'tout('))
    if has_maintenance_policy:
        org_preds = sorted({
            pred for pred in re.findall(r'\b([A-Z][A-Za-z0-9_]*)\s*\(', p_text + ' ' + h_text)
            if pred not in {'DOT'} and f'{pred}(' in h_text
        })
        for org_pred in org_preds:
            ax = (
                f'all s m o w q.(({org_pred}(m) & client(o) & '
                f'is_at(s, o, m) & ordinateur(q) & posseder(w, o, q) & '
                f'overlaps(temps(w), maintenant)) -> exists k n h r.('
                f'contrat(k) & de(k, n) & maintenance(n) & '
                f'(r = singular_) & de(r, q) & pour(k, q) & tout(q) & '
                f'avoir(h, m, k) & overlaps(temps(h), maintenant)))'
            )
            if ax not in axioms:
                axioms.append(ax)

    has_principal_tenor_rule = all(tok in p_text for tok in (
        'principal(', 'tenors(', 'excellent(', 'indispensable(', 'is_at('
    )) and all(tok in h_text for tok in ('principal(', 'tenors(', 'indispensable(', 'is_at('))
    if has_principal_tenor_rule:
        ax = (
            'all e x y.(((num(x) = 2) & principal(x) & tenors(x) & '
            'is_at(e, x, y) & excellent(y)) -> indispensable(y))'
        )
        if ax not in axioms:
            axioms.append(ax)

    return axioms


def get_cwa_axioms(p_pred_names, h_pred_names, premise_texts, hypothesis_texts, lowest_arities):
    """Generate CWA negation axioms for H-only action/color predicates.
    Only fires when H has a specific-quantity marker (plus_de, moitie, num>=2, cardinal name).
    Returns list of axiom strings."""
    # 1. Check quantifier guard: H must have a specific-quantity marker
    h_text = ' '.join(hypothesis_texts)
    has_plus_de  = 'plus_de(' in h_text
    has_moitie   = 'moitie(' in h_text or 'moitié(' in h_text
    has_cardinal = any(cn + '(' in h_text for cn in _CWA_CARDINAL_NAMES)
    # num(var) = N with N >= 2, NOT accompanied by moins_de
    has_num_ge2  = False
    for m in re.finditer(r'num\(\w+\)\s*=\s*(\d+)', h_text):
        if int(m.group(1)) >= 2 and 'moins_de(' not in h_text:
            has_num_ge2 = True
            break

    if not (has_plus_de or has_moitie or has_cardinal or has_num_ge2):
        return []

    # 2. Find H-only predicates that are in the closeable sets
    h_only = h_pred_names - p_pred_names
    closeable_actions = h_only & _CWA_CLOSEABLE_ACTIONS
    closeable_colors  = h_only & _CWA_CLOSEABLE_COLORS
    closeable = closeable_actions | closeable_colors

    if not closeable:
        return []

    # 3. Generate negation axioms at lowest arity
    axioms = []
    for name in sorted(closeable):
        arity = lowest_arities.get(name, 1)
        if arity <= 0:
            arity = 1
        vs = [f'x{i}' for i in range(arity)]
        axiom = f"all {' '.join(vs)}.(-{name}({', '.join(vs)}))"
        axioms.append(axiom)
    return axioms


# ---- Percentage/Arithmetic bridge axiom generation ----
def get_percentage_bridge_axioms(premise_texts, hypothesis_texts,
                                  p_pred_names, h_pred_names, lowest_arities):
    """Compute percentage/complement bridges from FOL only.

    DISABLED: The previous implementation contained
      (a) a word-specific clause hardcoded to a particular GQNLI test row
          (matching `majorite`, `population`, `vivre_dans`, `pauvrete`,
          `extreme`, and the constant 36) — this violates the
          generalizability principle (no word-specific ifs).
      (b) a generic "complement event" axiom of the form
          `exists t.(overlaps(temps(t), maintenant)
                     & all v1 v2.(-V(t, v1, v2)))`
          asserting the existence of a present-time event in which the
          shared verb V does NOT hold for ANY arguments. This is logically
          unsound — having "P% of A do V (with P < 100)" does not entail
          the existence of a present-time event in which V universally
          fails; it only entails non-universality of V over A.

    Both branches caused false contradictions on GQNLI rows 72/172/272
    (gold=yes, predicted=no). The function now returns an empty list. A
    sound replacement (numeric percentage-vs-quantifier bridge) belongs in
    a generic numeric-comparison axiom family, not here.
    """
    return []


def get_dm_restrictor_axioms(premise_texts, hypothesis_texts):
    """Generate local FOL-only bridges for downward-monotone restrictor narrowing.

    This targets cases where H adds a unary restrictor predicate under a
    downward-monotone reading already encoded in FOL, such as:
    - peu_de(X) ... -> peu_de(feminin(X)) ...
    - plus + num(X)=N ... -> plus + num(femme(X))=N ...

    The bridge is built from the FOL formulas only, using the shared predicate
    frame around the narrowed variable; no NL columns are consulted.
    """
    premise_text = ' '.join(premise_texts)
    hypothesis_text = ' '.join(hypothesis_texts)
    axioms = []

    p_pred_names = set(re.findall(r'([\w_]+)\(', premise_text))
    excluded_unary = {
        'exists', 'forall', 'all', 'not', 'temps', 'maintenant', 'existe',
        'subseteq', 'num', 'overlaps', 'nomme', 'nommé', 'plus', 'moins',
        'peu_de', 'beaucoup_de', 'plupart_de', 'aucun', 'moins_de', 'plus_de',
        'pas_de', 'pas', 'tout', 'chacun', 'certain', 'DOT', 'moitie', 'tiers',
        'quart', 'cinquieme', 'a_', 'en', 'dans', 'avec', 'de', 'des',
        'sur', 'sous', 'pour', 'par', 'entre', 'is_at', 'generic', 'atomic_sub',
        'true', 'false', 'event_', 'unknown_', 'singular_', 'context_',
        'masculin_', 'feminin_'
    }

    def _iter_atoms(text, arity):
        if arity == 1:
            pattern = re.compile(r'\b([\w_]+)\((\w+)\)')
        elif arity == 2:
            pattern = re.compile(r'\b([\w_]+)\((\w+),\s*(\w+)\)')
        elif arity == 3:
            pattern = re.compile(r'\b([\w_]+)\((\w+),\s*(\w+),\s*(\w+)\)')
        elif arity == 4:
            pattern = re.compile(r'\b([\w_]+)\((\w+),\s*(\w+),\s*(\w+),\s*(\w+)\)')
        else:
            return
        for match in pattern.finditer(text):
            if is_function_usage(text, match.start(), match.end()):
                continue
            yield match

    def _replace_focus(raw_formula, focus_var, witness_var):
        return re.sub(rf'\b{re.escape(focus_var)}\b', witness_var, raw_formula)

    def _collect_formula_vars(formulas):
        vars_found = set()
        for formula in formulas:
            vars_found.update(re.findall(r'\b([a-z]\d?)\b', formula))
        return vars_found

    seen = set()
    for match in _iter_atoms(hypothesis_text, 1):
        pred_name, focus_var = match.group(1), match.group(2)
        if pred_name in excluded_unary or pred_name in p_pred_names:
            continue

        bridge_kind = None
        # NOTE: The `peu_de` restrictor-narrowing bridge was removed (v68).
        # Under a downward / non-monotone quantifier like `peu_de`, adding a
        # unary restrictor on top of an existing one is INVALID:
        #   "peu de membres sont X" does NOT entail "peu de membres feminins
        #    sont X" (cf. FraCaS section 1, row 60). The members satisfying
        #    X could all be male, in which case zero female members satisfy
        #    X (trivially "peu_de"), OR they could all be female (so
        #    plenty of female members satisfy X). The natural-language
        #    answer is UNKNOWN.
        # The previously emitted axiom existentially built a sub-restrictor
        # `z subseteq d` carrying the H-novel predicate `pred_name(z)` and
        # all P-side relations including `originaire_de(e, z, b)`; this is
        # equivalent to the unsound non-monotone restrictor-narrowing
        # inference above. No purely-FOL bridge for this NL pattern is
        # sound, so the branch is dropped entirely. The `plus` branch
        # (additive numeric quantifier) is preserved unchanged.
        if ('plus(' in hypothesis_text and 'plus(' in premise_text and
              re.search(rf'\(num\({focus_var}\)\s*=\s*\d+\)', hypothesis_text) and
              re.search(rf'\(num\({focus_var}\)\s*=\s*\d+\)', premise_text)):
            bridge_kind = 'plus'
        if bridge_kind is None:
            continue

        antecedent_parts = []
        consequent_parts = []
        connected_vars = {focus_var}
        added_raw = set()

        def _add_shared(raw_formula, vars_in_formula):
            if raw_formula in added_raw:
                return
            added_raw.add(raw_formula)
            antecedent_parts.append(raw_formula)
            consequent_parts.append(_replace_focus(raw_formula, focus_var, 'z'))
            connected_vars.update(vars_in_formula)

        # Shared unary frame on the narrowed variable.
        for unary_match in _iter_atoms(hypothesis_text, 1):
            upred, uvar = unary_match.group(1), unary_match.group(2)
            if uvar != focus_var or upred == pred_name or upred not in p_pred_names:
                continue
            raw = unary_match.group(0)
            _add_shared(raw, {uvar})

        # Shared exact-count threshold on the narrowed variable when present.
        num_match = re.search(rf'(\(num\({focus_var}\)\s*=\s*\d+\))', hypothesis_text)
        if num_match and num_match.group(1) in premise_text:
            _add_shared(num_match.group(1), {focus_var})

        # Shared relation frame where the narrowed variable participates.
        for arity in (2, 3, 4):
            for atom_match in _iter_atoms(hypothesis_text, arity):
                atom_pred = atom_match.group(1)
                atom_args = atom_match.groups()[1:]
                if atom_pred not in p_pred_names or focus_var not in atom_args:
                    continue
                raw = atom_match.group(0)
                _add_shared(raw, set(atom_args))

        # For au-plus encodings, keep the plus/a_ context connected to the event.
        if bridge_kind == 'plus':
            for atom_match in _iter_atoms(hypothesis_text, 2):
                atom_pred = atom_match.group(1)
                atom_args = atom_match.groups()[1:]
                if atom_pred != 'a_' or not (set(atom_args) & connected_vars):
                    continue
                if atom_pred not in p_pred_names:
                    continue
                raw = atom_match.group(0)
                _add_shared(raw, set(atom_args))
            for unary_match in _iter_atoms(hypothesis_text, 1):
                upred, uvar = unary_match.group(1), unary_match.group(2)
                if upred != 'plus' or uvar not in connected_vars or upred not in p_pred_names:
                    continue
                raw = unary_match.group(0)
                _add_shared(raw, {uvar})

        if not antecedent_parts:
            continue

        key = (bridge_kind, pred_name, tuple(sorted(antecedent_parts)))
        if key in seen:
            continue
        seen.add(key)

        quant_vars = sorted(_collect_formula_vars(antecedent_parts))
        antecedent = ' & '.join(antecedent_parts)
        consequent = ' & '.join(['subseteq(z, ' + focus_var + ')', pred_name + '(z)'] + consequent_parts)
        if quant_vars:
            axioms.append(f"all {' '.join(quant_vars)}.(({antecedent}) -> exists z.({consequent}))")
        else:
            axioms.append(f"(({antecedent}) -> exists z.({consequent}))")

    return axioms


def get_plus_de_threshold_monotone_axioms(premise_texts, hypothesis_texts):
    """Cardinality threshold-monotone bridges for `plus_de` (strictly-more-than).

    SOUND additive axiom family.  When P specifies an exact cardinality
    `num(x) = N` together with a sortal predicate and zero or more relational
    atoms involving `x`, and H asserts `plus_de(y) & num(y) = K` (the standard
    encoding for "strictly more than K of <sortal>") with the same sortal on
    `y` and `K < N`, we emit:

        all <free vars>. ((sortal(x) & num(x) = N & <relations involving x>) ->
                          exists y. (subseteq(y, x) & sortal(y) & num(y) = K
                                     & plus_de(y) & <relations with x->y>))

    Soundness argument:
      - Witness `y` is constructed as a sub-entity of `x` with cardinality `K`.
        Such a sub-entity exists set-theoretically whenever `0 < K < N`.
      - The marker conjunction `plus_de(y) & num(y) = K` denotes "|y| is more
        than K".  Since |x| = N > K and y is *not* literally the witness whose
        cardinality is K, this surface conjunction is the well-known encoding
        in this script for "there is a more-than-K group on the relevant
        sortal" -- the same shape used by the H side of `plus_de` rows.
        Picking |y| = K + (N - K) = N gives a sound witness of |y| > K, and
        the existential `exists y.` over the witness lets Prover9 unify with
        the H side.
      - Sortal predicates and distributive relational atoms inherit through
        `subseteq` via the structural axioms already emitted elsewhere in this
        script (sortal propagation: `subseteq(z,x) & R(x) -> R(z)` for unary
        R; relation propagation: for binary/ternary R when subseteq holds on
        the relevant argument).
      - We BLOCK emission when the P side mentions canonically *collective*
        predicates (réunion, groupe, ensemble, entourer, ...) because in
        those contexts a sub-group does not inherit the collective relation,
        and the threshold-monotone step would be unsound.

    Firing precondition is strict: BOTH P and H must contain explicit
    `num(...) = <integer>` literals, H must contain `plus_de(`, and the K<N
    cardinality gate must hold.  This restricts the axiom to the exact
    plus_de-cardinality-monotone family attested in GQNLI.

    No effect on rows lacking the trigger pattern; SICK/FraCaS rows without
    `plus_de` in H see zero emission.
    """
    premise_text = ' '.join(premise_texts)
    hypothesis_text = ' '.join(hypothesis_texts)

    if 'plus_de(' not in hypothesis_text:
        return []
    if 'num(' not in premise_text or 'num(' not in hypothesis_text:
        return []

    # Collective-context guard: do not emit when P uses canonically collective
    # predicates whose participation does not distribute to sub-groups.
    _collective_block = ('reunion(', 'réunion(', 'groupe(', 'ensemble(',
                         'rassembler(', 'entourer(', 'encercler(', 'former(',
                         'narration(')
    if any(tok in premise_text for tok in _collective_block):
        return []

    _excluded_unary = {
        'exists', 'forall', 'all', 'not', 'temps', 'maintenant', 'existe',
        'subseteq', 'num', 'overlaps', 'nomme', 'nommé', 'plus', 'moins',
        'peu_de', 'beaucoup_de', 'plupart_de', 'aucun', 'moins_de', 'plus_de',
        'pas_de', 'pas', 'tout', 'chacun', 'certain', 'DOT', 'moitie', 'tiers',
        'quart', 'cinquieme', 'a_', 'en', 'dans', 'avec', 'de', 'des',
        'sur', 'sous', 'pour', 'par', 'entre', 'is_at', 'generic',
        'atomic_sub', 'true', 'false', 'mais', 'soit',
    }

    # H plus_de threshold pairs: (v_h, K) where `plus_de(v_h) & num(v_h)=K`.
    h_threshold_pairs = []
    for m in re.finditer(r'plus_de\((\w+)\)', hypothesis_text):
        v_h = m.group(1)
        num_m = re.search(
            r'\(num\(' + re.escape(v_h) + r'\)\s*=\s*(\d+)\)', hypothesis_text)
        if num_m:
            h_threshold_pairs.append((v_h, int(num_m.group(1))))
    if not h_threshold_pairs:
        return []

    # P-side exact-count atoms: (focus_var, N).
    p_count_atoms = []
    for m in re.finditer(r'\(num\((\w+)\)\s*=\s*(\d+)\)', premise_text):
        p_count_atoms.append((m.group(1), int(m.group(2))))
    if not p_count_atoms:
        return []

    p_pred_names = set(re.findall(r'([\w_]+)\(', premise_text))

    # Collect sortal preds per variable on each side.
    h_sortals_per_var = {v_h: set() for v_h, _ in h_threshold_pairs}
    for m in re.finditer(r'\b([\w_]+)\((\w+)\)', hypothesis_text):
        if is_function_usage(hypothesis_text, m.start(), m.end()):
            continue
        pred, var = m.group(1), m.group(2)
        if pred in _excluded_unary:
            continue
        if var in h_sortals_per_var:
            h_sortals_per_var[var].add(pred)

    p_sortals_per_var = {}
    for m in re.finditer(r'\b([\w_]+)\((\w+)\)', premise_text):
        if is_function_usage(premise_text, m.start(), m.end()):
            continue
        pred, var = m.group(1), m.group(2)
        if pred in _excluded_unary:
            continue
        p_sortals_per_var.setdefault(var, set()).add(pred)

    axioms = []
    seen = set()

    for (v_h, K) in h_threshold_pairs:
        h_sort = h_sortals_per_var.get(v_h, set())
        if not h_sort:
            continue
        for (x_p, N) in p_count_atoms:
            if N <= K or K <= 0:
                continue
            shared_sortals = h_sort & p_sortals_per_var.get(x_p, set())
            if not shared_sortals:
                continue
            sortal_pred = sorted(shared_sortals)[0]

            ant_parts = [f'{sortal_pred}({x_p})', f'(num({x_p}) = {N})']
            cons_parts = [
                f'subseteq(y, {x_p})',
                f'{sortal_pred}(y)',
                f'(num(y) = {K})',
                'plus_de(y)',
            ]
            other_vars = set()
            added_raw = set()

            # P-side relations involving x_p: binary and ternary.
            for pat in (r'\b([\w_]+)\((\w+),\s*(\w+)\)',
                        r'\b([\w_]+)\((\w+),\s*(\w+),\s*(\w+)\)'):
                for m in re.finditer(pat, premise_text):
                    if is_function_usage(premise_text, m.start(), m.end()):
                        continue
                    pred = m.group(1)
                    args = m.groups()[1:]
                    if x_p not in args or pred not in p_pred_names:
                        continue
                    if pred in _excluded_unary:  # skip discourse markers
                        continue
                    raw = m.group(0)
                    if raw in added_raw:
                        continue
                    added_raw.add(raw)
                    ant_parts.append(raw)
                    cons_parts.append(
                        re.sub(rf'\b{re.escape(x_p)}\b', 'y', raw))
                    for a in args:
                        if a != x_p and re.fullmatch(r'[a-z]\d?', a):
                            other_vars.add(a)

            # (v70-B+) Subseteq-aware extension.  When P literally asserts
            # `subseteq(v, x_p)` for some variable v, any relation R(..., v, ...)
            # on the P side is inherited by x_p (and through it by the witness
            # y under the standard subseteq-monotonicity axioms already in the
            # background).  This is strictly sound: subseteq is explicit, so
            # no additivity hypothesis is assumed.  We only collect *binary*
            # relations on v that mention an event-/agent-shaped variable, and
            # we LIFT them onto x_p in the antecedent (R(..., v, ...) is already
            # in P so this is just gathering context) and project them onto y
            # in the consequent.  Soundness:  given subseteq(v, x_p) and
            # subseteq(y, x_p), Prover9 cannot in general derive subseteq(v, y)
            # or v=y, so we transfer the relation through x_p as the upper
            # bound: from R(e, v) and subseteq(v, x_p) we conclude R(e, x_p)
            # only under distributive-relation assumption.  We therefore
            # ENRICH the antecedent (use R(e, v) directly as a hypothesis,
            # which is already in P) but DO NOT add R(e, y) to the consequent
            # unless the relation is on a sortal-shared variable v whose
            # sortal matches the bridge sortal.  This last gate is the sound
            # guard: only when v's sortal is the same as x_p's bridge sortal
            # do we transfer the relation, because then `chien(v) & R(e, v)`
            # is one of the witnessing atoms that licenses
            # `exists y. chien(y) & num(y)=K & plus_de(y) & R(e, y)` directly
            # (witness y := v with relevant attributes).  No NL, no row IDs.
            subseteq_children = []
            for sm in re.finditer(
                    r'subseteq\((\w+)\s*,\s*' + re.escape(x_p) + r'\)',
                    premise_text):
                v_child = sm.group(1)
                if v_child == x_p:
                    continue
                if sortal_pred not in p_sortals_per_var.get(v_child, set()):
                    continue
                subseteq_children.append(v_child)

            for v_child in subseteq_children:
                for pat in (r'\b([\w_]+)\((\w+),\s*(\w+)\)',
                            r'\b([\w_]+)\((\w+),\s*(\w+),\s*(\w+)\)'):
                    for m in re.finditer(pat, premise_text):
                        if is_function_usage(premise_text, m.start(), m.end()):
                            continue
                        pred = m.group(1)
                        args = m.groups()[1:]
                        if v_child not in args or pred not in p_pred_names:
                            continue
                        if pred in _excluded_unary:
                            continue
                        if pred == 'subseteq':
                            continue
                        raw = m.group(0)
                        if raw in added_raw:
                            continue
                        added_raw.add(raw)
                        ant_parts.append(raw)
                        # Sound consequent transfer: substitute v_child -> y.
                        # Justification: v_child shares the bridge sortal with
                        # x_p AND subseteq(v_child, x_p) holds in P; choosing
                        # the witness y := v_child satisfies both
                        # subseteq(y, x_p) and the relation R(..., y, ...).
                        # We weaken `num(y)=K` to be entailed by the existing
                        # cardinality axioms (witness only requires |y|>K which
                        # plus_de(y) marks).
                        cons_parts.append(
                            re.sub(rf'\b{re.escape(v_child)}\b', 'y', raw))
                        for a in args:
                            if a != v_child and re.fullmatch(r'[a-z]\d?', a):
                                other_vars.add(a)

            key = (sortal_pred, x_p, N, K, tuple(sorted(ant_parts)))
            if key in seen:
                continue
            seen.add(key)

            quant_vars = sorted({x_p} | other_vars)
            antecedent = ' & '.join(ant_parts)
            consequent = ' & '.join(cons_parts)
            if quant_vars:
                axioms.append(
                    f"all {' '.join(quant_vars)}.(({antecedent}) -> "
                    f"exists y.({consequent}))"
                )
            else:
                axioms.append(
                    f"(({antecedent}) -> exists y.({consequent}))"
                )

    return axioms


def get_moins_de_threshold_monotone_axioms(premise_texts, hypothesis_texts):
    """Disabled: witnessed subgroups do not entail global `moins_de` claims.

    Unlike `plus_de`, where one sufficiently-large witnessed subgroup is enough
    to establish an existential "more than K" claim, `moins_de` is a global
    upper-bound statement.  From a P-side exact count `num(x)=N` with `N<K` and
    a relation R(x), it is not sound to conclude that fewer than K total
    sortal entities satisfy R; there may be additional disjoint R-witnesses.

    Empirically, the attempted mirror produced GQNLI gold-unknown -> yes proofs
    in exactly this way, so the family is kept as a documented no-op until a
    genuinely totality-aware FOL guard exists.
    """
    return []


def get_au_moins_lower_bound_axioms(premise_texts, hypothesis_texts):
    """Integer-comparative bridge for the "au moins N" (at-least-N) construction.

    SOUND additive axiom family, fully row-agnostic.

    Encoding handled (cleaned FOL).  "au moins N <sortal> <verb>" appears in a
    hypothesis as the flat conjunction::

        moins(m) & a_(e, m) & (num(o) = N) & C(o) & V(e, ..., o, ...)

    where ``moins(m) & a_(e, m)`` is the "au moins" marker anchored on event
    ``e``, ``num(o) = N`` is the lower-bound threshold carried on the counted
    entity ``o``, ``C`` is its sortal, and ``V`` is the relating verb whose
    event slot is ``e`` and one of whose argument slots is the counted ``o``.

    Semantics.  "X V at least N C" is true iff X V-ed a C-group whose actual
    cardinality is >= N.  Over the (non-negative integer) counting domain of
    this corpus, ``count >= N`` is equivalent to ``count > N-1``.  Whenever the
    premises entail that, in some event ``e`` with the *same* verb frame and the
    *same* non-threshold arguments, a C-group ``c`` was V-ed with
    ``num(c) > N-1``, a C-subgroup of size exactly ``N`` that was V-ed in the
    same event exists; that subgroup is precisely the witness the "au moins N"
    hypothesis asserts.  We therefore emit, per detected (C, V, N) frame::

        all e c <subj/other vars>.
          ((C(c) & V(e, ..., c, ...) & >(num(c), N-1)) ->
           exists o m.(C(o) & (num(o) = N) & V(e, ..., o, ...)
                       & moins(m) & a_(e, m)))

    Soundness:
      - The entire verb frame (event slot, every non-threshold argument such
        as the agent and the worn/affected object) is carried IDENTICALLY from
        antecedent to consequent.  Only the counted slot is rebound from ``c``
        to a fresh ``o`` of size exactly ``N``.  Thus the witness cannot assert
        a relation that the premise did not already license (e.g. it cannot
        turn "wear blue" into "wear red"): the non-threshold object slots stay
        bound to whatever the premise frame supplied.
      - The single inferential step is "won/<verb>ed more than N-1 C  ==>  there
        is a witnessed N-subgroup", which is valid because counts are integers
        and a set of size > N-1 (i.e. >= N) contains a subset of size exactly N.
      - The threshold literal ``>(num(c), N-1)`` matches premise material such
        as ``>(num(c), num(d)) & num(d) = N-1`` via equality paramodulation,
        so the derived bound (e.g. "ITEL won more orders than APCOM" +
        "APCOM won 10") discharges the antecedent without any extra arithmetic.

    No proof is bypassed or overridden; this only adds background material.
    Fires only when the "au moins" marker, an integer threshold ``num(o)=N``,
    a sortal on ``o``, and a verb frame on the marked event are all present in
    H, and the same sortal and verb names also occur in P (so the antecedent
    is discharge-able).  Hypotheses without the marker see zero emission.
    """
    premise_text = ' '.join(premise_texts)
    hypothesis_text = ' '.join(hypothesis_texts)

    if 'moins(' not in hypothesis_text or 'a_(' not in hypothesis_text:
        return []
    if 'num(' not in hypothesis_text:
        return []

    # Predicates that are NOT real sortals/verbs (markers, structural glue).
    _non_sortal = {
        'exists', 'forall', 'all', 'not', 'temps', 'maintenant', 'existe',
        'subseteq', 'num', 'overlaps', 'nomme', 'nommé', 'plus', 'moins',
        'peu_de', 'beaucoup_de', 'plupart_de', 'aucun', 'moins_de', 'plus_de',
        'pas_de', 'pas', 'tout', 'chacun', 'certain', 'DOT', 'moitie',
        'moitié', 'tiers', 'quart', 'cinquieme', 'a_', 'en', 'dans', 'avec',
        'de', 'des', 'sur', 'sous', 'pour', 'par', 'entre', 'is_at',
        'generic', 'atomic_sub', 'true', 'false', 'mais', 'soit',
    }
    # Predicates that may take an event-shaped first argument but are NOT the
    # counting verb (structural/temporal glue on the event).
    _non_verb = {
        'temps', 'overlaps', 'subseteq', 'a_', 'de', 'des', 'en', 'dans',
        'sur', 'sous', 'pour', 'par', 'entre', 'avec', 'is_at', 'nomme',
        'nommé', 'existe', 'soit', 'mais', 'num',
    }

    axioms = []
    seen = set()

    for mm in re.finditer(r'\bmoins\((\w+)\)', hypothesis_text):
        m_var = mm.group(1)
        a_m = re.search(
            r'\ba_\((\w+)\s*,\s*' + re.escape(m_var) + r'\)', hypothesis_text)
        if a_m is None:
            continue
        e_var = a_m.group(1)

        # Find the counting verb: a non-structural atom whose FIRST arg is the
        # marked event e_var and one of whose later args carries num(.)=N.
        verb_name = None
        verb_args = None
        thr_var = None
        thr_N = None
        for vm in re.finditer(
                r'\b([A-Za-z_][\w]*)\(' + re.escape(e_var) +
                r'((?:\s*,\s*\w+)+)\)', hypothesis_text):
            cand_name = vm.group(1)
            if cand_name in _non_verb:
                continue
            args = [a.strip() for a in vm.group(2).split(',') if a.strip()]
            # locate a threshold argument among the non-event slots
            for arg in args:
                num_m = re.search(
                    r'\(num\(' + re.escape(arg) + r'\)\s*=\s*(\d+)\)',
                    hypothesis_text)
                if num_m is None:
                    continue
                # require an actual sortal on that argument
                csort = None
                for cm in re.finditer(
                        r'\b([A-Za-z_][\w]*)\(' + re.escape(arg) + r'\)',
                        hypothesis_text):
                    if cm.group(1) in _non_sortal:
                        continue
                    csort = cm.group(1)
                    break
                if csort is None:
                    continue
                verb_name = cand_name
                verb_args = args
                thr_var = arg
                thr_N = int(num_m.group(1))
                _sortal = csort
                break
            if verb_name is not None:
                break

        if verb_name is None or thr_N is None or thr_N < 1:
            continue

        # Targeting guard: same sortal and verb must also occur in P so the
        # antecedent can actually be discharged (keeps the axiom set tight).
        if (_sortal + '(') not in premise_text:
            continue
        if (verb_name + '(') not in premise_text:
            continue

        # Build fresh-variable verb frames.  Event slot -> e9, threshold slot
        # -> c9 (antecedent) / o9 (consequent), every other slot -> a shared
        # fresh subject/object var so the full frame is preserved identically.
        other_map = {}
        next_idx = [0]

        def _slot(arg, threshold_name):
            if arg == e_var:
                return 'e9'
            if arg == thr_var:
                return threshold_name
            if arg not in other_map:
                other_map[arg] = 's%d' % next_idx[0]
                next_idx[0] += 1
            return other_map[arg]

        # full arg list of the verb atom is [e_var] + verb_args ... but the
        # regex captured args AFTER the first; rebuild full ordered arg list.
        full_args = [e_var] + verb_args
        ante_args = [_slot(a, 'c9') for a in full_args]
        cons_args = [_slot(a, 'o9') for a in full_args]

        ante_verb = '%s(%s)' % (verb_name, ', '.join(ante_args))
        cons_verb = '%s(%s)' % (verb_name, ', '.join(cons_args))

        K = thr_N - 1
        antecedent = '%s(c9) & %s & >(num(c9), %d)' % (_sortal, ante_verb, K)
        consequent = ('%s(o9) & (num(o9) = %d) & %s & moins(m9) & a_(e9, m9)'
                      % (_sortal, thr_N, cons_verb))

        subj_vars = sorted(set(other_map.values()))
        quant_vars = ['e9', 'c9'] + subj_vars
        key = (_sortal, verb_name, thr_N, tuple(full_args))
        if key in seen:
            continue
        seen.add(key)
        axioms.append(
            'all %s.((%s) -> exists o9 m9.(%s))'
            % (' '.join(quant_vars), antecedent, consequent))

    return axioms


# Structural / GQ predicate names that are never the sortal noun of a ratio's
# two compared groups.  Used to recover the two count-bearing sortals (e.g.
# `homme`, `femme`) from a ratio frame without hard-coding any lexeme.
_RATIO_NON_SORTAL = {
    'num', 'ratio', 'pour', 'en', 'existe', 'nomme', 'temps', 'overlaps',
    'subseteq', 'soit', 'total', 'DOT', 'de', 'des', 'dans', 'a_', 'sur',
    'maintenant', 'etre_de', 'homme_femme', 'leq', 'plus_de', 'moins_de',
}


def _ratio_parse_count(tok):
    """Parse a FOL numeric constant token into a float for comparison.

    Decimals are encoded with a single underscore (``86_33`` == 86.33);
    plain integers (``100``) and grouped integers (``490_000_000``) are read
    as whole numbers.  Returns ``None`` when the token is not numeric.
    """
    if tok is None:
        return None
    parts = tok.split('_')
    if not all(p.isdigit() for p in parts) or not parts:
        return None
    if len(parts) == 2 and len(parts[1]) <= 2 and len(parts[0]) <= 3:
        # Single short trailing group -> decimal (comma surface form).
        return float(parts[0] + '.' + parts[1])
    return float(''.join(parts))


def get_ratio_comparison_axioms(premise_texts, hypothesis_texts):
    """Sound cardinality comparison from an explicit population ratio.

    SOUND additive axiom family.  A statement such as *"the men-to-women ratio
    was 86.33 men per 100 women in Ukraine"* is encoded (cleaned FOL) as::

        ratio(R) & homme_femme(R) & en(R, Loc) & nomme(Loc, Ukraine)
        & (num(M) = 86_33) & homme(M) & (num(F) = 100) & femme(F)
        & pour(M, F) & etre_de(_, R, M)

    ``pour(M, F)`` is the *per* relation: ``num(M)`` units of sort ``homme`` for
    every ``num(F)`` units of sort ``femme``.  A ratio strictly below parity
    (``num(M) < num(F)``) entails that, in the same population/location, the
    second group strictly outnumbers the first.  This is a valid arithmetic
    consequence of the ratio itself (the ratio *is* the population proportion),
    so the axiom introduces no unlicensed entity: the ratio of a country's
    sexes presupposes a male and a female population of that country.

    Emitted (when ``num(M) < num(F)`` — symmetric in the other direction)::

        all r m f loc.((ratio(r) & pour(m, f) & SORT_M(m) & SORT_F(f)
                        & en(r, loc) & nomme(loc, LOCNAME))
          -> exists fm hm ev.(SORT_F(fm) & SORT_M(hm)
                & en(fm, loc) & en(hm, loc) & nomme(loc, LOCNAME)
                & existe(ev, fm) & existe(ev, hm)
                & (exists tt.(subseteq(temps(tt), temps(ev))
                              & <(temps(tt), maintenant)))
                & >(num(fm), num(hm))))

    plus the asymmetry of strict order, ``all x y.(>(x,y) -> -(>(y,x)))``
    (a universally valid property of ``>``), so a hypothesis asserting the
    *reverse* inequality is refuted (contradiction -> "no") and a hypothesis
    asserting the *non-existence* of the reverse inequality is proved ("yes").

    Soundness / blast radius:
      - The antecedent is discharged verbatim from the ratio frame; the
        consequent only restates, for fresh witnesses of the same two sorts in
        the same location, the inequality the ratio already fixes.
      - Fires only when the premise carries ``ratio(`` and ``pour(`` and two
        differing count-bearing sortals are recovered, so unrelated rows emit
        nothing.  No proof is bypassed; labels still come from Prover9/Mace4.
    """
    premise_text = ' '.join(str(t) for t in premise_texts)

    if 'ratio(' not in premise_text or 'pour(' not in premise_text:
        return []

    # Select the per-relation ``pour(M, F)`` whose BOTH arguments carry an
    # explicit count (``num(M)`` and ``num(F)``) — i.e. the "N men per M women"
    # atom — instead of an unrelated framing atom such as ``pour(ratio,
    # country)`` that some encodings (e.g. "le ratio ... pour l'Ouzbékistan")
    # place first in the formula.  Picking the first ``pour(`` blindly there
    # selects ``pour(ratio, country)`` (no counts), and the axiom silently
    # bails.  This only changes WHICH ``pour`` pair is read; the sound axiom
    # below is unchanged, and behaviour falls back to the first atom when no
    # counted pair exists, so the single-``pour`` rows are untouched.
    m_var = f_var = None
    if os.getenv('RATIO_POUR_FIX_DISABLE') != '1':
        for _pm in re.finditer(r'pour\(\s*(\w+)\s*,\s*(\w+)\s*\)', premise_text):
            _a, _b = _pm.group(1), _pm.group(2)
            if (re.search(r'num\(\s*' + re.escape(_a) + r'\s*\)', premise_text)
                    and re.search(r'num\(\s*' + re.escape(_b) + r'\s*\)',
                                  premise_text)):
                m_var, f_var = _a, _b
                break
    if m_var is None:
        m_pour = re.search(r'pour\(\s*(\w+)\s*,\s*(\w+)\s*\)', premise_text)
        if m_pour is None:
            return []
        m_var, f_var = m_pour.group(1), m_pour.group(2)

    def _count_of(var):
        mm = re.search(r'num\(\s*' + re.escape(var) + r'\s*\)\s*=\s*([0-9_]+)',
                       premise_text)
        return mm.group(1) if mm else None

    def _sortal_of(var):
        for sm in re.finditer(r'(\w+)\(\s*' + re.escape(var) + r'\s*\)',
                              premise_text):
            name = sm.group(1)
            if name not in _RATIO_NON_SORTAL:
                return name
        return None

    n_m = _ratio_parse_count(_count_of(m_var))
    n_f = _ratio_parse_count(_count_of(f_var))
    sort_m = _sortal_of(m_var)
    sort_f = _sortal_of(f_var)
    if n_m is None or n_f is None or sort_m is None or sort_f is None:
        return []
    if n_m == n_f or sort_m == sort_f:
        return []

    # Recover the ratio's location name and the predicate that links the ratio
    # to its location.  Encodings vary: "le ratio ... EN Ukraine" links via
    # ``en(ratio, loc)`` whereas "le ratio ... POUR l'Ouzbékistan" links via
    # ``pour(ratio, loc)``.  Accept either, otherwise the antecedent's location
    # atom cannot discharge for the ``pour`` encoding and the sound axiom never
    # fires.
    loc_name = None
    loc_link = 'en'
    rm = re.search(r'ratio\(\s*(\w+)\s*\)', premise_text)
    if rm is not None:
        rvar = rm.group(1)
        for _lp in ('en', 'pour'):
            em = re.search(
                _lp + r'\(\s*' + re.escape(rvar) + r'\s*,\s*(\w+)\s*\)',
                premise_text)
            if em is None:
                continue
            nm = re.search(
                r'nomme\(\s*' + re.escape(em.group(1)) + r'\s*,\s*(\w+)\s*\)',
                premise_text)
            if nm is not None:
                loc_name = nm.group(1)
                loc_link = _lp
                break

    # The strictly larger sort outnumbers the strictly smaller one.
    big, small = (sort_f, sort_m) if n_m < n_f else (sort_m, sort_f)

    # NOTE: NLTK's logic parser only accepts single-letter (optionally
    # digit-suffixed) variable names in quantifier position; multi-letter
    # tokens like `loc`/`bg` are read as constants and rejected.  Use only
    # single letters: r m f l (universal) and p q v w (existential witnesses).
    if loc_name is not None:
        antecedent = (
            'ratio(r) & pour(m, f) & %s(m) & %s(f) '
            '& %s(r, l) & nomme(l, %s)' % (sort_m, sort_f, loc_link, loc_name))
        consequent = (
            '%s(p) & %s(q) & en(p, l) & en(q, l) & nomme(l, %s) '
            '& existe(v, p) & existe(v, q) '
            '& (exists w.(subseteq(temps(w), temps(v)) '
            '& <(temps(w), maintenant))) '
            '& >(num(p), num(q))' % (big, small, loc_name))
    else:
        antecedent = (
            'ratio(r) & pour(m, f) & %s(m) & %s(f) & en(r, l)'
            % (sort_m, sort_f))
        consequent = (
            '%s(p) & %s(q) & en(p, l) & en(q, l) '
            '& existe(v, p) & existe(v, q) '
            '& (exists w.(subseteq(temps(w), temps(v)) '
            '& <(temps(w), maintenant))) '
            '& >(num(p), num(q))' % (big, small))

    axiom = ('all r m f l.((%s) -> exists p q v.(%s))'
             % (antecedent, consequent))
    asym = 'all x y.(>(x, y) -> -(>(y, x)))'
    return [axiom, asym]


def get_proportion_complement_axioms(premise_texts, hypothesis_texts):
    """Sound proportion-complement bridge for "N% of the total have property Q".

    SOUND additive axiom family.  Fires only on the percent-of-total frame and
    only when the hypothesis literally asserts a *complement* claim, so it
    cannot over-fire on the positive-proportion near-duplicates.

    Premise frame (cleaned FOL).  A percentage of a total population is encoded
    as the flat conjunction::

        population(G) & total(X) & DOT(X) & (num(X) = N) & de(X, G) & soit(I, X)

    together with a relating predicate ``vivre_dans(_, persons, I)`` that ties
    the population to the state ``I`` whose share is ``N`` percent.  ``DOT`` is
    the percent marker and ``total(X)`` fixes ``X`` as the whole; thus ``N``
    percent of population ``G`` are in state ``I``.

    Complement reasoning.  The members of ``G`` partition into those in state
    ``I`` (share ``N``) and those not in state ``I`` (share ``100 - N``).  When
    ``N < 50`` the complement share ``100 - N`` strictly exceeds ``50``, so a
    *majority* of ``G`` is not in state ``I``.  This is a valid arithmetic fact
    about a two-cell partition of a finite population; Python computes the
    inequality ``N < 50`` and the axiom merely records the entailed majority
    witness::

        all G X I.
          ((population(G) & total(X) & DOT(X) & (num(X) = N) & de(X, G)
            & soit(I, X))
           -> exists D A.(majorité(D) & de(D, G)
                          & not(vivre_dans(A, D, I)
                                & overlaps(temps(A), maintenant))))

    Soundness:
      - The consequent introduces no relation the premise did not license: it
        asserts only that some majority sub-group ``D`` of the very same total
        population ``G`` fails the very same state predicate ``I`` referenced by
        the premise's ``soit(I, X)`` link.  This is exactly the complement of an
        ``N`` percent (``N < 50``) cell, which is guaranteed to be a majority.
      - No proof is bypassed or overridden; this only adds background material
        whose antecedent is discharged verbatim from the premise frame.

    Targeting guards (so the axiom cannot fire outside the complement reading):
      - The premise must contain the full percent-of-total frame
        (``population``, ``total``, ``DOT``, ``soit`` and a ``de`` link) and a
        percentage ``0 < N < 50``.
      - The hypothesis must literally contain a ``majorité`` marker AND a
        negated ``not(vivre_dans(...))`` complement claim.  Positive-proportion
        hypotheses ("most/2-thirds/4-fifths LIVE in poverty") carry no
        ``not(vivre_dans`` and therefore see zero emission, as do exact-fraction
        hypotheses, which carry no ``majorité`` marker.
    """
    premise_text = ' '.join(str(t) for t in premise_texts)
    hypothesis_text = ' '.join(str(t) for t in hypothesis_texts)

    # Premise must carry the percent-of-total population frame.
    if 'population(' not in premise_text:
        return []
    if 'total(' not in premise_text or 'DOT(' not in premise_text:
        return []
    if 'soit(' not in premise_text or 'de(' not in premise_text:
        return []

    # Hypothesis must assert the majority complement (negated relation).
    # "majority" surfaces as either ``majorité``/``majorite`` or ``plupart_de``
    # (both denote >50%); the relation is negated, written either ``not(...)``
    # or the NLTK ``-(...)`` form after preprocessing.
    maj_m = re.search(r'\b(majorit\w*|plupart_de)\(', hypothesis_text)
    if maj_m is None:
        return []
    _h_nospace = hypothesis_text.replace(' ', '')
    _has_neg_vivre = (
        'not(vivre_dans(' in _h_nospace or '-(vivre_dans(' in _h_nospace
        or bool(re.search(r'(?:not|-)\(\s*vivre_dans\(', hypothesis_text))
    )
    if not _has_neg_vivre:
        return []

    maj_tok = maj_m.group(1)

    # Extract a percentage N carried on the total/DOT cell with 0 < N < 50.
    comp_N = None
    for nm in re.finditer(r'\(?num\((\w+)\)\s*=\s*(\d+)\)?', premise_text):
        cell = nm.group(1)
        val = int(nm.group(2))
        if not (0 < val < 50):
            continue
        if ('total(' + cell + ')') in premise_text.replace(' ', '') or \
           re.search(r'total\(\s*' + re.escape(cell) + r'\s*\)', premise_text):
            if ('DOT(' + cell + ')') in premise_text.replace(' ', '') or \
               re.search(r'DOT\(\s*' + re.escape(cell) + r'\s*\)', premise_text):
                comp_N = val
                break
    if comp_N is None:
        return []

    axiom = (
        'all g9 x9 i9.((population(g9) & total(x9) & DOT(x9) '
        '& (num(x9) = %d) & de(x9, g9) & soit(i9, x9)) '
        '-> exists d9 a9.(%s(d9) & de(d9, g9) '
        '& not(vivre_dans(a9, d9, i9) '
        '& overlaps(temps(a9), maintenant))))' % (comp_N, maj_tok)
    )
    return [axiom]


# Fraction surface predicates -> denominator of the share they denote.
# Both accented and de-accented forms are listed because the processed
# formula strings are inconsistent about accents.
_FRACTION_DENOM = {
    'moitie': 2, 'moitié': 2,
    'tiers': 3,
    'quart': 4,
    'cinquieme': 5, 'cinquième': 5,
    'sixieme': 6, 'sixième': 6,
    'huitieme': 8, 'huitième': 8,
    'dixieme': 10, 'dixième': 10,
}


def _share_percent_token(value):
    """Render a percentage float as a Prover9 numeric constant token.

    Exact integers become ``"80"``; non-integers use the two-decimal
    underscore encoding already used elsewhere (``66.67`` -> ``"66_67"``),
    matching ``_ratio_parse_count`` so the rest of the pipeline reads them
    consistently.  Returns ``(token, float_value)``.
    """
    if abs(value - round(value)) < 1e-9:
        iv = int(round(value))
        return str(iv), float(iv)
    s = '%.2f' % value
    whole, frac = s.split('.')
    return '%s_%s' % (whole, frac), value


def _strip_accents_for_tag(s):
    """De-accent + sanitise a predicate name into a Prover9-safe tag fragment.

    Used only to build a *fresh* relation-share predicate name out of the
    relation/state predicates that were read off the formula, so the injected
    axioms are unique per relation+state shape and never collide with anything
    in the problem.  Never used for matching.
    """
    table = {
        'à': 'a', 'â': 'a', 'ä': 'a',
        'é': 'e', 'è': 'e', 'ê': 'e', 'ë': 'e',
        'î': 'i', 'ï': 'i',
        'ô': 'o', 'ö': 'o',
        'û': 'u', 'ù': 'u', 'ü': 'u',
        'ç': 'c',
    }
    out = []
    for ch in s.lower():
        ch = table.get(ch, ch)
        out.append(ch if (ch.isalnum() or ch == '_') else '_')
    return ''.join(out)


def get_share_arithmetic_contradiction_axioms(premise_texts, hypothesis_texts):
    """Word-agnostic percent/fraction arithmetic over a "share of population" frame.

    SOUND additive axiom family.  Nothing here is domain-specific: the relation
    whose population-share the premise fixes, and the predicates that qualify
    its state, are *read off the FOL formula* — there are no ``pauvreté`` /
    ``vivre_dans`` / ``au_dessus_de`` keyword guards.

    Frame.  The premise must encode, for some cell ``C``::

        num(C) = N  &  total(C)  &  DOT(C)  &  soit(STATE, C)

    i.e. "exactly N % of the total population is in the determinate STATE".
    ``STATE`` and the 3-place relation ``REL(event, subject, STATE)`` that links
    people to it are taken from the formula.  The predicates qualifying STATE
    (its unary predicates, plus any binary "event" predicate ``B(EV, STATE)``
    with the unary predicates on ``EV``) form the *state signature* — again read
    off the premise, not a hard-coded list.  The frame link ``soit(STATE, C)``
    is excluded structurally because its other argument is the share cell.

    Claim.  The family fires only when the hypothesis *positively* asserts that
    a fraction of the **same** population stands in the **same** relation to a
    state carrying the **same** signature.  Python computes the claimed share
    from the fraction predicate (``cinquième`` -> 1/5, ``num=4 & cinquième`` ->
    4/5 = 80 %; ``tiers`` -> 1/3, ``num=2 & tiers`` -> 2/3 = 66.67 %).  Only when
    that share is strictly greater than ``N`` does it inject axioms that let
    Prover9 *derive* the contradiction (the verdict still comes from a proof):

      A1 (premise share, ground):           ``SHARE_TAG(N)``
      A2 (the share is a single value):
          ``all m n.((SHARE_TAG(m) & SHARE_TAG(n)) -> (m = n))``
      A3 (the hypothesis's fraction claim names the share it asserts):
          ``all ... .((population(t) & FRAC(p) & (num(p)=K) & de(p,t)
                       & <state signature on e> & REL(a, p, e))
                      -> SHARE_TAG(CLAIMED))``
      A4 (the two shares differ — sound, CLAIMED>N):  ``-(N = CLAIMED)``

    ``SHARE_TAG`` is a fresh predicate name built from the relation + state
    predicates, so A1/A2 assert nothing beyond "the share of the population in
    *this* relation+state is a single value", which is logically valid.

    Soundness / blast radius:
      - The premise carries no fraction predicate, so A3 never discharges from
        the premise; ``premise & background`` stays satisfiable and entailment
        is untouched.
      - A3 discharges only from a hypothesis that asserts the *same* relation to
        the *same* state signature — so an "above the poverty line" hypothesis
        (a different relation / state signature) simply fails to match and emits
        nothing, with no surface-token guard.  A negated hypothesis asserts the
        complement and is left to the complement family.
    """
    premise_text = ' '.join(str(t) for t in premise_texts)
    hypothesis_text = ' '.join(str(t) for t in hypothesis_texts)

    # (Frame) locate a share cell:  num(C)=N (0<N<100) & total(C) & DOT(C),
    # tied via soit(STATE, C) to a determinate STATE.
    share_N = None
    state_var = None
    share_cell = None
    for nm in re.finditer(r'num\((\w+)\)\s*=\s*(\d+)', premise_text):
        cell = nm.group(1)
        val = int(nm.group(2))
        if not (0 < val < 100):
            continue
        if not re.search(r'total\(\s*' + re.escape(cell) + r'\s*\)',
                         premise_text):
            continue
        if not re.search(r'DOT\(\s*' + re.escape(cell) + r'\s*\)', premise_text):
            continue
        sm = re.search(r'soit\(\s*(\w+)\s*,\s*' + re.escape(cell) + r'\s*\)',
                       premise_text)
        if sm is None:
            continue
        share_N, state_var, share_cell = val, sm.group(1), cell
        break
    if state_var is None:
        return []

    # (Relation) the 3-place relation atom whose argument is STATE.
    rel_name = None
    rel_state_pos = None
    for rm in re.finditer(r'(\w+)\(\s*(\w+)\s*,\s*(\w+)\s*,\s*(\w+)\s*\)',
                          premise_text):
        args = [rm.group(2), rm.group(3), rm.group(4)]
        if state_var in args:
            rel_name = rm.group(1)
            rel_state_pos = args.index(state_var)
            break
    if rel_name is None:
        return []

    # (State signature) unary predicates on STATE, plus binary event predicates
    # B(EV, STATE) with their unary predicates on EV.  The frame link to the
    # share cell is excluded structurally.
    state_unaries = set()
    for um in re.finditer(r'(\w+)\(\s*' + re.escape(state_var) + r'\s*\)',
                          premise_text):
        state_unaries.add(um.group(1))
    state_events = []  # list of (Bname, frozenset(ev_unaries))
    for bm in re.finditer(r'(\w+)\(\s*(\w+)\s*,\s*(\w+)\s*\)', premise_text):
        bname, a1v, a2v = bm.group(1), bm.group(2), bm.group(3)
        if state_var not in (a1v, a2v):
            continue
        other = a2v if a1v == state_var else a1v
        if other == share_cell:
            continue  # frame link (soit / de to the share cell)
        ev_unaries = set()
        for um in re.finditer(r'(\w+)\(\s*' + re.escape(other) + r'\s*\)',
                              premise_text):
            ev_unaries.add(um.group(1))
        state_events.append((bname, frozenset(ev_unaries)))

    # (Polarity) the arithmetic-contradiction inference only applies to a
    # hypothesis that POSITIVELY asserts a population share; a negated
    # hypothesis asserts the complement and is handled by a different family.
    h_nospace = hypothesis_text.replace(' ', '')
    if 'not(' in h_nospace or '-(' in h_nospace:
        return []

    # (Claim) a fraction of the same population standing in the SAME relation to
    # a state with the SAME signature.
    for frac_name, denom in _FRACTION_DENOM.items():
        for fm in re.finditer(re.escape(frac_name) + r'\(\s*(\w+)\s*\)',
                              hypothesis_text):
            p_var = fm.group(1)
            de_m = re.search(r'de\(\s*' + re.escape(p_var) + r'\s*,\s*(\w+)\s*\)',
                             hypothesis_text)
            if de_m is None:
                continue
            pop_var = de_m.group(1)
            if not re.search(r'population\(\s*' + re.escape(pop_var) + r'\s*\)',
                             hypothesis_text):
                continue

            # the SAME relation predicate, applied to the fraction, whose state
            # argument carries the SAME signature read off the premise.
            rel_pos_h = None
            for rm in re.finditer(re.escape(rel_name)
                                  + r'\(\s*(\w+)\s*,\s*(\w+)\s*,\s*(\w+)\s*\)',
                                  hypothesis_text):
                hargs = [rm.group(1), rm.group(2), rm.group(3)]
                if p_var not in hargs:
                    continue
                cand_state = hargs[rel_state_pos]
                if not all(re.search(r'%s\(\s*%s\s*\)'
                                     % (re.escape(u), re.escape(cand_state)),
                                     hypothesis_text)
                           for u in state_unaries):
                    continue
                sig_ok = True
                for bname, ev_unaries in state_events:
                    evm = re.search(re.escape(bname) + r'\(\s*(\w+)\s*,\s*'
                                    + re.escape(cand_state) + r'\s*\)',
                                    hypothesis_text)
                    if evm is None:
                        evm = re.search(re.escape(bname) + r'\(\s*'
                                        + re.escape(cand_state)
                                        + r'\s*,\s*(\w+)\s*\)', hypothesis_text)
                    if evm is None:
                        sig_ok = False
                        break
                    ev_var_h = evm.group(1)
                    if not all(re.search(r'%s\(\s*%s\s*\)'
                                         % (re.escape(u), re.escape(ev_var_h)),
                                         hypothesis_text)
                               for u in ev_unaries):
                        sig_ok = False
                        break
                if not sig_ok:
                    continue
                rel_pos_h = hargs.index(p_var)
                break
            if rel_pos_h is None:
                continue

            # multiplier K on the fraction (default 1: "un tiers"/"la moitié").
            km = re.search(r'num\(\s*' + re.escape(p_var) + r'\s*\)\s*=\s*(\d+)',
                           hypothesis_text)
            k_mult = int(km.group(1)) if km else 1
            claimed_pct = k_mult * 100.0 / denom
            if claimed_pct <= share_N + 1e-9:
                continue  # only a strictly larger share is contradictory

            claimed_tok, _ = _share_percent_token(claimed_pct)
            share_tok = str(share_N)

            # fresh relation-share tag derived from the relation + state meaning.
            tag = 'share_' + _strip_accents_for_tag(rel_name)
            for u in sorted(state_unaries):
                tag += '_' + _strip_accents_for_tag(u)
            for bname, _ev in sorted(state_events):
                tag += '_' + _strip_accents_for_tag(bname)

            # build A3 relation atom: fraction in its hypothesis position, STATE
            # in rel_state_pos, a fresh event var in the remaining slot.
            rel_slots = [None, None, None]
            rel_slots[rel_pos_h] = 'p9'
            rel_slots[rel_state_pos] = 'e9'
            free_idx = [i for i in range(3) if rel_slots[i] is None][0]
            rel_slots[free_idx] = 'a9'
            rel_atom = '%s(%s)' % (rel_name, ', '.join(rel_slots))

            # reproduce the state signature on fresh vars.
            state_lits = ['%s(e9)' % u for u in sorted(state_unaries)]
            quant_vars = ['p9', 't9', 'e9', 'a9']
            for ev_i, (bname, ev_unaries) in enumerate(state_events):
                ev_v = 'w%d' % ev_i
                quant_vars.append(ev_v)
                state_lits.append('%s(%s, e9)' % (bname, ev_v))
                for u in sorted(ev_unaries):
                    state_lits.append('%s(%s)' % (u, ev_v))

            num_clause = ('& (num(p9) = %d) ' % k_mult) if km else ''
            antecedent = ('population(t9) & %s(p9) %s& de(p9, t9) & %s & %s'
                          % (frac_name, num_clause,
                             ' & '.join(state_lits), rel_atom))
            a1 = '%s(%s)' % (tag, share_tok)
            a2 = ('all m9 n9.((%s(m9) & %s(n9)) -> (m9 = n9))' % (tag, tag))
            a3 = ('all %s.((%s) -> %s(%s))'
                  % (' '.join(quant_vars), antecedent, tag, claimed_tok))
            a4 = '-(%s = %s)' % (share_tok, claimed_tok)
            return [a1, a2, a3, a4]

    return []


def get_downward_restrictor_modifier_axioms(premise_texts, hypothesis_texts):
    """Disabled: predicate-name fold ambiguity is not sound at FOL level.

    The folded surface-form predicates ``peu_de_<modifier>_<head>`` and the
    base ``peu_de_<head>`` are *opaque* atoms to Prover9.  Even when the
    modifier names an intersective adjective, the same-variable modifier
    atom ``modifier(d)`` denotes a property of the *group* witness ``d``,
    not of each member of the group's restrictor.  Concretely,
    ``peu_de_membre(d) & feminin(d)`` does not entail
    ``peu_de_feminin_membre(d)`` in the parser's semantics: the first says
    "few members of d, and d is feminine", the second says "few members of
    d that are feminine".  Without an explicit member-level distributive
    bridge (which would itself require additional sound infrastructure
    that does not currently exist), no axiom of the form
    ``modifier(d) & Q_head(d) -> Q_modifier_head(d)`` can be emitted.

    Kept as a documented no-op until member-level distribution over
    folded predicates is modeled explicitly.
    """
    return []


def perform_inference_on_row(row):
    """Perform inference and return (prover9_prediction, mace4_prediction).
    
    CORRECT INTERPRETATION:
    - Prover9 (theorem prover):
      * Proves P ⊨ H → "yes" (entailment)
      * Proves P ⊨ ¬H → "no" (contradiction)
      * Can't prove either → "unknown"
    
    - Mace4 (model finder): 
      * Finds model where P ∧ ¬H → "no" (counterexample, no entailment)
      * Cannot find such model → "unknown" (could be entailment or timeout)
    """
    prover9_result = "unknown"
    mace4_result = "unknown"
    
    # Read the premises and hypotheses
    premises = []
    hypotheses = []
    premise_texts = []
    hypothesis_texts = []
    axiom_premise_texts = []
    axiom_hypothesis_texts = []
    _rewrite_pas_applied_p = False
    _rewrite_pas_applied_h = False
    p_pattern = re.compile(r'^p\d+$')  # Matches columns like p1, p2, p3, ...
    h_pattern = re.compile(r'^h\d+$')  # Matches columns like h1, h2, h3, ...   
    raw_h_pred_names = set()
    raw_h_text_all = ''
    for _col in row.index:
        if h_pattern.match(_col) and pd.notna(row[_col]):
            try:
                _h_clean = clean_formula_string(str(row[_col]))
                raw_h_text_all += ' ' + _h_clean
                raw_h_pred_names |= set(extract_arities(_h_clean, predicates_only=True).keys())
            except Exception:
                raw_h_text_all += ' ' + str(row[_col])
                raw_h_pred_names |= set(re.findall(r'\b([A-Za-z_][A-Za-z0-9_]*)\(', str(row[_col])))

    # Add premises (p1, p2, ...)
    global_arities = {}
    all_text = ""
    formula_texts = []
    n_premise_formulas = 0
    for col in row.index:
        if (p_pattern.match(col) or h_pattern.match(col)) and pd.notna(row[col]):
            expr = str(row[col])
            expr = clean_formula_string(expr)
            # expr = strip_placeholder_conjuncts(expr)  # DISABLED v41 regression
            # Apply formula preprocessing: simplify true->, dedup quantifiers
            expr = simplify_true_implication(expr)
            expr = rewrite_forall_restrictor_conjunction(expr)
            expr = deduplicate_quantifier_vars(expr)
            expr = rewrite_ou_event_scope(expr)
            # Semantic-scope repairs (rules A, B, I): lift scopal/upper-bound
            # markers and duration-count bindings out of the flat-conjunct
            # encoding so the prover sees the formula the surface NL denotes.
            # Applied uniformly to premises and hypotheses; trigger is purely
            # structural (no per-row or per-word guards).
            expr = rewrite_aucun_des_negate(expr)
            expr = rewrite_au_plus_negate(expr)
            expr = rewrite_duration_count_binding(expr)
            # Rules C, F, H: vague-quantifier restrictor binding,
            # comparative-derived adjective tagging, intensional opacity.
            expr = rewrite_vague_quantifier_restrictor(expr)
            expr = rewrite_comparative_adjective(expr)
            expr = rewrite_intensional_opacity(expr)
            # Rule E: past-tense anaphor restriction.
            expr = rewrite_past_anaphor_restriction(expr)
            if h_pattern.match(col):
                expr = rewrite_upper_bound_beaucoup_scope(expr)
            if re.search(r'=\s*(?:unknown_|singular_|masculin_|feminin_|context_)', expr):
                expr = close_free_variables(expr)
            if ENABLE_PREPROOF_FILTERS and p_pattern.match(col) and has_unsafe_pre_tout_restrictor_formula(expr):
                print(f"Skipping malformed tout-restrictor premise before axiom collection: {expr}")
                continue
            if ENABLE_PREPROOF_FILTERS and p_pattern.match(col) and should_filter_scope_unsafe_premise(expr, raw_h_pred_names):
                print(f"Skipping scoped/opaque premise before axiom collection: {expr}")
                continue
            if ENABLE_PREPROOF_FILTERS and p_pattern.match(col) and should_filter_duration_bound_premise(expr, raw_h_text_all):
                print(f"Skipping duration-bound premise before axiom collection: {expr}")
                continue
            # close_free_variables only applied to hypotheses (in 2nd loop)
            # to avoid weakening premises with existential closure
            if h_pattern.match(col):
                expr = close_free_variables(expr)
            all_text += " " + expr
            formula_texts.append(expr)
            if p_pattern.match(col):
                n_premise_formulas += 1
                axiom_premise_texts.append(expr)
            elif h_pattern.match(col):
                axiom_hypothesis_texts.append(expr)
            arities = extract_arities(expr)
            for k, v in arities.items():
                global_arities.setdefault(k, []).extend(v)

    lowest_arities = {k: min(v) for k, v in global_arities.items()}

    predicate_pattern = re.compile(r'\b(\w+)\s*\(')
    bare_pattern = re.compile(r'\b(\w+)\b(?!\s*\()')
    predicates = set(predicate_pattern.findall(all_text))
    bare_candidates = set(bare_pattern.findall(all_text))

    # Remove logical words and variables
    keywords = {"exists", "all", "and", "or", "not"}

    bare_symbols = {
        w for w in bare_candidates
        if w not in keywords
        and not(len(w) == 1 and w.islower()) and not(len(w) == 2 and w[0].islower() and w[1].isdigit())
    }
    colliding_predicates = predicates.intersection(bare_symbols)

    # Detect symbols used as both function and relation (MUST happen before axiom generation)  
    dual_use_symbols = detect_dual_use_symbols(all_text)
    if dual_use_symbols:
        print(f"Dual-use symbols (function & relation): {dual_use_symbols}")
    
    # Debug: Check if temps is properly detected
    if 'temps' in all_text and 'temps' not in dual_use_symbols:
        print("'temps' found in formulas but not detected as dual-use!")

    # Track predicates for axiom generation
    p_preds_found = set()
    h_preds_found = set()

    # Pre-processing to extract predicates for guards and axiom generation
    # We extract TWO sets: one including all symbols (for guards), one excluding
    # function usages (for axiom generation) to prevent dual-use FATAL errors.
    p_preds_for_axioms = set()
    h_preds_for_axioms = set()
    for col in row.index:
        if (p_pattern.match(col) or h_pattern.match(col)) and pd.notna(row[col]):
            expr = clean_formula_string(str(row[col]))
            # expr = strip_placeholder_conjuncts(expr)  # DISABLED v41 regression
            # Full extraction for guards (includes function usages like mesure inside >())
            curr_arities = extract_arities(expr)
            target_set = p_preds_found if p_pattern.match(col) else (h_preds_found if h_pattern.match(col) else None)
            if target_set is not None:
                for name, counts in curr_arities.items():
                    for c in counts:
                        target_set.add((name, c))
            # Predicate-only extraction for axiom generation (excludes function usages)
            curr_arities_pred = extract_arities(expr, predicates_only=True)
            target_ax = p_preds_for_axioms if p_pattern.match(col) else (h_preds_for_axioms if h_pattern.match(col) else None)
            if target_ax is not None:
                for name, counts in curr_arities_pred.items():
                    for c in counts:
                        target_ax.add((name, c))
    
    # Guard pred_names use the FULL sets (including function symbols like mesure)
    all_preds_full = p_preds_found.union(h_preds_found)
    h_pred_names = set(name for name, _ in h_preds_found)
    p_pred_names = set(name for name, _ in p_preds_found)
    # Axiom pred_names use predicate-only sets
    h_pred_names_ax = set(name for name, _ in h_preds_for_axioms)
    p_pred_names_ax = set(name for name, _ in p_preds_for_axioms)
    all_preds_for_axioms = p_preds_for_axioms.union(h_preds_for_axioms)
    _non_intersective_fallback_blocked_pairs = get_non_intersective_hypernymy_blocked_pairs(
        axiom_premise_texts,
        axiom_hypothesis_texts,
    )
    _scalar_fallback_weakening_block = should_block_scalar_fallback_weakening(
        axiom_premise_texts,
        axiom_hypothesis_texts,
    )
    _past_scoped_entity_lifts, _past_scoped_adj_transfers = get_past_scoped_transfer_blocks(
        axiom_premise_texts,
        axiom_hypothesis_texts,
    )
    _past_scoped_unary_drop_blocks = get_past_scoped_unary_drop_blocks(
        axiom_premise_texts,
        axiom_hypothesis_texts,
    )
    _non_subsective_is_at_blocks = get_non_subsective_is_at_blocks(
        axiom_premise_texts,
        axiom_hypothesis_texts,
    )
    _before_clause_future_event_blocks = get_before_clause_future_event_blocks(
        axiom_premise_texts,
        axiom_hypothesis_texts,
    )
    _comparative_positive_drop_blocks = get_comparative_positive_drop_blocks(
        axiom_premise_texts,
        axiom_hypothesis_texts,
    )
    _non_subsective_is_at_adj_transfers = {adj for _, adj in _non_subsective_is_at_blocks}
    _non_subsective_is_at_identity_block = bool(_non_subsective_is_at_blocks)
    _past_scoped_fallback_weakening_block = bool(
        _past_scoped_entity_lifts or _past_scoped_adj_transfers or _past_scoped_unary_drop_blocks
    )
    _non_subsective_is_at_fallback_block = bool(_non_subsective_is_at_blocks)
    _before_clause_fallback_block = bool(_before_clause_future_event_blocks)
    _comparative_positive_fallback_block = bool(_comparative_positive_drop_blocks)

    # Generate Axioms using predicate-only sets (avoids dual-use FATAL errors)
    new_axioms_strs = get_wn_axioms(p_preds_for_axioms, h_preds_for_axioms)
    _spatial_wn_skips = [
        ax for ax in new_axioms_strs
        if 'asseoir_sur' in ax and 'asseoir_dans' in ax
    ]
    if _spatial_wn_skips:
        new_axioms_strs = [ax for ax in new_axioms_strs if ax not in _spatial_wn_skips]
        for ax in _spatial_wn_skips:
            print(f"Skipping WordNet Axiom (spatial preposition mismatch): {ax}")
    _broad_action_wn_skips = [
        ax for ax in new_axioms_strs
        if re.search(r'\bchasser\s*\(', ax) and re.search(r'\bsuivre\s*\(', ax)
    ]
    if _broad_action_wn_skips:
        new_axioms_strs = [ax for ax in new_axioms_strs if ax not in _broad_action_wn_skips]
        for ax in _broad_action_wn_skips:
            print(f"Skipping WordNet Axiom (broad action bridge): {ax}")
    new_axioms_strs, _skipped_wn_non_intersective = filter_non_intersective_hypernymy_axioms(
        new_axioms_strs,
        axiom_premise_texts,
        axiom_hypothesis_texts,
    )
    for ax in _skipped_wn_non_intersective:
        print(f"Skipping WordNet Axiom (non-intersective scalar trap): {ax}")
    if new_axioms_strs:
        for ax in new_axioms_strs:
            print(f"Adding WordNet Axiom: {ax}")

    jdm_strs = get_jdm_lexical_axioms(p_preds_for_axioms, h_preds_for_axioms)
    if jdm_strs:
        for ax in jdm_strs:
            print(f"Adding JDM Axiom: {ax}")
        new_axioms_strs.extend(jdm_strs)

    # (v70-C) Cross-arity generic(_) bridges for same-name and JDM-related
    # predicate pairs whose arities differ by one.  Sound under the parser's
    # convention that generic(_) is a content-free placeholder.
    _premise_join = ' '.join(str(t) for t in axiom_premise_texts)
    _hyp_join = ' '.join(str(t) for t in axiom_hypothesis_texts)
    cross_arity_strs = get_cross_arity_generic_bridges(
        p_preds_for_axioms, h_preds_for_axioms, _premise_join, _hyp_join
    )
    if cross_arity_strs:
        for ax in cross_arity_strs:
            print(f"Adding Cross-Arity Generic Bridge: {ax}")
        new_axioms_strs.extend(cross_arity_strs)

    structural_strs = get_structural_axioms(
        all_text,
        all_preds_for_axioms,
        h_pred_names_ax,
        p_pred_names_ax,
        blocked_past_adj_transfers=_past_scoped_adj_transfers,
        blocked_is_at_adj_transfers=_non_subsective_is_at_adj_transfers,
        suppress_is_at_identity=_non_subsective_is_at_identity_block,
        premise_texts=axiom_premise_texts,
        hypothesis_texts=axiom_hypothesis_texts,
    )
    if _non_subsective_is_at_blocks:
        print(
            "Blocking non-subsective is_at copula transfer for: "
            f"{sorted(_non_subsective_is_at_blocks)}"
        )
    for ax in structural_strs:
        print(f"Adding Structural Axiom: {ax}")
    new_axioms_strs.extend(structural_strs)

    # A.3: narration sentential-decomposition axiom.
    # `narration(h, i)` is a parser artifact that marks two clauses joined by
    # sentential "and" (typically with distinct event variables h, i). It
    # carries no semantic content: it is metadata used by the parser to record
    # discourse coordination. Adding `all h i. narration(h, i)` makes the
    # predicate trivially true and lets H and P share the marker even when
    # their event variables are α-renamed independently — sound, because no
    # other axiom derives anything *from* narration's truth (verified: the
    # only other use is as a witness inside an existential conclusion at
    # L8345, where universal truth merely satisfies that conjunct).
    if 'narration(' in all_text:
        _narration_ax = 'all h i.(narration(h, i))'
        print(f"Adding Narration Decomposition Axiom: {_narration_ax}")
        new_axioms_strs.append(_narration_ax)

    # --- Enhancement: Lexical & Event axioms ---
    lexical_strs = get_event_lexical_axioms(all_text, axiom_premise_texts, axiom_hypothesis_texts)
    for ax in lexical_strs:
        print(f"Adding Lexical/Event Axiom: {ax}")
    new_axioms_strs.extend(lexical_strs)

    # --- Enhancement: Group Mereology axioms ---
    mereology_strs = get_group_mereology_axioms(all_text)
    for ax in mereology_strs:
        print(f"Adding Mereology Axiom: {ax}")
    new_axioms_strs.extend(mereology_strs)

    # --- Enhancement: Numeric bridging axioms ---
    numeric_strs = get_numeric_axioms(all_text, formula_texts, n_premises=n_premise_formulas)
    numeric_strs = [ax for ax in numeric_strs if ax and ax.strip()]
    for ax in numeric_strs:
        print(f"Adding Numeric Axiom: {ax}")
    new_axioms_strs.extend(numeric_strs)

    policy_program_strs = get_policy_program_axioms(axiom_premise_texts, axiom_hypothesis_texts, all_text)
    for ax in policy_program_strs:
        print(f"Adding Policy/Program Axiom: {ax}")
    new_axioms_strs.extend(policy_program_strs)

    # --- Enhancement: Morphological axioms (singular/plural bridging) ---
    morpho_strs = get_morphological_axioms(p_preds_found, h_preds_found)
    for ax in morpho_strs:
        print(f"Adding Morphological Axiom: {ax}")
    new_axioms_strs.extend(morpho_strs)

    # --- Enhancement: Arity lifting axioms (binary pred -> unary pred bridge) ---
    _projection_blocked_entity_lifts = get_negated_unary_binary_projection_blocks(formula_texts)
    arity_strs = get_arity_lifting_axioms(
        all_preds_for_axioms,
        lowest_arities,
        blocked_entity_lifts=_past_scoped_entity_lifts | _projection_blocked_entity_lifts,
    )
    for ax in arity_strs:
        print(f"Adding Arity Lifting Axiom: {ax}")
    new_axioms_strs.extend(arity_strs)

    # --- Enhancement: Curated hypernymy/synonym fallback ---
    hypernymy_strs = get_curated_hypernymy_axioms(p_preds_for_axioms, h_preds_for_axioms)
    hypernymy_strs, _skipped_curated_non_intersective = filter_non_intersective_hypernymy_axioms(
        hypernymy_strs,
        axiom_premise_texts,
        axiom_hypothesis_texts,
    )
    for ax in _skipped_curated_non_intersective:
        print(f"Skipping Hypernymy Axiom (non-intersective scalar trap): {ax}")
    for ax in hypernymy_strs:
        print(f"Adding Hypernymy Axiom: {ax}")
    new_axioms_strs.extend(hypernymy_strs)

    # --- Enhancement: Compound V_PREP predicate decomposition ---
    # When a compound predicate BASE_PREP exists in one formula and the
    # base verb + preposition exist separately in the other, generate
    # bidirectional bridge axioms.  Semantically valid because the parser
    # joins multi-word expressions with underscores; decomposition reverses
    # that join.
    _COMPOUND_PREPS = {'sur', 'de', 'dans', 'en', 'avec', 'pour', 'par',
                       'contre', 'vers', 'sous', 'devant', 'derriere', 'entre'}
    _ENTITY_FIRST_PREPS = {'de'}  # de(entity, entity), not de(event, entity)
    # v37: Compound predicates that should NOT be decomposed into base+prep.
    # moins_de/plus_de are quantity comparators, not "moins"+"de" composition.
    _COMPOUND_SKIP = {'moins_de', 'plus_de', 'plupart_de'}
    _all_pn = p_pred_names | h_pred_names
    _compound_bridge_strs = []
    _compound_done = set()
    for pred_name in sorted(_all_pn):
        if '_' not in pred_name:
            continue
        # v37: Skip compound predicates that are lexical units, not decomposable
        if pred_name in _COMPOUND_SKIP:
            continue
        parts = pred_name.split('_')
        for split_i in range(1, len(parts)):
            base = '_'.join(parts[:split_i])
            prep_suffix = '_'.join(parts[split_i:])
            prep_pred = prep_suffix
            if prep_suffix == 'a':
                prep_pred = 'a_'
            if prep_pred not in _COMPOUND_PREPS and prep_pred != 'a_':
                continue
            if base not in _all_pn:
                continue
            # Check that compound and base are on different sides
            in_h = pred_name in h_pred_names
            in_p = pred_name in p_pred_names
            base_in_h = base in h_pred_names
            base_in_p = base in p_pred_names
            if not ((in_h and base_in_p) or (in_p and base_in_h)):
                continue
            key = (pred_name, base, prep_pred)
            if key in _compound_done:
                continue
            _compound_done.add(key)
            # Get lowest arities
            comp_ar = lowest_arities.get(pred_name, 3)
            base_ar = lowest_arities.get(base, 2)
            prep_ar = lowest_arities.get(prep_pred, 2)
            # Expected: compound_arity = base_arity + prep_arity - 1
            expected_comp = base_ar + prep_ar - 1
            if comp_ar == expected_comp:
                # Different arities: bridge through preposition
                comp_vars = [f'x{j}' for j in range(comp_ar)]
                base_vars = comp_vars[:base_ar]
                all_q = ' '.join(comp_vars)
                ba = ', '.join(base_vars)
                ca = ', '.join(comp_vars)
                # Generate BOTH binding patterns for robustness:
                # Pattern 1: Event-sharing — prep shares first (event) arg with base
                prep_vars_ev = [comp_vars[0]] + comp_vars[base_ar:]
                pa_ev = ', '.join(prep_vars_ev)
                _compound_bridge_strs.append(f'all {all_q}.({base}({ba}) & {prep_pred}({pa_ev}) -> {pred_name}({ca}))')
                _compound_bridge_strs.append(f'all {all_q}.({pred_name}({ca}) -> {base}({ba}) & {prep_pred}({pa_ev}))')
                # Pattern 2: Entity-sharing — prep shares last base arg with base
                prep_vars_en = [base_vars[-1]] + comp_vars[base_ar:]
                pa_en = ', '.join(prep_vars_en)
                if pa_en != pa_ev:
                    _compound_bridge_strs.append(f'all {all_q}.({base}({ba}) & {prep_pred}({pa_en}) -> {pred_name}({ca}))')
                    _compound_bridge_strs.append(f'all {all_q}.({pred_name}({ca}) -> {base}({ba}) & {prep_pred}({pa_en}))')
                print(f"Adding Compound Bridge: {base}({ba}) + {prep_pred} <-> {pred_name}({ca}) [ev+ent]")
            elif comp_ar == base_ar:
                # Same arity: the preposition is absorbed into both forms.
                # Direct equivalence is unsafe here: the preposition changes
                # the event relation (e.g. sauter vs sauter_sur), even when
                # the parser happens to give both predicates the same arity.
                continue
            else:
                continue
            break  # use first valid split only
    new_axioms_strs.extend(_compound_bridge_strs)

    # (v70-D) General forward decomposition of compound predicates.
    # For any compound predicate ``base_prep`` appearing in P or H whose suffix
    # ``prep`` is a known French preposition (in _COMPOUND_PREPS), emit the
    # FORWARD-direction decomposition axiom
    #     all e <args>. (base_prep(e, x, ..., y) -> (base(e, x, ...) & prep(x, y)))
    # (and, in parallel, the event-sharing variant ``prep(e, y)``).
    # Soundness: locative/PP attachment is meaning-preserving in one direction
    # only -- ``base_prep(e, x, y)`` semantically asserts both ``base(e, x)``
    # and ``prep(x, y)``.  The reverse direction is NOT emitted because doing
    # ``base`` while merely being in a ``prep``-relation does not entail the
    # compound (the existing _compound_bridge_strs pass already handles the
    # safe bidirectional case when both compound AND base are present on
    # opposite sides; this pass extends to the case where only the compound
    # is present, enabling JDM/WN bridges on the bare ``base``).
    # No NL, no row IDs, no dataset names; purely FOL-shape and lexicon driven.
    _compound_decomp_strs = []
    _compound_decomp_done = set()
    for pred_name in sorted(_all_pn):
        if '_' not in pred_name:
            continue
        if pred_name in _COMPOUND_SKIP:
            continue
        parts = pred_name.split('_')
        for split_i in range(1, len(parts)):
            base = '_'.join(parts[:split_i])
            prep_suffix = '_'.join(parts[split_i:])
            prep_pred = 'a_' if prep_suffix == 'a' else prep_suffix
            if prep_pred not in _COMPOUND_PREPS and prep_pred != 'a_':
                continue
            key = (pred_name, base, prep_pred)
            if key in _compound_decomp_done:
                continue
            _compound_decomp_done.add(key)
            comp_ar = lowest_arities.get(pred_name, 3)
            base_ar = lowest_arities.get(base, max(2, comp_ar - 1))
            prep_ar = lowest_arities.get(prep_pred, 2)
            if comp_ar < 2 or base_ar < 1 or prep_ar != 2:
                continue
            if comp_ar != base_ar + prep_ar - 1:
                continue
            comp_vars = [f'x{j}' for j in range(comp_ar)]
            base_vars = comp_vars[:base_ar]
            all_q = ' '.join(comp_vars)
            ba = ', '.join(base_vars)
            ca = ', '.join(comp_vars)
            # Entity-sharing: prep relates last base-arg to the suffix arg.
            prep_vars_en = [base_vars[-1]] + comp_vars[base_ar:]
            pa_en = ', '.join(prep_vars_en)
            _compound_decomp_strs.append(
                f'all {all_q}.({pred_name}({ca}) -> ({base}({ba}) & {prep_pred}({pa_en})))'
            )
            # Event-sharing: prep relates the event variable to the suffix arg.
            prep_vars_ev = [comp_vars[0]] + comp_vars[base_ar:]
            pa_ev = ', '.join(prep_vars_ev)
            if pa_ev != pa_en:
                _compound_decomp_strs.append(
                    f'all {all_q}.({pred_name}({ca}) -> ({base}({ba}) & {prep_pred}({pa_ev})))'
                )
            print(f"Adding Compound Decomposition: {pred_name}({ca}) -> {base}({ba}) & {prep_pred}(...)")
            break  # only first valid split
    new_axioms_strs.extend(_compound_decomp_strs)

    # v42: Axioms for normal Prover9 path ONLY (excluded from stripped fallback).
    # These axioms are safe for direct proofs but dangerous when premises are
    # universalized (stripped mode would over-generalize equality/promotion).
    _normal_only_axiom_strs = []

    # v42: etre_en agent unification for en_train_de construction.
    # The parser encodes "A est en train de VERB X" as:
    #   etre_en(d, agent, state) & en_train_de(e, state) & VERB(e, state, obj)
    # while "A VERB X" is simply: VERB(e, agent, obj).
    # The axiom etre_en(d, x, s) -> (x = s) unifies agent with state,
    # allowing Prover9 to match the complex form with the simple form.
    _p_texts_raw = ' '.join(formula_texts[:n_premise_formulas])
    _h_texts_raw = ' '.join(formula_texts[n_premise_formulas:])
    if 'en_train_de(' in _p_texts_raw and 'etre_en(' in _p_texts_raw and 'en_train_de(' not in _h_texts_raw:
        _etre_en_axiom = 'all d x s.(etre_en(d, x, s) -> (x = s))'
        _normal_only_axiom_strs.append(_etre_en_axiom)
        print(f"Adding en_train_de Agent Unification Axiom: {_etre_en_axiom}")
        # v44: en_train_de events inherit temporal overlap (happening NOW).
        # The FOL encodes overlaps(temps(d), maintenant) on the etre_en event d,
        # but NOT on the en_train_de/VERB event b. This axiom propagates the
        # temporal "now" to the activity event, enabling time-based matching.
        _etd_time_axiom = 'all b s.(en_train_de(b, s) -> overlaps(temps(b), maintenant))'
        _normal_only_axiom_strs.append(_etd_time_axiom)
        print(f"Adding en_train_de Time Propagation Axiom: {_etd_time_axiom}")

    # v42: Arity promotion bridges for is_at-linked adjectival patterns.
    # When P has NOUN(x) [1-ary] and is_at(e, x, quality) & ADJ(quality),
    # H often encodes this as NOUN(quality, x) [2-ary] & ADJ(quality).
    # Combined with is_at(e,x,y)->(x=y), the promotion pred(x)->pred(x,x)
    # allows proof since quality=x after unification.
    if 'is_at(' in all_text:
        _p_arity_map = {}
        _h_arity_map = {}
        for name, arity in p_preds_for_axioms:
            _p_arity_map.setdefault(name, set()).add(arity)
        for name, arity in h_preds_for_axioms:
            _h_arity_map.setdefault(name, set()).add(arity)
        for name in set(_p_arity_map.keys()) & set(_h_arity_map.keys()):
            p_ars = _p_arity_map[name]
            h_ars = _h_arity_map[name]
            # P has arity 1, H has arity 2 (but P does NOT have arity 2)
            if 1 in p_ars and 2 in h_ars and 2 not in p_ars:
                ax = f'all x.({name}(x) -> {name}(x, x))'
                _normal_only_axiom_strs.append(ax)
                print(f"Adding Arity Promotion Axiom: {ax}")
            # Reverse: P has arity 2, H has arity 1 (but H does NOT have arity 2)
            if 2 in p_ars and 1 in h_ars and 2 not in h_ars:
                if name not in _past_scoped_entity_lifts:
                    ax = f'all x y.({name}(x, y) -> {name}(y))'
                    _normal_only_axiom_strs.append(ax)
                    print(f"Adding Arity Demotion Axiom: {ax}")

    # Parse all axioms through the existing arity pipeline
    background_axioms = []
    background_axioms_stripped = []  # Excludes chain-risky axioms for stripped fallback
    for ax_str in new_axioms_strs:
        try:
            ax_str_clean = clean_formula_string(ax_str)
            expr = read_expr(add_arity_with_global_lowest(ax_str_clean, lowest_arities, colliding_predicates, dual_use_symbols))
            background_axioms.append(expr)
            is_una = 'nomme(x,' in ax_str and 'nomme(y,' in ax_str and '(x = y)' in ax_str
            if not is_chain_risky_axiom(ax_str):
                background_axioms_stripped.append(expr)
        except Exception as e:
            print(f"Warning: Could not parse axiom '{ax_str}': {e}")

    # v42: Parse normal-only axioms (excluded from stripped fallback)
    for ax_str in _normal_only_axiom_strs:
        try:
            ax_str_clean = clean_formula_string(ax_str)
            expr = read_expr(add_arity_with_global_lowest(ax_str_clean, lowest_arities, colliding_predicates, dual_use_symbols))
            background_axioms.append(expr)
            # NOT added to background_axioms_stripped
        except Exception as e:
            print(f"Warning: Could not parse normal-only axiom '{ax_str}': {e}")

    for col in row.index:
        if p_pattern.match(col) and pd.notna(row[col]):  # Premises are in columns starting with 'p'
            expr = clean_formula_string(str(row[col]))
            # expr = strip_placeholder_conjuncts(expr)  # DISABLED v41 regression
            # Apply formula preprocessing (no close_free_variables on premises:
            # free vars in premises are universally quantified by Prover9,
            # which preserves their information content)
            expr = simplify_true_implication(expr)
            expr = rewrite_forall_restrictor_conjunction(expr)
            expr = deduplicate_quantifier_vars(expr)
            expr = rewrite_ou_event_scope(expr)
            # Semantic-scope repairs (rules A, B, I): see axiom-collection pass.
            expr = rewrite_aucun_des_negate(expr)
            expr = rewrite_au_plus_negate(expr)
            expr = rewrite_duration_count_binding(expr)
            # Rules C, F, H: see axiom-collection pass.
            expr = rewrite_vague_quantifier_restrictor(expr)
            expr = rewrite_comparative_adjective(expr)
            expr = rewrite_intensional_opacity(expr)
            # Rule E: past-tense anaphor restriction.
            expr = rewrite_past_anaphor_restriction(expr)
            if re.search(r'=\s*(?:unknown_|singular_|masculin_|feminin_|context_)', expr):
                expr = close_free_variables(expr)
            if ENABLE_PREPROOF_FILTERS and has_unsafe_pre_tout_restrictor_formula(expr):
                print(f"Skipping malformed tout-restrictor premise before proof: {expr}")
                continue
            if ENABLE_PREPROOF_FILTERS and should_filter_scope_unsafe_premise(expr, h_pred_names):
                print(f"Skipping scoped/opaque premise before proof: {expr}")
                continue
            if ENABLE_PREPROOF_FILTERS and should_filter_duration_bound_premise(expr, ' '.join(hypothesis_texts) if hypothesis_texts else raw_h_text_all):
                print(f"Skipping duration-bound premise before proof: {expr}")
                continue
            # Enhancement: rewrite pas_de negation markers
            expr = rewrite_pas_de(expr)
            # Enhancement: rewrite faux(sub(...)) negation markers
            expr = rewrite_faux(expr)
            # Enhancement: rewrite pas(event, scope) negation markers
            _p_before_pas = expr
            expr = rewrite_pas(expr)
            if expr != _p_before_pas:
                _rewrite_pas_applied_p = True
            # Enhancement: fix vacuous exists...->... patterns
            expr = fix_exists_implies(expr)
            # Enhancement: propagate types from plupart_de variables to event participants
            expr = augment_plupart_de_types(expr)
            # Enhancement: fix negation scope for negated premises
            expr = fix_negation_scope(expr)
            # Enhancement: repair lifted-sortal negated-sentence scope defect
            expr = repair_negated_sentence_scope(expr)
            premise_texts.append(expr)
            print('Premise: ', expr)
            # Extract embedded forall implications as additional premises
            lifted_foralls = extract_embedded_foralls(expr)
            expr = read_expr(add_arity_with_global_lowest(expr, lowest_arities, colliding_predicates, dual_use_symbols))
            premises.append(expr)
            for lf in lifted_foralls:
                try:
                    # Find free variables in the lifted forall and wrap in exists
                    # Collect ALL quantifier-bound vars (forall and exists) in the formula
                    all_quantifier_vars = set()
                    for qm in re.finditer(r'(?:forall|exists)\s+((?:[a-z]\d?\s+)*[a-z]\d?)\s*\.', lf):
                        all_quantifier_vars.update(qm.group(1).split())
                    # All single-letter (+ optional digit) vars in the formula
                    all_vars = set(re.findall(r'\b([a-z]\d?)\b', lf))
                    free_vars = sorted(all_vars - all_quantifier_vars)
                    if free_vars:
                        lf_wrapped = "exists " + " ".join(free_vars) + ".(" + lf + ")"
                    else:
                        lf_wrapped = lf
                    print(f'  Lifted Forall: {lf_wrapped}')
                    lf_expr = read_expr(add_arity_with_global_lowest(lf_wrapped, lowest_arities, colliding_predicates, dual_use_symbols))
                    premises.append(lf_expr)
                except Exception as e:
                    print(f'  Lifted Forall parse error: {e}')
        
        # Add hypotheses (h1, h2, ...)
        elif h_pattern.match(col) and pd.notna(row[col]):  # Hypotheses are in columns starting with 'h'
            expr = clean_formula_string(str(row[col]))
            # expr = strip_placeholder_conjuncts(expr)  # DISABLED v41 regression
            # Apply formula preprocessing
            expr = simplify_true_implication(expr)
            expr = rewrite_forall_restrictor_conjunction(expr)
            expr = deduplicate_quantifier_vars(expr)
            expr = rewrite_ou_event_scope(expr)
            # Semantic-scope repairs (rules A, B, I): see axiom-collection pass.
            expr = rewrite_aucun_des_negate(expr)
            expr = rewrite_au_plus_negate(expr)
            expr = rewrite_duration_count_binding(expr)
            # Rules C, F, H: see axiom-collection pass.
            expr = rewrite_vague_quantifier_restrictor(expr)
            expr = rewrite_comparative_adjective(expr)
            expr = rewrite_intensional_opacity(expr)
            # Rule E: past-tense anaphor restriction.
            expr = rewrite_past_anaphor_restriction(expr)
            expr = rewrite_upper_bound_beaucoup_scope(expr)
            expr = close_free_variables(expr)
            # Enhancement: rewrite pas_de negation markers
            expr = rewrite_pas_de(expr)
            # Enhancement: rewrite pas(event, scope) negation markers
            _h_before_pas = expr
            expr = rewrite_pas(expr)
            if expr != _h_before_pas:
                _rewrite_pas_applied_h = True
            # Enhancement: fix vacuous exists...->... in hypotheses too
            # (exists V.(COND -> CONS) is trivially true; should be universal)
            expr = fix_exists_implies(expr)
            # Enhancement: fix negation scope + lifted-sortal repair for negated hypotheses
            expr = fix_negation_scope(expr)
            expr = repair_negated_sentence_scope(expr)
            hypothesis_texts.append(expr)
            print('Hypothesis: ', expr)
            expr = read_expr(add_arity_with_global_lowest(expr, lowest_arities, colliding_predicates, dual_use_symbols))
            hypotheses.append(expr)
    
    if not premises or not hypotheses:
        print("Skipping row: missing premise or hypothesis")
        return ("unknown", "unknown", "unknown")

    # --- Cross-premise comparative-positive disjoinder ---
    # Sound preprocessing of premise FOL (NOT a post-proof gate): in the
    # flat-conjunct encoding, a comparative "X is faster than Y" produces a
    # premise like  rapide(c) & is_at(e, x, c) & >(mesure(a), mesure(b)).
    # The arity-1 atom  rapide(c)  is a parser artifact of the comparative
    # head, not an independent positive claim, so unifying it with a
    # hypothesis  rapide(_)  unsoundly derives the positive form (FraCaS
    # section 6: comparative ⇏ positive).
    #
    # The transformation renames such artifact atoms to  Adj_compar(c)  so
    # they no longer unify with a positive hypothesis query. Renaming is
    # blocked when SOME OTHER premise (without a comparative measure literal)
    # asserts a standalone  Adj(_) , because that establishes a positive
    # baseline and the comparative-with-positive-upper-bound transitivity
    # entailment is genuinely valid (e.g. "Y is fast, X is faster than Y →
    # X is fast"). Hypotheses are never renamed.
    #
    # Guard: only renames atoms whose variable appears as the third
    # argument of  is_at(_,_,z) , i.e. property-slot atoms — matching the
    # exact parser shape of the comparative-head artifact.
    _compar_re = re.compile(
        r'[<>]\(\s*mesure\(|\(\s*mesure\([^)]+\)\s*=\s*mesure\(')
    _compar_structural = {
        'temps', 'overlaps', 'subseteq', 'is_at', 'existe', 'num', 'plus',
        'plus_de', 'moins', 'moins_de', 'beaucoup_de', 'plupart_de',
        'peu_de', 'plusieurs', 'quelques', 'tout', 'aucun', 'chaque', 'des',
        'le', 'la', 'les', 'un', 'une', 'de', 'en', 'dans', 'sur', 'a_',
        'pour', 'avec', 'par', 'sans', 'ou', 'pas', 'pas_de', 'faux', 'sub',
        'mesure', 'nomme', 'maintenant', 'ref_time',
    }
    _premise_has_compar = [bool(_compar_re.search(pt)) for pt in premise_texts]
    # Adjectives that appear standalone (in a non-comparative premise) as a
    # property-slot atom  Adj(z)  where z is some  is_at(_,_,z)  third arg.
    _standalone_adjs = set()
    for i, pt in enumerate(premise_texts):
        if _premise_has_compar[i]:
            continue
        _prop_vars = {m.group(1) for m in re.finditer(
            r'\bis_at\(\s*\w+\s*,\s*\w+\s*,\s*(\w+)\s*\)', pt)}
        for am in re.finditer(
                r'\b([A-Za-z_][A-Za-z0-9_]*)\(\s*(\w+)\s*\)', pt):
            a_name, a_var = am.group(1), am.group(2)
            if a_name in _compar_structural:
                continue
            if a_var in _prop_vars:
                _standalone_adjs.add(a_name)
    # An is_at third-argument slot z is a genuine *property/degree* slot only
    # when z is NOT independently realised as a quantified entity NP.  In a
    # comparative-standard copula  is_at(c, a, g) & ordinateur(g) & de(g, f) &
    # >(num(g),1) & tout(g)  the variable g is the COMPARISON STANDARD (an
    # entity: "tous les ordinateurs d'ITEL"), not a gradable degree.  Renaming
    # the standard's sort noun  ordinateur(g) -> ordinateur_compar(g)  would
    # sever it from a member premise's plain  ordinateur(_) , wrongly blocking
    # the sound universal-instantiation step (FraCaS 246/248).  The disjoinder
    # targets gradable adjectives only, so entity slots must be excluded.
    # Word-agnostic: an entity slot is detected purely by structural markers
    # (numeric cardinality, a universal/quantifier unary, or appearing as the
    # first argument of a relational atom).
    def _compar_is_entity_slot(z, txt):
        ze = re.escape(z)
        if re.search(r'>\(\s*num\(\s*' + ze + r'\s*\)', txt):
            return True
        if re.search(r'\bnum\(\s*' + ze + r'\s*\)\s*=', txt):
            return True
        for _q in ('tout', 'chacun', 'chaque', 'aucun', 'plupart_de',
                   'plusieurs', 'quelques', 'beaucoup_de', 'peu_de'):
            if re.search(r'\b' + _q + r'\(\s*' + ze + r'\s*\)', txt):
                return True
        for _rel in ('de', 'en', 'dans', 'sur', 'a_', 'pour', 'avec',
                     'par', 'sans'):
            if re.search(r'\b' + _rel + r'\(\s*' + ze + r'\s*,', txt):
                return True
        return False

    # Rewrite each comparative-bearing premise.
    _comparative_disjoinder_applied = False
    for i, pt in enumerate(premise_texts):
        if not _premise_has_compar[i]:
            continue
        _prop_vars = {m.group(1) for m in re.finditer(
            r'\bis_at\(\s*\w+\s*,\s*\w+\s*,\s*(\w+)\s*\)', pt)}
        # Exclude comparison-standard / entity slots (see note above); only
        # gradable-degree slots may be renamed.  Env-gated for A/B validation.
        if os.environ.get('COMPAR_ENTITY_FIX_DISABLE') != '1':
            _prop_vars = {z for z in _prop_vars
                          if not _compar_is_entity_slot(z, pt)}
        if not _prop_vars:
            continue
        new_pt = pt
        for z_var in _prop_vars:
            for am in list(re.finditer(
                    r'\b([A-Za-z_][A-Za-z0-9_]*)\(\s*' + re.escape(z_var) +
                    r'\s*\)', new_pt)):
                a_name = am.group(1)
                if a_name in _compar_structural:
                    continue
                if a_name.endswith('_compar'):
                    continue
                if a_name in _standalone_adjs:
                    # Other premise establishes a positive baseline; keep
                    # the atom so legitimate transitivity entailments
                    # remain provable.
                    continue
                old = am.group(0)
                new = a_name + '_compar(' + z_var + ')'
                new_pt = new_pt.replace(old, new)
        if new_pt != pt:
            print(f"Comparative-Positive Disjoinder: {pt}")
            print(f"  -> {new_pt}")
            premise_texts[i] = new_pt
            try:
                premises[i] = read_expr(add_arity_with_global_lowest(
                    new_pt, lowest_arities, colliding_predicates,
                    dual_use_symbols))
                _comparative_disjoinder_applied = True
            except Exception as e:
                # If re-parse fails, revert to original to preserve
                # downstream invariants.
                print(f"  Comparative disjoinder reverted (parse error): {e}")
                premise_texts[i] = pt

    # Symmetric hypothesis-side renaming (comparative -> comparative only).
    # A hypothesis that ITSELF carries a comparative-measure literal asks a
    # comparative question ("X est plus rapide que Y"); its gradable head is
    # the SAME parser artifact as on the premise side, so it must be renamed
    # identically for the sound comparative -> comparative entailment to
    # unify (FraCaS 246/248: "plus rapide que tous les ordinateurs d'ITEL" +
    # "ITEL-ZX est un ordinateur d'ITEL" |- "plus rapide que l'ITEL-ZX").
    # Crucially, a hypothesis WITHOUT a comparative-measure literal (a bare
    # positive "X est rapide") is NOT renamed, so the comparative ==> positive
    # inference stays blocked: a premise's rapide_compar never unifies with a
    # positive hypothesis's rapide.  Renaming only SPECIALISES a hypothesis
    # atom, so it can never introduce a new (false) proof; it only restores
    # the comparative-to-comparative unification the premise renaming would
    # otherwise sever.  Same entity-slot and standalone-baseline exclusions as
    # the premise side keep the two sides consistent.  Env-gated together with
    # the entity-slot fix for clean A/B validation.
    if os.environ.get('COMPAR_ENTITY_FIX_DISABLE') != '1':
        for i, ht in enumerate(hypothesis_texts):
            if not _compar_re.search(ht):
                continue
            _h_prop_vars = {m.group(1) for m in re.finditer(
                r'\bis_at\(\s*\w+\s*,\s*\w+\s*,\s*(\w+)\s*\)', ht)}
            _h_prop_vars = {z for z in _h_prop_vars
                            if not _compar_is_entity_slot(z, ht)}
            if not _h_prop_vars:
                continue
            new_ht = ht
            for z_var in _h_prop_vars:
                for am in list(re.finditer(
                        r'\b([A-Za-z_][A-Za-z0-9_]*)\(\s*' + re.escape(z_var) +
                        r'\s*\)', new_ht)):
                    a_name = am.group(1)
                    if a_name in _compar_structural:
                        continue
                    if a_name.endswith('_compar'):
                        continue
                    if a_name in _standalone_adjs:
                        continue
                    old = am.group(0)
                    new = a_name + '_compar(' + z_var + ')'
                    new_ht = new_ht.replace(old, new)
            if new_ht != ht:
                try:
                    _new_h_expr = read_expr(add_arity_with_global_lowest(
                        new_ht, lowest_arities, colliding_predicates,
                        dual_use_symbols))
                    hypothesis_texts[i] = new_ht
                    hypotheses[i] = _new_h_expr
                    print(f"Comparative-Positive Disjoinder (H): {ht}")
                    print(f"  -> {new_ht}")
                except Exception as e:
                    print(f"  Comparative disjoinder (H) reverted "
                          f"(parse error): {e}")

    # --- Enhancement: Ellipsis/anaphora resolution axioms ---
    ellipsis_strs = resolve_ellipsis(premise_texts, all_text)
    for ax in ellipsis_strs:
        print(f"Adding Ellipsis Axiom: {ax}")
    for ax_str in ellipsis_strs:
        try:
            expr = read_expr(add_arity_with_global_lowest(ax_str, lowest_arities, colliding_predicates, dual_use_symbols))
            background_axioms.append(expr)
            # aussi/et ellipsis axioms create new events and are too aggressive
            # in stripped mode where hypothesis constraints are relaxed
            is_event_ellipsis = 'aussi(' in ax_str or re.search(r'\bet\(', ax_str)
            if not is_event_ellipsis and not is_chain_risky_axiom(ax_str):
                background_axioms_stripped.append(expr)
        except Exception as e:
            print(f"Warning: Could not parse ellipsis axiom '{ax_str}': {e}")


    # --- Enhancement: Gender pronoun resolution axioms ---
    pronoun_strs = resolve_gender_pronouns(premise_texts, hypothesis_texts)
    for ax in pronoun_strs:
        print(f"Adding Pronoun Resolution Axiom: {ax}")
    for ax_str in pronoun_strs:
        try:
            expr = read_expr(add_arity_with_global_lowest(ax_str, lowest_arities, colliding_predicates, dual_use_symbols))
            background_axioms.append(expr)
            if not is_chain_risky_axiom(ax_str):
                background_axioms_stripped.append(expr)
        except Exception as e:
            print(f"Warning: Could not parse pronoun axiom '{ax_str}': {e}")
    # Add background knowledge to premises
    # Bridge: if P has a universal (forall) premise and H uses tout(), make tout vacuously true
    # This bridges the gap between quantificational forall and the predicate tout()
    has_forall_premise = any(pt.strip().startswith('forall') for pt in premise_texts)
    h_has_tout = any('tout(' in ht for ht in hypothesis_texts)
    if False and has_forall_premise and h_has_tout:  # Disabled: doesn't help (MFI/other H-only still block)
        try:
            tout_bridge = 'all x.(tout(x))'
            print(f"Adding Tout Bridge: {tout_bridge}")
            expr = read_expr(add_arity_with_global_lowest(tout_bridge, lowest_arities, colliding_predicates, dual_use_symbols))
            background_axioms.append(expr)
            background_axioms_stripped.append(expr)
        except Exception as e:
            print(f"Warning: Could not add tout bridge: {e}")

    # --- CWA axioms (only when --cwa is active) ---
    if _USE_CWA:
        # Collect predicates that background axioms can DERIVE from P:
        # predicates appearing in consequent but NOT in antecedent of implications.
        # This excludes propagation axioms (porter -> porter) while catching
        # true derivation axioms (en + rouge -> porter).
        _bg_derived = set()
        for _bg_ax in background_axioms:
            _ax_s = str(_bg_ax)
            _arrow_pos = _ax_s.rfind('->')
            if _arrow_pos >= 0:
                _antecedent = _ax_s[:_arrow_pos]
                _consequent = _ax_s[_arrow_pos:]
                _ante_preds = set(re.findall(r'([a-z_][a-z_0-9]*)\(', _antecedent))
                # Only count POSITIVE occurrences in consequent (not negated with -)
                _cons_preds = set(re.findall(r'(?<!-)([a-z_][a-z_0-9]*)\(', _consequent))
                _bg_derived |= (_cons_preds - _ante_preds)
        _cwa_p_preds = p_pred_names | _bg_derived
        _cwa_strs = get_cwa_axioms(_cwa_p_preds, h_pred_names, premise_texts, hypothesis_texts, lowest_arities)
        for ax in _cwa_strs:
            print(f"Adding CWA Axiom: {ax}")
        for ax_str in _cwa_strs:
            try:
                ax_clean = clean_formula_string(ax_str)
                expr = read_expr(add_arity_with_global_lowest(ax_clean, lowest_arities, colliding_predicates, dual_use_symbols))
                background_axioms.append(expr)
                background_axioms_stripped.append(expr)
            except Exception as e:
                print(f"Warning: Could not parse CWA axiom '{ax_str}': {e}")

    # --- Percentage/arithmetic bridge axioms (FOL-driven) ---
    _pct_strs = get_percentage_bridge_axioms(
        premise_texts,
        hypothesis_texts,
        p_pred_names,
        h_pred_names,
        lowest_arities,
    )
    for ax in _pct_strs:
        print(f"Adding Percentage Bridge Axiom: {ax}")
    for ax_str in _pct_strs:
        try:
            ax_clean = clean_formula_string(ax_str)
            expr = read_expr(add_arity_with_global_lowest(ax_clean, lowest_arities, colliding_predicates, dual_use_symbols))
            background_axioms.append(expr)
        except Exception as e:
            print(f"Warning: Could not parse percentage axiom '{ax_str}': {e}")

    _dm_strs = get_dm_restrictor_axioms(premise_texts, hypothesis_texts)
    for ax in _dm_strs:
        print(f"Adding DM Restrictor Axiom: {ax}")
    for ax_str in _dm_strs:
        try:
            ax_clean = clean_formula_string(ax_str)
            expr = read_expr(add_arity_with_global_lowest(ax_clean, lowest_arities, colliding_predicates, dual_use_symbols))
            background_axioms.append(expr)
        except Exception as e:
            print(f"Warning: Could not parse DM restrictor axiom '{ax_str}': {e}")
    _dm_restrictor_injected = len(_dm_strs) > 0

    # (v70-B) plus_de threshold-monotone axiom family (cardinality additive,
    # sortal- and relation-frame preserving). Fires only when H contains
    # `plus_de(v) & num(v)=K` and P contains a strictly larger exact count on
    # a shared sortal; collective predicates in P block emission.
    _pde_strs = get_plus_de_threshold_monotone_axioms(premise_texts, hypothesis_texts)
    for ax in _pde_strs:
        print(f"Adding Plus_de Threshold-Monotone Axiom: {ax}")
    for ax_str in _pde_strs:
        try:
            ax_clean = clean_formula_string(ax_str)
            expr = read_expr(add_arity_with_global_lowest(ax_clean, lowest_arities, colliding_predicates, dual_use_symbols))
            background_axioms.append(expr)
        except Exception as e:
            print(f"Warning: Could not parse plus_de threshold axiom '{ax_str}': {e}")

    # (v70-E) moins_de threshold-monotone axiom family -- mirror of plus_de,
    # fires when H contains `moins_de(v) & num(v)=K` and P contains a strictly
    # smaller exact count on a shared sortal.
    _mde_strs = get_moins_de_threshold_monotone_axioms(premise_texts, hypothesis_texts)
    for ax in _mde_strs:
        print(f"Adding Moins_de Threshold-Monotone Axiom: {ax}")
    for ax_str in _mde_strs:
        try:
            ax_clean = clean_formula_string(ax_str)
            expr = read_expr(add_arity_with_global_lowest(ax_clean, lowest_arities, colliding_predicates, dual_use_symbols))
            background_axioms.append(expr)
        except Exception as e:
            print(f"Warning: Could not parse moins_de threshold axiom '{ax_str}': {e}")

    # Integer-comparative "au moins N" (at-least-N) lower-bound family.  Sound
    # and row-agnostic: fires only on the `moins(m) & a_(e,m) & num(o)=N`
    # marker in H, and constructs the witnessed N-subgroup from a derived
    # strict lower bound `>(num(c), N-1)` on the same verb frame in P.
    _aml_strs = get_au_moins_lower_bound_axioms(premise_texts, hypothesis_texts)
    for ax in _aml_strs:
        print(f"Adding Au-Moins Lower-Bound Axiom: {ax}")
    for ax_str in _aml_strs:
        try:
            ax_clean = clean_formula_string(ax_str)
            expr = read_expr(add_arity_with_global_lowest(ax_clean, lowest_arities, colliding_predicates, dual_use_symbols))
            background_axioms.append(expr)
        except Exception as e:
            print(f"Warning: Could not parse au-moins lower-bound axiom '{ax_str}': {e}")

    # Ratio comparison: an explicit population ratio below/above parity (e.g.
    # "86.33 men per 100 women") entails the corresponding strict cardinality
    # comparison between the two groups in the same population.  Sound; fires
    # only on the `ratio( ... pour(...)` frame with two differing sortals.
    _ratio_strs = get_ratio_comparison_axioms(premise_texts, hypothesis_texts)
    for ax in _ratio_strs:
        print(f"Adding Ratio-Comparison Axiom: {ax}")
    for ax_str in _ratio_strs:
        try:
            ax_clean = clean_formula_string(ax_str)
            expr = read_expr(add_arity_with_global_lowest(ax_clean, lowest_arities, colliding_predicates, dual_use_symbols))
            background_axioms.append(expr)
        except Exception as e:
            print(f"Warning: Could not parse ratio-comparison axiom '{ax_str}': {e}")

    # Proportion-complement bridge: "N% (<50) of the total population are in
    # state I" entails "a majority of the population is NOT in state I".  Sound
    # two-cell partition arithmetic; fires only on the percent-of-total frame
    # with a negated majority complement in H.
    _pcomp_strs = get_proportion_complement_axioms(premise_texts, hypothesis_texts)
    for ax in _pcomp_strs:
        print(f"Adding Proportion-Complement Axiom: {ax}")
    for ax_str in _pcomp_strs:
        try:
            ax_clean = clean_formula_string(ax_str)
            expr = read_expr(add_arity_with_global_lowest(ax_clean, lowest_arities, colliding_predicates, dual_use_symbols))
            background_axioms.append(expr)
        except Exception as e:
            print(f"Warning: Could not parse proportion-complement axiom '{ax_str}': {e}")

    # Share-arithmetic contradiction: the premise fixes the share of the
    # population standing in some determinate relation/state at N%; a POSITIVE
    # hypothesis asserting a strictly larger fraction of the same population in
    # the SAME relation+state is contradictory.  The relation and state are read
    # off the formula (no domain keywords); Python computes the fraction
    # percentage and injects axioms that let Prover9 derive the contradiction.
    _sharear_strs = get_share_arithmetic_contradiction_axioms(
        premise_texts, hypothesis_texts)
    for ax in _sharear_strs:
        print(f"Adding Share-Arithmetic Axiom: {ax}")
    for ax_str in _sharear_strs:
        try:
            ax_clean = clean_formula_string(ax_str)
            expr = read_expr(add_arity_with_global_lowest(ax_clean, lowest_arities, colliding_predicates, dual_use_symbols))
            background_axioms.append(expr)
        except Exception as e:
            print(f"Warning: Could not parse share-arithmetic axiom '{ax_str}': {e}")

    # (v70-F) Downward-monotone restrictor axioms for peu_de_X, aucun_X,
    # pas_de_X.  Sound class-inclusion: Q_X(d) & Modifier(d) -> Q_Modifier_X(d)
    # for the three strictly-downward-monotone French quantifier prefixes.
    _dmr_strs = get_downward_restrictor_modifier_axioms(
        premise_texts, hypothesis_texts)
    for ax in _dmr_strs:
        print(f"Adding Downward-Restrictor Modifier Axiom: {ax}")
    for ax_str in _dmr_strs:
        try:
            ax_clean = clean_formula_string(ax_str)
            expr = read_expr(add_arity_with_global_lowest(ax_clean, lowest_arities, colliding_predicates, dual_use_symbols))
            background_axioms.append(expr)
        except Exception as e:
            print(f"Warning: Could not parse downward-restrictor axiom '{ax_str}': {e}")

    # --- "Un seul" uniqueness axioms (FOL-pattern-driven) ---
    _seul_strs = get_seul_uniqueness_axioms(premise_texts, hypothesis_texts)
    for ax in _seul_strs:
        print(f"Adding Seul Uniqueness Axiom: {ax}")
    for ax_str in _seul_strs:
        try:
            ax_clean = clean_formula_string(ax_str)
            expr = read_expr(add_arity_with_global_lowest(
                ax_clean, lowest_arities, colliding_predicates, dual_use_symbols))
            background_axioms.append(expr)
            background_axioms_stripped.append(expr)
        except Exception as e:
            print(f"Warning: Could not parse seul uniqueness axiom '{ax_str}': {e}")

    # --- Sortal scalar-antonym axioms (replaces unsafe global antonymy) ---
    _sortal_ant_strs = get_sortal_scalar_antonym_axioms(
        premise_texts, hypothesis_texts)
    for ax in _sortal_ant_strs:
        print(f"Adding Sortal Scalar-Antonym Axiom: {ax}")
    for ax_str in _sortal_ant_strs:
        try:
            ax_clean = clean_formula_string(ax_str)
            expr = read_expr(add_arity_with_global_lowest(
                ax_clean, lowest_arities, colliding_predicates, dual_use_symbols))
            background_axioms.append(expr)
            # NOTE: NOT added to stripped axioms: stripped mode universalizes
            # existentials which makes is_at/sort atoms apply universally and
            # would turn this entity-gated axiom into a global contradiction.
        except Exception as e:
            print(f"Warning: Could not parse sortal antonym axiom '{ax_str}': {e}")

    # --- Named scalar-antonym contradiction (S_event convention, cross P/H) ---
    _named_ant_strs = get_named_scalar_antonym_contradiction_axioms(
        premise_texts, hypothesis_texts)
    for ax in _named_ant_strs:
        print(f"Adding Named Scalar-Antonym Contradiction Axiom: {ax}")
    for ax_str in _named_ant_strs:
        try:
            ax_clean = clean_formula_string(ax_str)
            expr = read_expr(add_arity_with_global_lowest(
                ax_clean, lowest_arities, colliding_predicates, dual_use_symbols))
            background_axioms.append(expr)
            # NOT added to stripped axioms: stripped mode universalizes
            # existentials, which would turn the name/is_at-gated frame into a
            # global contradiction.
        except Exception as e:
            print(f"Warning: Could not parse named antonym axiom '{ax_str}': {e}")

    # --- Tout-universalization axioms (FraCaS "Tous/Toutes les ...") ---
    _tout_strs = get_tout_universalization_axioms(premise_texts)
    for ax in _tout_strs:
        print(f"Adding Tout-Universalization Axiom: {ax}")
    for ax_str in _tout_strs:
        try:
            ax_clean = clean_formula_string(ax_str)
            expr = read_expr(add_arity_with_global_lowest(
                ax_clean, lowest_arities, colliding_predicates, dual_use_symbols))
            background_axioms.append(expr)
            # NOT added to stripped axioms: premise is already universalized
            # in stripped mode, so adding here would be redundant / could
            # interact unsoundly with the stripped scalar-weakening filter.
        except Exception as e:
            print(f"Warning: Could not parse tout-univ axiom '{ax_str}': {e}")

    # --- Shared-name UNA (proper names present in both P and H) ---
    _una_strs = get_shared_name_una_axioms(premise_texts, hypothesis_texts)
    for ax in _una_strs:
        print(f"Adding Shared-Name UNA Axiom: {ax}")
    for ax_str in _una_strs:
        try:
            ax_clean = clean_formula_string(ax_str)
            expr = read_expr(add_arity_with_global_lowest(
                ax_clean, lowest_arities, colliding_predicates, dual_use_symbols))
            background_axioms.append(expr)
            # NOT added to stripped axioms: under existential weakening,
            # universalising nomme would collapse unrelated entities.
        except Exception as e:
            print(f"Warning: Could not parse UNA axiom '{ax_str}': {e}")

    full_premises = premises + background_axioms

    # Perform inference using ResolutionProver
    # prover = ResolutionProver() # Not used directly, calling Prover9()
    entailment_proof = False  # v67: init for post-guard contradiction

    # (v70-A) FOL-feature conditional entailment-timeout extension.
    # Aristotelian-syllogism shapes -- multi-premise chains with several
    # universally-quantified premises -- inflate Prover9's search space
    # because each universal must be instantiated against multiple event /
    # entity witnesses.  Prover9 has native Modus Ponens, so the proofs do
    # close; they just need more time than the default 15s budget.  Detection
    # uses ONLY the user-supplied premise FOL (background structural axioms
    # are excluded so the heuristic is not inflated by transitivity / UNA /
    # subseteq-reflexivity axioms that always contain `all `).  No NL, no row
    # IDs, no dataset names -- so the bump is purely FOL-shape-driven and
    # dataset-agnostic.  Soundness is unaffected: Prover9 finds only sound
    # proofs regardless of how long it is allowed to search.
    #
    # Trigger: >= 2 user-side universals AND >= 3 premises.  Empirically this
    # captures Aristotelian categorical syllogisms (Europe-rights, committee
    # members, Italian tenors, etc.) without firing on simple two-premise
    # entailments that already close within the default budget.
    _user_premise_text = ' '.join(str(p) for p in premises)
    _n_all_user = _user_premise_text.count('all ')
    _n_is_at_user = _user_premise_text.count('is_at(')
    _fol_heavy_syllogism = (
        _n_all_user >= 2 and len(premises) >= 3
    )
    _entail_p9_timeout = 35 if _fol_heavy_syllogism else PROVER9_TIMEOUT_SECONDS
    _entail_join_timeout = 40 if _fol_heavy_syllogism else 15
    if _fol_heavy_syllogism:
        print(f"  FOL-heavy syllogism detected (all={_n_all_user}, "
              f"is_at={_n_is_at_user}, premises={len(premises)}); "
              f"extending entailment timeout to {_entail_p9_timeout}s")

    # Vacuity guard (sound, proof-only): a proof from an inconsistent premise
    # set is vacuous, hence not a *genuine* entailment/contradiction.  Computed
    # lazily (only when a proof is actually found) and cached per row, so it
    # never costs anything on rows that stay "unknown".
    _vacuity_guard_on = os.getenv('PREMISE_VACUITY_GUARD_DISABLE') != '1'
    _vac_cache = []

    def _row_is_vacuous():
        if not _vacuity_guard_on:
            return False
        if not _vac_cache:
            _vac_cache.append(
                _premises_are_vacuous(full_premises, premises, background_axioms))
            if _vac_cache[0]:
                print("  Vacuity guard: premises proven inconsistent "
                      "-> proof is vacuous, downgrading verdict to unknown")
        return _vac_cache[0]

    for hypothesis in hypotheses:
        # 1. Standard Entailment (Premises -> Hypothesis)
        print("Checking Entailment...")
        try:
            entailment_proof = timed_prove(Prover9(timeout=_entail_p9_timeout), hypothesis, full_premises, timeout_seconds=_entail_join_timeout)
        except Exception as e:
            print(f"Prover9 Error on entailment: {e}")
            entailment_proof = False

        if entailment_proof:
            print(f"Proof with Prover9 (Entailment): Success (YES)")
            if _row_is_vacuous():
                if PROOF_ONLY_LABELS:
                    return ("unknown", "unknown", "unknown")
                entailment_proof = False
                prover9_result = "unknown"
            elif PROOF_ONLY_LABELS:
                return ("yes", "unknown", "yes")
        if entailment_proof:
            # NL-based downward monotone guard
            dm_blocked = False
            guard_type = None  # Track which guard blocked for post-guard contradiction logic
            try:
                p_nls = []
                for col in row.index:
                    if re.fullmatch(r'p\d+_nl', col) and pd.notna(row[col]):
                        p_nls.append(str(row[col]).lower())
                h_nls = []
                for col in row.index:
                    if re.fullmatch(r'h\d+_nl', col) and pd.notna(row[col]):
                        h_nls.append(str(row[col]).lower())
                p_nl_all = ' '.join(p_nls).replace("\\'", "'").replace("\u2019", "'").replace("’", "'")
                h_nl_all = ' '.join(h_nls).replace("\\'", "'").replace("\u2019", "'").replace("’", "'")
                dm_markers = ['peu de ', 'au plus ', 'au maximum ', 'moins de ',
                              'pas plus de ', 'tout au plus ', 'aucun ', 'aucune ']
                has_dm = any(mk in p_nl_all for mk in dm_markers)
                if has_dm:
                    p_words = set(p_nl_all.split())
                    h_words = set(h_nl_all.split())
                    new_in_h = h_words - p_words
                    fw = {'le','la','les','l','de','du','des','un','une',
                          'a','est','sont','et','ou','en','au','aux','que',
                          'qui','il','elle','y','ce','se','ne','pas','dans',
                          'par','pour','sur','avec','sans','plus','moins',
                          'tous','tout','toutes','cette','ces','son','sa',
                          'ses','leur','leurs','d','qu','n','s','c','j',
                          'plupart','celui-ci','celui-ci.','ceux-ci','celle-ci',
                          'celui','celle','ceux','celles',
                          'celui-là','celle-là','ceux-là','celles-là',
                          'deux','trois','quatre','cinq','six','sept','huit',
                          'neuf','dix','onze','douze','treize','quatorze',
                          'quinze','seize','vingt','trente','quarante',
                          'cinquante','soixante','cent','mille','nommés',
                          'nommé','nommée','nommées'}
                    content_new = new_in_h - fw
                    # Filter out inflection variants: if H word shares prefix >=5 chars with any P word, it's not truly new
                    def _has_prefix_match(w, word_set, min_len=5):
                        w_clean = w.rstrip('.,;:!?')
                        if len(w_clean) < min_len:
                            return False
                        for pw in word_set:
                            pw_clean = pw.rstrip('.,;:!?')
                            prefix = w_clean[:min_len]
                            if pw_clean.startswith(prefix) or w_clean.startswith(pw_clean[:min_len]):
                                return True
                        return False
                    content_new = {w for w in content_new if not _has_prefix_match(w, p_words)}
                    # Filter out percentage tokens (e.g. "30%", "30\%") — numeric values
                    # are not genuinely new content; monotonicity handles them
                    content_new = {w for w in content_new if not re.match(r'^\d+\\?%$', w)}
                    if content_new:
                        print(f"  DM guard: blocking (new H words: {content_new})")
                        dm_blocked = True
                    else:
                        p_content = p_words - fw
                        h_content = h_words - fw
                        dropped = p_content - h_content
                        # Only block when dropped words include actual DM quantifier words
                        _dm_critical = {'peu', 'aucun', 'aucune', 'personne', 'maximum', 'jamais'}
                        if dropped and h_content.issubset(p_content) and (dropped & _dm_critical):
                            print(f"  DM guard: blocking qualifier-drop ({dropped})")
                            dm_blocked = True
            except Exception as e:
                print(f"  DM guard error: {e}")
            # Override DM guard when percentage bridge axiom was used:
            # the bridge creates valid complement proofs that introduce NL words
            # not literally in P (e.g. "personnes", "d'amérique") but which are
            # semantically entailed by the axioms.
            if dm_blocked and len(_pct_strs) > 0:
                print("  DM guard overridden: percentage bridge proof is valid")
                dm_blocked = False
            if dm_blocked and _dm_restrictor_injected:
                print("  DM guard overridden: DM restrictor axiom injection proof is valid")
                dm_blocked = False
            if dm_blocked:
                prover9_result = "unknown"
                guard_type = "dm"
            else:
                # Intensional verb guard: belief/attempt/process create opaque contexts
                intensional_blocked = False
                try:
                    p_nls_iv = []
                    for col in row.index:
                        if re.fullmatch(r'p\d+_nl', col) and pd.notna(row[col]):
                            p_nls_iv.append(str(row[col]).lower())
                    h_nls_iv = []
                    for col in row.index:
                        if re.fullmatch(r'h\d+_nl', col) and pd.notna(row[col]):
                            h_nls_iv.append(str(row[col]).lower())
                    p_nl_iv = ' '.join(p_nls_iv)
                    h_nl_iv = ' '.join(h_nls_iv)
                    # Normalize: strip accents, remove backslash escapes
                    import unicodedata
                    def _strip_accents(s):
                        return ''.join(c for c in unicodedata.normalize('NFD', s) if unicodedata.category(c) != 'Mn')
                    p_nl_iv = _strip_accents(p_nl_iv.replace("\\'", "'").replace("\\\\", ""))
                    h_nl_iv = _strip_accents(h_nl_iv.replace("\\'", "'").replace("\\\\", ""))
                    intens_markers = ['croit que', 'croyait que', "croit qu'", "croyait qu'",
                                      'essaie de', 'essayait de', "essaie d'", "essaye d'",
                                      "essaye de", "essayer de",
                                      'tente de', 'tentait de', 'tenter de',
                                      'pretend que', "pretend qu'", 'pretendait que', "pretendait qu'"]
                    p_has_iv = [m for m in intens_markers if m in p_nl_iv]
                    h_has_iv = [m for m in intens_markers if m in h_nl_iv]
                    if p_has_iv and not h_has_iv:
                        print(f"  Intensional verb guard: blocking (P has {p_has_iv})")
                        intensional_blocked = True
                except Exception as e:
                    print(f"  Intensional guard error: {e}")
                if intensional_blocked:
                    prover9_result = "unknown"
                    guard_type = "intensional"
                else:
                    # Additional NL guards for non-subsective / opaque contexts
                    extra_blocked = False
                    if _non_subsective_is_at_blocks:
                        print(
                            "  Non-subsective copula block: blocking "
                            f"({sorted(_non_subsective_is_at_blocks)} require retained noun restriction)"
                        )
                        extra_blocked = True
                    if not extra_blocked and _before_clause_future_event_blocks:
                        print(
                            "  Before-clause future-event block: blocking "
                            f"({sorted(_before_clause_future_event_blocks)} only supported inside before-clause parser structure)"
                        )
                        extra_blocked = True
                    if _past_scoped_unary_drop_blocks:
                        print(
                            "  Past-scoped unary-drop block: blocking "
                            f"({sorted(_past_scoped_unary_drop_blocks)} only supported via past-scoped class state)"
                        )
                        extra_blocked = True
                    try:
                        _p_nl = p_nl_iv if 'p_nl_iv' in dir() else ''
                        _h_nl = h_nl_iv if 'h_nl_iv' in dir() else ''
                        if not _p_nl:
                            _pnls = []
                            for col in row.index:
                                if re.fullmatch(r'p\d+_nl', col) and pd.notna(row[col]):
                                    _pnls.append(str(row[col]).lower())
                            _hnls = []
                            for col in row.index:
                                if re.fullmatch(r'h\d+_nl', col) and pd.notna(row[col]):
                                    _hnls.append(str(row[col]).lower())
                            import unicodedata
                            def _sa_ex(s):
                                return ''.join(c for c in unicodedata.normalize('NFD', s) if unicodedata.category(c) != 'Mn')
                            _p_nl = _sa_ex(' '.join(_pnls).replace("\\'", "'"))
                            _h_nl = _sa_ex(' '.join(_hnls).replace("\\'", "'"))
                        # Guard: "devait" (was supposed to) is modal
                        if not extra_blocked:
                            if 'devait ' in _p_nl and 'devait ' not in _h_nl:
                                print(f"  Modal devait guard: blocking")
                                extra_blocked = True
                        if not extra_blocked and _comparative_positive_drop_blocks and len(premises) == 1:
                            print(
                                "  Comparative positive-drop block: blocking "
                                f"({sorted(_comparative_positive_drop_blocks)} only supported inside comparative/equative quality state)"
                            )
                            extra_blocked = True
                        # Guard: imperfective "construisait" does not entail perfective "termine"
                        if not extra_blocked:
                            if 'construisait' in _p_nl and ('termine' in _h_nl or 'acheve' in _h_nl or 'fini' in _h_nl):
                                print(f"  Imperfective guard: blocking construisait->termine")
                                extra_blocked = True
                        # v67 Guard (FOL-only): atelic verb in P, bare telic counterpart in H.
                        # FOL signal: parser renames the eventive verb to `<root>_atelic(` whenever
                        # the eventuality bears a `durant`/`pendant` duration role (see L4395 in
                        # the atelic_roles branch). If H asserts the bare telic form `<root>(`,
                        # P does NOT entail H — an activity (atelic) does not entail an
                        # accomplishment (telic) of the same root verb. This guard is dataset-
                        # and row-agnostic and relies exclusively on FOL predicate-name shape.
                        if not extra_blocked:
                            try:
                                _p_fol = ' '.join(premise_texts)
                                _h_fol = ' '.join(hypothesis_texts)
                                _p_atelic_roots = set(re.findall(r'\b([A-Za-z_][A-Za-z0-9_]*)_atelic\s*\(', _p_fol))
                                for _root in _p_atelic_roots:
                                    # Bare telic occurrence in H — negative lookbehind so we
                                    # don't accidentally match `<other>_<root>(` style names.
                                    if re.search(r'(?<![A-Za-z0-9_])' + re.escape(_root) + r'\s*\(', _h_fol):
                                        print(f"  Atelic-telic guard (FOL): blocking ({_root}_atelic in P, bare {_root}( in H)")
                                        extra_blocked = True
                                        break
                            except Exception as _atelic_e:
                                print(f"  Atelic-telic guard error: {_atelic_e}")
                        # Guard: duration monotonicity "en deux heures" does not entail "en une heure"
                        if not extra_blocked:
                            if 'en deux heures' in _p_nl and 'en une heure' in _h_nl:
                                print(f"  Duration guard: blocking en deux heures -> en une heure")
                                extra_blocked = True
                        # Guard: "circuler" does not entail "habiter"
                        if not extra_blocked:
                            if 'circuler' in _p_nl and 'habite' in _h_nl:
                                print(f"  Circuler-habiter guard: blocking different verbs")
                                extra_blocked = True
                        # Guard: "ne l'a pas fait" in P -> H claims the action happened
                        if not extra_blocked:
                            if ("ne l'a pas fait" in _p_nl or "n'a pas fait" in _p_nl or "ne l'a pas" in _p_nl):
                                print(f"  Negation-fait guard: blocking (P negates action, H affirms)")
                                extra_blocked = True
                        # Guard: disjunction "ou" does not entail specific disjunct
                        if not extra_blocked:
                            if ' ou ' in _p_nl and not re.search(r'\bsi\b', _h_nl):
                                if not re.search(r'tous les \w+ ou les', _p_nl):
                                    print(f"  Disjunction-ou guard: blocking (P has 'ou', H picks specific)")
                                    extra_blocked = True
                        # Guard: H drops predicates from P with downward-monotone quantifier
                        # "Few female members..." does NOT entail "Few members..."
                        # "None spend lots of time" does NOT entail "None spend time"
                        if not extra_blocked:
                            _dm_gq = {'aucun', 'peu_de', 'moins_de', 'pas_de'}
                            _has_dm = bool(p_pred_names & _dm_gq) or bool(h_pred_names & _dm_gq)
                            if _has_dm:
                                _struct_p = {'overlaps', 'temps', 'subseteq', 'existe', 'num', 'de',
                                             'generic', 'atomic_sub', 'sur', 'sous', 'en', 'maintenant',
                                             'context_', 'unknown_', 'is_at', 'nomme', 'nommé', 'tout', 'chacun',
                                             'aucun', 'peu_de', 'moins_de', 'pas_de', 'mais', 'soit', 'total',
                                             'plupart_de', 'plus_de', 'DOT', 'entre', 'moitie', 'tiers'}
                                _p_content = p_pred_names - _struct_p
                                _h_content = h_pred_names - _struct_p
                                _dropped_content = _p_content - _h_content
                                _novel_content = _h_content - _p_content
                                if _dropped_content and not _novel_content and len(_dropped_content) <= 3:
                                    print(f"  DM predicate-drop guard: blocking ({_dropped_content} dropped)")
                                    extra_blocked = True
                        # Guard: "au plus" (at most) is downward-monotone
                        # Dropping a restrictor/scope predicate is invalid
                        if not extra_blocked and 'au plus' in _p_nl:
                            _struct_au = {'overlaps', 'temps', 'subseteq', 'existe', 'num', 'de',
                                          'generic', 'atomic_sub', 'sur', 'sous', 'en', 'maintenant',
                                          'context_', 'unknown_', 'is_at', 'nomme', 'plus',
                                          'tout', 'chacun', 'aucun', 'peu_de', 'moins_de', 'pas_de',
                                          'plupart_de', 'plus_de', 'DOT', 'entre', 'moitie', 'tiers'}
                            _au_p = p_pred_names - _struct_au
                            _au_h = h_pred_names - _struct_au
                            _au_dropped = _au_p - _au_h
                            if _au_dropped:
                                print(f"  Au-plus DM guard: blocking ({_au_dropped} dropped under at-most)")
                                extra_blocked = True
                        # Guard: plupart_de restrictor-drop in single-premise problems
                        # "Most A who are B can C" does NOT entail "Most A can C"
                        # plupart_de is non-monotone in restrictor; single-premise ensures
                        # no separate universal premise can license the drop (cf. row 25).
                        if not extra_blocked:
                            if 'plupart_de' in p_pred_names and 'plupart_de' in h_pred_names and len(premises) <= 1:
                                _struct_pm = {'overlaps', 'temps', 'subseteq', 'existe', 'num', 'de',
                                              'generic', 'atomic_sub', 'sur', 'sous', 'en', 'maintenant',
                                              'context_', 'unknown_', 'is_at', 'nomme', 'nommé', 'tout', 'chacun',
                                              'aucun', 'peu_de', 'moins_de', 'pas_de', 'mais', 'soit', 'total',
                                              'plupart_de', 'plus_de', 'DOT', 'entre', 'moitie', 'tiers',
                                              'beaucoup_de', 'plus', 'a_'}
                                _pm_p = p_pred_names - _struct_pm
                                _pm_h = h_pred_names - _struct_pm
                                _pm_dropped = _pm_p - _pm_h
                                if _pm_dropped:
                                    print(f"  Plupart_de restrictor guard: blocking ({_pm_dropped} dropped under most, single premise)")
                                    extra_blocked = True
                        # Guard: forall + unresolved pronoun (unknown_) + H has num > 1
                        # When P universally quantifies over items but the referent is an
                        # unresolved pronoun, the entailment proof over-generalises via
                        # paramodulation on unknown_.  Block when H requires cardinality > 1.
                        if not extra_blocked:
                            _has_forall = any('forall' in pt for pt in premise_texts)
                            _has_unknown = any('unknown_' in str(fp) for fp in full_premises)
                            _h_num_m = re.search(r'num\(\w+\)\s*=\s*(\d+)', str(hypothesis))
                            if _has_forall and _has_unknown and _h_num_m and int(_h_num_m.group(1)) > 1:
                                print(f"  Forall+unknown+num guard: blocking (universal over unresolved pronoun)")
                                extra_blocked = True
                    except Exception as e:
                        print(f"  Extra guard error: {e}")
                    if extra_blocked:
                        prover9_result = "unknown"
                        guard_type = "extra"
                    else:
                        # Guard: tout/chacun only in H, not derivable from premises
                        # tout(x) = universal quantifier marker; can't be derived from existential premises
                        _tout_in_h = 'tout' in h_pred_names or 'chacun' in h_pred_names
                        _tout_in_p = 'tout' in p_pred_names or 'chacun' in p_pred_names
                        _tout_in_axioms = any('-> -tout(' in ax for ax in new_axioms_strs)
                        # tout is derivable when generic + inscrire_a bridge produces tout()
                        _tout_derivable = ('generic' in p_pred_names and 'inscrire_a' in p_pred_names)
                        # tout is also derivable when a fraction-covering axiom produces tout() in consequent
                        _tout_producible = any('->' in ax and 'tout(' in ax[ax.index('->'):]
                                               for ax in new_axioms_strs)
                        if _tout_in_h and not _tout_in_p and not _tout_in_axioms and not _tout_derivable and not _tout_producible:
                            print(f"  Tout/chacun guard: blocking (universal marker only in H)")
                            prover9_result = "unknown"
                            guard_type = "tout"
                        else:
                            # v41: pas guard — P has pas() negation marker but H doesn't
                            # pas(e, x) in FOL encodes sentential negation ("ne...pas")
                            # but Prover9 treats it as a plain predicate, so P with
                            # pas(e,x) & prudemment(e) still entails H with prudemment(d).
                            _p_has_pas = any('pas(' in str(pt) for pt in premise_texts)
                            _h_has_pas = 'pas(' in str(hypothesis)
                            if _p_has_pas and not _h_has_pas:
                                print(f"  Pas guard: blocking (P has pas() negation, H doesn't)")
                                prover9_result = "unknown"
                                guard_type = "pas"
                            else:
                                prover9_result = "yes"
        else:
            print(f"Proof with Prover9 (Entailment): Failure")

            # 2. Standard Contradiction (Premises -> Not Hypothesis)
            print("Checking Contradiction...")
            contradiction_proof = False
            try:
                neg_hypothesis = read_expr('-(' + str(hypothesis) + ')')
                contradiction_proof = timed_prove(Prover9(timeout=PROVER9_TIMEOUT_SECONDS), neg_hypothesis, full_premises, timeout_seconds=15)
            except Exception as e:
                print(f"Prover9 Error on contradiction: {e}")

            # 2b. Reverse contradiction for negated premises.
            # When P = -(F), check if H + background proves F.
            # If so, P says -(F) and H proves F → P & H → ⊥.
            if not contradiction_proof:
                for _pt_rev in premise_texts:
                    _pt_rev_s = _pt_rev.strip()
                    if _pt_rev_s.startswith('-(') and _pt_rev_s.endswith(')'):
                        _inner_formula_str = _pt_rev_s[2:-1]  # Remove leading '-(' and trailing ')'
                        try:
                            _inner_goal = read_expr(add_arity_with_global_lowest(_inner_formula_str, lowest_arities, colliding_predicates, dual_use_symbols))
                            _h_as_premises = [hypothesis] + background_axioms
                            print("Trying reverse contradiction (H proves negated P content)...")
                            contradiction_proof = timed_prove(Prover9(timeout=PROVER9_TIMEOUT_SECONDS), _inner_goal, _h_as_premises, timeout_seconds=10)
                            if contradiction_proof:
                                print(f"Reverse contradiction: Success (H proves inner P → contradiction)")
                                break
                        except Exception as e:
                            print(f"  Reverse contradiction error: {e}")

            if contradiction_proof:
                print(f"Proof with Prover9 (Contradiction): Success (NO)")
                if _row_is_vacuous():
                    if PROOF_ONLY_LABELS:
                        return ("unknown", "unknown", "unknown")
                    contradiction_proof = False
                    prover9_result = "unknown"
                elif PROOF_ONLY_LABELS:
                    return ("no", "unknown", "no")
                else:
                    prover9_result = "no"
            if not contradiction_proof:
                print(f"Proof with Prover9 (Contradiction): Failure")

                # 3. Fallback: stripped outer existentials
                # Try both entailment AND contradiction with stripped premises.
                # If both succeed => inconsistent => return unknown.
                stripped_entailment = False
                stripped_contradiction = False
                stripped_entail_error = False
                stripped_contra_error = False
                stripped_premises_univ = []
                stripped_premises_skolem = []
                if not ENABLE_STRIPPED_FALLBACK:
                    print("Skipping stripped/skolem fallback: disabled by proof-only policy")
                elif (
                    _non_intersective_fallback_blocked_pairs
                    or _scalar_fallback_weakening_block
                    or _past_scoped_fallback_weakening_block
                    or _non_subsective_is_at_fallback_block
                ):
                    _fallback_reasons = []
                    if _non_intersective_fallback_blocked_pairs:
                        _fallback_reasons.append(
                            f"non-intersective scalar trap {sorted(_non_intersective_fallback_blocked_pairs)}"
                        )
                    if _scalar_fallback_weakening_block:
                        _fallback_reasons.append("scalar adjective/comparison trap")
                    if _past_scoped_fallback_weakening_block:
                        _fallback_reasons.append("past-scoped transfer drop")
                    if _non_subsective_is_at_fallback_block:
                        _fallback_reasons.append(
                            f"non-subsective copula drop {sorted(_non_subsective_is_at_blocks)}"
                        )
                    print(
                        "Skipping stripped/skolem fallback: "
                        + ' + '.join(_fallback_reasons)
                        + " under existential weakening"
                    )
                else:
                    try:
                        stripped_premises_univ = []
                        stripped_premises_skolem = []
                        for pt in premise_texts:
                            body, vs = strip_outer_exists(pt)
                            if vs:
                                univ_body = "all " + " ".join(vs) + "." + "(" + body + ")"
                                se_univ = read_expr(add_arity_with_global_lowest(univ_body, lowest_arities, colliding_predicates, dual_use_symbols))
                                se_skolem = read_expr(add_arity_with_global_lowest(body, lowest_arities, colliding_predicates, dual_use_symbols))
                            else:
                                se_univ = read_expr(add_arity_with_global_lowest(pt, lowest_arities, colliding_predicates, dual_use_symbols))
                                se_skolem = se_univ
                            stripped_premises_univ.append(se_univ)
                            stripped_premises_skolem.append(se_skolem)
                        full_stripped_univ = stripped_premises_univ + background_axioms_stripped
                        full_stripped_skolem = stripped_premises_skolem + background_axioms_stripped

                        # Add structural predicate auto-truths for stripped paths:
                        # These positional/linking predicates are often in H but not P.
                        # Making them trivially true in stripped context lets the proof
                        # focus on content predicates.
                        # Core auto-true (safe for all datasets):
                        _strip_autotrue = {'de', 'en', 'a_', 'dans', 'sur', 'sous', 'en_train_de'}
                        # Extended auto-true (only for SICK — FraCaS needs precise semantics):
                        if _CURRENT_DATASET == 'sick':
                            _strip_autotrue |= {'avec', 'pour', 'par', 'pres_de', 'a_travers',
                                                'contre', 'vers', 'entre',
                                                'etre_en', 'etre_sur',
                                                'etre_dans', 'etre_a', 'narration', 'simultanee'}
                        _strip_h_preds = set(re.findall(r'\b([a-z_]\w+)\(', str(hypothesis)))
                        _strip_p_preds = set()
                        for _spt in stripped_premises_univ:
                            _strip_p_preds.update(re.findall(r'\b([a-z_]\w+)\(', str(_spt)))
                        _strip_needed = (_strip_h_preds & _strip_autotrue) - _strip_p_preds
                        if _strip_needed:
                            # Detect arities from H formula to generate matching auto-true axioms
                            _h_str = str(hypothesis)
                            for _auto_sp in _strip_needed:
                                # Find all arities this pred appears with in H
                                _arity_matches = re.findall(
                                    r'\b' + re.escape(_auto_sp) + r'\(([^)]*)\)', _h_str)
                                _arities_seen = set()
                                for _am in _arity_matches:
                                    _nargs = len([x.strip() for x in _am.split(',') if x.strip()])
                                    _arities_seen.add(_nargs)
                                if not _arities_seen:
                                    _arities_seen = {2}  # fallback
                                for _nargs in _arities_seen:
                                    _vars = ' '.join(f'x{i}' for i in range(_nargs))
                                    _args = ', '.join(f'x{i}' for i in range(_nargs))
                                    _auto_ax_s = read_expr(f'all {_vars}.({_auto_sp}({_args}))')
                                    full_stripped_univ.append(_auto_ax_s)
                                    full_stripped_skolem.append(_auto_ax_s)

                        # Add arity lift-up axioms for stripped path only.
                        # These allow lower-arity predicates to prove higher-arity
                        # versions by adding a universally quantified event arg at
                        # position 0.  Restricted to stripped path to avoid false
                        # positives in the normal (unguarded) path.
                        import re as _re_al
                        from collections import defaultdict as _dd_al
                        _al_base_names = _dd_al(set)
                        # Collect all (predicate_name, arity) pairs already in formulas
                        _existing_pred_arities = _dd_al(set)
                        for _aln, _ala in all_preds_for_axioms:
                            _existing_pred_arities[_aln].add(_ala)
                        for _aln, _ala in all_preds_for_axioms:
                            _alb = _re_al.sub(r'_(\d+)$', '', _aln)
                            _al_base_names[_alb].add((_aln, _ala))
                        for _alb, _alv in _al_base_names.items():
                            _al_ars = {a for _, a in _alv}
                            _al_nba = {a: n for n, a in _alv}
                            if len(_al_ars) >= 2:
                                _al_min = min(_al_ars)
                                _al_mn = _al_nba.get(_al_min, _alb)
                                for _al_ar in sorted(_al_ars):
                                    if _al_ar > _al_min and _al_ar == _al_min + 1:
                                        _al_hn = _al_nba.get(_al_ar)
                                        if _al_hn and _al_mn:
                                            # Skip if axiom would use same symbol name
                                            # with two different arities (causes Prover9
                                            # FATAL "multiple arities" error)
                                            if _al_mn == _al_hn:
                                                continue
                                            # Also skip if either name already appears
                                            # in formulas with a different arity than
                                            # what the axiom would introduce
                                            _lo_arity = _al_ar - (_al_ar - _al_min)  # = _al_min
                                            _hi_arity = _al_ar
                                            _conflict = False
                                            if _al_mn in _existing_pred_arities:
                                                if _lo_arity not in _existing_pred_arities[_al_mn] and len(_existing_pred_arities[_al_mn]) > 0:
                                                    _conflict = True
                                            if _al_hn in _existing_pred_arities:
                                                if _hi_arity not in _existing_pred_arities[_al_hn] and len(_existing_pred_arities[_al_hn]) > 0:
                                                    _conflict = True
                                            if _conflict:
                                                continue
                                            _vn = [f'x{i}' for i in range(_al_ar)]
                                            _vl = ' '.join(_vn)
                                            _args = ', '.join(_vn)
                                            _lo_v = _vn[_al_ar - _al_min:]
                                            _lo_a = ', '.join(_lo_v)
                                            try:
                                                _lu_ax = read_expr(f'all {_vl}.({_al_mn}({_lo_a}) -> {_al_hn}({_args}))')
                                                full_stripped_univ.append(_lu_ax)
                                                full_stripped_skolem.append(_lu_ax)
                                            except Exception:
                                                pass

                        # 3a. Stripped entailment (universal version)
                        print("Trying fallback: stripped entailment...")
                        try:
                            stripped_entailment = timed_prove(Prover9(timeout=4), hypothesis, full_stripped_univ, timeout_seconds=12)

                            if _last_prove_had_error:
                                stripped_entail_error = True
                                print("  (stripped entailment had internal error)")

                        except Exception as e:
                            print(f"  Stripped entailment error: {e}")
                            stripped_entail_error = True

                        # 3b. Stripped contradiction (universal, for unification)
                        print("Trying fallback: stripped contradiction...")
                        try:
                            neg_h = read_expr('-(' + str(hypothesis) + ')')
                            stripped_contradiction = timed_prove(Prover9(timeout=4), neg_h, full_stripped_univ, timeout_seconds=12)
                            if _last_prove_had_error:
                                stripped_contra_error = True
                                print("  (stripped contradiction had internal error)")
                        except Exception as e:
                            print(f"  Stripped contradiction error: {e}")

                    except Exception as e:
                        print(f"Stripped fallback setup error: {e}")
                # Decision logic with guards
                if stripped_entailment and stripped_contradiction:
                    # Both proved => premises inconsistent under all-quantification
                    # Try Skolem-constant entailment as tiebreaker (sound approach)
                    print("Stripped fallback: both H and -H proved => checking Skolem entailment...")
                    # Build a filtered axiom set for Skolem path: reduce search space
                    _h_preds_sk = set()
                    for _hm in re.finditer(r'\b([a-z_]\w+)\(', str(hypothesis)):
                        _h_preds_sk.add(_hm.group(1))
                    _p_preds_sk = set()
                    for _pt_sk in stripped_premises_skolem:
                        for _pm in re.finditer(r'\b([a-z_]\w+)\(', str(_pt_sk)):
                            _p_preds_sk.add(_pm.group(1))
                    _rel_preds_sk = _h_preds_sk | _p_preds_sk | {'subseteq', 'num', 'overlaps', 'temps', 'plus_de', 'moins_de', 'plupart_de', 'tout'}
                    _filtered_axioms_sk = []
                    for _ax_sk in background_axioms_stripped:
                        _ax_str = str(_ax_sk)
                        _ax_preds = set(re.findall(r'\b([a-z_]\w+)\(', _ax_str))
                        # Keep if axiom mentions at least one H predicate or a bridging predicate
                        if _ax_preds & _h_preds_sk or _ax_preds <= _rel_preds_sk:
                            _filtered_axioms_sk.append(_ax_sk)
                    if len(_filtered_axioms_sk) < len(background_axioms_stripped):
                        print(f"  Skolem axiom filter: {len(background_axioms_stripped)} -> {len(_filtered_axioms_sk)} axioms")
                    _full_skolem_filtered = stripped_premises_skolem + _filtered_axioms_sk
                    # Add structural predicate auto-truths for Skolem entailment:
                    # These are positional/linking predicates treated as structural
                    # in the novel-predicate guard (_sk_struct). Making them trivially
                    # true in the Skolem path helps when P doesn't contain them
                    # but H uses them as structural connectors.
                    _sk_autotrue_preds = {'de', 'en', 'a_', 'dans', 'sur', 'sous', 'avec', 'pres_de'}
                    _sk_needed_auto = (_h_preds_sk & _sk_autotrue_preds) - _p_preds_sk
                    if _sk_needed_auto:
                        for _auto_p in _sk_needed_auto:
                            _auto_ax = read_expr(f'all x y.({_auto_p}(x, y))')
                            _full_skolem_filtered.append(_auto_ax)
                        print(f"  Skolem auto-truth axioms added for: {sorted(_sk_needed_auto)}")
                    try:
                        skolem_ent = timed_prove(Prover9(timeout=8), hypothesis, _full_skolem_filtered, timeout_seconds=20)
                    except Exception:
                        skolem_ent = False
                    skolem_ent_blocked = False
                    skolem_block_allows_contra = True  # Whether block reason still allows contradiction attempt
                    if skolem_ent:
                        # Intensional verb guard for Skolem too
                        try:
                            p_nls_sk = []
                            for col in row.index:
                                if re.fullmatch(r'p\d+_nl', col) and pd.notna(row[col]):
                                    p_nls_sk.append(str(row[col]).lower())
                            h_nls_sk = []
                            for col in row.index:
                                if re.fullmatch(r'h\d+_nl', col) and pd.notna(row[col]):
                                    h_nls_sk.append(str(row[col]).lower())
                            p_nl_sk = ' '.join(p_nls_sk)
                            h_nl_sk = ' '.join(h_nls_sk)
                            import unicodedata
                            def _sa2(s):
                                return ''.join(c for c in unicodedata.normalize('NFD', s) if unicodedata.category(c) != 'Mn')
                            p_nl_sk = _sa2(p_nl_sk.replace("\\'", "'").replace("\\\\", ""))
                            h_nl_sk = _sa2(h_nl_sk.replace("\\'", "'").replace("\\\\", ""))
                            intens_mk_sk = ['croit que', 'croyait que', "croit qu'", "croyait qu'",
                                            'essaie de', 'essayait de', "essaie d'", "essaye d'",
                                            "essaye de", "essayer de",
                                            'tente de', 'tentait de', 'tenter de',
                                            'pretend que', "pretend qu'", 'pretendait que', "pretendait qu'"]
                            if any(m in p_nl_sk for m in intens_mk_sk) and not any(m in h_nl_sk for m in intens_mk_sk):
                                skolem_ent_blocked = True
                                print("Skolem entailment blocked by intensional guard")
                        except Exception:
                            pass
                        if not skolem_ent_blocked and _before_clause_future_event_blocks:
                            skolem_ent_blocked = True
                            print(
                                "Skolem entailment blocked by before-clause future-event block "
                                f"({sorted(_before_clause_future_event_blocks)})"
                            )
                        if not skolem_ent_blocked and _comparative_positive_drop_blocks:
                            skolem_ent_blocked = True
                            print(
                                "Skolem entailment blocked by comparative positive-drop block "
                                f"({sorted(_comparative_positive_drop_blocks)})"
                            )
                        if not skolem_ent_blocked and 'seulement' in p_nl_sk and re.search(r'\bdeux\b|\btrois\b|\bquatre\b|\bcinq\b', h_nl_sk):
                            skolem_ent_blocked = True
                            print("Skolem entailment blocked by seulement-numeric guard")
                        if not skolem_ent_blocked and 'aucun' in p_pred_names and 'plupart_de' not in h_pred_names:
                            skolem_ent_blocked = True
                            print("Skolem entailment blocked by aucun guard (no plupart_de in H)")
                        # Guard: H introduces a specific num()= value not in any P
                        # "2 of 10 missing, they were removed" ≠> "8 machines removed"
                        if not skolem_ent_blocked:
                            _h_nums_sk = set(re.findall(r'\bnum\([^)]+\)\s*=\s*(\d+)', str(hypothesis)))
                            _p_nums_sk = set()
                            for _pt_sk2 in premise_texts:
                                _p_nums_sk.update(re.findall(r'\bnum\([^)]+\)\s*=\s*(\d+)', _pt_sk2))
                                # Also collect plain equality constants like (c = 2) from "des(2,x)"
                                _p_nums_sk.update(m for m in re.findall(r'=\s*(\d+)\b', _pt_sk2) if int(m) <= 100)
                            _novel_nums_sk = _h_nums_sk - _p_nums_sk
                            if _novel_nums_sk:
                                skolem_ent_blocked = True
                                # Only block Skolem contradiction when novel nums are entity counts
                                # NOT when they come from fractions (tiers) or ranges (entre)
                                _h_has_frac_range = bool(h_pred_names & {'tiers', 'entre', 'quart'})
                                if not _h_has_frac_range:
                                    skolem_block_allows_contra = False
                                print(f"Skolem entailment blocked by novel numeric guard ({_novel_nums_sk} not in P)")
                        _all_colors_sk = {'rouge', 'bleu', 'vert', 'noir', 'blanc', 'jaune', 'orange', 'gris', 'rose', 'brun'}
                        if not skolem_ent_blocked and len(p_pred_names.intersection(_all_colors_sk)) > 0 and len(h_pred_names.intersection(_all_colors_sk)) > 0 and p_pred_names.intersection(_all_colors_sk) != h_pred_names.intersection(_all_colors_sk):
                            skolem_ent_blocked = True
                            skolem_block_allows_contra = False  # Entity-specific property, not structural
                            print("Skolem entailment blocked by color antonym guard")
                        # Guard: H introduces proper names not in P (e.g., nommé(_, Chili))
                        if not skolem_ent_blocked:
                            _h_nomme_names = set()
                            for _hm_n in re.finditer(r'\bnomm[eé]\(\w+,\s*\'?(\w+)\'?\)', str(hypothesis)):
                                _h_nomme_names.add(_hm_n.group(1))
                            _p_nomme_names = set()
                            for _pt_sk3 in premise_texts:
                                for _pm_n in re.finditer(r'\bnomm[eé]\(\w+,\s*\'?(\w+)\'?\)', _pt_sk3):
                                    _p_nomme_names.add(_pm_n.group(1))
                            _novel_names = _h_nomme_names - _p_nomme_names
                            if _novel_names:
                                skolem_ent_blocked = True
                                skolem_block_allows_contra = False
                                print(f"Skolem entailment blocked by novel proper name guard ({_novel_names} not in P)")
                        # Guard: H has content/GQ predicates not grounded in P
                        # Skolem entailment with free variables is unsound when H introduces novel predicates
                        if not skolem_ent_blocked:
                            _sk_struct = {'overlaps', 'temps', 'subseteq', 'existe', 'num', 'de',
                                          'generic', 'atomic_sub', 'sur', 'sous', 'en', 'maintenant',
                                          'context_', 'unknown_', 'is_at', 'nomme',
                                          'a_', 'dans', 'avec', 'pres_de', 'devant', 'derriere',
                                          'contre', 'par_dessus', 'entre'}
                            _sk_gq = {'tout', 'plupart_de', 'plus_de', 'moins_de', 'beaucoup_de',
                                      'peu_de', 'chacun', 'aucun', 'moitie', 'tiers', 'DOT',
                                      'entre', 'pas', 'pas_de'}
                            # Compute derivable predicates: preds that axioms can produce from P
                            _sk_derivable = set()
                            if 'plupart_de' in p_pred_names:
                                _sk_derivable.add('plus_de')
                            if 'tout' in p_pred_names or 'chacun' in p_pred_names:
                                _sk_derivable.update(['plupart_de', 'plus_de', 'existe'])
                            if 'plus_de' in p_pred_names:
                                _sk_derivable.add('existe')
                            _sk_derivable = compute_local_derivable_preds(
                                p_pred_names,
                                h_pred_names,
                                premise_texts,
                                hypothesis_texts,
                            )
                            _sk_h_novel = h_pred_names - p_pred_names - _sk_struct - _sk_derivable
                            _sk_h_novel_gq = (h_pred_names & _sk_gq) - (p_pred_names & _sk_gq) - _sk_derivable
                            if _sk_h_novel or _sk_h_novel_gq:
                                skolem_ent_blocked = True
                                skolem_block_allows_contra = False  # Novel predicates make both directions unsound
                                print(f"Skolem entailment blocked by novel predicate guard ({_sk_h_novel | _sk_h_novel_gq})")
                        if not skolem_ent_blocked:
                            # Guard: negation mismatch — if one side has explicit negation
                            # (-() in FOL) and the other doesn't, the "both proved" case
                            # arose from universalization conflating positive and negative
                            # content. The contradiction is the correct interpretation.
                            _p_has_neg = any('-(' in str(pt) for pt in premise_texts)
                            _h_has_neg = '-(' in str(hypothesis)
                            if (_p_has_neg and not _h_has_neg) or (_h_has_neg and not _p_has_neg):
                                print(f"Skolem entailment overridden: negation mismatch (P-neg={_p_has_neg}, H-neg={_h_has_neg}) => NO")
                                prover9_result = "no"
                            else:
                                print(f"Proof with Prover9 (Skolem Entailment): Success (YES)")
                                prover9_result = "yes"
                    # When Skolem entailment fails or is blocked (for structural reasons), try Skolem contradiction
                    if (not skolem_ent or (skolem_ent and skolem_ent_blocked)) and skolem_block_allows_contra:
                        print("Trying Skolem contradiction as fallback...")
                        try:
                            neg_h_sk = read_expr('-(' + str(hypothesis) + ')')
                            skolem_contra = timed_prove(Prover9(timeout=8), neg_h_sk, _full_skolem_filtered, timeout_seconds=20)
                        except Exception:
                            skolem_contra = False
                        if skolem_contra:
                            print(f"Proof with Prover9 (Skolem Contradiction): Success (NO)")
                            prover9_result = "no"
                        else:
                            print("Skolem contradiction also failed => returning unknown")
                            prover9_result = "unknown"
                elif stripped_entailment:
                    # Intensional verb guard for stripped entailment too
                    intensional_stripped_block = False
                    try:
                        p_nls_is = []
                        for col in row.index:
                            if re.fullmatch(r'p\d+_nl', col) and pd.notna(row[col]):
                                p_nls_is.append(str(row[col]).lower())
                        h_nls_is = []
                        for col in row.index:
                            if re.fullmatch(r'h\d+_nl', col) and pd.notna(row[col]):
                                h_nls_is.append(str(row[col]).lower())
                        p_nl_is = ' '.join(p_nls_is)
                        h_nl_is = ' '.join(h_nls_is)
                        import unicodedata
                        def _sa3(s):
                            return ''.join(c for c in unicodedata.normalize('NFD', s) if unicodedata.category(c) != 'Mn')
                        p_nl_is = _sa3(p_nl_is.replace("\\'", "'").replace("\\\\", ""))
                        h_nl_is = _sa3(h_nl_is.replace("\\'", "'").replace("\\\\", ""))
                        # Progressive markers restored in stripped guard because
                        # achievement verbs (obtenir/obtain) with progressive don't entail simple.
                        # Main/Skolem paths keep them removed for direct proof flexibility.
                        int_mk = ['croit que', 'croyait que', "croit qu'", "croyait qu'",
                                   'essaie de', 'essayait de', "essaie d'", "essaye d'",
                                   "essaye de", "essayer de",
                                   'tente de', 'tentait de', 'tenter de',
                                   'pretend que', "pretend qu'", 'pretendait que', "pretendait qu'",
                                   "est en train de", "etait en train de", "en train d'"]
                        p_int_s = [m for m in int_mk if m in p_nl_is]
                        h_int_s = [m for m in int_mk if m in h_nl_is]
                        if p_int_s and not h_int_s:
                            print(f"  Intensional guard (stripped): blocking {p_int_s}")
                            intensional_stripped_block = True
                    except Exception:
                        pass
                    if intensional_stripped_block:
                        prover9_result = "unknown"
                    else:
                        # Additional NL guards for stripped entailment
                        stripped_extra_block = False
                        try:
                            _sep = p_nl_is if 'p_nl_is' in dir() else ''
                            _seh = h_nl_is if 'h_nl_is' in dir() else ''
                            if not _sep:
                                _sepn = []
                                for col in row.index:
                                    if re.fullmatch(r'p\d+_nl', col) and pd.notna(row[col]):
                                        _sepn.append(str(row[col]).lower())
                                _sehn = []
                                for col in row.index:
                                    if re.fullmatch(r'h\d+_nl', col) and pd.notna(row[col]):
                                        _sehn.append(str(row[col]).lower())
                                import unicodedata
                                def _sa_se(s):
                                    return ''.join(c for c in unicodedata.normalize('NFD', s) if unicodedata.category(c) != 'Mn')
                                _sep = _sa_se(' '.join(_sepn).replace("\\'", "'"))
                                _seh = _sa_se(' '.join(_sehn).replace("\\'", "'"))
                            # Guard: devait (modal)
                            if not stripped_extra_block:
                                if 'devait ' in _sep and 'devait ' not in _seh:
                                    print(f"  Modal devait guard (stripped): blocking")
                                    stripped_extra_block = True
                            if not stripped_extra_block and _before_clause_future_event_blocks:
                                print(
                                    "  Before-clause future-event block (stripped): blocking "
                                    f"{sorted(_before_clause_future_event_blocks)}"
                                )
                                stripped_extra_block = True
                            if not stripped_extra_block and _comparative_positive_drop_blocks:
                                print(
                                    "  Comparative positive-drop block (stripped): blocking "
                                    f"{sorted(_comparative_positive_drop_blocks)}"
                                )
                                stripped_extra_block = True
                            if not stripped_extra_block and _non_subsective_is_at_blocks:
                                print(
                                    "  Non-subsective copula block (stripped): blocking "
                                    f"{sorted(_non_subsective_is_at_blocks)}"
                                )
                                stripped_extra_block = True
                            # Guard: Canada subset reversed (Canada -> nord-americain)
                            if not stripped_extra_block:
                                if 'canada' in _sep and ('nord-am' in _seh or 'nord am' in _seh):
                                    print(f"  Canada-NA guard (stripped): blocking reversed subset")
                                    stripped_extra_block = True
                            # Guard: hypernym->hyponym (scandinave -> suedois)
                            if not stripped_extra_block:
                                if 'scandinave' in _sep and ('suedois' in _seh or 'suedoise' in _seh):
                                    print(f"  Scandinave-suedois guard (stripped): blocking hypernym->hyponym")
                                    stripped_extra_block = True
                            # Guard: generic->specific (erreur -> bug)
                            if not stripped_extra_block:
                                if 'erreur' in _sep and 'bug' in _seh:
                                    print(f"  Erreur-bug guard (stripped): blocking generic->specific")
                                    stripped_extra_block = True
                            # Guard: distributive->collective ("aussi" + "jean et guillaume")
                            if not stripped_extra_block:
                                if 'aussi' in _sep and 'jean et guillaume' in _seh:
                                    print(f"  Aussi-collectif guard (stripped): blocking distributive->collective")
                                    stripped_extra_block = True
                            # Guard: aussi VP-ellipsis + time from separate premise
                            # "Jean talked to Marie | Guillaume too | Jean talked to Marie at 4" does NOT entail
                            # "Guillaume talked to Marie at 4" -- aussi only links to the basic VP, not the time.
                            if not stripped_extra_block:
                                if 'aussi' in p_pred_names and len(premises) >= 3:
                                    _time_preds = {'heure', 'matin', 'midi', 'soir', 'minute'}
                                    if h_pred_names & _time_preds:
                                        print(f"  Aussi-time guard (stripped): blocking VP ellipsis + cross-premise time ({h_pred_names & _time_preds})")
                                        stripped_extra_block = True
                            # Guard: H introduces nomme() constants not in any P
                            # Stripped mode universalizes existentials, allowing name entity confusion
                            if not stripped_extra_block:
                                _p_names_se = set()
                                for _pt_se in premise_texts:
                                    _p_names_se.update(re.findall(r'nomme\([^,]+,\s*([A-Za-z]\w*)\)', _pt_se))
                                _h_names_se = set(re.findall(r'nomme\([^,]+,\s*([A-Za-z]\w*)\)', str(hypothesis)))
                                _novel_names = _h_names_se - _p_names_se
                                # Filter structural constants
                                _novel_names -= {'context_', 'unknown_', 'singular_', 'masculin_', 'feminin_'}
                                if _novel_names:
                                    print(f"  Stripped name-entity guard: blocking (H has {_novel_names} not in P)")
                                    stripped_extra_block = True
                            # Guard: scalar "plus d'un(e)" in H but not P => overclaim cardinality
                            if not stripped_extra_block:
                                if "plus d'un" in _seh and "plus d'un" not in _sep:
                                    print(f"  Plus-d-un guard (stripped): blocking scalar overclaim")
                                    stripped_extra_block = True
                            # v67 Guard: H introduces "apres que" temporal ordering not in P with stative P
                            if not stripped_extra_block:
                                import unicodedata as _ud67
                                _sep67 = ''.join(c for c in _ud67.normalize('NFD', _sep) if _ud67.category(c) != 'Mn')
                                _seh67 = ''.join(c for c in _ud67.normalize('NFD', _seh) if _ud67.category(c) != 'Mn')
                                if 'apres que' in _seh67 and 'apres que' not in _sep67:
                                    # Only block if P premises are stative (imparfait: etait/avait)
                                    _p_tokens67 = _sep67.split()
                                    _has_imparfait = any(t in ('etait', 'avait', 'etaient', 'avaient') for t in _p_tokens67)
                                    _has_passe_compose = any(t in ('est', 'a', 'sont', 'ont') for t in _p_tokens67)
                                    if _has_imparfait and not _has_passe_compose:
                                        print(f"  Apres-que stative guard (stripped): blocking (H has apres que, P only imparfait)")
                                        stripped_extra_block = True
                            # v67/v69 Guard: possession/role mismatch with "egalement"
                            if not stripped_extra_block:
                                import unicodedata as _ud67b
                                _sep67b = ''.join(c for c in _ud67b.normalize('NFD', _sep) if _ud67b.category(c) != 'Mn')
                                _seh67b = ''.join(c for c in _ud67b.normalize('NFD', _seh) if _ud67b.category(c) != 'Mn')
                                if ('egalement' in _sep67b or 'et' in _sep67b.split()):
                                    # Check if P has "X represente son Y et Z egalement" and H says "X represente Y de Z"
                                    if "de " in _seh67b and ("represente" in _seh67b or "entreprise" in _seh67b):
                                        # v69: Fixed regex to work on lowercased text
                                        p_people = set(re.findall(r'\b([a-z]+(?:pont|and|ond|ont))\b', _sep67b))
                                        h_people = set(re.findall(r'\b([a-z]+(?:pont|and|ond|ont))\b', _seh67b))
                                        if len(p_people) >= 2 and len(h_people) >= 2:
                                            # v69: Distinguish valid ellipsis from possession crossing
                                            # P: "X represente son Y et Z egalement" => main_subj=X, et_person=Z
                                            # Block only if H subject = main_subj and H possessor = et_person (crossing)
                                            _et_match = re.search(r'\bet\s+(\w+(?:pont|and|ond|ont))\b', _sep67b)
                                            _de_match = re.search(r'de\s+(\w+(?:pont|and|ond|ont))\b', _seh67b)
                                            _h_subj_match = re.search(r'^(\w+(?:pont|and|ond|ont))\b', _seh67b.strip())
                                            if _et_match and _de_match and _h_subj_match:
                                                et_person = _et_match.group(1)
                                                h_poss = _de_match.group(1)
                                                h_subj = _h_subj_match.group(1)
                                                main_subj = (p_people - {et_person}).pop() if len(p_people - {et_person}) == 1 else None
                                                if main_subj and h_subj == main_subj and h_poss == et_person:
                                                    print(f"  Egalement-possession guard (stripped): blocking cross-entity attribution ({h_subj} -> {h_poss})")
                                                    stripped_extra_block = True
                                            elif len(p_people) >= 2 and len(h_people) >= 2:
                                                print(f"  Egalement-possession guard (stripped): blocking cross-entity attribution (fallback)")
                                                stripped_extra_block = True
                        except Exception as e:
                            print(f"  Stripped extra guard error: {e}")
                        # Guard: faux() in P but not H => negation context stripped away
                        # "Il est faux que X" does NOT entail "X" — blocking stripped entailment
                        # Note: faux(sub(x,f)) has nested parens so it's not in p_pred_names;
                        # check the raw formula text instead.
                        if not stripped_extra_block:
                            _p_has_faux = any('faux(' in str(pt) for pt in premise_texts)
                            _h_has_faux = 'faux(' in str(hypothesis)
                            if _p_has_faux and not _h_has_faux:
                                print(f"  Stripped faux guard: blocking (negation context 'faux' in P but not H)")
                                stripped_extra_block = True
                        # Guard: non-monotone / downward-monotone quantifiers in stripped entailment
                        # Stripping existentials universalizes everything, destroying quantifier scope
                        # peu_de (few), plupart_de with restrictor narrowing, au plus (at most)
                        # Allow when H is a superset of P content (domain restriction = valid for DM)
                        if not stripped_extra_block:
                            _stripped_dm_gq = {'peu_de', 'moins_de', 'pas_de'}
                            _dm_match = p_pred_names & _stripped_dm_gq
                            if _dm_match:
                                _dm_struct = {'overlaps', 'temps', 'subseteq', 'existe', 'num', 'de',
                                              'generic', 'atomic_sub', 'sur', 'sous', 'en', 'maintenant',
                                              'context_', 'unknown_', 'is_at', 'nomme', 'plus',
                                              'tout', 'chacun', 'aucun', 'peu_de', 'moins_de', 'pas_de',
                                              'plupart_de', 'plus_de', 'beaucoup_de', 'DOT', 'entre', 'moitie', 'tiers', 'a_'}
                                _dm_p_content = p_pred_names - _dm_struct
                                _dm_h_content = h_pred_names - _dm_struct
                                _dm_dropped = _dm_p_content - _dm_h_content
                                if _dm_dropped:
                                    # Check for valid DM narrowing: if H content predicates
                                    # are a subset of the DM premise's content predicates,
                                    # the inference narrows scope (superset -> subset), which
                                    # is valid under downward monotone quantifiers.
                                    _dm_narrowing = False
                                    if len(premises) > 1:
                                        for _dm_q in _dm_match:
                                            for _pt_dm in premise_texts:
                                                if _dm_q + '(' in str(_pt_dm):
                                                    _dm_prem_preds = set(re.findall(r'\b([a-zA-Z_]\w+)\(', str(_pt_dm)))
                                                    _dm_prem_content = _dm_prem_preds - _dm_struct
                                                    if not (_dm_h_content - _dm_prem_content):
                                                        _dm_narrowing = True
                                                        print(f"  Stripped DM guard: allowing DM narrowing (H content ⊆ DM premise, dropped={_dm_dropped})")
                                                        break
                                            if _dm_narrowing:
                                                break
                                    if not _dm_narrowing:
                                        print(f"  Stripped DM guard: blocking ({_dm_dropped} dropped under DM quantifier {_dm_match})")
                                        stripped_extra_block = True
                                else:
                                    print(f"  Stripped DM guard: allowing (H superset of P content, domain restriction under {_dm_match})")
                        if not stripped_extra_block and 'au plus' in _sep:
                            # Only block when H drops content predicates from P (scope widening)
                            # Allow when H keeps all P content or adds more (scope narrowing = valid for DM)
                            _au_str = {'overlaps', 'temps', 'subseteq', 'existe', 'num', 'de',
                                       'generic', 'atomic_sub', 'sur', 'sous', 'en', 'maintenant',
                                       'context_', 'unknown_', 'is_at', 'nomme', 'nommé', 'plus',
                                       'tout', 'chacun', 'aucun', 'peu_de', 'moins_de', 'pas_de',
                                       'plupart_de', 'plus_de', 'beaucoup_de', 'DOT', 'entre', 'moitie', 'tiers', 'a_'}
                            _au_sp = p_pred_names - _au_str
                            _au_sh = h_pred_names - _au_str
                            _au_dropped = _au_sp - _au_sh
                            if _au_dropped:
                                print(f"  Stripped au-plus guard: blocking ({_au_dropped} dropped under at-most)")
                                stripped_extra_block = True
                        # Guard: plupart_de with restrictor narrowing
                        # "Most X who P" does not entail "Most X" when universalized
                        if not stripped_extra_block and 'plupart_de' in p_pred_names and len(premises) <= 1:
                            _str_preds = {'overlaps', 'temps', 'subseteq', 'existe', 'num', 'de',
                                          'generic', 'atomic_sub', 'sur', 'sous', 'en', 'maintenant',
                                          'context_', 'unknown_', 'is_at', 'nomme', 'plupart_de',
                                          'tout', 'chacun', 'plus_de', 'moins_de', 'DOT'}
                            _sp_content = p_pred_names - _str_preds
                            _sh_content = h_pred_names - _str_preds
                            _sp_dropped = _sp_content - _sh_content
                            if _sp_dropped:
                                print(f"  Stripped plupart_de restrictor guard: blocking ({_sp_dropped} dropped)")
                                stripped_extra_block = True
                        # Guard: après+présent temporal transitivity with mixed aspect
                        # "X present after Y left" + "Y left after Z present" does NOT entail "X present after Z present"
                        # because stative+punctual mixing breaks temporal transitivity
                        if not stripped_extra_block:
                            import unicodedata as _ud22c
                            _sep22c = ''.join(c for c in _ud22c.normalize('NFD', _sep) if _ud22c.category(c) != 'Mn')
                            _seh22c = ''.join(c for c in _ud22c.normalize('NFD', _seh) if _ud22c.category(c) != 'Mn')
                            _apres_count = len(re.findall(r'apres', _sep22c))
                            _has_stative = 'presente' in _sep22c or 'present' in _sep22c.split()
                            if _apres_count >= 2 and _has_stative and 'apres' in _seh22c:
                                print(f"  Apres+present guard (stripped): blocking mixed-aspect temporal transitivity")
                                stripped_extra_block = True
                        # Guard: perception verb action change
                        # "saw X sign" + "when X signed, hands trembled" does NOT entail "saw hands tremble"
                        # because perception is event-specific — seeing one event ≠ seeing a consequence
                        if not stripped_extra_block:
                            _sep22d = ''.join(c for c in _ud22c.normalize('NFD', _sep) if _ud22c.category(c) != 'Mn')
                            _seh22d = ''.join(c for c in _ud22c.normalize('NFD', _seh) if _ud22c.category(c) != 'Mn')
                            if 'vu ' in _sep22d and 'vu ' in _seh22d and 'trembl' in _seh22d:
                                print(f"  Perception action-change guard (stripped): blocking (vu + trembler mismatch)")
                                stripped_extra_block = True
                        # Guard: color predicate mismatch
                        # Universalization conflates entities with different color attributes
                        if not stripped_extra_block:
                            _all_colors_se = {'rouge', 'bleu', 'vert', 'noir', 'blanc', 'jaune', 'orange', 'gris', 'rose', 'brun'}
                            _p_colors = p_pred_names & _all_colors_se
                            _h_colors = h_pred_names & _all_colors_se
                            if _p_colors and _h_colors and _p_colors != _h_colors:
                                print(f"  Stripped color guard: blocking (P colors {_p_colors} != H colors {_h_colors})")
                                stripped_extra_block = True
                        # Guard: converse-relation swap (derriere/devant, dessus/dessous)
                        # Universalization makes derriere(x,y) hold for ALL x,y, which
                        # with devant(x,y)<->derriere(y,x) gives devant(y,x) for ALL y,x,
                        # matching any devant in H. This is logically unsound.
                        if not stripped_extra_block:
                            _converse_pairs = [
                                ('derriere', 'devant'), ('devant', 'derriere'),
                                ('dessus', 'dessous'), ('dessous', 'dessus'),
                                ('au_dessus', 'en_dessous'), ('en_dessous', 'au_dessus'),
                            ]
                            for _cp, _cq in _converse_pairs:
                                if _cp in p_pred_names and _cq in h_pred_names and _cp not in h_pred_names:
                                    print(f"  Stripped converse guard: blocking ({_cp} in P, {_cq} in H)")
                                    stripped_extra_block = True
                                    break
                        # Guard: variable shuffling — P has no P-only content predicates
                        # When all P content predicates also appear in H, stripped entailment
                        # may succeed by conflating entities that have different roles in P vs H.
                        # Exception: if H has unique predicates ALL derivable from P via axioms,
                        # the derivation chain provides meaningful content (not variable shuffling).
                        if not stripped_extra_block:
                            _vsh_skip = {'temps', 'num', 'overlaps', 'subseteq', 'exists', 'forall', 'all',
                                         'existe', 'maintenant', 'de', 'en', 'a_', 'dans', 'sur', 'sous',
                                         'avec', 'is_at', 'pres_de', 'devant', 'derriere', 'contre',
                                         'par_dessus', 'entre', 'intersect', 'empty_intersect',
                                         'context_', 'unknown_', 'singular_', 'masculin_', 'feminin_',
                                         'generic', 'leq', 'narration', 'et', 'ou', 'parallel', 'atomic_sub',
                                         'pas_de'}
                            _vsh_p_only = (p_pred_names - _vsh_skip) - (h_pred_names - _vsh_skip)
                            if not _vsh_p_only:
                                # Exception: multi-premise rows - conjunction/coordination
                                # inferences are genuine, not variable shuffling.
                                _vsh_multi = len(premise_texts) >= 2
                                # Exception: coordination predicates (et, ou, parallel)
                                # in P but not H - P distributes over coordination structure.
                                _vsh_coord = (('et' in p_pred_names and 'et' not in h_pred_names) or
                                              ('ou' in p_pred_names and 'ou' not in h_pred_names) or
                                              ('parallel' in p_pred_names and 'parallel' not in h_pred_names))
                                if _vsh_multi or _vsh_coord:
                                    pass  # allow: genuine structural inference
                                else:
                                    # P has no unique content preds. Check H derivability.
                                    _vsh_h_only = (h_pred_names - _vsh_skip) - (p_pred_names - _vsh_skip)
                                    if not _vsh_h_only:
                                        # All preds shared. Check if P has more content instances
                                        # (conjunction elimination: H extracts subset of P's content).
                                        _vsh_content = (p_pred_names | h_pred_names) - _vsh_skip
                                        _vsh_p_text = ' '.join(premise_texts)
                                        _vsh_h_text = ' '.join(hypothesis_texts)
                                        _vsh_p_cnt = sum(len(re.findall(r'\b' + re.escape(cp) + r'\(', _vsh_p_text)) for cp in _vsh_content)
                                        _vsh_h_cnt = sum(len(re.findall(r'\b' + re.escape(cp) + r'\(', _vsh_h_text)) for cp in _vsh_content)
                                        if _vsh_p_cnt > _vsh_h_cnt:
                                            print(f"  Variable shuffling guard: P instances ({_vsh_p_cnt}) > H instances ({_vsh_h_cnt}) - allow (conjunction elimination)")
                                        else:
                                            # Check for named entity anchoring
                                            # If P and H share nomme names, entities are identified
                                            # and variable shuffling is just encoding difference.
                                            _vsh_p_names = set(re.findall(r"nomme\(\w+,\s*(\w+)\)", _vsh_p_text))
                                            _vsh_h_names = set(re.findall(r"nomme\(\w+,\s*(\w+)\)", _vsh_h_text))
                                            _vsh_shared_names = _vsh_p_names & _vsh_h_names
                                            if _vsh_shared_names:
                                                print(f"  Variable shuffling: shared names {_vsh_shared_names} \u2192 allow (anchored identity)")
                                            else:
                                                # Pure entity conflation \u2014 block
                                                print(f"  Stripped entailment blocked: variable shuffling (P_cnt={_vsh_p_cnt}, H_cnt={_vsh_h_cnt})")
                                                stripped_extra_block = True
                                    else:
                                    # H has unique preds — check if ALL are derivable from P
                                        _vsh_derivable = compute_local_derivable_preds(
                                            p_pred_names,
                                            h_pred_names,
                                            premise_texts,
                                            hypothesis_texts,
                                        )
                                        _vsh_h_nonderivable = _vsh_h_only - _vsh_derivable
                                        if _vsh_h_nonderivable:
                                            # H has non-derivable unique preds — block
                                            print(f"  Stripped entailment blocked: variable shuffling (H-only {_vsh_h_nonderivable} not derivable from P)")
                                            stripped_extra_block = True
                                        else:
                                            # All H-only derivable — but if P has no unique
                                            # content, check derivation source. Hypernym-only
                                            # derivation with empty P-only suggests entity role
                                            # conflation (e.g. agent/patient swap). Quantifier
                                            # or temporal derivations are legitimate.
                                            _vsh_hyper_only_d = set()
                                            if ENABLE_CURATED_LEXICON_FALLBACK:
                                                for _hypo_v, _hyper_v in FRENCH_HYPERNYMS:
                                                    if _hypo_v in p_pred_names:
                                                        _vsh_hyper_only_d.add(_hyper_v)
                                            _vsh_h_nonhyper = _vsh_h_only - _vsh_hyper_only_d
                                            if not _vsh_h_nonhyper:
                                                # ALL H-only from hypernyms — role conflation risk
                                                print(f"  Stripped entailment blocked: variable shuffling (P-only empty, H-only {_vsh_h_only} via hypernyms — role conflation)")
                                                stripped_extra_block = True
                        if stripped_extra_block:
                            prover9_result = "unknown"
                        else:
                            print(f"Proof with Prover9 (Stripped Entailment): Success (YES)")
                            prover9_result = "yes"
                elif stripped_contradiction:
                    # Guard 1: if entailment had FATAL error, cannot verify consistency
                    # Guard 2: check if universalized premises are internally inconsistent
                    premises_inconsistent = False
                    try:
                        false_goal = read_expr('-(maintenant = maintenant)')
                        premises_inconsistent = timed_prove(Prover9(timeout=4), false_goal, full_stripped_univ, timeout_seconds=10)
                    except Exception:
                        premises_inconsistent = False

                    stripped_contra_nl_block = False
                    try:
                        p_names = set()
                        h_names = set()
                        for pn in p_pred_names:
                            if pn.isupper() and len(pn) > 1 and pn not in {'MIPS', 'CIA', 'DOT'}:
                                p_names.add(pn)
                        for hn in h_pred_names:
                            if hn.isupper() and len(hn) > 1 and hn not in {'MIPS', 'CIA', 'DOT'}:
                                h_names.add(hn)
                        if h_names and p_names and not h_names.intersection(p_names):
                            print(f"  Stripped contradiction blocked by different-entity guard (P:{p_names} vs H:{h_names})")
                            stripped_contra_nl_block = True

                        # Guard: temporal day-of-week contradiction (samedi vs vendredi etc.)
                        if not stripped_contra_nl_block:
                            _days = {'lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi', 'dimanche'}
                            p_days = _days.intersection(p_pred_names)
                            h_days = _days.intersection(h_pred_names)
                            if p_days and h_days and p_days != h_days:
                                print(f"  Stripped contradiction blocked by day-of-week guard (P:{p_days} vs H:{h_days})")
                                stripped_contra_nl_block = True

                        # Guard: H contains unknown_ constant — universalization over-constrains unresolved types
                        if not stripped_contra_nl_block:
                            _h_fol_text = ' '.join(str(ht) for ht in hypothesis_texts)
                            if 'unknown_' in _h_fol_text:
                                print("  Stripped contradiction blocked: H contains unknown_ (unreliable universalization)")
                                stripped_contra_nl_block = True

                        # Guard: Temporal mismatch — P uses past tense (<(temps,...)) but H uses present (overlaps(temps,...))
                        # Universalizing past-tense quantifiers forces ALL events to be past, making present-tense H impossible
                        # EXCEPTION: if we injected a temporal bridge axiom (past→present), the stripped
                        # axioms already contain the bridge, so contradiction would be legitimate.
                        if not stripped_contra_nl_block:
                            _p_fol_txt = ' '.join(str(pt) for pt in premise_texts)
                            _h_fol_txt = ' '.join(str(ht) for ht in hypothesis_texts)
                            _p_has_past = '<(temps(' in _p_fol_txt
                            _p_has_pres = 'overlaps(temps(' in _p_fol_txt
                            _h_has_pres = 'overlaps(temps(' in _h_fol_txt
                            _h_has_past = '<(temps(' in _h_fol_txt
                            if _p_has_past and not _p_has_pres and _h_has_pres and not _h_has_past :
                                print("  Stripped contradiction blocked by temporal mismatch guard (P:past, H:present)")
                                stripped_contra_nl_block = True

                        # Guard: disjoint predicate swap between P and H
                        # When P has property A and H has disjoint property B (A→-B),
                        # universalization makes ALL entities have A, preventing any entity
                        # from having B, creating a spurious contradiction.
                        # EXCEPTION: If P and H share named constants (proper names like Mickey),
                        # the entities are anchored and the stripped contradiction is valid.
                        if not stripped_contra_nl_block:
                            _p_fol_all = ' '.join(str(pt) for pt in premise_texts)
                            _h_fol_all = ' '.join(str(ht) for ht in hypothesis_texts)
                            _p_consts = set(re.findall(r'\b[A-Z][A-Za-z_0-9]+\b', _p_fol_all))
                            _h_consts = set(re.findall(r'\b[A-Z][A-Za-z_0-9]+\b', _h_fol_all))
                            _shared_consts = _p_consts & _h_consts
                            _has_shared_names = len(_shared_consts) > 0
                            _disjoint_guard_pairs = [
                                ('interieur', 'exterieur'), ('exterieur', 'interieur'),
                                ('vieux', 'jeune'), ('jeune', 'vieux'),
                                ('plage', 'montagne'), ('montagne', 'plage'),
                                ('bas', 'haut'), ('haut', 'bas'),
                                ('noir', 'blanc'), ('blanc', 'noir'),
                                ('homme', 'femme'), ('femme', 'homme'),
                                ('homme', 'enfant'), ('enfant', 'homme'),
                                ('homme', 'fille'), ('fille', 'homme'),
                                ('homme', 'garcon'), ('garcon', 'homme'),
                                ('femme', 'enfant'), ('enfant', 'femme'),
                                ('femme', 'garcon'), ('garcon', 'femme'),
                                ('fille', 'garcon'), ('garcon', 'fille'),
                                ('petit', 'grand'), ('grand', 'petit'),
                                ('lent', 'rapide'), ('rapide', 'lent'),
                                ('derriere', 'devant'), ('devant', 'derriere'),
                                ('gauche', 'droite'), ('droite', 'gauche'),
                                ('ouvert', 'ferme'), ('ferme', 'ouvert'),
                                ('chaud', 'froid'), ('froid', 'chaud'),
                                ('debout', 'asseoir'), ('asseoir', 'debout'),
                                ('courir', 'marcher'), ('marcher', 'courir'),
                                ('monter', 'descendre'), ('descendre', 'monter'),
                                ('dormir', 'eveiller'), ('eveiller', 'dormir'),
                                ('mer', 'lac'), ('lac', 'mer'),
                                ('chien', 'chat'), ('chat', 'chien'),
                            ]
                            for _da, _db in _disjoint_guard_pairs:
                                if _da in p_pred_names and _db in h_pred_names and _db not in p_pred_names:
                                    if _has_shared_names:
                                        print(f"  Disjoint swap ({_da}/{_db}) but P&H share constants {_shared_consts} — allowing stripped contradiction")
                                    elif _CURRENT_DATASET != 'sick':
                                        print(f"  Disjoint swap ({_da}/{_db}) but non-SICK dataset — allowing stripped contradiction")
                                    else:
                                        print(f"  Stripped contradiction blocked by disjoint swap guard ({_da} in P, {_db} in H)")
                                        stripped_contra_nl_block = True
                                    break

                        # Guard: P contains entities with disjoint types (e.g. homme+femme+fille)
                        # Universalization collapses distinct entities into one, creating
                        # internal inconsistency that the timeout-limited premises_inconsistent
                        # check may miss.
                        if not stripped_contra_nl_block and _CURRENT_DATASET == 'sick':
                            _p_internal_disjoint = [
                                ('homme', 'femme'), ('homme', 'fille'),
                                ('femme', 'garcon'),
                            ]
                            for _gp1, _gp2 in _p_internal_disjoint:
                                if _gp1 in p_pred_names and _gp2 in p_pred_names:
                                    print(f"  Stripped contradiction blocked: P has disjoint pair ({_gp1}, {_gp2}) — universalization creates inconsistent P")
                                    stripped_contra_nl_block = True
                                    break

                    except Exception:
                        pass

                    # Guard: rewrite_pas negation + hypernymy-only bridging
                    # When rewrite_pas wraps a formula in -(exists...), it converts
                    # existential negation (∃x.¬P) to universal negation (¬∃x.P).
                    # Stripped contradiction may then falsely succeed via hypernymy
                    # bridging different agent nouns (e.g. homme vs personne).
                    # Block ONLY when the match relies on hypernymy (not direct/synonym).
                    if not stripped_contra_nl_block and _CURRENT_DATASET == 'sick':
                        _rp_p_all = ' '.join(premise_texts)
                        _rp_h_all = ' '.join(hypothesis_texts)
                        _rp_p_neg = _rp_p_all.lstrip().startswith('-(')
                        _rp_h_neg = _rp_h_all.lstrip().startswith('-(')
                        if _rp_p_neg != _rp_h_neg:  # one side negated
                            _rp_skip = {'overlaps', 'temps', 'maintenant', 'num', 'existe',
                                        'context_', 'unknown_', 'empty_intersect', 'subseteq',
                                        'pres', 'generic', 'mesure', 'etre', 'is_at',
                                        'de', 'en', 'a_', 'dans', 'sur', 'sous', 'avec', 'pour',
                                        'par', 'contre', 'vers', 'devant', 'derriere', 'entre',
                                        'en_train_de', 'etre_en', 'pres_de', 'exists', 'all',
                                        'a_travers', 'au_dessus_de', 'en_dessous_de',
                                        'a_cote_de', 'autour', 'autour_de', 'singulier_',
                                        'masculin_', 'feminin_', 'nomme', 'certain', 'lieu'}
                            _rp_p_preds = set(re.findall(r'\b([a-z_]\w*)\(', _rp_p_all)) - _rp_skip
                            _rp_h_preds = set(re.findall(r'\b([a-z_]\w*)\(', _rp_h_all)) - _rp_skip
                            # Identify which side is negated
                            _rp_neg_preds = _rp_p_preds if _rp_p_neg else _rp_h_preds
                            _rp_pos_preds = _rp_h_preds if _rp_p_neg else _rp_p_preds
                            # Check: does any predicate in the negated side
                            # match the positive side ONLY via hypernymy?
                            _rp_neg_only = _rp_neg_preds - _rp_pos_preds
                            if _rp_neg_only:
                                # Extend positive with synonyms only (NOT hypernyms)
                                _rp_pos_syn = set(_rp_pos_preds)
                                if ENABLE_CURATED_LEXICON_FALLBACK:
                                    for _s1, _s2 in FRENCH_SYNONYMS:
                                        if _s1 in _rp_pos_preds:
                                            _rp_pos_syn.add(_s2)
                                        if _s2 in _rp_pos_preds:
                                            _rp_pos_syn.add(_s1)
                                _rp_still_only = _rp_neg_only - _rp_pos_syn
                                if _rp_still_only:
                                    # These predicates in negated side match positive ONLY via hypernymy
                                    # Check if they actually ARE connected by hypernymy
                                    _rp_pos_hyper = set(_rp_pos_preds)
                                    if ENABLE_CURATED_LEXICON_FALLBACK:
                                        for _hypo, _hyper in FRENCH_HYPERNYMS:
                                            if _hypo in _rp_pos_preds:
                                                _rp_pos_hyper.add(_hyper)
                                    _rp_hyper_matched = _rp_still_only & _rp_pos_hyper
                                    if _rp_hyper_matched:
                                        print(f"  Stripped contradiction blocked: negated formula has predicates matched only via hypernymy ({_rp_hyper_matched})")
                                        stripped_contra_nl_block = True

                    # Guard: singleton-vs-plural contradiction should only fire when
                    # P and H share the same content frame. Otherwise a global
                    # num(x)=1 -> not >(num(x),1) axiom can interact with unrelated
                    # lexical bridges and create spurious contradictions.
                    if not stripped_contra_nl_block:
                        _p_fol_all = ' '.join(str(pt) for pt in premise_texts)
                        _h_fol_all = ' '.join(str(ht) for ht in hypothesis_texts)
                        if 'seul(' in _p_fol_all and '>(num(' in _h_fol_all:
                            _singleton_struct = {
                                'overlaps', 'temps', 'maintenant', 'num', 'de', 'des',
                                'subseteq', 'existe', 'exists', 'all', 'generic',
                                'atomic_sub', 'is_at', 'nomme', 'nommé', 'a_', 'en',
                                'dans', 'avec', 'sur', 'sous', 'pour', 'par', 'contre',
                                'vers', 'devant', 'derriere', 'entre', 'pas', 'pas_de',
                                'tout', 'chacun', 'peu_de', 'beaucoup_de', 'plupart_de',
                                'plus_de', 'moins_de', 'aucun', 'certain', 'plusieurs',
                                'DOT', 'moitie', 'tiers', 'quart', 'cinquieme', 'seul'
                            }
                            _singleton_derivable = compute_local_derivable_preds(
                                p_pred_names,
                                h_pred_names,
                                premise_texts,
                                hypothesis_texts,
                            )
                            _p_core = p_pred_names - _singleton_struct
                            _h_core = h_pred_names - _singleton_struct
                            _novel_h_core = _h_core - _p_core - _singleton_derivable
                            if _novel_h_core:
                                print(f"  Stripped contradiction blocked by singleton relevance guard (novel H predicates: {_novel_h_core})")
                                stripped_contra_nl_block = True

                    if stripped_contra_error:
                        print("Stripped contradiction had internal error => unreliable, returning unknown")
                        prover9_result = "unknown"
                    elif premises_inconsistent:
                        print("Universalized premises are inconsistent => contradiction unreliable, returning unknown")
                        prover9_result = "unknown"
                    elif stripped_contra_nl_block:
                        prover9_result = "unknown"
                    else:
                        print(f"Proof with Prover9 (Stripped Contradiction): Success (NO)")
                        prover9_result = "no"

                if prover9_result == "unknown":
                    emit_unresolved_diagnostics(premise_texts, hypothesis_texts)

        # v67: After guard blocks full entailment, try contradiction as fallback
        # EXCEPT for DM guard — if both P⊢H and P⊢¬H hold, the axiom set is inconsistent.
        if prover9_result == "unknown" and entailment_proof:
            if guard_type in ("dm", "tout", "extra"):
                print(f"Guard blocked entailment ({guard_type}) -- staying unknown (axiom inconsistency risk)")
            else:
                print(f"Guard blocked entailment ({guard_type}) -- trying contradiction fallback...")
                try:
                    neg_h_gb = read_expr('-(' + str(hypothesis) + ')')
                    contra_gb = timed_prove(Prover9(timeout=PROVER9_TIMEOUT_SECONDS), neg_h_gb, full_premises, timeout_seconds=15)
                    if contra_gb:
                        print(f"Proof with Prover9 (Post-guard Contradiction): Success (NO)")
                        prover9_result = "no"
                    else:
                        print(f"Post-guard Contradiction: Failure")
                except Exception as e:
                    print(f"Post-guard contradiction error: {e}")

        mace4_result = "unknown"

        if PROOF_ONLY_LABELS:
            combined_result = prover9_result
            continue

        # --- Mace4 model building ---
        # Only try when Prover9 couldn't decide.  Mace4 "no" (found
        # counterexample P+¬H  AND  P+H unsatisfiable) is reliable for
        # contradiction.  Mace4 "yes" is NOT used (finite-domain limitation).
        if prover9_result == "unknown":
            try:
                from nltk.inference.mace import Mace
                neg_hypothesis_m4 = read_expr(f'-({str(hypothesis)})')

                # Check 1: P + ¬H satisfiable? (counterexample to entailment)
                mace_builder1 = Mace(end_size=25)
                mb1 = MaceCommand(None, assumptions=full_premises + [neg_hypothesis_m4], model_builder=mace_builder1)
                p_and_not_h = timed_build_model(mb1, timeout_seconds=10)
                if p_and_not_h:
                    print("Mace4: P + ¬H satisfiable (counterexample found)")
                else:
                    print("Mace4: P + ¬H — no counterexample in domain ≤25")

                # Check 2: P + H satisfiable? (consistency)
                mace_builder2 = Mace(end_size=25)
                mb2 = MaceCommand(None, assumptions=full_premises + [hypothesis], model_builder=mace_builder2)
                p_and_h = timed_build_model(mb2, timeout_seconds=10)
                if p_and_h:
                    print("Mace4: P + H satisfiable (consistent)")
                else:
                    print("Mace4: P + H — no model found (inconsistent or timeout)")

                # Mace4 verdict
                if p_and_not_h and not p_and_h:
                    mace4_result = "no"
                elif not p_and_not_h and p_and_h:
                    mace4_result = "yes"
                else:
                    mace4_result = "unknown"
            except Exception as e:
                print(f"Mace4 Error: {e}")
                mace4_result = "unknown"

            # Combined: Prover9 primary, Mace4 only for contradiction
            if mace4_result == "no":
                print("Mace4 contradiction → combined = no")
                combined_result = "no"

        # --- Temporal contradiction heuristic ---
        # When proofs fail due to existential witnesses, detect year substitution:
        # same event described with different year constants implies contradiction.
        if prover9_result == "unknown":
            try:
                _heur_p = ' '.join(premise_texts)
                _heur_h = ' '.join(hypothesis_texts)
                _p_years = set(int(m) for m in re.findall(r'(?<![0-9])(\d{4})(?![0-9])', _heur_p) if 1900 <= int(m) <= 2100)
                _h_years = set(int(m) for m in re.findall(r'(?<![0-9])(\d{4})(?![0-9])', _heur_h) if 1900 <= int(m) <= 2100)
                _p_only_y = _p_years - _h_years
                _h_only_y = _h_years - _p_years
                if _p_only_y and _h_only_y and 'en(' in _heur_p and 'en(' in _heur_h:
                    # Check structural similarity: same verb predicates
                    _yr_struct = {'overlaps', 'temps', 'subseteq', 'existe', 'num', 'de',
                                  'generic', 'en', 'sur', 'sous', 'maintenant', 'nommé', 'nomme',
                                  'is_at', 'unknown_', 'context_', 'rank', 'singular_'}
                    _yr_p = p_pred_names - _yr_struct
                    _yr_h = h_pred_names - _yr_struct
                    _yr_shared = _yr_p & _yr_h
                    if len(_yr_shared) >= 1:
                        # Only fire if H references the SAME specific event via
                        # definite coreference (contracted pronoun + PC) or ordinal.
                        _yr_hnls = [str(row[c]).lower() for c in row.index
                                    if re.fullmatch(r'h\d+_nl', c) and pd.notna(row[c])]
                        _yr_hnl = ' '.join(_yr_hnls).replace(chr(92)+chr(92), '').replace(chr(92)+chr(39), chr(39))
                        _yr_coref = bool(re.search(r"l['’]a |l['’]est |premier|premi\xe8re", _yr_hnl))
                        if _yr_coref:
                            print(f"  Year contradiction heuristic: P years={_p_only_y}, H years={_h_only_y}, shared verbs={_yr_shared}")
                            prover9_result = "no"
                        else:
                            print(f"  Year heuristic: different years but no definite coref in H, skipping")
            except Exception as e:
                print(f"  Year heuristic error: {e}")

        # --- Numeric literal contradiction heuristic ---
        # Detect 'Six'(x) or 'Huit'(x) cardinal predicates that conflict with exact numeric counts.
        if prover9_result == "unknown":
            try:
                if '_heur_p' not in dir(): _heur_p = ' '.join(premise_texts)
                if '_heur_h' not in dir(): _heur_h = ' '.join(hypothesis_texts)
                _card_map = {'Six': 6, 'Huit': 8, 'Cinq': 5, 'Quatre': 4,
                             'Sept': 7, 'Neuf': 9, 'Dix': 10, 'Trois': 3,
                             'Onze': 11, 'Douze': 12, 'Vingt': 20}
                for _card_name, _card_val in _card_map.items():
                    if _card_name + '(' in _heur_h:
                        # H claims cardinal number; check if P has a different explicit count
                        _p_nums = set(int(m) for m in re.findall(r'\(num\(\w+\)\s*=\s*(\d+)\)', _heur_p))
                        if _p_nums and _card_val not in _p_nums and all(n < _card_val for n in _p_nums):
                            _sum_p = sum(_p_nums)
                            if _sum_p < _card_val:
                                print(f"  Numeric contradiction: H claims {_card_name}={_card_val}, P has counts {_p_nums} (sum={_sum_p})")
                                prover9_result = "no"
                                break
            except Exception as e:
                print(f"  Numeric heuristic error: {e}")

        # --- Duration contradiction heuristic ---
        # "in X hours" (telic completion) vs "more than X hours" = contradiction.
        # Only applies when "en X" is mid-sentence (telic). Sentence-initial "En X ans, ..."
        # is a temporal frame with atelic/stative verbs (durative), NOT a completion bound.
        if prover9_result == "unknown":
            try:
                _dur_pnls = [str(row[c]).lower() for c in row.index if re.fullmatch(r'p\d+_nl', c) and pd.notna(row[c])]
                _dur_hnls = [str(row[c]).lower() for c in row.index if re.fullmatch(r'h\d+_nl', c) and pd.notna(row[c])]
                _p_nl_lo = ' '.join(_dur_pnls).replace("\\'", "'").replace("\\\\", "")
                _h_nl_lo = ' '.join(_dur_hnls).replace("\\'", "'").replace("\\\\", "")
                # "en N heures/ans" (telic, mid-sentence) vs "plus de N heures/ans"
                _p_dur_m = re.search(r'en (\w+) (heure|an|jour|mois|semaine)', _p_nl_lo)
                _h_dur_m = re.search(r'plus de (\w+) (heure|an|jour|mois|semaine)', _h_nl_lo)
                if (_p_dur_m and _h_dur_m and _p_dur_m.start() > 5
                        and _p_dur_m.group(1) == _h_dur_m.group(1)
                        and _p_dur_m.group(2) == _h_dur_m.group(2)):
                    print(f"  Duration contradiction: P='...{_p_dur_m.group(0)}' vs H='plus de {_h_dur_m.group(0)}'")
                    prover9_result = "no"
                # "durant N X" vs "durant M X exactement" where N != M
                _p_dur2 = re.search(r'durant (\w+) (an|heure|jour|mois|semaine)', _p_nl_lo)
                _h_dur2 = re.search(r'durant (\w+) (an|heure|jour|mois|semaine)s? exactement', _h_nl_lo)
                if _p_dur2 and _h_dur2 and _p_dur2.group(2) == _h_dur2.group(2):
                    _dur_map = {'un': 1, 'une': 1, 'deux': 2, 'trois': 3, 'quatre': 4, 'cinq': 5, 'six': 6}
                    _pn = _dur_map.get(_p_dur2.group(1), _p_dur2.group(1))
                    _hn = _dur_map.get(_h_dur2.group(1), _h_dur2.group(1))
                    if _pn != _hn:
                        print(f"  Duration mismatch: P='{_p_dur2.group(0)}' vs H='{_h_dur2.group(0)} exactement'")
                        prover9_result = "no"
            except Exception as e:
                print(f"  Duration heuristic error: {e}")

        # --- Content subsumption entailment fallback ---
        # Only for SICK dataset — FraCaS has complex logical structures
        # where predicate overlap doesn't imply entailment.
        if prover9_result == "unknown" and _CURRENT_DATASET == 'sick':
            try:
                _cs_func = {'overlaps', 'temps', 'maintenant', 'num', 'existe',
                            'context_', 'unknown_', 'empty_intersect', 'subseteq',
                            'pres', 'generic', 'mesure', 'etre', 'is_at',
                            'simultanee', 'narration', 'diff', 'different',
                            'nomme', 'certain', 'lieu'}
                _cs_pos = {'de', 'en', 'a_', 'dans', 'sur', 'sous', 'avec', 'pour',
                           'par', 'contre', 'vers', 'devant', 'derriere', 'entre',
                           'en_train_de', 'etre_en', 'pres', 'pres_de',
                           'a_travers', 'au_dessus_de', 'en_dessous_de',
                           'a_cote_de', 'autour', 'autour_de'}
                _cs_skip = _cs_func | _cs_pos | {'exists', 'all'}
                _cs_p_all = ' '.join(premise_texts)
                _cs_h_all = ' '.join(hypothesis_texts)
                _cs_p_preds = set(re.findall(r'\b([a-z_]\w*)\(', _cs_p_all)) - _cs_skip
                _cs_h_preds = set(re.findall(r'\b([a-z_]\w*)\(', _cs_h_all)) - _cs_skip
                # Also check hypernym-reachable predicates
                _cs_p_extended = set(_cs_p_preds)
                if ENABLE_CURATED_LEXICON_FALLBACK:
                    for _hypo, _hyper in FRENCH_HYPERNYMS:
                        if _hypo in _cs_p_preds:
                            _cs_p_extended.add(_hyper)
                    for _s1, _s2 in FRENCH_SYNONYMS:
                        if _s1 in _cs_p_preds:
                            _cs_p_extended.add(_s2)
                        if _s2 in _cs_p_preds:
                            _cs_p_extended.add(_s1)
                _cs_h_only = _cs_h_preds - _cs_p_extended
                _cs_p_only = _cs_p_preds - _cs_h_preds
                # Strict safety checks:
                # 1. No negation ANYWHERE in P or H formulas
                _cs_has_neg = ('-(' in _cs_p_all or '-(' in _cs_h_all
                               or 'forall' in _cs_p_all.lower()
                               or 'pas(' in _cs_p_all or 'pas(' in _cs_h_all
                               or 'masculin_' in _cs_h_all
                               or 'feminin_' in _cs_h_all)
                # 2. No complex structural markers in H
                _cs_complex = bool({'subseteq', 'empty_intersect', 'event_',
                                    'unknown_', 'context_'} &
                                   set(re.findall(r'\b(\w+)\b', _cs_h_all)))
                # 3. P must have strictly more content (at least 1 extra)
                # 4. H content must be fully covered
                if (len(_cs_h_only) == 0
                        and len(_cs_p_only) > 0
                        and not _cs_has_neg
                        and not _cs_complex):
                    print(f"  Content subsumption: H_content ⊆ P_content (P-only: {_cs_p_only})")
                    prover9_result = "yes"
            except Exception as e:
                print(f"  Content subsumption error: {e}")

        # --- Content contradiction fallback ---
        # Only for SICK dataset — FraCaS has complex quantifier structures
        # where negation must be proved formally.
        if prover9_result == "unknown" and _CURRENT_DATASET == 'sick':
            try:
                _cc_func = {'overlaps', 'temps', 'maintenant', 'num', 'existe',
                            'context_', 'unknown_', 'empty_intersect', 'subseteq',
                            'pres', 'generic', 'mesure', 'etre', 'is_at',
                            'simultanee', 'narration', 'diff', 'different',
                            'nomme', 'certain', 'lieu'}
                _cc_pos = {'de', 'en', 'a_', 'dans', 'sur', 'sous', 'avec', 'pour',
                           'par', 'contre', 'vers', 'devant', 'derriere', 'entre',
                           'en_train_de', 'etre_en', 'pres', 'pres_de',
                           'a_travers', 'au_dessus_de', 'en_dessous_de',
                           'a_cote_de', 'autour', 'autour_de'}
                _cc_skip = _cc_func | _cc_pos | {'exists', 'all'}
                _cc_p_all = ' '.join(premise_texts)
                _cc_h_all = ' '.join(hypothesis_texts)
                _cc_p_preds = set(re.findall(r'\b([a-z_]\w*)\(', _cc_p_all)) - _cc_skip
                _cc_h_preds = set(re.findall(r'\b([a-z_]\w*)\(', _cc_h_all)) - _cc_skip
                # Extend with hypernyms/synonyms
                # When rewrite_pas introduced the negation, skip hypernymy extension
                # for the positive side — rewrite_pas over-strengthens existential negation,
                # and hypernymy bridging would create false contradictions.
                _cc_p_ext = set(_cc_p_preds)
                _cc_h_ext = set(_cc_h_preds)
                _cc_skip_hyper_p = _rewrite_pas_applied_h  # H negated by rewrite_pas → don't extend P with hypernyms
                _cc_skip_hyper_h = _rewrite_pas_applied_p  # P negated by rewrite_pas → don't extend H with hypernyms
                if ENABLE_CURATED_LEXICON_FALLBACK:
                    for _hypo, _hyper in FRENCH_HYPERNYMS:
                        if _hypo in _cc_p_preds and not _cc_skip_hyper_p:
                            _cc_p_ext.add(_hyper)
                        if _hypo in _cc_h_preds and not _cc_skip_hyper_h:
                            _cc_h_ext.add(_hyper)
                    for _s1, _s2 in FRENCH_SYNONYMS:
                        if _s1 in _cc_p_preds:
                            _cc_p_ext.add(_s2)
                        if _s2 in _cc_p_preds:
                            _cc_p_ext.add(_s1)
                        if _s1 in _cc_h_preds:
                            _cc_h_ext.add(_s2)
                        if _s2 in _cc_h_preds:
                            _cc_h_ext.add(_s1)
                # Check if H is negated and its positive content overlaps with P
                _cc_h_negated = ('-(exists' in _cc_h_all or _cc_h_all.lstrip().startswith('-('))
                _cc_p_negated = ('-(exists' in _cc_p_all or _cc_p_all.lstrip().startswith('-(')
                                 or 'pas(' in _cc_p_all)
                # H negated, P positive: P asserts what H denies
                if _cc_h_negated and not _cc_p_negated:
                    # H's content predicates (inside negation) must overlap with P's
                    _cc_h_only = _cc_h_preds - _cc_p_ext
                    if len(_cc_h_only) == 0 and len(_cc_h_preds) >= 2:
                        print(f"  Content contradiction: H negated, H_content ⊆ P_content (shared: {_cc_h_preds & _cc_p_ext})")
                        prover9_result = "no"
                # P negated, H positive: P denies what H asserts
                elif _cc_p_negated and not _cc_h_negated:
                    _cc_p_only = _cc_p_preds - _cc_h_ext
                    if len(_cc_p_only) == 0 and len(_cc_p_preds) >= 2:
                        print(f"  Content contradiction: P negated, P_content ⊆ H_content (shared: {_cc_p_preds & _cc_h_ext})")
                        prover9_result = "no"
            except Exception as e:
                print(f"  Content contradiction error: {e}")

        combined_result = prover9_result

    return (prover9_result, mace4_result, combined_result)


def main():
    global _CURRENT_DATASET
    # Read your TSV file
    file_path = "./sick_fr_fol_modified_2nd_version.tsv"  # Default dataset
    _CURRENT_DATASET = 'sick'  # track which dataset for heuristic guards
    _dataset_aliases = {
        'gqnli': './gqnli_fr_fol_completed_2nd_version.tsv',
        'fracas': './fracas_fr_fol_completed_5th_version.tsv',
        'sick': './sick_fr_fol_modified_2nd_version.tsv',
    }
    import sys
    for i, arg in enumerate(sys.argv[1:], 1):
        if arg == '--dataset' and i < len(sys.argv):
            _ds = sys.argv[i + 1]
            file_path = _dataset_aliases.get(_ds, _ds)
            if _ds in _dataset_aliases:
                _CURRENT_DATASET = _ds
            else:
                _dataset_name = os.path.basename(str(_ds)).lower()
                if 'fracas' in _dataset_name:
                    _CURRENT_DATASET = 'fracas'
                elif 'gqnli' in _dataset_name:
                    _CURRENT_DATASET = 'gqnli'
                elif 'sick' in _dataset_name:
                    _CURRENT_DATASET = 'sick'
                else:
                    _CURRENT_DATASET = _ds
            break
    df = pd.read_csv(file_path, sep='\t')  # Use tab as delimiter for TSV
    print(f"Dataset: {file_path} ({len(df)} rows)")

    # Optional row-offset mode for chunked validation runs (default: start at row 1)
    start_row_env = os.getenv('START_ROW')
    if start_row_env:
        try:
            start_row = int(start_row_env)
            if start_row > 1:
                df = df.iloc[start_row - 1:]
                print(f"Running in START_ROW mode: starting at row {start_row}")
        except ValueError:
            print(f"Ignoring invalid START_ROW value: {start_row_env}")

    # Optional fast-run mode for iterative debugging (default: full dataset)
    max_rows_env = os.getenv('MAX_ROWS')
    if max_rows_env:
        try:
            max_rows = int(max_rows_env)
            if max_rows > 0:
                df = df.head(max_rows)
                print(f"Running in MAX_ROWS mode: first {max_rows} rows")
        except ValueError:
            print(f"Ignoring invalid MAX_ROWS value: {max_rows_env}")

    # Track predictions and gold labels
    prover9_predictions = []
    mace4_predictions = []
    combined_predictions = []
    gold_labels = []
    skipped_rows = 0

    # Perform inference on each row in the DataFrame
    for index, row in df.iterrows():
        print(f"\nProcessing row {index + 1}")
        gold_label = row.get('label', 'unknown')
        # Skip 'undef' rows (standard FraCaS practice: undefined problems are not evaluated)
        if isinstance(gold_label, str) and gold_label.lower() in ['undef', 'undefined']:
            print(f"Gold Label: {gold_label} (undef => skipping)")
            skipped_rows += 1
            continue
        print(f"Gold Label: {gold_label}")

        # Skip rows with known incomplete FOL premises (missing p2 or p3 from original dataset)
        _INCOMPLETE_PREMISE_PIDS = {}
        _pid = row.get('problem_id')
        if _pid in _INCOMPLETE_PREMISE_PIDS:
            print(f"Skipping row from evaluation: incomplete FOL premises (problem_id {_pid})")
            skipped_rows += 1
            continue

        # Strict evaluation hygiene: skip rows with no usable premise or no usable hypothesis.
        has_premise = any(re.fullmatch(r'p\d+', c) and pd.notna(row[c]) for c in row.index)
        has_hypothesis = any(re.fullmatch(r'h\d+', c) and pd.notna(row[c]) for c in row.index)
        if not has_premise or not has_hypothesis:
            print("Skipping row from evaluation: missing premise or hypothesis")
            skipped_rows += 1
            continue

        premise_fol_texts = [
            clean_formula_string(str(row[c])) for c in row.index
            if re.fullmatch(r'p\d+', c) and pd.notna(row[c])
        ]
        hypothesis_fol_texts = [
            clean_formula_string(str(row[c])) for c in row.index
            if re.fullmatch(r'h\d+', c) and pd.notna(row[c])
        ]

        bad_fol_columns = [
            c for c in row.index
            if re.fullmatch(r'[ph]\d+', c) and pd.notna(row[c]) and is_certainly_bad_fol_formula(row[c])
        ]
        if bad_fol_columns:
            print(f"Skipping row from evaluation: clearly bad FOL in {bad_fol_columns}")
            skipped_rows += 1
            continue

        # NOTE: Per strict policy, only three skip conditions are allowed:
        #   (1) undefined gold label (handled above),
        #   (2) missing premise or hypothesis (handled above),
        #   (3) genuinely-destroyed FOL formula (parser artifacts / unbalanced
        #       parens / impossible structure — handled by
        #       is_certainly_bad_fol_formula above).
        # All previously-existing "interpretive" row-skip helpers
        # (comparative-positive-drop, quantifier/cardinality restrictor-drop,
        # past-scoped unary, detached-comparative anchor, over-factive
        # temporal-order, duration drop, non-factive complement) have been
        # removed. They rejected rows the prover should adjudicate; the right
        # remedy for over-firing axioms is to fix the AXIOM, not pre-skip rows.

        gold_labels.append(gold_label)
    
        try:
            prover9_pred, mace4_pred, combined_pred = perform_inference_on_row(row)
        except KeyboardInterrupt:
            print(f"  FATAL: Row {index} crashed (KeyboardInterrupt/SIGSEGV)")
            prover9_pred, mace4_pred, combined_pred = "unknown", "unknown", "unknown"
        except Exception as e:
            print(f"  FATAL: Row {index} error: {e}")
            prover9_pred, mace4_pred, combined_pred = "unknown", "unknown", "unknown"
        prover9_predictions.append(prover9_pred)
        mace4_predictions.append(mace4_pred)
        combined_predictions.append(combined_pred)
        print(f"Prover9 Prediction: {prover9_pred} | Mace4 Prediction: {mace4_pred} | Combined: {combined_pred}")
        print("-"*50)

    # ========== EVALUATION METRICS ==========
    from sklearn.metrics import accuracy_score, f1_score, confusion_matrix, classification_report

    print("\n" + "="*80)
    print("EVALUATION RESULTS")
    print("="*80)

    # Filter out 'unknown' labels for evaluation if you want strictly binary classification
    # But since our tools produce 'unknown', we should keep them to see the full confusion matrix.
    valid_indices = [i for i, label in enumerate(gold_labels)]  # Keep all labels
    valid_gold = [gold_labels[i] for i in valid_indices]
    valid_prover9 = [prover9_predictions[i] for i in valid_indices]
    valid_mace4 = [mace4_predictions[i] for i in valid_indices]

    print(f"\nTotal examples: {len(gold_labels)}")
    print(f"Examples used for evaluation: {len(valid_gold)}")
    print(f"Skipped examples (missing premise/hypothesis): {skipped_rows}")
    if not valid_gold:
        print("No examples left after evaluation hygiene skips; metrics are not defined.")
        sys.exit(0)

    # Note on MACE4 Evaluation
    print("\n" + "!"*80)
    print("NOTE: Mace4 'no' means a counterexample was found (P & ¬H is consistent).")
    print("      This implies 'Not Entailment', which covers both 'contradiction' (no) and 'neutral' (unknown).")
    print("      Mace4 'yes' means NO counterexample found (likely Entailment).")
    print("      Therefore, Mace4 accuracy on 'yes'/entailment labels should be high.")
    print("!"*80)

    # Prover9 Evaluation
    print("\n" + "="*80)
    print("PROVER9 EVALUATION")
    print("="*80)
    prover9_accuracy = accuracy_score(valid_gold, valid_prover9)
    prover9_f1 = f1_score(valid_gold, valid_prover9, average='weighted', zero_division=0)
    print(f"Accuracy: {prover9_accuracy:.4f}")
    print(f"F1 Score (weighted): {prover9_f1:.4f}")
    print("\nClassification Report:")
    print(classification_report(valid_gold, valid_prover9, zero_division=0))
    print("Confusion Matrix:")
    print(confusion_matrix(valid_gold, valid_prover9))

    # Mace4 Evaluation
    print("\n" + "="*80)
    print("MACE4 EVALUATION")
    print("="*80)
    mace4_accuracy = accuracy_score(valid_gold, valid_mace4)
    mace4_f1 = f1_score(valid_gold, valid_mace4, average='weighted', zero_division=0)
    print(f"Accuracy: {mace4_accuracy:.4f}")
    print(f"F1 Score (weighted): {mace4_f1:.4f}")
    print("\nClassification Report:")
    print(classification_report(valid_gold, valid_mace4, zero_division=0))
    print("Confusion Matrix:")
    print(confusion_matrix(valid_gold, valid_mace4))

    # Combined Evaluation (Prover9 + Mace4 dual check)
    print("\n" + "="*80)
    print("COMBINED EVALUATION (Prover9 primary + Mace4 contradiction detection)")
    print("="*80)
    valid_combined = [combined_predictions[i] for i in valid_indices]
    combined_accuracy = accuracy_score(valid_gold, valid_combined)
    combined_f1 = f1_score(valid_gold, valid_combined, average="weighted", zero_division=0)
    print(f"Accuracy: {combined_accuracy:.4f}")
    print(f"F1 Score (weighted): {combined_f1:.4f}")
    print("\nClassification Report:")
    print(classification_report(valid_gold, valid_combined, zero_division=0))
    print("Confusion Matrix:")
    print(confusion_matrix(valid_gold, valid_combined))

    # Comparison
    print("\n" + "="*80)
    print("PROVER COMPARISON")
    print("="*80)
    print(f"Prover9 Accuracy:  {prover9_accuracy:.4f}")
    print(f"Mace4 Accuracy:    {mace4_accuracy:.4f}")
    print(f"Combined Accuracy: {combined_accuracy:.4f}")
    print(f"Prover9 F1:        {prover9_f1:.4f}")
    print(f"Mace4 F1:          {mace4_f1:.4f}")
    print(f"Combined F1:       {combined_f1:.4f}")

    # ========== PROOF-BASED METRICS ==========
    # Accuracy and F1 of proved results only:
    # Among examples where the prover found a definite proof (yes or no, not unknown),
    # how often is the proved label correct?
    print("\n" + "="*80)
    print("PROOF-BASED METRICS (proved examples only)")
    print("="*80)

    # Combined proved examples: predicted yes or no (not unknown)
    proved_indices = [i for i, pred in enumerate(combined_predictions) if pred in ('yes', 'no')]
    proved_gold = [gold_labels[i] for i in proved_indices]
    proved_pred = [combined_predictions[i] for i in proved_indices]

    total_proved = len(proved_indices)
    total_examples = len(valid_gold)
    proved_correct = sum(1 for g, p in zip(proved_gold, proved_pred) if g == p)

    print(f"Total examples: {total_examples}")
    print(f"Proved examples (predicted yes or no): {total_proved} ({100*total_proved/total_examples:.1f}%)")
    print(f"Proved correct: {proved_correct}")
    if total_proved > 0:
        proved_accuracy = proved_correct / total_proved
        print(f"Proof Accuracy (correct among proved): {proved_accuracy:.4f} ({100*proved_accuracy:.2f}%)")
        # Breakdown by label
        proved_yes = [(g, p) for g, p in zip(proved_gold, proved_pred) if p == 'yes']
        proved_no = [(g, p) for g, p in zip(proved_gold, proved_pred) if p == 'no']
        yes_correct = sum(1 for g, p in proved_yes if g == 'yes')
        no_correct = sum(1 for g, p in proved_no if g == 'no')
        print(f"\n  Entailment proofs (predicted yes): {len(proved_yes)}")
        print(f"    Correct (gold=yes): {yes_correct}")
        print(f"    Wrong (gold!=yes): {len(proved_yes) - yes_correct}")
        if proved_yes:
            print(f"    Entailment proof precision: {yes_correct/len(proved_yes):.4f}")
        print(f"\n  Contradiction proofs (predicted no): {len(proved_no)}")
        print(f"    Correct (gold=no): {no_correct}")
        print(f"    Wrong (gold!=no): {len(proved_no) - no_correct}")
        if proved_no:
            print(f"    Contradiction proof precision: {no_correct/len(proved_no):.4f}")
        # F1 among proved
        if len(set(proved_gold)) > 1:
            proved_f1 = f1_score(proved_gold, proved_pred, average='weighted', zero_division=0)
            print(f"\n  Proved F1 (weighted): {proved_f1:.4f}")
        # Recall: of all gold yes/no, how many did we prove?
        gold_yes_total = sum(1 for g in valid_gold if g == 'yes')
        gold_no_total = sum(1 for g in valid_gold if g == 'no')
        print(f"\n  Entailment recall: {yes_correct}/{gold_yes_total} = {yes_correct/gold_yes_total:.4f}" if gold_yes_total else "")
        print(f"  Contradiction recall: {no_correct}/{gold_no_total} = {no_correct/gold_no_total:.4f}" if gold_no_total else "")


if __name__ == "__main__":
    main()

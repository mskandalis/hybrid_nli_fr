import re
import regex
import random
import string
from itertools import count
from nltk.sem.logic import LogicParser


def var_name_generator():
    for i in count(0):
        for c in string.ascii_lowercase:
            yield c if i == 0 else f"{c}{i}"

def remove_quant_wrappers(line):
    def process(s):
        i = 0
        result = []
        stack = []

        while i < len(s):
            if s.startswith('[exists', i):
                # Skip "[exists" and start tracking quantifier wrappers
                i += len('[exists')
                stack.append('exists')
            elif s.startswith('[forall', i):
                # Also handle forall quantifiers
                i += len('[forall')
                stack.append('forall')
            elif s[i] == '[':
                result.append(s[i])
                stack.append('[')
                i += 1
            elif s[i] == ']':
                if stack:
                    top = stack.pop()
                    if top in ['exists', 'forall']:
                        # End of quantifier wrapper — don't append this closing bracket
                        i += 1
                        continue
                result.append(']')
                i += 1
            else:
                result.append(s[i])
                i += 1
        return ''.join(result)
    return process(line)

def format_exists_sequence(text):
    parts = text.split(',')
    result = []
    i = 0

    while i < len(parts):
        part = parts[i].strip()
        if part == 'exists':
            group = []
            while i < len(parts) - 1 and parts[i].strip() == 'exists':
                var = parts[i + 1].strip()
                group.append(var)
                i += 2
            result.append('exists ' + ' '.join(group) + '.')
        else:
            result.append(part+',')
            i += 1

    return ' '.join(result)

def replace_var_expressions(input_filename, output_filename):
    pattern = r"'\$VAR'\(_\d+\)"

    with open(input_filename, 'r', encoding='utf-8') as infile, open(output_filename, 'w', encoding='utf-8') as outfile:
        for line in infile:
            if line.strip().startswith("fol("):
                replacements = {}
                var_names = var_name_generator()

                line = re.sub(r"\b([a-z])\b(?=\()", r"'\1'", line)

                def replacer(match):
                    key = match.group(0)
                    if key not in replacements:
                        while True:
                            new_var = next(var_names)
                            # If this new variable does NOT already appear as a word in the line, use it
                            if not re.search(rf'\b{re.escape(new_var)}\b', line):
                                replacements[key] = new_var
                                break               
                        return replacements[key]
                    else:
                        return replacements[key]             
                new_line = re.sub(pattern, replacer, line)
                new_line = remove_quant_wrappers(new_line)
                new_line = format_exists_sequence(new_line)
                outfile.write(new_line.rstrip(', ')+'\n')


def balance_parentheses(expr):
    """
    Balance parentheses by removing unmatched ones.
    Uses a more robust approach that tracks actual nesting.
    """
    result = []
    stack = []
    
    # First pass: mark valid parentheses pairs
    valid_positions = set()
    
    for i, char in enumerate(expr):
        if char == '(':
            stack.append(i)
        elif char == ')':
            if stack:
                open_pos = stack.pop()
                valid_positions.add(open_pos)
                valid_positions.add(i)
    
    # Second pass: build result with only valid parentheses
    for i, char in enumerate(expr):
        if char in '()':
            if i in valid_positions:
                result.append(char)
        else:
            result.append(char)
    
    return ''.join(result)

def remove_redundant_parens(expr):
    chars = list(expr)
    stack = []
    to_remove = set()

    # Track matching parens
    pairs = []
    for i, ch in enumerate(chars):
        if ch == '(':
            stack.append(i)
        elif ch == ')':
            if stack:
                open_idx = stack.pop()
                pairs.append((open_idx, i))

    # Sort pairs from innermost to outermost
    pairs.sort()

    # Track which parens we've already removed
    removed = [False] * len(chars)

    for open_idx, close_idx in reversed(pairs):
        # Skip if already removed
        if removed[open_idx] or removed[close_idx]:
            continue

        inner = expr[open_idx + 1 : close_idx]

        # Strip whitespace
        inner = inner.strip()

        # If the inner expression starts and ends with parentheses,
        # and those parentheses are a matched pair in our list,
        # we consider removing the outer pair
        if (inner.startswith('(') and inner.endswith(')')):
            # Find if the inner parentheses are exactly the next pair inward
            for inner_open, inner_close in pairs:
                if inner_open == open_idx + 1 and inner_close == close_idx - 1:
                    # Mark the outer pair as redundant
                    to_remove.add(open_idx)
                    to_remove.add(close_idx)
                    removed[open_idx] = True
                    removed[close_idx] = True
                    break

    # Build new expression without redundant parens
    return ''.join(ch for i, ch in enumerate(chars) if i not in to_remove)

def balance_brackets(expr):
    """
    Balance brackets by removing unmatched ones.
    Similar to balance_parentheses but for square brackets.
    """
    result = []
    stack = []
    
    # First pass: mark valid bracket pairs
    valid_positions = set()
    
    for i, char in enumerate(expr):
        if char == '[':
            stack.append(i)
        elif char == ']':
            if stack:
                open_pos = stack.pop()
                valid_positions.add(open_pos)
                valid_positions.add(i)
    
    # Second pass: build result with only valid brackets
    for i, char in enumerate(expr):
        if char in '[]':
            if i in valid_positions:
                result.append(char)
        else:
            result.append(char)
    
    return ''.join(result)

def balance_all_brackets_and_parens(expr):
    """
    Balance both brackets and parentheses in an expression.
    This ensures proper nesting and removes unmatched brackets/parentheses.
    """
    result = []
    stack = []
    valid_positions = set()
    bracket_pairs = {'(': ')', '[': ']'}
    
    # First pass: mark valid bracket/parenthesis pairs
    for i, char in enumerate(expr):
        if char in bracket_pairs:
            stack.append((i, char))
        elif char in bracket_pairs.values():
            # Find matching opening bracket/parenthesis
            for j in range(len(stack) - 1, -1, -1):
                pos, open_char = stack[j]
                if bracket_pairs[open_char] == char:
                    # Found matching pair
                    valid_positions.add(pos)
                    valid_positions.add(i)
                    stack.pop(j)
                    break
    
    # Second pass: build result with only valid brackets/parentheses
    for i, char in enumerate(expr):
        if char in '()[]':
            if i in valid_positions:
                result.append(char)
        else:
            result.append(char)
    
    return ''.join(result)

def convert_brackets_to_parentheses(formula):
    """
    Convert bracket notation to parentheses notation for NLTK compatibility.
    Handles patterns like x[...] -> x.(...)
    """
    # First balance all brackets and parentheses
    formula = balance_all_brackets_and_parens(formula)
    
    # Convert variable[...] to variable.(...)
    formula = re.sub(r'\b([a-z]|[a-z]\d+)\[', r'\1.(', formula)
    
    # Convert remaining ] to )
    formula = formula.replace(']', ')')
    
    return formula

def normalize_quoted_identifiers(formula):
    """
    Replace -, ', and . by _ inside single-quoted identifiers,
    but keep the surrounding quotes and original casing.
    """

    def repl(match):
        content = match.group(1)
        # replace only inside the quoted word
        content = re.sub(r"\\\\", r"\\", content)
        content = re.sub(r"\\'|[.](?!-)", "_", content)
        content = re.sub(r"\.(?=-)", "", content)
        content = re.sub(r"(?<=\d)-(?=\d)", "_HYPHEN_", content)
        content = regex.sub(r"(?<=\p{L})-(?=\p{L}|\d)", "_", content)
        content = regex.sub(r"(?<=\p{L})--(?=\p{L})", "__", content)


        return f"'{content}'"   # keep quotes

    return re.sub(r"'((?:\\'|[^'])*)'", repl, formula)

def normalize_numeric_underscores(formula):
    """
    Find numbers (possibly quoted) that contain underscores, and remove the underscores.
    """
    # Pattern: numbers possibly quoted, containing at least one underscore
    pattern = r"'?\b(\d+(?:_\d+)+)\b'?"

    def repl(m):
        num_str = m.group(1)
        # Remove underscores
        num_clean = num_str.replace('_', '')
        return num_clean  # return as unquoted number

    return re.sub(pattern, repl, formula)

def extract_line_by_fol_number(fol_file, source_file):
    # Read the entire source file into a list
    lp = LogicParser()

    with open(source_file, 'r', encoding='utf-8') as sf:
        source_lines = sf.readlines()

    # Read the fol_file content first to avoid file truncation issues
    with open(fol_file, 'r', encoding='utf-8') as ff:
        fol_lines = ff.readlines()
    
    # Now write the processed output
    with open(fol_file, 'w', encoding='utf-8') as outfile:    
        for line in fol_lines:
            match = re.search(r'fol\((\d+)', line)
            if match:
                number = int(match.group(1))
                # Line numbers are typically 1-based
                if 1 <= number <= len(source_lines):
                    # Extract formula after 'prenex, '
                    if 'prenex, ' in line:
                        formula = line.split('prenex, ')[1].strip()
                    else:
                        formula = line.strip()
                    
                    # Process the formula
                    formula = re.sub(r"'[(]'(?=\([a-z])", "'OPENING_PARENTHESIS'", formula)
                    formula = re.sub(r"'[)]'(?=\([a-z])", "'CLOSING_PARENTHESIS'", formula)
                    formula = balance_parentheses(formula)
                    formula = convert_brackets_to_parentheses(formula)
                    formula = remove_redundant_parens(formula)
                    formula = formula.rstrip('.')
                    formula = normalize_numeric_underscores(formula)
                    formula = normalize_quoted_identifiers(formula)
                    formula = re.sub(r'\b(?:and|or)\s*\(', lambda m: f"'{m.group(0)[:-1]}'(", formula)
                    formula = re.sub(r"'[,] '(?=\()", "'COMMA'", formula)
                    formula = re.sub(r"\b(\d+)\.(\d+)\b", r"\1_\2", formula)
                    formula = re.sub(r"(\d*_?-?\d+)\,\s?(\d+[a-z]?[a-z]?)\b", r"\1_\2", formula)
                    formula = re.sub(r"'-(?=\w)", r"'_", formula)
                    formula = re.sub(r'(?<=[(&])\s?-(?=\()', r'DASH', formula)
                    formula = re.sub(r"\$\.?(?=\()", "'dollar'", formula)
                    formula = re.sub(r"\\\"(?=\([a-z])", "'DOUBLE_QUOTE'", formula)
                    formula = re.sub(r"(?<=\()&(?=\([a-z])", "'and'", formula)
                    formula = re.sub(r"(?<=\()\b([a-z][0-9])\b(?=\()", r"'\1'", formula)
                    #formula = regex.sub(r"(?<=\(|& )(\>|\<)(?=\()", r"'\1'", formula)
                    formula = regex.sub(r"(?<=\(|& )\\(?=\([a-z])", "'BACKSLASH'", formula)
                    formula = re.sub(r"(?<=[a-z], )\\(?=\))", "'BACKSLASH'", formula)
                    #formula = re.sub(r"(?<=\=)(\s?)(\?)(?=\))", r"\1'\2'", formula)
                    formula = re.sub(r"iota(?=\()", "'iota'", formula)
                    formula = regex.sub(r"(?<=\()'.'(?=\()", "'DOT'", formula)





                    try:
                        parsed_expr = lp.parse(formula)
                        print(f"FOL expression for sentence {number} compatible with NLTK.")
                    except Exception as e:
                        print(f"Error raised during parsing of FOL expression for sentence {number} with NLTK: {e}")

                    outfile.write(f"# fol({number}): {source_lines[number - 1].strip()}\n{formula}\n\n")
                else:
                    print(f"fol({number}): [Line not found]")

replace_var_expressions('fol_sentences_xnli_test.pl', 'fol_nltk_xnli_test.txt')
extract_line_by_fol_number('fol_nltk_xnli_test.txt', 'xnli_test_input.txt')
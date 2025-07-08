import re
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
                # Skip "quant(" and start tracking parentheses
                i += len('[exists')
                stack.append('exists')
            elif s[i] == '[':
                result.append(s[i])
                stack.append('[')
                i += 1
            elif s[i] == ']':
                if stack:
                    top = stack.pop()
                    if top == 'exists':
                        # End of quant(...) — don't append this closing paren
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

                def replacer(match):
                    key = match.group(0)
                    if key not in replacements:
                        replacements[key] = next(var_names)

                    return replacements[key]
                new_line = re.sub(pattern, replacer, line)
                new_line = remove_quant_wrappers(new_line)
                new_line = format_exists_sequence(new_line)
                outfile.write(new_line.rstrip(', ')+'\n')


# Example usage
replace_var_expressions('fol_sentences.pl', 'fol_nltk.txt')

def balance_parentheses(expr):
    open_count = 0
    corrected = []

    for char in expr:
        if char == '(':
            open_count += 1
            corrected.append(char)
        elif char == ')':
            if open_count > 0:
                open_count -= 1
                corrected.append(char)
            else:
                # Too many closing parens — skip
                continue
        else:
            corrected.append(char)

    # If too many opening parens, we remove from the end
    if open_count > 0:
        for _ in range(open_count):
            # Remove last unmatched opening '(' from the end
            for i in range(len(corrected) - 1, -1, -1):
                if corrected[i] == '(':
                    corrected.pop(i)
                    break

    return ''.join(corrected)

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

def extract_line_by_fol_number(fol_file, source_file):
    # Read the entire source file into a list
    lp = LogicParser()

    with open(source_file, 'r', encoding='utf-8') as sf:
        source_lines = sf.readlines()

    # Process the fol_file line by line
    with open(fol_file, 'r', encoding='utf-8') as ff:
        ff = ff.readlines()
    
    with open(fol_file, 'w', encoding='utf-8') as outfile:    
        for line in ff:
            match = re.search(r'fol\((\d+)', line)
            if match:
                number = int(match.group(1))
                # Line numbers are typically 1-based
                if 1 <= number <= len(source_lines):
                    formula = balance_parentheses(line.split('prenex, ')[1].strip())
                    formula = re.sub(r'\b([a-z]|[a-z]1)\[', r'\1.(', formula)
                    formula = formula.replace('].', ').')
                    formula = formula.replace('])', '))') if 'forall' in formula and formula.index('forall') < formula.find("])") else formula
                    formula = remove_redundant_parens(formula)
                    formula = formula.rstrip('.')
                    try:
                        parsed_expr = lp.parse(formula)
                        print(f"FOL expression for sentence {number} compatible with NLTK.")
                    except Exception as e:
                        print(f"Error raised during parsing of FOL expression for sentence {number} with NLTK: {e}")


                    outfile.write(f"# fol({number}): {source_lines[number - 1].strip()}\n{formula}\n\n")
                else:
                    print(f"fol({number}): [Line not found]")

extract_line_by_fol_number('fol_nltk.txt', 'sick_input.txt')
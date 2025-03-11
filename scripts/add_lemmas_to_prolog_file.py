import pandas as pd
import json
import re

def load_lemmas_by_id(jsonl_file):
    """Load lemmas from JSONL and return a dictionary with sentence ID as the key."""
    lemma_dict = {}
    with open(jsonl_file, 'r', encoding='utf-8') as f:
        for line in f:
            data = json.loads(line)  # Parse JSON line
            lemma_dict[data["id"]] = {entry[0]: entry[1] for entry in data["pos_lemma"]}
    return lemma_dict

def replace_second_occurrence(content, lemma_dict):
    """Replace the second occurrence of the first word inside an `ex_si(...)` block with its lemma."""
    # We need to correctly tokenize the content while keeping nested parentheses intact
    # To handle this properly, we will manually process the content
    
    tokens = []  # This will store the actual tokens
    current_token = ""
    count = 0
    first_word = None

    i = 0
    while i < len(content):
        if content[i] == "(":
            # Start of a nested structure
            paren_level = 1
            tokens.append("(")
            i += 1
            while i < len(content) and paren_level > 0:
                if content[i] == "(":
                    paren_level += 1
                elif content[i] == ")":
                    paren_level -= 1
                current_token += content[i]
                i += 1
            tokens.append(current_token)
            current_token = ""
        elif content[i].isalpha() or content[i] in ["'", "-"]:  # start of a word
            current_token += content[i]
            i += 1
            # if we reach the end of the word, add it to tokens
            if i == len(content) or not (content[i].isalpha() or content[i] in ["'", "-"]):
                tokens.append(current_token)
                current_token = ""
        else:
            # Add non-alphabetic characters as tokens too
            if current_token:
                tokens.append(current_token)
            tokens.append(content[i])
            current_token = ""
            i += 1

    # Now we have tokens, we can replace the second occurrence of the first token
    replaced_content = []
    count_first_word = 0

    for token in tokens:
        if first_word is None and token.isalpha():
            first_word = token
        if token == first_word:
            count_first_word += 1
            if count_first_word == 2:
                if first_word in lemma_dict:
                    replaced_content.append(lemma_dict[first_word])  # replace second occurrence
                else:
                    replaced_content.append(token)  # leave as is
            else:
                replaced_content.append(token)
        else:
            replaced_content.append(token)
    
    return "".join(replaced_content)

def process_prolog_file(pl_file, lemma_file, output_file):
    """Process Prolog file, replacing second occurrences with lemmas from JSONL based on sentence ID."""
    lemma_by_id = load_lemmas_by_id(lemma_file)  # Load lemma dictionary

    with open(pl_file, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    updated_lines = []
    current_sentence_id = None  # Store the last seen sentence ID

    for i, line in enumerate(lines):
        match = re.match(r"sent\((\d+),", line)
        if match:
            current_sentence_id = int(match.group(1))  # Store sentence ID
            updated_lines.append(line)
            continue  # Next line contains `ex_si(...)`

        lemma_dict = lemma_by_id.get(current_sentence_id, {})  # Get lemma mappings for this sentence

        # Replace `ex_si` with `si`
        line = line.replace("ex_si", "si")

        # Process each `si(...)` block separately
        new_line = ""
        last_idx = 0

        # Find all `si(...)` blocks
        for match in re.finditer(r"si\((.*?)\)", line):
            full_match = match.group(0)  # Entire `si(...)`
            content = match.group(1)  # Inside `si(...)`

            # Replace second occurrence in this `si(...)`
            new_si_expr = replace_second_occurrence(content, lemma_dict)

            # Keep everything before this match + replace the match
            new_line += line[last_idx:match.start()] + f"si({new_si_expr})"
            last_idx = match.end()

        new_line += line[last_idx:]  # Append remaining part of line
        updated_lines.append(new_line)

    with open(output_file, 'w', encoding='utf-8') as f:
        f.writelines(updated_lines)

    print(f"Processed file saved as: {output_file}")

# Example usage
process_prolog_file("superpos_nolem_elmo.pl", "lemma_sick.jsonl", "output_lemmasi.pl")

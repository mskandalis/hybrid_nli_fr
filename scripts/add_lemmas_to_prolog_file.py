import pandas as pd
import json
import re

def load_lemmas_by_id(jsonl_file):
    """Load lemmas from JSONL and return a dictionary with sentence ID as the key."""
    lemma_dict = {}
    with open(jsonl_file, 'r', encoding='utf-8') as f:
        for line in f:
            data = json.loads(line)  # Parse JSON line
            lemma_dict[data["id"]] = {entry[0]: entry[1] if entry[1] is not None else entry[0] for entry in data["pos_lemma"]}
    return lemma_dict

def extract_si_elements(text):
    # Find all occurrences of si() and their content
    si_pattern = re.compile(r'si\((.*?)\)(?=\s*,\s*si|$|\s*],\s*Result)', re.DOTALL)
    
    # Extract the content inside each si()
    si_elements = si_pattern.findall(text)
    
    # Split the content of each si() by commas
    result_list = []
    for element in si_elements:
        elements = [item.strip() for item in element.split(", ")]
        result_list.append(elements)
    
    return result_list

def replace_second_occurrence(content, lemma_dict):
    """Replace the second occurrence of the first word inside an `ex_si(...)` block with its lemma."""
    # We need to correctly tokenize the content while keeping nested parentheses intact
    
    tokens = []  # Store the actual tokens
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

    for idr, token in enumerate(tokens):
        if first_word is None and token.lstrip("'").isalpha():
            first_word = token
        if token == first_word:
            count_first_word += 1

            tok=first_word.strip("'")
            mod_tok= first_word.lstrip("'")
            modified_tok = tok+"'"

            first_word_value = lemma_dict.get(first_word)
            mod_tok_value = lemma_dict.get(mod_tok)
            modified_tok_value = lemma_dict.get(modified_tok)
            tok_value = lemma_dict.get(tok)
            complex_word = first_word+tokens[idr+1]
            complex_word2 = first_word+tokens[idr+1]+tokens[idr+2]
            complex_word_value = lemma_dict.get(complex_word, lemma_dict.get(complex_word.strip("'"), lemma_dict.get(complex_word.strip("'").replace("\\", ""))))
            complex_word2_value = lemma_dict.get(complex_word2, lemma_dict.get(complex_word2.strip("'"), lemma_dict.get(complex_word2.strip("'").replace("\\", ""))))

            # Fallback to first_word if no value is found
            replacement_value = first_word_value or mod_tok_value or modified_tok_value or tok_value or complex_word_value or complex_word2_value or first_word

            if count_first_word == 2:
                if replacement_value:
                    if any(char.isupper() for char in replacement_value) and not (replacement_value.startswith("'") and replacement_value.endswith("'")) and ("'" != replaced_content[-1] and "'" != replaced_content[-2]):
                        replaced_content.append(f"'{replacement_value}'")

                    else:
                        replaced_content.append(replacement_value)  # replace second occurrence
                else:
                    replaced_content.append(token)

            else:

                replaced_content.append(token)

        else:
            replaced_content.append(token)
    repla = text = re.sub(r"(?<!\\)'(?=(\w|\\))", "", "".join(replaced_content))

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

        lemma_dict = {key+ "'" if (len(key) == 1 and ((key.lower() in 'djlmnst') or (key.lower() in 'c' and "°" not in lemma_dict.keys()))) or (key.lower() =='qu') else key: (str(value) + 'e' if (len(key) == 1 and len(value)==1 and (key.lower() in 'djlmnst' or (key.lower() in 'c' and "°" not in lemma_dict.keys())) and key.lower()==value.lower()) or value.lower()=='qu' else value)
        for key, value in lemma_dict.items()}

        # Replace `ex_si` with `si`
        line = line.replace("ex_si", "si")
        run = extract_si_elements(line)
        modified_text=line
        for i, elements in enumerate(run, 1):

            #print(f"si {i}: {elements}")
            modified_elements = elements.copy()
            # Example: Change the third element of each si
            tok=elements[2].strip("'")
            mod_tok= elements[2].lstrip("'")
            modified_tok = tok+"'"
            complex_word = mod_tok.rstrip("\\''")
            complex_word2 = tok.replace("\\", "'")
            stripped_text = re.sub(r'[\W]', '', elements[2])

            first_word_value = lemma_dict.get(elements[2])
            mod_tok_value = lemma_dict.get(mod_tok)
            modified_tok_value = lemma_dict.get(modified_tok)
            tok_value = lemma_dict.get(tok)
            complex_word_value = lemma_dict.get(complex_word)
            complex_word2_value = lemma_dict.get(complex_word2)
            stripped_text_value = lemma_dict.get(stripped_text)

            # Fallback to first_word if no value is found
            replacement_value = first_word_value or mod_tok_value or modified_tok_value or tok_value or complex_word_value or complex_word2_value or stripped_text_value or elements[2]

            modified_elements[2] = replacement_value  # Replace the third element with its lemma from lemma_dict
            if "'" in modified_elements[2] and not(modified_elements[2].startswith("'") and modified_elements[2].endswith("'")):
                modified_elements[2] = re.sub(r"(?<!\\)'", r"\\'", modified_elements[2])
            if not re.fullmatch(r"[a-z]+", modified_elements[2]) and not(modified_elements[2].startswith("'") and modified_elements[2].endswith("'")):
                modified_elements[2] = f"'{modified_elements[2]}'"            
            # Reconstruct the `si()` string with the modified elements
            modified_si = f"si({', '.join(modified_elements)})"
            initial_si = f"si({', '.join(run[i-1])})"
            
            # Replace the old `si()` string in the original text with the modified one
            modified_text = modified_text.replace(initial_si, modified_si)
        updated_lines.append(modified_text)

    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(':- dynamic sent/2.\n\n')
        f.writelines(updated_lines)

    print(f"Processed file saved as: {output_file}")

# Example usage
process_prolog_file("rte3_dev_new_superpos_bert_deepgrail_nolem.pl", "stanza/rte3_dev_postags_lemmas_stanza.jsonl", "output_lemmasi_rte3_dev_0_0001_bert.pl")

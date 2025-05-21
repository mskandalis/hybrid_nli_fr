#!/usr/bin/env python

import pandas as pd 
import re
import csv
import json
import ast
import unicodedata


def extract_rules_to_csv(xml_file, output_tsv,sentences_txt):
    with open(xml_file, 'r', encoding='utf-8') as infile, open(output_tsv, 'w', newline='', encoding='utf-8') as outfile, open(sentences_txt, 'r', encoding='utf-8') as sentencefile:
        lines = infile.readlines()  # Read all lines from the XML file
        sentences = sentencefile.readlines()
        csv_writer = csv.writer(outfile, delimiter='\t')  # Create a CSV writer
        
        # Write header if needed
        csv_writer.writerow(['id', 'sentence', 'pros', 'formula'])  # This writes a header for the column

        for i in range(1, len(lines)):
            # Check if the current line starts with "<rule" and the previous line is blank
            if lines[i].strip().startswith("<rule") and lines[i-1].strip() == '':
            	rule_line = lines[i].strip()

            	before_pros, after_pros = rule_line.split('pros=', 1)  # Split into two parts at the first occurrence of 'pros'
            	pros, formula = after_pros.split(' formula=', 1)

            	pattern = r'\b\d+\b'
            	integerindex = re.search(pattern, lines[i-2].strip()).group()
            	csv_writer.writerow([integerindex, sentences[int(integerindex)-1].strip(), pros.strip('"'), formula.strip('">').replace('lit(s(main))-', '').replace('lit(np(A,B,C))-', '').replace('lit(txt)-', '').replace('lit(np(B,C,D))-', '')])  # Write to CSV


# Provide the XML file path (replace with the actual file path)
xml_file = './proofs.xml'
output_tsv = 'rules_output.tsv'
sentences_txt = 'gqnli_fr_input.txt'

# Sample text (your Prolog file content)
with open('proofs.xml', 'r', encoding='utf-8') as xml_proof:
    xml_proofs = xml_proof.read()
    # Regex to find the comment number    
    proof_pattern = re.compile(r'<!-- (\d+)\.')
    # Regex to find the formulas
    mot_pattern = re.compile(r'pros="([^"]+)"')
    lit_pattern = re.compile(r'formula="([^"]+)"')
    split_pattern = re.compile(r"-(appl\(|word\(|lambda\(|[A-Z])")
    axiom_pattern = re.compile(r'rule name="([^"]+)"')

    # List to store results
    words = []
    formulas = []
    proof_numbers = []
    cg_category = []
    axioms = []

    # Variable to track the latest proof number
    current_proof_number = None

    # Split the text into lines
    for liney in xml_proofs.splitlines():
        # Search for comment with the current proof number
        proof_match = proof_pattern.search(liney)
        if proof_match:
            # If we find a number, update the current_number
            current_proof_number = proof_match.group(1)
        
        # Search for formulas and associate with the last proof number
        lit_match = lit_pattern.search(liney)
        mot_match = mot_pattern.search(liney)
        axiom_match = axiom_pattern.search(liney)
        if lit_match and current_proof_number:
            text_to_split = lit_match.group(1)
            split_match = split_pattern.search(text_to_split)
            if split_match:
                cg_catego = text_to_split[:split_match.start()]
                formull = text_to_split[split_match.start():]
                cg_category.append(cg_catego)
                formulas.append(formull.strip('-'))  # Extract everything after "lit("
                proof_numbers.append(current_proof_number)  # Reuse the last proof number

        # Search for the word in "pros"
                if mot_match:
                    axioms.append(axiom_match.group(1).rstrip('"'))
                    if len(mot_match.group(1))>1:
                        words.append(mot_match.group(1).strip('"'))
                    else:
                        words.append(mot_match.group(1))  # Extract the word from "pros"

    # Create a DataFrame with the extracted data
    datafr = pd.DataFrame({
        'Proof Number': proof_numbers,
        'Pros': words,
        'Rule_name': axioms,
        'Cg_category' : cg_category,
        'Formula': formulas
    })

    # Display the DataFrame
    datafr.to_csv('all_the_rules_with_cg.tsv', index=False, sep="\t")

extract_rules_to_csv(xml_file, output_tsv, sentences_txt)

def extract_number_value(attribute_str):
    """Extracts the value corresponding to 'Number=' from a given string."""
    if attribute_str is None:
        return None

    split_data = attribute_str.split('|')
    for part in split_data:
        if part.startswith('Number='):
            return part.split('=')[1]
    return None  # If 'Number=' is not found, return None

def load_lemmas_by_id(jsonl_file):
    """Load lemmas from JSONL and return a dictionary with sentence ID as the key."""
    lemma_dict = {}
    with open(jsonl_file, 'r', encoding='utf-8') as f:
        for line in f:
            data = json.loads(line)  # Parse JSON line
            #number_value = extract_number_value(entry[3])
            lemma_dict[data["id"]] = {entry[0]: entry[1]+"|"+number_value if (number_value:=extract_number_value(entry[3])) is not None and entry[1] is not None else entry[1]+"|"+number_value if number_value is not None else entry[1] if entry[1] is not None else entry[0]+"|"+number_value if number_value is not None else entry[0] for entry in data["pos_lemma"]}

    return lemma_dict


# appl(word(1), word(2)) -> (word(1)@word(2)), taking also into account nested structures like appl(word(8),appl(word(6),word(7))), and keeping lambda() as it is.

def find_matching_paren(s, start):
    stack = 1
    for i in range(start + 1, len(s)):
        if s[i] == '(':
            stack += 1
        elif s[i] == ')':
            stack -= 1
            if stack == 0:
                return i
    return -1  # Unmatched parenthesis

def parse_appl(expression):
    expression = expression.strip()
    
    if expression.startswith("lambda("):
        # Find the first comma to separate lambda arguments
        start_idx = expression.find("(") + 1
        split_idx = expression.find(",", start_idx)
        if split_idx == -1:
            return expression  # Invalid lambda expression
        
        lambda_var = expression[start_idx:split_idx].strip()
        
        # Find the matching parenthesis for the lambda expression
        end_idx = find_matching_paren(expression, start_idx - 1)
        if end_idx == -1:
            return expression  # Invalid format
        
        lambda_body = expression[split_idx + 1:end_idx].strip()
        
        # Recursively process the body of lambda to transform any appl calls
        lambda_body_parsed = parse_appl(lambda_body)
        return f"abst({lambda_var}, {lambda_body_parsed})"
    
    if expression.startswith("appl("):
        inner_expr = expression[5:-1]  # Remove "appl(" and ending ")"
        stack, split_idx = 0, -1
        
        # Find the main comma separating the two arguments
        for i, char in enumerate(inner_expr):
            if char == '(':
                stack += 1
            elif char == ')':
                stack -= 1
            elif char == ',' and stack == 0:
                split_idx = i
                break
        
        if split_idx == -1:
            return expression  # Invalid format, return as-is
        
        left = inner_expr[:split_idx].strip()
        right = inner_expr[split_idx + 1:].strip()
        
        left_parsed = parse_appl(left)
        right_parsed = parse_appl(right)
        
        return f'({left_parsed}@{right_parsed})'
    
    return expression  # Base case: return as-is if not an appl expression

# Function to replace word(N) with tlp(<N-th word in the list>)
def replace_word_with_tlp(input_tsv, output_tsv, lemmas_list, supertags_file, all_the_rules):
    data = input_tsv

    #lemmafile= pd.read_json(path_or_buf=lemmas_list, lines=True) for lemmas et POS tags from spaCy
    # supertags_tsv = pd.read_csv(supertags_file, sep='\t')
    lemma_by_id = load_lemmas_by_id(lemmas_list)

    # Define a pattern to match word(N), where N is a number inside parentheses
    pattern = r'word\((\d+)\)'
    pattern_variables = r'@([A-Z])\)'

    with open(supertags_file, 'r', encoding='utf-8') as tokensl: #open('sick_aligned_tags.txt', 'r', encoding='utf-8') as aligned_tags:
        tokensfile= tokensl.readlines()
        #aligned_lemma = aligned_tags.readlines()
        number_of_lines = sum(1 for line in tokensfile)
        for index, value in enumerate(data['id']):
#            cg=ast.literal_eval(supertags_tsv['cg_supertags'][value-1])

            lemma_dict = lemma_by_id.get(value, {})
            lemma_dict = {key+ "'" if (len(key) == 1 and ((key.lower() in 'djlmnst') or (key.lower() in 'c' and "°" not in lemma_dict.keys()))) or (key.lower() =='qu') else key: (str(value.split('|')[0]) + 'e' if (len(key) == 1 and len(value.split('|')[0])==1 and (key.lower() in 'djlmnst' or (key.lower() in 'c' and "°" not in lemma_dict.keys())) and key.lower()==value.split('|')[0].lower()) or value.split('|')[0].lower()=='qu' else value)
            for key, value in lemma_dict.items()}

            input_str = data['intermediate_conversion_for_langpro'][index]
            processed_list = []
            for texte in tokensfile:
                # Split by ' ' first, which will separate the tokens
                parts = texte.strip().split()
                # Now split each part by '|', and store them as lists of lists
                split_parts = [part.split('|') for part in parts if part]  # Check if part is non-empty

                processed_list.append(split_parts)

#            if len(processed_list[value-1]) != len(cg):
#                cg = list(filter(lambda x: x != 'dl(0,s,txt)', cg)) if '.' not in processed_list[value-1] else cg

#                assert len(processed_list[value-1]) == len(cg), f"Lists have different lengths: {len(cg)} != {len(processed_list[value-1])}, index: {index}\nsentence: {processed_list[value-1]}\nCG tags list: {cg}"

            # Function to replace each match
            def replacement(match):
                # Extract the number inside the parentheses
                number = int(match.group(1))
                matches = re.findall(pattern, input_str)
                numbers = [int(match) for match in matches]
                largest_number = max(numbers)

                for idex, valeur in enumerate(processed_list[value-1]):
                    # Check if the number is within the bounds of the list
                    if 0 <= largest_number < len(processed_list[value-1]):

                        # Replace with the corresponding word from the list
                        mot = processed_list[value-1][number][0]
                        tok=mot.strip("'")
                        mod_tok= mot.lstrip("'")
                        modified_tok = tok+"'"
                        complex_word = mod_tok.rstrip("\\''")
                        complex_word2 = tok.replace("\\", "'")
                        stripped_text = re.sub(r'[\W]', '', mot)

                        first_word_value = lemma_dict.get(mot)
                        mod_tok_value = lemma_dict.get(mod_tok)
                        modified_tok_value = lemma_dict.get(modified_tok)
                        tok_value = lemma_dict.get(tok)
                        complex_word_value = lemma_dict.get(complex_word)
                        complex_word2_value = lemma_dict.get(complex_word2)
                        stripped_text_value = lemma_dict.get(stripped_text)

                        # Fallback to first_word if no value is found
                        lemme = first_word_value or mod_tok_value or modified_tok_value or tok_value or complex_word_value or complex_word2_value or stripped_text_value or mot
                        lemma = lemme.split('|')[0]

                        if not re.fullmatch(r"[a-z]+", mot) and not(mot.startswith("'") and mot.endswith("'")):
                            mot = mot.replace("'", "\\'")
                            mot = f"'{mot}'"
                        #lemmaline= ast.literal_eval(aligned_lemma[value-1])
                        #assert len(processed_list[value-1]) == len(cg), f"For sentence id {index}, lists have different lengths:\nlemmas {len(lemmaline)}, tokens & POStags {len(processed_list[value-1])}, CGs {len(cg)}."

                        #lemma = lemmaline[number][2] 
                        if not re.fullmatch(r"[a-z]+", lemma) and not(lemma.startswith("'") and lemma.endswith("'")):
                            lemma = lemma.replace("'", "\\'")
                            lemma = f"'{lemma}'"
                        pos = processed_list[value-1][number][1]
                        supertags = processed_list[value-1][number][3]
                        
                        # return f'(tlp({mot}, {lemma}, {pos}, 0, O), \'{supertags}\')' if for use by LangPro's visualiser: https://naturallogic.pro/LangPro/vis_utils
                        # return f'(tlp({mot}, {lemma}, {pos}, 0, O), {supertags})' #if for use directly by LangPro theorem prover
                        if len(lemme.split('|')) > 1:
                            return f"tlp({mot}, {lemma}, '{pos}:{lemme.split('|')[1]}', 0, O)" #if for use directly by LangPro theorem prover
                        else:
                            if not re.fullmatch(r"[a-z]+", pos) and not(pos.startswith("'") and pos.endswith("'")):
                                pos = f"'{pos}'"
                            return f"tlp({mot}, {lemma}, {pos}, 0, O)"
                    else:
                        # If the number is out of bounds, return the original word
                        print("Adjusting the numbering of the words for this example...")
                        words_to_replace = all_the_rules[all_the_rules['Proof Number']==value]
                        words_to_replace = words_to_replace[words_to_replace['Converted_rules'].str.len() < 10]
                        words_to_replace = words_to_replace[words_to_replace['Converted_rules'].str.len() > 2]
                        words_to_replace = words_to_replace[words_to_replace['Rule_name'].str.contains('axiom', case=False, na=False)]
                            
                        # Replace with the corresponding word from the list
                        mot = words_to_replace[words_to_replace['Converted_rules']==f'word({number})']['Pros'].iloc[0]
                        tok=mot.strip("'")
                        mod_tok= mot.lstrip("'")
                        modified_tok = tok+"'"
                        complex_word = mod_tok.rstrip("\\''")
                        complex_word2 = tok.replace("\\", "'")
                        stripped_text = re.sub(r'[\W]', '', mot)
                        order_of_check = [mot, mod_tok, modified_tok, tok, complex_word, complex_word2, stripped_text]

                        first_word_value = lemma_dict.get(mot)
                        mod_tok_value = lemma_dict.get(mod_tok)
                        modified_tok_value = lemma_dict.get(modified_tok)
                        tok_value = lemma_dict.get(tok)
                        complex_word_value = lemma_dict.get(complex_word)
                        complex_word2_value = lemma_dict.get(complex_word2)
                        stripped_text_value = lemma_dict.get(stripped_text)

                        # Fallback to first_word if no value is found
                        lemme = first_word_value or mod_tok_value or modified_tok_value or tok_value or complex_word_value or complex_word2_value or stripped_text_value or mot
                        lemma = lemme.split('|')[0]

                        if not re.fullmatch(r"[a-z]+", mot) and not(mot.startswith("'") and mot.endswith("'")):
                            mot = mot.replace("'", "\\'")
                            mot = f"'{mot}'"
                        #lemmaline= ast.literal_eval(aligned_lemma[value-1])
                        #assert len(processed_list[value-1]) == len(cg), f"For sentence id {index}, lists have different lengths:\nlemmas {len(lemmaline)}, tokens & POStags {len(processed_list[value-1])}, CGs {len(cg)}."

                        #lemma = lemmaline[number][2] 
                        if not re.fullmatch(r"[a-z]+", lemma) and not(lemma.startswith("'") and lemma.endswith("'")):
                            lemma = lemma.replace("'", "\\'")
                            lemma = f"'{lemma}'"
                        pos = next((inner[1] for inner in processed_list[value-1] if any(oc == inner[0] for oc in order_of_check) or any(oc in inner[0] for oc in order_of_check)), mot)
                        supertags = next((inner[3] for inner in processed_list[value-1] if inner[0] in order_of_check), 0)
                        
                        # return f'(tlp({mot}, {lemma}, {pos}, 0, O), \'{supertags}\')' if for use by LangPro's visualiser: https://naturallogic.pro/LangPro/vis_utils
                        # return f'(tlp({mot}, {lemma}, {pos}, 0, O), {supertags})' #if for use directly by LangPro theorem prover
                        if len(lemme.split('|')) > 1:
                            return f"tlp({mot}, {lemma}, '{pos}:{lemme.split('|')[1]}', 0, O)" #if for use directly by LangPro theorem prover
                        else:
                            if not re.fullmatch(r"[a-z]+", pos) and not(pos.startswith("'") and pos.endswith("'")):
                                pos = f"'{pos}'"
                            return f"tlp({mot}, {lemma}, {pos}, 0, O)"


            # Apply the regex and replacement to the input string
            transformed_str = re.sub(pattern, replacement, input_str)
            transformed_str = re.sub(pattern_variables, r'@\1', transformed_str)
            print("\n",transformed_str)
            print('---------- sentence with id ', value, ' processed, out of ', str(number_of_lines), ' lines. ----------\n')
            data.at[index, 'intermediate_conversion_for_langpro'] = transformed_str
        return data 


# Example usage
data = pd.read_csv("rules_output.tsv", sep='\t')
intermediate_conversion_appl=[]
for index, value in enumerate(data['id']):
    input_str = data['formula'][index]
    result = parse_appl(input_str)
    #For appl(lambda(A, appl(appl(word(9), appl(word(10), word(11))), appl(appl(word(6), appl(word(7), word(8))), A))), appl(word(0), appl(word(5), appl(appl(word(2), appl(word(3), word(4))), word(1)))))
    #It should normally give (lambda@(A, ((word(9)@(word(10)@word(11)))@((word(6)@(word(7)@word(8)))@A)))@(word(0)@(word(5)@((word(2)@(word(3)@word(4)))@word(1)))))

    intermediate_conversion_appl.append((data['id'][index], data['sentence'][index], data['pros'][index], input_str, result))

intermediate_conversion_appl = pd.DataFrame(intermediate_conversion_appl, columns=['id', 'sentence', 'pros', 'formula', 'intermediate_conversion_for_langpro'])

#Add the CG category for every rule in the formula 
def transform_appl(expression, allrules):
    replacements = {}
    pattern_abst = r"abst\(([A-Z]|[A-Z][0-9]),|@([A-Z]|[A-Z][0-9])\)"
    another_pattern = r'\b[A-Z][0-9]?\b'
    all_mappings = []
    # Collect all replacements first without modifying expression on the fly
    for _, row in allrules.iterrows():
        formulae = row['Converted_rules']
        
        if formulae not in intermediate_conversion_appl['intermediate_conversion_for_langpro'][indx] and len(formulae)>2:
            #formulae = row['Converted_rules']
            interm = re.sub(r'\b[A-Z][0-9]?\b', '~', intermediate_conversion_appl['intermediate_conversion_for_langpro'][indx])
            formulo = re.sub(r'\b[A-Z][0-9]?\b', '~', formulae)

            start_index = interm.find(formulo)
            capitals_whole_expr = re.findall(another_pattern, intermediate_conversion_appl['intermediate_conversion_for_langpro'][indx][start_index:start_index+len(formulae)])
            capitals_sub = re.findall(another_pattern, formulae)
            try:    
                existing_row = next((item for item in all_mappings if item['Proof Number'] == row['Proof Number']), None)
          
                if existing_row:
                    # If the row already exists, just add the new mappings to the existing dictionary
                    for i in range(len(capitals_sub)):
                        existing_row['Mappings'][capitals_sub[i]] = capitals_whole_expr[i]

                else:
                    # If the row does not exist, create a new row with the mappings
                    mapping = {capitals_sub[i]: capitals_whole_expr[i] for i in range(len(capitals_sub))}
                    all_mappings.append({'Proof Number': row['Proof Number'], 'Mappings': mapping})

                for key, value in mapping.items():
                    formulae = re.sub(fr'\b{key}[0-9]?\b', f'{value}', formulae)
            except:
                print(f"Rule not appearing directly in the lambda-term for the example No {indx}")

        
        if re.match(another_pattern, formulae) and (formulae not in intermediate_conversion_appl['intermediate_conversion_for_langpro'][indx]):
            mapping_row = next((item for item in all_mappings if item['Proof Number'] == row['Proof Number']), None)
            try:
                formulae = mapping_row['Mappings'][formulae]
            except:
                print(f"Rule not appearing directly in the lambda-term for the example No {indx}")

        formula, category = formulae, row['Cg_category']

        # Replace matches
        replacements[formula] = category
        replacements[formula] = re.sub(r"(\w*[\u00C0-\u017F]+\w*)", r"'\1'", replacements[formula])

    # Replace expressions from longest to shortest (to prevent partial replacements)
    sorted_replacements = sorted(replacements.keys(), key=len, reverse=True)
    
    for formula in sorted_replacements:
        if len(formula)<3:
            expression = re.sub(fr'(?<=\W){formula}(?=\W)', fr'({formula}, {replacements[formula]})', expression)
        else:
            expression = expression.replace(formula, f'({formula}, {replacements[formula]})')
    
    return expression

datarules = pd.read_csv('all_the_rules_with_cg.tsv', sep="\t")
new_rules=[]
for indind, valval in enumerate(datarules['Proof Number']):
    resultate = parse_appl(datarules['Formula'][indind])
    new_rules.append(resultate)

datarules['Converted_rules'] = new_rules

la_liste=[]
for indx, valu in enumerate(intermediate_conversion_appl['id']):
    allrules = datarules[datarules['Proof Number']==valu]
    input_expr = intermediate_conversion_appl['intermediate_conversion_for_langpro'][indx]
    result = transform_appl(input_expr, allrules)
    la_liste.append(result)

intermediate_conversion_appl['intermediate_conversion_for_langpro'] = la_liste

# Perform the replacement
result = replace_word_with_tlp(intermediate_conversion_appl, "input_for_langpro.tsv", "stanza/gqnli_fr_postags_lemmas_stanza.jsonl", "gqnli_new_superpos_bert_deepgrail.txt", datarules)
conversion_appl = pd.DataFrame(result)
conversion_appl = conversion_appl.rename(columns={'intermediate_conversion_for_langpro': 'langpro_input'})

# Convert to prolog file
conversion_appl.to_csv('input_for_langpro.tsv', index=False, sep="\t")
with open('langpro_input_prolog_format.pl', 'w', encoding='utf-8') as prol:
    for index, value in enumerate(conversion_appl['id']):
        prolog_term = re.sub(r'(\b\w*[\u00C0-\u017F]+\w*\b)', r"\1", conversion_appl['langpro_input'][index])
        comment_sentence = conversion_appl['sentence'][index].replace("'", " ").replace("’", " ").lower()
        prol.write(f"% {comment_sentence}\ncg_term({conversion_appl['id'][index]}, {prolog_term}).\n\n")  # Each entry as a Prolog fact

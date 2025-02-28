#!/usr/bin/env python

import pandas as pd 
import re
import csv
import json
import ast

def extract_rules_to_csv(xml_file, output_csv,sentences_txt):
    with open(xml_file, 'r') as infile, open(output_csv, 'w', newline='', encoding='utf-8') as outfile, open(sentences_txt, 'r', encoding='utf-8') as sentencefile:
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
xml_file = './sick_proofs.xml'
output_csv = 'rules_output.tsv'
sentences_txt = 'sick_raw.txt'

import re
import pandas as pd

# Sample text (your Prolog file content)
with open('sick_proofs.xml', 'r', encoding='utf-8') as xml_proof:
    xml_proofs = xml_proof.read()
    # Regex to find the comment number    
    proof_pattern = re.compile(r'<!-- (\d+)\.')
    # Regex to find the formulas
    lit_pattern = re.compile(r'formula="([^"]+)"')
    split_pattern = re.compile(r"-(appl\(|word\(|lambda\(|[A-Z])")

    # List to store results
    formulas = []
    proof_numbers = []
    cg_category = []

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
        if lit_match and current_proof_number:
            text_to_split = lit_match.group(1)
            split_match = split_pattern.search(text_to_split)
            if split_match:
                cg_catego = text_to_split[:split_match.start()]
                formull = text_to_split[split_match.start():]
                cg_category.append(cg_catego)
                formulas.append(formull.strip('-'))  # Extract everything after "lit("
                proof_numbers.append(current_proof_number)  # Reuse the last proof number

    # Create a DataFrame with the extracted data
    datafr = pd.DataFrame({
        'Proof Number': proof_numbers,
        'Cg_category' : cg_category,
        'Formula': formulas
    })

    # Display the DataFrame
    datafr.to_csv('all_the_rules_with_cg.tsv', index=False, sep="\t")

extract_rules_to_csv(xml_file, output_csv, sentences_txt)

# appl(word(1), word(2)) -> (word(1)@word(2)), taking also into account nested structures like appl(word(8),appl(word(6),word(7))), and keeping lambda() as it is.
import re

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
def replace_word_with_tlp(input_csv, output_csv, tokens_list, supertags_file):
    data = input_csv
    #lemmafile= pd.read_json(path_or_buf=tokens_list, lines=True) for lemmas et POS tags from spaCy
    supertags_tsv = pd.read_csv(supertags_file, sep='\t')

    # Define a pattern to match word(N), where N is a number inside parentheses
    pattern = r'word\((\d+)\)'
    pattern_variables = r'@([A-Z])\)'

    with open('sick_superpos.txt', 'r') as tokensl, open('sick_aligned_tags.txt', 'r', encoding='utf-8') as aligned_tags:
        tokensfile= tokensl.readlines()
        aligned_lemma = aligned_tags.readlines()
        number_of_lines = sum(1 for line in tokensfile)
        for index, value in enumerate(data['id']):
            cg=ast.literal_eval(supertags_tsv['cg_supertags'][value-1])

            input_str = data['intermediate_conversion_for_langpro'][index]
            processed_list = []
            for texte in tokensfile:
                # Split by '|1 ' first, which will separate the tokens
                parts = texte.strip().split('|1 ')
                # Now split each part by '|', and store them as lists of lists
                split_parts = [part.split('|') for part in parts if part]  # Check if part is non-empty

                processed_list.append(split_parts)

            if len(processed_list[value-1]) != len(cg):
                cg = [x for x in cg if x != 'dl(0,s,txt)']
                assert len(processed_list[value-1]) == len(cg), f"Lists have different lengths: {len(cg)} != {len(processed_list[value-1])}, index: {index}\nsentence: {processed_list[value-1]}\nCG tags list: {cg}"

            # Function to replace each match
            def replacement(match):
                # Extract the number inside the parentheses
                number = int(match.group(1)) 
                for idex, valeur in enumerate(processed_list[value-1]):
                    # Check if the number is within the bounds of the list
                    if 0 <= number <= len(processed_list[value-1]):

                        # Replace with the corresponding word from the list
                        mot = processed_list[value-1][number][0]

                        if re.search(r"[',.]", mot) or '@' in mot or '%' in mot or re.search(r"\w*[A-Z]+\w*", mot) or re.search(r"\w*[\u00C0-\u017F]+\w*", mot):
                            mot = mot.replace("'", "\\'")
                            mot = f"'{mot}'"
                        lemmaline= ast.literal_eval(aligned_lemma[value-1])
                        assert len(processed_list[value-1]) == len(lemmaline) == len(cg), f"For sentence id {index}, lists have different lengths:\nlemmas {len(lemmaline)}, tokens & POStags {len(processed_list[value-1])}, CGs {len(cg)}."
                        lemma = lemmaline[number][2] 
                        if re.search(r"[',.]", lemma) or '@' in lemma or '%' in lemma or re.search(r"\w*[A-Z]+\w*", lemma)or re.search(r"\w*[\u00C0-\u017F]+\w*", lemma):
                            lemma = lemma.replace("'", "\\'")
                            lemma = f"'{lemma}'"
                        pos = processed_list[value-1][number][1]
                        supertags = cg[number]
                        if len(pos)==1 and pos.isupper() or '@' in pos or '%' in pos or re.search(r"\w*[A-Z]+\w*", pos) or re.search(r"\w*[\u00C0-\u017F]+\w*", pos):
                            pos = f"'{pos}'"
                        # return f'(tlp({mot}, {lemma}, {pos}, 0, O), \'{supertags}\')' if for use by LangPro's visualiser: https://naturallogic.pro/LangPro/vis_utils
                        # return f'(tlp({mot}, {lemma}, {pos}, 0, O), {supertags})' #if for use directly by LangPro theorem prover
                        return f"tlp({mot}, {lemma}, {pos}, 0, O)" #if for use directly by LangPro theorem prover
                    else:
                        # If the number is out of bounds, return the original word
                        return match.group(0)

            # Apply the regex and replacement to the input string
            transformed_str = re.sub(pattern, replacement, input_str)
            transformed_str = re.sub(pattern_variables, r'@\1', transformed_str)
            print('sentence with id ', value, ' processed, out of ', str(number_of_lines), ' lines.')
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
    another_pattern = r'[A-Z][0-9]?'
    all_mappings = []
    # Collect all replacements first without modifying expression on the fly
    for _, row in allrules.iterrows():
        formulae = row['Converted_rules']
        
        if formulae not in intermediate_conversion_appl['intermediate_conversion_for_langpro'][indx] and len(formulae)>2:
            #formulae = row['Converted_rules']
            interm = re.sub(r'[A-Z][0-9]?', 'Z', intermediate_conversion_appl['intermediate_conversion_for_langpro'][indx])
            formulo = re.sub(r'[A-Z][0-9]?', 'Z', formulae)

            start_index = interm.find(formulo)
            capitals_whole_expr = re.findall(another_pattern, intermediate_conversion_appl['intermediate_conversion_for_langpro'][indx][start_index:start_index+len(formulae)])
            capitals_sub = re.findall(another_pattern, formulae)
            
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
                formulae = re.sub(fr'{key}|{key}[0-9]', f'{value}', formulae)

        
        if re.match(another_pattern, formulae) and (formulae not in intermediate_conversion_appl['intermediate_conversion_for_langpro'][indx]):
            mapping_row = next((item for item in all_mappings if item['Proof Number'] == row['Proof Number']), None)

            formulae = mapping_row['Mappings'][formulae]

                #if re.match(another_pattern, formulae) and (formulae not in intermediate_conversion_appl['intermediate_conversion_for_langpro'][indx]):
                #    formulae = 'O'
                #    if re.match(another_pattern, formulae) and (formulae not in intermediate_conversion_appl['intermediate_conversion_for_langpro'][indx]):
                 #       formulae = 'B'
                 #       if re.match(another_pattern, formulae) and (formulae not in intermediate_conversion_appl['intermediate_conversion_for_langpro'][indx]):
                 #           formulae = 'E'
                  #          if re.match(another_pattern, formulae) and (formulae not in intermediate_conversion_appl['intermediate_conversion_for_langpro'][indx]):
                  #              formulae = 'M'


        formula, category = formulae, row['Cg_category']

        # Replace matches with "A"
        replacements[formula] = category

    # Replace expressions from longest to shortest (to prevent partial replacements)
    sorted_replacements = sorted(replacements.keys(), key=len, reverse=True)
    
    for formula in sorted_replacements:
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
result = replace_word_with_tlp(intermediate_conversion_appl, "input_for_langpro.tsv", "deepgrail_tagger/lemma_sick.jsonl", "deepgrail_tagger/sick_cg_tags.tsv")
conversion_appl = pd.DataFrame(result)
conversion_appl = conversion_appl.rename(columns={'intermediate_conversion_for_langpro': 'langpro_input'})

# Convert to prolog file
conversion_appl.to_csv('input_for_langpro.tsv', index=False, sep="\t")
with open('langpro_input_prolog_format.pl', 'w', encoding='utf-8') as prol:
    for index, value in enumerate(conversion_appl['id']):
        prolog_term = re.sub(r'(\b\w*[\u00C0-\u017F]+\w*\b)', r"\1", conversion_appl['langpro_input'][index])
        comment_sentence = conversion_appl['sentence'][index].replace("'", " ").replace("’", " ").lower()
        prol.write(f"% {comment_sentence}\ncg_term({conversion_appl['id'][index]}, {prolog_term}).\n\n")  # Each entry as a Prolog fact

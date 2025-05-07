import pandas as pd
import ast

# Function to replace parts of the line
def replace_in_line(line, replacements):
    # Split the line by space, then pipe (|)
    text = line.split(' ')

    # Keep the first part of each section, replace everything else with the corresponding replacement
    new_parts = []
    
    for i, value in enumerate(text):
        parts = value.split('|')
        new_parts.append(parts[0]+'|')
        new_parts.append(parts[1]+'|')
        if i < len(repl):
            if all(isinstance(inner, list) for inner in repl[i]):
                new_parts.append(str(len(repl[i]))+'|')
                bert_supertags = ('|'.join(str(item) for inner in repl[i] for item in inner))
                new_parts.append(bert_supertags)
            else: 
                new_parts.append('1|')
                new_parts.append(repl[i]+'|')
                new_parts.append('1')
        else:
            new_parts.append('|'.join(str(item) for item in parts[2:]))

        new_parts.append(' ')
    new_line = ''.join(new_parts).strip()
        # Reassemble the line with the replaced values
    return new_line

supertags_tsv = pd.read_csv("deepgrail_tagger/deepgrail_supertagged_xnli_test_dataset_0_0001.tsv", sep='\t')
replacement_list= supertags_tsv['cg_supertags']
with open('DeepGrail2021/xnli_test_super_0.3.txt', 'r', encoding='utf-8') as file, open('xnli_test_new_superpos_bert_deepgrail.txt', 'w', encoding='utf-8') as output_file:
    lines = file.readlines()
    for index, line in enumerate(lines):
        # Process the line
        repl = ast.literal_eval(replacement_list[index])
        new_line = replace_in_line(line.strip(), repl)
        output_file.write(f"{new_line}\n")

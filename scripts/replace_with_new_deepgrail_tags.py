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
            new_parts.append('1|')
            new_parts.append(repl[i]+'|')
            new_parts.append('1')
        else:
            new_parts.append('1|')
            new_parts.append(parts[3]+'|')
            new_parts.append('1')
            # Check if parts[5] and parts[6] exist and add them
#            if len(parts) >= 5:  # Check if parts[5] and parts[6] exist
#                new_parts.append('2|')
#                new_parts.append(parts[3]+'|')
#                new_parts.append(parts[4])
#                new_parts.append('|' + parts[5] + '|')
#                new_parts.append(parts[6])
                
                # Check if parts[7] and parts[8] exist and add them
#            if len(parts) >= 8:
#                new_parts.append('3|')
#                new_parts.append(parts[3]+'|')
#                new_parts.append(parts[4])
#                new_parts.append('|' + parts[5] + '|')
#                new_parts.append(parts[6])
#                new_parts.append('|' + parts[7] + '|')
#                new_parts.append(parts[8]) 
                    
                    # Check if parts[9] and parts[10] exist and add them
#            if len(parts) >= 10:
#                new_parts.append('4|')
#                new_parts.append(parts[3]+'|')
#                new_parts.append(parts[4])
#                new_parts.append('|' + parts[5] + '|')
#                new_parts.append(parts[6])
#                new_parts.append('|' + parts[7] + '|')
#                new_parts.append(parts[8]) 
#                new_parts.append('|' + parts[9] + '|')
 #               new_parts.append(parts[10]) 
        new_parts.append(' ')
    new_line = ''.join(new_parts).strip()
        # Reassemble the line with the replaced values
    return new_line

supertags_tsv = pd.read_csv("deepgrail_tagger/sick_cg_tags.tsv", sep='\t')
replacement_list= supertags_tsv['cg_supertags']
with open('sick_super_elmo.txt', 'r', encoding='utf-8') as file, open('sick_new_superpos.txt', 'w', encoding='utf-8') as output_file:
    lines = file.readlines()
    for index, line in enumerate(lines):
        # Process the line
        repl = ast.literal_eval(replacement_list[index])
        new_line = replace_in_line(line.strip(), repl)
        output_file.write(f"{new_line}\n")

import pandas as pd
from datasets import load_dataset
import re


sick_train = load_dataset("maximoss/rte3-french", split="test").to_pandas()

sick_train['Subset'] = 'TEST'

sick_sorted = sick_train


# Helper function to split and clean sentences
def clean_sentence(sentence):
    return [item.strip() for item in re.split(r'(?<!M\.)(?<=\w{3}[!.?])\s(?!"$)|(?<!M\.)(?<=\w[àéaeiounùlth1-9CDSTPI][!.?])\s(?!"$)|(?<=[!.?:]|[a-z])\s(?=[1-9]\.\s[a-zA-Z])|(?<=.[\])"\'][!.?])\s(?!"$)|(?<=\w\.\.\.)\s(?!"$)(?=[A-Z])|(?<=\S{3}[!.?])\s(?!"$)(?=\S{3})|(?<=\S{3}[!.?])\s(?!"$)(?=[A-Z][a-z])|(?<=\w[àéaeiounùlth1-9CDSTPI][!.?])\s(?!"$)(?=\S{2})|(?<=\S{3}\s[!.?])\s(?!"$)(?=\S{2})|(?<=\w[àéaeiounùlth1-9CDSTPI][!.?])\s(?!"$)(?=\S{2})|(?<=\s[VX][!.?])\s(?!"$)(?=[^AEOU][aeiouéèêàîôùûïöül])', sentence) if item.strip()]

# Helper function to escape special characters for Prolog
def escape_prolog(sentence):
    # Escape single quotes and percentage signs
    return sentence.replace("'", "\\'").replace("%", "\\%")

# Function to write Prolog fact with dynamic numero
def write_prolog_fact(prol, index, numero, answer, sick_sentences, sick_sentence_B):
    prol.write(f"%problem id = {index}\n")
    
    # Write Prolog facts for premise (sick_sentences)
    for sentence in sick_sentences:
        if sentence:
            prol.write(f"sen_id({numero}, {index}, 'p', 'TEST', '{answer}', '{escape_prolog(sentence)}').\n")
            numero += 1  # Increment numero after each premise sentence
    
    # Write Prolog facts for hypothesis (sick_sentence_B)
    for sentence in sick_sentence_B:
        if sentence:
            prol.write(f"sen_id({numero}, {index}, 'h', 'TEST', '{answer}', '{escape_prolog(sentence)}').\n")
            numero += 1  # Increment numero after each hypothesis sentence


# Opening the file to write Prolog facts
with open('rte3_test_id_sentences_split.pl', 'w', encoding='utf-8') as prol:
    numero = 1  # Start from 1 for each new problem
    
    for index, row in sick_train.iterrows():
        if str(row['label']) == '0':
            answer = "yes"
        elif str(row['label']) == '1':
        	answer = "unknown"
        elif str(row['label']) == '2':
        	answer = "no"
        # Process premise and hypothesis (splitting them into sentences)
        sick_sentences = clean_sentence(row['premise'])  # Process premise into sentences
        sick_sentence_B = clean_sentence(row['hypothesis'])  # Process hypothesis into sentences
        
        # Write Prolog facts for this row
        write_prolog_fact(prol, row['id'], numero, answer, sick_sentences, sick_sentence_B)
        numero += len(sick_sentences) + len(sick_sentence_B)

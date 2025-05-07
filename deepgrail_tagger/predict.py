from SuperTagger.SuperTagger import SuperTagger
from SuperTagger.Utils.helpers import categorical_accuracy_str

import pandas as pd

#### DATA ####
# from datasets import load_dataset
# ds = load_dataset("maximoss/sick-fr-mt", split="validation")

#### POS-Tagging ####
"""https://huggingface.co/gilf/french-camembert-postag-model this model uses the same tags for POS-tagging as MElt"""
#from transformers import AutoTokenizer, AutoModelForTokenClassification, TokenClassificationPipeline

#tokenizer_pos = AutoTokenizer.from_pretrained("gilf/french-camembert-postag-model")
#model_pos = AutoModelForTokenClassification.from_pretrained("gilf/french-camembert-postag-model")
#pos = TokenClassificationPipeline(model=model_pos, tokenizer=tokenizer_pos)

#def make_prediction(sentence):
#    labels = [l['entity'] for l in pos(sentence)]
#    return list(zip(sentence.split(" "), labels))

#res = make_prediction("George Washington est allé à Washington")

#### MODEL FOR CGs ####
tagger = SuperTagger()

model = "models/flaubert_super_98%_V2_50e/flaubert_super_98%_V2_50e.pt"

tagger.load_weights(model)

beta_value = 1

#### TEST FOR CGs ####
a_s = "( 1 ) parmi les huit \" partants \" acquis ou potentiels , MM. Lacombe , Koehler et Laroze ne sont pas membres " \
      "du PCF . "
tags_s = [['let', 'dr(0,s,s)', 'let', 'dr(0,dr(0,s,s),np)', 'dr(0,np,n)', 'dr(0,n,n)', 'let', 'n', 'let', 'dl(0,n,n)',
           'dr(0,dl(0,dl(0,n,n),dl(0,n,n)),dl(0,n,n))', 'dl(0,n,n)', 'let', 'dr(0,np,np)', 'np', 'dr(0,dl(0,np,np),np)',
           'np', 'dr(0,dl(0,np,np),np)', 'np', 'dr(0,dl(0,np,s),dl(0,np,s))', 'dr(0,dl(0,np,s),np)', 'dl(1,s,s)', 'np',
           'dr(0,dl(0,np,np),n)', 'n', 'dl(0,s,txt)']]

pred_convert = tagger.predict(a_s, beta=beta_value)

print("Model : ", model)

print("\tLen Text           : ", len(a_s.split()))
print("\tLen tags           : ", len(tags_s[0]))
print("\tLen pred_convert   : ", len(pred_convert[0]))
print()
print("\tText               : ", a_s)
print()
print("\tTags               : ", tags_s[0])
print()
print("\tPred_convert       : ", pred_convert[0])
print()
print("\tScore              :", categorical_accuracy_str(pred_convert, tags_s))

preds_all = []

#for index, value in enumerate(ds['pair_ID']):
#    premise = ds['sentence_A'][index]
#    hypothesis = ds['sentence_B'][index]
#    _, pred_convert_p, _ = tagger.predict(premise)
#    _, pred_convert_h, _ = tagger.predict(hypothesis)

#    preds_all.append((str(ds['pair_ID'][index])+"p", premise, pred_convert_p[0]))
#    preds_all.append((str(ds['pair_ID'][index])+"h", hypothesis, pred_convert_h[0]))

with open('../gqnli_fr_input.txt', 'r', encoding='utf-8') as file, open('../gqnli_fr_input.txt', 'r', encoding='utf-8') as dfil:
    initial_sentences = dfil.readlines()
    # Iterate over each line with its index using enumerate
    for index, line in enumerate(file):
        # Process the line (strip removes leading/trailing whitespace)
        line = line.strip()
        pred_convert = tagger.predict(line, beta=beta_value)
        preds_all.append((index+1, initial_sentences[index].strip(), pred_convert[0]))

preds_all = pd.DataFrame(preds_all, columns=['id', 'sentence', 'cg_supertags'])

filename = f"deepgrail_supertagged_gqnli_dataset_{str(beta_value).replace('.', '_')}.tsv"
preds_all.to_csv(filename, index=False, sep="\t")

preds_all['count_formulas_per_token'] = preds_all['cg_supertags'].apply(lambda row: sum(len(inner) for inner in row))
preds_all['count_tokens'] = preds_all['cg_supertags'].apply(lambda row: len(row))
average = preds_all['count_formulas_per_token'].sum() / preds_all['count_tokens'].sum()

print("Average number of formulas per token: ", average)

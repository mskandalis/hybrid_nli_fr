import pandas as pd
import json
import ast

corpus = pd.read_csv("deepgrail_tagger/deepgrail_supertagged_sick_dataset.tsv", sep='\t')

###For SpaCy POS tags###
#posdata= pd.read_json(path_or_buf="deepgrail_tagger/postagged_lemma_validation.jsonl", lines=True)

#with open('superpos.txt', 'w') as f:
#   for index, value in enumerate(corpus['id']):
#       cg=ast.literal_eval(corpus['cg_supertags'][index])
#       for idex, valeur in enumerate(posdata['pos_lemma'][index]):
#           assert len(cg)==len(posdata['pos_lemma'][index])
#            print((posdata['pos_lemma'][index][idex][0]+"|"+posdata['pos_lemma'][index][idex][2]+"|1|"+cg[idex]+"|1"), file=f, end = " ")
#        print("", file=f)

###For TreeTagger POS tags###
ttpos = pd.read_csv("deepgrail_tagger/TreeTagger/tt_tags.tsv", sep='\t', header=None)
print(ttpos)
with open('superpos_tt.txt', 'w') as t:
    metrima=0
    for index, value in enumerate(corpus['id']):
        cg=ast.literal_eval(corpus['cg_supertags'][index])
        for idex, valeur in enumerate(cg):
            assert metrima==ttpos.index[metrima]
            print((ttpos[0][metrima]+"|"+ttpos[1][metrima]+"|1|"+cg[idex]+"|1"), file=t, end = " ")
            metrima+=1
        print("", file=t)   

print(metrima)
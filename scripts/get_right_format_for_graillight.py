import pandas as pd
import json
import ast

###For SpaCy POS tags###
#posdata= pd.read_json(path_or_buf="deepgrail_tagger/postagged_lemma_validation.jsonl", lines=True)

#with open('superpos.txt', 'w') as f:
#   for index, value in enumerate(corpus['id']):
#       cg=ast.literal_eval(corpus['cg_supertags'][index])
#       for idex, valeur in enumerate(posdata['pos_lemma'][index]):
#           assert len(cg)==len(posdata['pos_lemma'][index])
#            print((posdata['pos_lemma'][index][idex][0]+"|"+posdata['pos_lemma'][index][idex][2]+"|1|"+cg[idex]+"|1"), file=f, end = " ")
#        print("", file=f)

###For TreeTagger POS tags and lemmas###

import pprint   #For proper print of sequences.
import treetaggerwrapper

tagger = treetaggerwrapper.TreeTagger(TAGLANG='fr')
tttags=[]
with open('input.txt', 'r', encoding='utf-8') as input_text, open('postags_lemmas_tt.txt', 'w', encoding='utf-8') as output_tags:
    for index, line in enumerate(input_text):
        tags = tagger.tag_text(line)
        tttags.append(tags)

    for sublist in tttags:
        sousliste = [item.split('\t') for item in sublist]
        output_tags.write(repr(sousliste)+'\n')


corpus = pd.read_csv("./deepgrail_tagger/deepgrail_supertagged_sick_dataset.tsv", sep='\t')

with open('superpos.txt', 'w') as output_file, open('postags_lemmas_tt.txt', 'r', encoding='utf-8') as tags:
    tags_file = tags.readlines()
    tags_corrected=[]
    for liney in tags_file:
        lines=ast.literal_eval(liney)
        for i in range(len(lines)-1, 0, -1):
            # Check if the current list is ["'", 'PUN', "'"]
            if lines[i] == ["'", 'PUN', "'"]:
                # Append the first column (first element) of the current list to the first element of the previous list
                if lines[i-1][0] == 'd':
                    lines[i-1][0] += lines[i][0]
                    lines[i-1][1] ='PRP'
                    lines[i-1][2] = 'de'
                elif lines[i-1][0] == 'l':
                    lines[i-1][0] += lines[i][0]
                    lines[i-1][1] = 'DET:ART'
                    lines[i-1][2] = 'le'
                elif lines[i-1][0] == 'n':
                    lines[i-1][0] += lines[i][0]
                    lines[i-1][2] = 'ne'
                elif lines[i-1][0] == 'L':
                    lines[i-1][0] += lines[i][0]
                    lines[i-1][1] = 'DET:ART'
                    lines[i-1][2] = 'Le'
                elif lines[i-1][0] == 'D':
                    lines[i-1][0] += lines[i][0]
                    lines[i-1][1] ='PRP'
                    lines[i-1][2] = 'De'
                else:
                    lines[i-1][0] += lines[i][0]
                    lines[i-1][2] += lines[i][2]
                # Remove the current list ["'", 'PUN', "'"]
                del lines[i]
            if lines[i] == ['-mêmes', 'ADJ', 'même'] or lines[i] == ['-même', 'ADJ', 'même']:
                lines[i-1][0] += lines[i][0]
                lines[i-1][2] = lines[i-1][2]+'-'+lines[i][2]
                del lines[i]
            elif lines[i] == ['-ci', 'ADV', '-ci'] or lines[i] == ['-là', 'ADV', '-là']:
                lines[i-1][0] += lines[i][0]
                lines[i-1][2] += lines[i][2]
                del lines[i]
        tags_corrected.append(lines)

    for index, value in enumerate(corpus['id']):
        cg=ast.literal_eval(corpus['cg_supertags'][index])
        if len(cg) != len(tags_corrected[index]):
            #print(f"Index: {index}")
            #print(f"Lists have different lengths: {len(cg)} != {len(tags_corrected[index])}")
            print(cg)
            print(tags_corrected[index])
            cg = list(filter(lambda x: x != 'dl(0,s,txt)', cg))
            if len(cg) != len(tags_corrected[index]):
                tags_corrected[index] = [[elem.split('\t') for elem in tagger.tag_text(part)] for item in tags_corrected[index] for part in (item[0].split('-') if '-' in item[0] and item[0]!='au-dessus' else [item[0]])]
                tags_corrected[index] = [inner[0] for inner in tags_corrected[index]]
                if len(cg) != len(tags_corrected[index]):
                    for i in range(len(tags_corrected[index]) -1, 0, -1):
                        if tags_corrected[index][i-1][1] == 'ADJ' and tags_corrected[index][i][1] == 'VER:ppre' or tags_corrected[index][i][1] == 'ADJ':
                            cg.insert(i, cg[i-1]) 
                            break
                        assert len(cg) == len(tags_corrected[index]), f"Lists have different lengths: {len(cg)} != {len(tags_corrected[index])}, index: {index}"

        if len(cg) == len(tags_corrected[index]):
            for indy, valval in enumerate(cg):  
                print(index, tags_corrected[index], tags_corrected[index][indy][0], tags_corrected[index][indy][1], cg[indy])
                print((tags_corrected[index][indy][0]+"|"+tags_corrected[index][indy][1]+"|1|"+cg[indy]+"|1"), file=output_file, end = " ")

        print("", file=output_file)   

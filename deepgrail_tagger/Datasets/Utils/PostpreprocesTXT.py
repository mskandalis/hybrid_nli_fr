import itertools
import pickle
import re

import numpy as np
import pandas as pd


# dr = /
# dl = \

def sub_tree_word(word_with_data: str):
    s = word_with_data.split('|')
    word = s[0]
    tree = s[2]
    tree = re.sub("dr", "/", tree)
    tree = re.sub("dl", "\\\\", tree)
    tree = re.sub("dia", "dia,", tree)
    tree = re.sub("box", "box,", tree)
    tree = re.sub("dl", "\\\\,", tree)
    tree = re.sub(",\(1,|,\(0,|\(1,|\(0,", ",", tree)
    tree = re.sub("|\)", "", tree)

    return word, tree.split(',')


def sub_tree_line(line_with_data: str):
    line_list = line_with_data.split()
    sentence = ""
    sub_trees = []
    #sub_trees.append(["[START]"])
    for word_with_data in line_list:
        w, t = sub_tree_word(word_with_data)
        sentence += ' ' +w
        t.append("[SEP]")
        sub_trees.append(t)
        """if ('ppp' in list(itertools.chain(*sub_trees))):
            print(sentence)"""
    sub_trees.append(["[SOS]"])
    return sentence, list(itertools.chain(*sub_trees))


def Txt_to_csv(file_name: str):
    file = open(file_name, "r", encoding="utf8")
    text = file.readlines()

    sub = [sub_tree_line(data) for data in text]

    df = pd.DataFrame(data=sub, columns = ['Sentences', 'sub_tree'])

    df.to_csv("../Datasets/" + file_name[:-4] + "_dataset.csv", index=False)


def normalize_word(orig_word):
    word = orig_word.lower()
    if (word is "["):
        word = "("
    if (word is "]"):
        word = ")"

    return word

def read_maxentdata(file):
    with open(file, 'r', encoding="UTF8") as f:
        vocabulary = set()
        vnorm = set()
        partsofspeech1 = set()
        partsofspeech2 = set()
        superset = set()
        sentno = 0
        maxlen = 0
        words = ""
        postags1 = []
        postags2 = []
        supertags = []
        allwords = []
        allpos1 = []
        allpos2 = []
        allsuper = []
        for line in f:
            line = line.strip().split()
            length = len(line)
            if (length > maxlen):
                maxlen = length
            for l in range(length):
                item = line[l].split('|')
                if len(item) > 2:
                    orig_word = item[0]
                    word = normalize_word(orig_word)
                    postag = item[1]
                    supertag = item[2]
                    poslist = postag.split('-')
                    pos1 = poslist[0]
                    pos2 = poslist[1]
                    vocabulary.add(orig_word)
                    vnorm.add(word)
                    partsofspeech1.add(pos1)
                    partsofspeech2.add(pos2)
                    superset.add(supertag)
                    # words +=  ' ' +(str(orig_word))
                    words += ' ' + (str(orig_word))
                    postags1.append(pos1)
                    postags2.append(pos2)
                    supertags.append(supertag)
            allwords.append(words)
            allpos1.append(postags1)
            allpos2.append(postags2)
            allsuper.append(supertags)
            words = ""
            postags1 = []
            postags2 = []
            supertags = []

        X = np.asarray(allwords)
        Y1 = np.asarray(allpos1)
        Y2 = np.asarray(allpos2)
        Z = np.asarray(allsuper)
        return X, Y1, Y2, Z, vocabulary, vnorm, partsofspeech1, partsofspeech2, superset, maxlen

def save_obj(obj, name):
    with open(name + '.pkl', 'wb+') as f:
        pickle.dump(obj, f, pickle.HIGHEST_PROTOCOL)

def load_obj(name):
    with open(name + '.pkl', 'rb') as f:
        return pickle.load(f)

# Txt_to_csv("m2.txt")

X, Y1, Y2, Z, vocabulary, vnorm, partsofspeech1, partsofspeech2, superset, maxlen = read_maxentdata("m2.txt")

df = pd.DataFrame(columns = ["X", "Y1", "Y2", "Z"])

df['X'] = X[:len(X)-1]
df['Y1'] = Y1[:len(X)-1]
df['Y2'] = Y2[:len(X)-1]
df['Z'] = Z[:len(X)-1]

df.to_csv("../m2_dataset_V2.csv", index=False)


t =  np.unique(np.array(list(itertools.chain(*Z))))

print(t.size)

dict = { i : t[i] for i in range(0, len(t) ) }

save_obj(dict,"../index_to_super")

t =  np.unique(np.array(list(itertools.chain(*Y1))))

print(t.size)

dict = { i : t[i] for i in range(0, len(t) ) }

save_obj(dict,"../index_to_pos1")
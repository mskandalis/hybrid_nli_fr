The implementation of DeepGrail in this repository includes the possibility for a beta value assignment, as in Clark and Curran's supertagger.

# DeepGrail

This repository contains a Python implementation of BertForTokenClassification using TLGbank data to develop
part-of-speech taggers and supertaggers.

This code was designed to work with the [DeepGrail Linker](https://gitlab.irit.fr/pnria/global-helper/deepgrail-linker)
to provide a wide coverage syntactic and semantic parser for French. But the Tagger is independent, you can use it for your own tags.

## Usage

### Structure

```
.
├── Datasets                    # TLGbank data
├── SuperTagger                 # Implementation of BertForTokenClassification
│   ├── SuperTagger.py          # Main class
│   └── Tagging_bert_model.py   # Bert model
├── predict.py                  # Example of prediction
└── train.py                    # Example of train
```

### Installation

Python 3.9.10 **(Warning don't use Python 3.10**+**)**

Clone the project locally. In a clean python venv do `pip install -r requirements.txt`

Download already trained models or prepare data for **your** train.

## How To use

**predict.py** and **train.py** show simple examples of how to use the model, feel free to look at them before using the
SupperTagger

### Utils

For load **m2_dataset.csv**, you can use `SuperTagger.Utils.utils.read_csv_pgbar(...)`. This function return a pandas
dataframe.

### Prediction

For predict on your data you need to load a model (save with this code).

```
df = read_csv_pgbar(file_path,20)
texts = df['X'].tolist()

tagger = SuperTagger()

tagger.load_weights("your/model/path")

pred_without_argmax, pred_convert, bert_hidden_state = tagger.predict(texts[7])

print(pred_convert)
#['let', 'dr(0,s,s)', 'let', 'dr(0,dr(0,s,s),np)', 'dr(0,np,n)', 'dr(0,n,n)', 'let', 'n', 'let', 'dl(0,n,n)', 'dr(0,dl(0,dl(0,n,n),dl(0,n,n)),dl(0,n,n))', 'dl(0,n,n)', 'let', 'dr(0,np,np)', 'np', 'dr(0,dl(0,np,np),np)', 'np', 'dr(0,dl(0,np,np),np)', 'np', 'dr(0,dl(0,np,s),dl(0,np,s))', 'dr(0,dl(0,np,s),np)', 'dl(1,s,s)', 'np', 'dr(0,dl(0,np,np),n)', 'n', 'dl(0,s,txt)']
```

### Training

```
df = read_csv_pgbar(file_path,1000)
texts = df['X'].tolist()
tags = df['Z'].tolist()

#Dict for convert ID to token (The dict is save with the model for prediction)
index_to_super = load_obj('Datasets/index_to_super') 

tagger = SuperTagger()

bert_name = 'camembert-base'

tagger.create_new_model(len(index_to_super), bert_name, index_to_super)
# You can load your model for re-train this
# tagger.load_weights("your/model/path")

tagger.train(texts, tags, checkpoint=True)

pred_without_argmax, pred_convert, bert_hidden_state = tagger.predict(texts[7])
```

In train, if you use `checkpoint=True`, the model is automatically saved in a folder: Training_XX-XX_XX-XX. It saves
after each epoch. Use `tensorboard=True` for log in same folder. (`tensorboard --logdir=logs` for see logs)

`bert_name` can be any model available on [Hugging Face](https://huggingface.co/models)


## LICENCE

Copyright ou © ou Copr. CNRS, (18/07/2022)

Contributeurs : 
[Rabault Julien](https://www.linkedin.com/in/julienrabault), [de Pourtales Caroline](https://www.linkedin.com/in/caroline-de-pourtales/), Richard Moot

Ce logiciel est un programme informatique servant à établir un Proof Net depuis une phrase française. 

Ce logiciel est régi par la licence CeCILL-C soumise au droit français et
respectant les principes de diffusion des logiciels libres. Vous pouvez
utiliser, modifier et/ou redistribuer ce programme sous les conditions
de la licence CeCILL-C telle que diffusée par le CEA, le CNRS et l'INRIA 
sur le site "http://www.cecill.info".

En contrepartie de l'accessibilité au code source et des droits de copie,
de modification et de redistribution accordés par cette licence, il n'est
offert aux utilisateurs qu'une garantie limitée.  Pour les mêmes raisons,
seule une responsabilité restreinte pèse sur l'auteur du programme,  le
titulaire des droits patrimoniaux et les concédants successifs.

A cet égard  l'attention de l'utilisateur est attirée sur les risques
associés au chargement,  à l'utilisation,  à la modification et/ou au
développement et à la reproduction du logiciel par l'utilisateur étant 
donné sa spécificité de logiciel libre, qui peut le rendre complexe à 
manipuler et qui le réserve donc à des développeurs et des professionnels
avertis possédant  des  connaissances  informatiques approfondies.  Les
utilisateurs sont donc invités à charger  et  tester  l'adéquation  du
logiciel à leurs besoins dans des conditions permettant d'assurer la
sécurité de leurs systèmes et ou de leurs données et, plus généralement, 
à l'utiliser et l'exploiter dans les mêmes conditions de sécurité. 

Le fait que vous puissiez accéder à cet en-tête signifie que vous avez 
pris connaissance de la licence CeCILL-C, et que vous en avez accepté les
termes.

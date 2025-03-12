# Hybrid AI for NLI in French

This repository contains: 
- [datasets](https://huggingface.co/maximoss) for the task of [Natural Language Inference (NLI / RTE)](https://en.wikipedia.org/wiki/Textual_entailment) in French,
  - with sentence pairs,
  - a label ("yes" for entailment, "unknown" for neutral, or "no" for contradiction) for each sentence pair, and
  - their logical reprsentation (both lambda-terms and FOL expressions, in different files and for use by different models afterwards).
- the whole pipeline :
  - for obtaining this logical representation from the raw sentences, and
  - for predicting the label attributed to every sentence pair.

## Requirements

You need to have the following installed in your machine:
- [Prolog](https://www.swi-prolog.org/download/stable);
- TreeTagger (either the [original repository](https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger) alone, or the original repository + a [Python interface](https://github.com/miotto/treetagger-python) or a [TreeTagger Python Wrapper](https://treetaggerwrapper.readthedocs.io/en/latest)), or RNNTagger. Here I use the [third option mentioned](https://treetaggerwrapper.readthedocs.io/en/latest). After downloading TreeTagger, you will need to add the path to its bin to the PATH environment variable. This is done with
```set PATH=<your-path-to-TreeTagger's-folder>/bin;%PATH%``` in Windows, or
```export PATH=<your-path-to-TreeTagger's-folder>/bin;%PATH%``` in Linux.
For the Python Wrapper,
```pip install treetaggerwrapper```, then ```set```, for Windows, or ```export```, for Linux, ```TAGDIR=<your-path-to-TreeTagger's-folder>/TreeTagger```.

## Instructions
### Preparing the data and obtaining the lambda-terms (half deep learning, half prolog programme)
The steps you need to follow in order to obtain the input for [LangPro theorem Prover](https://github.com/kovvalsky/LangPro/tree/nl) are the following:
1. In order to extract the sentences from huggingface in a txt file (format: premise\n hypthesis\n premise\n hypothesis, etc.):
```
python scripts/extract_sentences_to_raw.py
```
2. POS-tagging with [TreeTagger](https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger) (not advised nowadays), [RNNTagger](https://www.cis.uni-muenchen.de/~schmid/tools/RNNTagger), or [1st DeepGrail's ELMo/LSTM](https://github.com/RichardMoot/DeepGrail2021) (advised), and lemmatisation with [TreeTagger](https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger) (not advised nowadays), [RNNTagger](https://www.cis.uni-muenchen.de/~schmid/tools/RNNTagger), or [spaCy](https://spacy.io/models/fr#fr_dep_news_trf) (advised):
```
tclsh tokenize.tcl raw.txt > input.txt
# python scripts/POStag-Lemma.ipynb (if you want to use lemmas from spaCy and not from TreeTagger or RNNTagger, later.)
TreeTagger\bin\tag-french <your-path-to>\input.txt tt_tags.tsv
```
3. Obtain the TLG (Type-Logical Grammar) label of every token in the sentences with DeepGrail, and then put this all together for the input to Graillight:
```
python deepgrail_tagger/predict.py
python scripts/assemble_graillight_input.py
```
4. Obtain [lambda-terms](https://en.wikipedia.org/wiki/Lambda_calculus), proofs and [DRS](https://en.wikipedia.org/wiki/Discourse_representation_theory) with [Graillight](https://github.com/RichardMoot/GrailLight):
```
tclsh supertag2pl superpos.txt > superpos_nolem.pl
swipl -q -g lemmatize -f lefff.pl superpos_nolem.pl
swipl -q -t main -f grail_light_nd.pl superpos.pl
```
5. Convert the output of Graillight to a compatible form for LangPro theorem prover:
```
python scripts/convert_grail_output_to_langpro_input.py
```

#### Score
With this pipeline from the beginning until the end, with Treetagger for POS-tagging, DeepGrailv2's for Supertagging, and Lefff for lemmatisation, the number and percentage of proofs generated (whether these proofs are correct or not) are as follows:

| Dataset       | Total sentences of the dataset | Total sentences given to Graillight | Number of sentences parsed successfully     |  Percentage of the sentences parsed successfully (%)       | Number of sentences failed to be parsed     |  Percentage of failures in parsing (%)    |  Resource limits |
| ------------- | ----------: | -----------: | -------------: | ----------: |  ----------: |  ----------: |   ----------: |
|  SICK-FR | 19680 (9840*2)  | 11059    | 10347 |  93,56 | 712 |   6,44 |0 |
|  FraCaS-FR | 881  | 314    | 301 |  95,86 | 13 |   4,14 |0 |
|  GQNLI-FR | 703 (premises separated to sentences if multiple sentences in it)  | 350    | 328 |  93,71 | 22 |   6,29 |0 |
|  GQNLI-FR | 600 (300*2) (every premise given as a whole single input, whatever the number of sentences in it)  | 247    | 171 |  69,23 | 76 |   30,77 |0 |

With the same pipeline but with DeepGrailv1's POS-tagger and Supertagger, and Lefff lemmatiser, the number and percentage of proofs generated (whether these proofs are correct or not) are as follows:

| Dataset       | Total sentences of the dataset | Total sentences given to Graillight | Number of sentences parsed successfully     |  Percentage of the sentences parsed successfully (%)       | Number of sentences failed to be parsed     |  Percentage of failures in parsing (%)    |  Resource limits |
| ------------- | ----------: | -----------: | -------------: | ----------: |  ----------: |  ----------: |   ----------: |
|  SICK-FR | 19680 (9840*2)  |  11059  | 10047 | 90,85  | 1012 |  9,15  | 0 |
|  FraCaS-FR | 881  |  314   | 268 | 85,35  | 46 |  14,65  | 0|
|  GQNLI-FR |  703 |  350   | 307 | 87,71  | 43 | 12,29   | 0 |

With the same pipeline but with DeepGrailv1's POS-tagger, DeepGrailv2's Supertagger, and Lefff lemmatiser, the number and percentage of proofs generated (whether these proofs are correct or not) are as follows:

| Dataset       | Total sentences of the dataset | Total sentences given to Graillight | Number of sentences parsed successfully     |  Percentage of the sentences parsed successfully (%)       | Number of sentences failed to be parsed     |  Percentage of failures in parsing (%)    |  Resource limits |
| ------------- | ----------: | -----------: | -------------: | ----------: |  ----------: |  ----------: |   ----------: |
|  SICK-FR |   |     |  |   |  |    | |
|  FraCaS-FR |   |     |  |   |  |    | |
|  GQNLI-FR |   |     |  |   |  |    | |

With the same pipeline but with DeepGrailv1's POS-tagger, DeepGrailv2's Supertagger, and spaCy's lemmatiser, the number and percentage of proofs generated (whether these proofs are correct or not) are as follows:

| Dataset       | Total sentences of the dataset | Total sentences given to Graillight | Number of sentences parsed successfully     |  Percentage of the sentences parsed successfully (%)       | Number of sentences failed to be parsed     |  Percentage of failures in parsing (%)    |  Resource limits |
| ------------- | ----------: | -----------: | -------------: | ----------: |  ----------: |  ----------: |   ----------: |
|  SICK-FR | 19680 (9840*2)  |  19680    | 18294 | 92,96  | 1386 |  7,04  | 0 |
|  FraCaS-FR |   |     |  |   |  |    | |
|  GQNLI-FR |   |     |  |   |  |    | |

#### Remarks

- For the tokenisation, which happens multiple times in the process, the key is consistency. Some tokenisers split words like celui-ci/celui-là, au-dessus, eux-mêmes, n', l', d', or English terms used in French like half-pipe (in skateboard); some other don't. Make sure whatever your choice, it's kept the same throughout the process. Here I make sure to verify this with the code itself.
- The big loss of sentences between the initial number of sentences and the number of sentences fed to Graillight occurs, for the moment, simply at step 4, with the second command that adds lemmas in the prolog file. **To be addressed shortly**.

### Predicting the label (two options)

1. LangPro in Prolog

2. Prover9/Mace4 in Python
   
# Citation Information

If you use any part of this repository, kindly ask to cite all the following papers:

**BibTeX:**

````BibTeX
@inproceedings{skandalis-etal-2024-new-datasets,
    title = "New Datasets for Automatic Detection of Textual Entailment and of Contradictions between Sentences in {F}rench",
    author = "Skandalis, Maximos  and
      Moot, Richard  and
      Retor{\'e}, Christian  and
      Robillard, Simon",
    editor = "Calzolari, Nicoletta  and
      Kan, Min-Yen  and
      Hoste, Veronique  and
      Lenci, Alessandro  and
      Sakti, Sakriani  and
      Xue, Nianwen",
    booktitle = "Proceedings of the 2024 Joint International Conference on Computational Linguistics, Language Resources and Evaluation (LREC-COLING 2024)",
    month = may,
    year = "2024",
    address = "Torino, Italy",
    publisher = "ELRA and ICCL",
    url = "https://aclanthology.org/2024.lrec-main.1065",
    pages = "12173--12186",
    abstract = "This paper introduces DACCORD, an original dataset in French for automatic detection of contradictions between sentences. It also presents new, manually translated versions of two datasets, namely the well known dataset RTE3 and the recent dataset GQNLI, from English to French, for the task of natural language inference / recognising textual entailment, which is a sentence-pair classification task. These datasets help increase the admittedly limited number of datasets in French available for these tasks. DACCORD consists of 1034 pairs of sentences and is the first dataset exclusively dedicated to this task and covering among others the topic of the Russian invasion in Ukraine. RTE3-FR contains 800 examples for each of its validation and test subsets, while GQNLI-FR is composed of 300 pairs of sentences and focuses specifically on the use of generalised quantifiers. Our experiments on these datasets show that they are more challenging than the two already existing datasets for the mainstream NLI task in French (XNLI, FraCaS). For languages other than English, most deep learning models for NLI tasks currently have only XNLI available as a training set. Additional datasets, such as ours for French, could permit different training and evaluation strategies, producing more robust results and reducing the inevitable biases present in any single dataset.",
}
````

**ACL:**

Maximos Skandalis, Richard Moot, Christian Retoré, and Simon Robillard. 2024. [New Datasets for Automatic Detection of Textual Entailment and of Contradictions between Sentences in French](https://aclanthology.org/2024.lrec-main.1065). In *Proceedings of the 2024 Joint International Conference on Computational Linguistics, Language Resources and Evaluation (LREC-COLING 2024)*, pages 12173–12186, Torino, Italy. ELRA and ICCL.

And

More to come.

# Acknowledgements

This work was supported by the Defence Innovation Agency (AID) of the Directorate General of Armament (DGA) of the French Ministry of Armed Forces, and by the ICO, _Institut Cybersécurité Occitanie_, funded by Région Occitanie, France. 

Part of the research was carried out during a research stay in Utrecht University with the support of the Erasmus+ programme.

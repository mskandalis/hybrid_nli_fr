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
- TreeTagger (either the [original repository](https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger) alone, or the original repository + a [Python interface](https://github.com/miotto/treetagger-python) or a [TreeTagger Python Wrapper](https://treetaggerwrapper.readthedocs.io/en/latest)), or RNNTagger.

## Instructions
### Preparing the data and obtaining the lambda-terms (half deep learning, half prolog programme)
The steps you need to follow in order to obtain the input for [LangPro theorem Prover](https://github.com/kovvalsky/LangPro/tree/nl) are the following:
1. In order to extract the sentences from huggingface in a txt file (format: premise\n hypthesis\n premise\n hypothesis, etc.):
```
python Scripts/extraire_phrases.py
```
2. POS-tagging and lemmatisation with [TreeTagger](https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger) or [RNNTagger](https://www.cis.uni-muenchen.de/~schmid/tools/RNNTagger):
```
tclsh tokenize.tcl raw.txt > input.txt
python scripts/POStag-Lemma.ipynb
bin\tag-french C:\Users\maxim\AppData\Roaming\MobaXterm\home\doctorat\GrailLight\input.txt tt_tags.tsv
```
3. Obtain the TLG (Type-Logical Grammar) label of every token in the sentences with DeepGrail, and then put this all together for the input to Graillight:
```
python deepgrail_tagger/predict.py
python scripts/get_right_format_for_graillight.py
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

With this pipeline from the beginning until the end, the number and percentage of proofs generated (whether these proofs are correct or not) are as follows:

| Dataset       | Total sentences of the dataset | Total sentences given to Graillight | Number of sentences parsed successfully     |  Percentage of the sentences parsed successfully (%)       | Number of sentences failed to be parsed     |  Percentage of failures in parsing (%)    |  Resource limits |
| :------------- | :----------: | -----------: | :------------- | :----------: |  :----------: |  :----------: |   :----------: |
|  SICK-FR | 19680  | 11059    | 10347 |  93,56 | 712 |   6,44 |0 |


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

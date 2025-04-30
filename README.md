# Hybrid AI for NLI in French

This repository contains: 
- [datasets](https://huggingface.co/maximoss) for the task of [Natural Language Inference (NLI / RTE)](https://en.wikipedia.org/wiki/Textual_entailment) in French,
  - with sentence pairs,
  - a label ("yes" for entailment, "unknown" for neutral, or "no" for contradiction) for each sentence pair, and
  - their logical reprsentation (both lambda-terms and FOL expressions, in different files and for use by different models and theorem provers afterwards).
- the whole pipeline :
  - for obtaining this logical representation from the raw sentences, and
  - for predicting the label attributed to every sentence pair.

## Requirements

You need to have the following installed in your machine:
- [Prolog](https://www.swi-prolog.org/download/stable);
- For Part-of-Speech Tagging:
  - the [ELMO POS-tagger](https://github.com/HIT-SCIR/ELMoForManyLangs) that you can use with [1st DeepGrail LSTM version](https://github.com/RichardMoot/DeepGrail2021) (advised), or
  - TreeTagger:
    - either the [original repository](https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger) alone, or
    - the original repository + a [Python interface](https://github.com/miotto/treetagger-python) or a [TreeTagger Python Wrapper](https://treetaggerwrapper.readthedocs.io/en/latest). Here I use the [last option mentioned](https://treetaggerwrapper.readthedocs.io/en/latest). For this, after downloading TreeTagger, you will need to add the path to its bin to the PATH environment variable. This is done with
```set PATH=<your-path-to-TreeTagger's-folder>/bin;%PATH%``` in Windows, or
```export PATH=<your-path-to-TreeTagger's-folder>/bin;%PATH%``` in Linux.
For the Python Wrapper,
```pip install treetaggerwrapper```, then ```set```, for Windows, or ```export```, for Linux, ```TAGDIR=<your-path-to-TreeTagger's-folder>/TreeTagger```.
  - [RNNTagger](https://www.cis.uni-muenchen.de/~schmid/tools/RNNTagger). 
- For lemmatisation:
  - [spaCy](https://spacy.io/models/fr#fr_dep_news_trf), or 
  - [spacy-lefff](https://spacy.io/universe/project/spacy-lefff), or
  - [Stanza](https://stanfordnlp.github.io/stanza) (advised), or
  - [TreeTagger](https://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger) (not advised nowadays), or [RNNTagger](https://www.cis.uni-muenchen.de/~schmid/tools/RNNTagger) (see above for these two).

## Instructions
### Preparing the data and obtaining the lambda-terms (half deep learning, half prolog programme)
The steps you need to follow in order to obtain the input for [LangPro theorem Prover](https://github.com/kovvalsky/LangPro/tree/nl) are the following:
1. In order to extract the sentences from huggingface in a txt file (format: premise\n hypthesis\n premise\n hypothesis, etc.):
```
python scripts/extract_sentences_to_raw.py
```
2. POS-tagging and lemmatisation:
```
tclsh tokenize.tcl raw.txt > input.txt
python scripts/lemmatise_with_spacy_stanza_lefff.py #if you want to use lemmas from spaCy or Stanza (advised), and not from TreeTagger or RNNTagger, later.
# TreeTagger\bin\tag-french <your-path-to>\input.txt tt_tags.tsv
python DeepGrail2021/super.py
```
3. Obtain the TLG (Type-Logical Grammar) label of every token in the sentences with DeepGrail, and then put this all together for the input to Graillight:
```
python deepgrail_tagger/predict.py
python scripts/assemble_graillight_input.py
python replace_with_new_deepgrail_tags.py
```
4. Obtain [lambda-terms](https://en.wikipedia.org/wiki/Lambda_calculus), proofs and [DRS](https://en.wikipedia.org/wiki/Discourse_representation_theory) with [Graillight](https://github.com/RichardMoot/GrailLight):
```
tclsh supertag2pl superpos.txt > superpos_nolem.pl
python add_lemmas_to_prolog_file.py
swipl -q -t main -f grail_light_nd.pl superpos.pl
```
5. Convert the output of Graillight to a compatible form for LangPro theorem prover:
```
python scripts/convert_grail_output_to_langpro_input.py
```

#### Remarks

- The advised pipeline is: ELMo POS-tagger used with DeepGrailv1, Stanza for lemmatisation, DeepGrailv2 for CG Supertagging, Graillight for proof finding / lambda-term generation.
- For the tokenisation, which happens multiple times in the process, the key is consistency. Some tokenisers split words like celui-ci/celui-là, au-dessus, eux-mêmes, n', l', d', or English terms used in French like half-pipe (in skateboard); some other don't. Make sure whatever your choice, it's kept the same throughout the process. Here I make sure to verify this with the code itself.

### Predicting the label (two options)

1. LangPro in Prolog

2. Prover9/Mace4 in Python
   
# Citation Information

If you use any part of this repository, kindly ask to cite all the following papers:

**BibTeX:**

For the datasets:
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

And, for the method:
````BibTeX
@misc{skandalis:hal-05002405,
  TITLE = {{Hybrid AI with LLMs and Theorem Provers for Semantic Parsing and Natural Language Inference for French}},
  AUTHOR = {Skandalis, Maximos and Abzianidze, Lasha and Moot, Richard and Robillard, Simon},
  URL = {https://hal.science/hal-05002405},
  NOTE = {Poster},
  HOWPUBLISHED = {{FoMo 2025 - ELLIS Winter School on Foundation Models}},
  ORGANIZATION = {{ELLIS Unit Amsterdam and University of Amsterdam}},
  YEAR = {2025},
  MONTH = Mar,
  PDF = {https://hal.science/hal-05002405v1/file/Natural_language_inference_neurosymbolic_ai.pdf},
  HAL_ID = {hal-05002405},
  HAL_VERSION = {v1},
}
````

**ACL:**

For the datasets:

Maximos Skandalis, Richard Moot, Christian Retoré, and Simon Robillard. 2024. [New Datasets for Automatic Detection of Textual Entailment and of Contradictions between Sentences in French](https://aclanthology.org/2024.lrec-main.1065). In *Proceedings of the 2024 Joint International Conference on Computational Linguistics, Language Resources and Evaluation (LREC-COLING 2024)*, pages 12173–12186, Torino, Italy. ELRA and ICCL.

And, for the method:

Maximos Skandalis, Lasha Abzianidze, Richard Moot, Simon Robillard. Hybrid AI with LLMs and Theorem Provers for Semantic Parsing and Natural Language Inference for French. *FoMo 2025 - ELLIS Winter School on Foundation Models*, Mar 2025, Amsterdam, Netherlands. , 2025. [⟨hal-05002405⟩](https://hal.science/hal-05002405v1)


# Acknowledgements

This work was supported by the Defence Innovation Agency (AID) of the Directorate General of Armament (DGA) of the French Ministry of Armed Forces, and by the ICO, _Institut Cybersécurité Occitanie_, funded by Région Occitanie, France. 

Part of the research was carried out during a research stay in Utrecht University with the support of the Erasmus+ programme.

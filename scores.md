#### Score
With this pipeline from the beginning until the end, with Treetagger for POS-tagging, DeepGrailv2's for Supertagging, and Graillight's integrated version of Lefff for lemmatisation, the number and percentage of proofs generated (whether these proofs are correct or not) are as follows:

| Dataset       | Total sentences of the dataset | Total sentences given to Graillight | Number of sentences parsed successfully     |  Percentage of the sentences parsed successfully (%)       | Number of sentences failed to be parsed     |  Percentage of failures in parsing (%)    |  Resource limits |
| ------------- | ----------: | -----------: | -------------: | ----------: |  ----------: |  ----------: |   ----------: |
|  SICK-FR | 19680 (9840*2)  | 11059    | 10347 |  93,56 | 712 |   6,44 |0 |
|  FraCaS-FR | 881  | 314    | 301 |  95,86 | 13 |   4,14 |0 |
|  GQNLI-FR | 703 (premises separated to sentences if multiple sentences in it)  | 350    | 328 |  93,71 | 22 |   6,29 |0 |
|  GQNLI-FR | 600 (300*2) (every premise given as a whole single input, whatever the number of sentences in it)  | 247    | 171 |  69,23 | 76 |   30,77 |0 |

With the same pipeline but with DeepGrailv1's POS-tagger and Supertagger, and Graillight's integrated version of Lefff lemmatiser, the number and percentage of proofs generated (whether these proofs are correct or not) are as follows:

| Dataset       | Total sentences of the dataset | Total sentences given to Graillight | Number of sentences parsed successfully     |  Percentage of the sentences parsed successfully (%)       | Number of sentences failed to be parsed     |  Percentage of failures in parsing (%)    |  Resource limits |
| ------------- | ----------: | -----------: | -------------: | ----------: |  ----------: |  ----------: |   ----------: |
|  SICK-FR | 19680 (9840*2)  |  11059  | 10047 | 90,85  | 1012 |  9,15  | 0 |
|  FraCaS-FR | 881  |  314   | 268 | 85,35  | 46 |  14,65  | 0|
|  GQNLI-FR |  703 |  350   | 307 | 87,71  | 43 | 12,29   | 0 |

With the same pipeline but with DeepGrailv1's POS-tagger, DeepGrailv2's Supertagger, and spaCy's lemmatiser, the number and percentage of proofs generated (whether these proofs are correct or not) are as follows:

| Dataset       | Total sentences of the dataset | Total sentences given to Graillight | Number of sentences parsed successfully     |  Percentage of the sentences parsed successfully (%)       | Number of sentences failed to be parsed     |  Percentage of failures in parsing (%)    |  Resource limits |
| ------------- | ----------: | -----------: | -------------: | ----------: |  ----------: |  ----------: |   ----------: |
|  SICK-FR | 19680 (9840*2)  |  19680    | 18294 | 92,96  | 1386 |  7,04  | 0 |
|  FraCaS-FR | 881  |   881  | 836 |  94,82 | 45 |  5,11  | 0|
|  GQNLI-FR | 703  |   703  | 628 |  89,33 | 75 |  10,67  | 0|
|  RTE3-TEST | 1828  |   1828  | 1496 |  81,84 | 332 |  18,16  | 0|
|  RTE3-DEV | 1959  |   1959  | 1594 | 81,37  | 365 |  18,63  | 0|
|  XNLI-TEST |  10409 |  10409   | 8132 | 78,12  | 2277 | 21,88   | 0|
|  XNLI-DEV |  5151 |  5151   | 3956 |  76,8 | 1195 |  23,2  | 0|
|  DACCORD | 2341  |   2341  | 1773 | 75,74  | 568 | 24,26   | 0|

With the same pipeline but with DeepGrailv1's POS-tagger, DeepGrailv2's Supertagger (beta value set to 0.1), and spaCy's lemmatiser, the number and percentage of proofs generated (whether these proofs are correct or not) are as follows:

| Dataset       | Total sentences of the dataset | Total sentences given to Graillight | Number of sentences parsed successfully     |  Percentage of the sentences parsed successfully (%)       | Number of sentences failed to be parsed     |  Percentage of failures in parsing (%)    |  Resource limits | Average number of formulas per token|
| ------------- | ----------: | -----------: | -------------: | ----------: |  ----------: |  ----------: |   ----------: | ----------:|
|  SICK-FR | 19680 (9840*2)  |  19680    |  |   |  |    | 0 | 1,0256|
|  FraCaS-FR | 881  |   881  |  |   |  |    | 0| 1,0266 |
|  GQNLI-FR | 703  |   703  |  |   |  |    | 0| 1,0318|
|  RTE3-TEST | 1828  |   1828  |  |   |  |    | 0| 1,0528|
|  RTE3-DEV | 1959  |   1959  |  |  |  |    | 0| 1,0601|
|  XNLI-TEST |  10409 |  10409   |  |   |  |    | 0| 1,06 |
|  XNLI-DEV |  5151 |  5151   |  |   |  |    | 0| 1,0624|
|  DACCORD | 2341  |   2341  |  |   |  |    | 0| 1,0687|

With the same pipeline but with DeepGrailv1's POS-tagger, DeepGrailv2's Supertagger (beta value set to 0.01), and spaCy's lemmatiser, the number and percentage of proofs generated (whether these proofs are correct or not) are as follows:

| Dataset       | Total sentences of the dataset | Total sentences given to Graillight | Number of sentences parsed successfully     |  Percentage of the sentences parsed successfully (%)       | Number of sentences failed to be parsed     |  Percentage of failures in parsing (%)    |  Resource limits | Average number of formulas per token|
| ------------- | ----------: | -----------: | -------------: | ----------: |  ----------: |  ----------: |   ----------: | ----------:|
|  SICK-FR | 19680 (9840*2)  |  19680    |  |   |  |    | 0 | 1,0618|
|  FraCaS-FR | 881  |   881  |  |   |  |    | 0| 1,0818 |
|  GQNLI-FR | 703  |   703  |  |   |  |    | 0| 1,0562 |
|  RTE3-TEST | 1828  |   1828  |  |   |  |    | 0| 1,15|
|  RTE3-DEV | 1959  |   1959  |  |  |  |    | 0| 1,176|
|  XNLI-TEST |  10409 |  10409   |  |   |  |    | 0| 1,1807 |
|  XNLI-DEV |  5151 |  5151   |  |   |  |    | 0| 1,1913|
|  DACCORD | 2341  |   2341  |  |   |  |    | 0| 1,198|

With the same pipeline but with DeepGrailv1's POS-tagger, DeepGrailv2's Supertagger (beta value set to 0.001), and spaCy's lemmatiser, the number and percentage of proofs generated (whether these proofs are correct or not) are as follows:

| Dataset       | Total sentences of the dataset | Total sentences given to Graillight | Number of sentences parsed successfully     |  Percentage of the sentences parsed successfully (%)       | Number of sentences failed to be parsed     |  Percentage of failures in parsing (%)    |  Resource limits | Average number of formulas per token|
| ------------- | ----------: | -----------: | -------------: | ----------: |  ----------: |  ----------: |   ----------: | ----------:|
|  SICK-FR | 19680 (9840*2)  |  19680    |  |   |  |    | 0 | 1,1431 |
|  FraCaS-FR | 881  |   881  |  |   |  |    | 0| 1,2453 |
|  GQNLI-FR | 703  |   703  |  |   |  |    | 0| 1,0955 |
|  RTE3-TEST | 1828  |   1828  |  |   |  |    | 0| 1,3974|
|  RTE3-DEV | 1959  |   1959  |  |  |  |    | 0| 1,4849|
|  XNLI-TEST |  10409 |  10409   |  |   |  |    | 0| 1,5795 |
|  XNLI-DEV |  5151 |  5151   |  |   |  |    | 0| 1,5767|
|  DACCORD | 2341  |   2341  |  |   |  |    | 0| 1,5480|

With the same pipeline but with DeepGrailv1's POS-tagger, DeepGrailv2's Supertagger (beta value set to 0.0001), and spaCy's lemmatiser, the number and percentage of proofs generated (whether these proofs are correct or not) are as follows:

| Dataset       | Total sentences of the dataset | Total sentences given to Graillight | Number of sentences parsed successfully     |  Percentage of the sentences parsed successfully (%)       | Number of sentences failed to be parsed     |  Percentage of failures in parsing (%)    |  Resource limits | Average number of formulas per token|
| ------------- | ----------: | -----------: | -------------: | ----------: |  ----------: |  ----------: |   ----------: | ----------:|
|  SICK-FR | 19680 (9840*2)  |  19680    |  |   |  |    | 0 |  1,4157|
|  FraCaS-FR | 881  |   881  |  |   |  |    | 0| 1,8625 |
|  GQNLI-FR | 703  |   703  | 698 | 99,29  | 5 |  0,71  | 0| 1,2444 |
|  RTE3-TEST | 1828  |   1828  |  |   |  |    | 0| 2,2468 |
|  RTE3-DEV | 1959  |   1959  |  |  |  |    | 0| 2,5643 |
|  XNLI-TEST |  10409 |  10409   |  |   |  |    | 0|  3,0798|
|  XNLI-DEV |  5151 |  5151   |  |   |  |    | 0| 3,0073|
|  DACCORD | 2341  |   2341  |  |   |  |    | 0| 2,6925|

With the same pipeline but with DeepGrailv1's POS-tagger and Supertagger (beta value set to 0.3), and spaCy's lemmatiser, the number and percentage of proofs generated (whether these proofs are correct or not) are as follows:

| Dataset       | Total sentences of the dataset | Total sentences given to Graillight | Number of sentences parsed successfully     |  Percentage of the sentences parsed successfully (%)       | Number of sentences failed to be parsed     |  Percentage of failures in parsing (%)    |  Resource limits |
| ------------- | ----------: | -----------: | -------------: | ----------: |  ----------: |  ----------: |   ----------: |
|  SICK-FR |  19680 |   19680   | 17573 | 89,29  | 2107 |  10,71  | 0 |
|  FraCaS-FR |  881 |  881   | 787 |  89,33 | 94 |  10,67  | 0 |
|  GQNLI-FR | 703  |   703  | 611 |  86,91 | 92 |  13,09  | 0 |
|  RTE3-TEST | 1828  |   1828  | 1504 | 82,28  | 324 |  17,72  | 0|
|  RTE3-DEV | 1959  |   1959  | 1568 | 80,04  | 391 |  19,96  | 0|
|  XNLI-TEST |  10409 |  10409   | 7472 | 71,78  | 2937 |  28,22  | 0|
|  XNLI-DEV |  5151 |  5151   | 3677 | 71,38  | 1474 |  28,62  | 0|
|  DACCORD | 2341  |   2341  | 1755 |  74,97 | 582 |  24,86  | 4 (0,17%)|

With the same pipeline but with DeepGrailv1's POS-tagger and Supertagger (beta value set to 0.1), and spaCy's lemmatiser, the number and percentage of proofs generated (whether these proofs are correct or not) are as follows:

| Dataset       | Total sentences of the dataset | Total sentences given to Graillight | Number of sentences parsed successfully     |  Percentage of the sentences parsed successfully (%)       | Number of sentences failed to be parsed     |  Percentage of failures in parsing (%)    |  Resource limits |
| ------------- | ----------: | -----------: | -------------: | ----------: |  ----------: |  ----------: |   ----------: |
|  SICK-FR | 19680 (9840*2)  |  19680    | 18602 | 94,52  | 1078 |  5,48  | 0 |
|  FraCaS-FR | 881  |   881  | 822 |  93,30 | 59| 6,70   | 0|
|  GQNLI-FR | 703  |   703  | 622 | 88,48 | 81 | 11,52   | 0|
|  RTE3-TEST | 1828  |   1828  | 1601 | 87,58  | 227 | 12,42   | 0|
|  RTE3-DEV | 1959  |   1959  | 1670 |  85,25 | 289 |  14,75  | 0|
|  XNLI-TEST |  10409 |  10409   | 8090 |  77,72 | 2316 | 22,25   | 3 (0,03%)|
|  XNLI-DEV |  5151 |  5151   | 4011 |  77,87 | 1140 |  22,13  | 0|
|  DACCORD | 2341  |   2341  | 1893 |  80,86 | 444 |  18,97  | 4 (0,17%)|

With the same pipeline but with DeepGrailv1's POS-tagger and Supertagger (beta value set to 0.01), and spaCy's lemmatiser, the number and percentage of proofs generated (whether these proofs are correct or not) are as follows:

| Dataset       | Total sentences of the dataset | Total sentences given to Graillight | Number of sentences parsed successfully     |  Percentage of the sentences parsed successfully (%)       | Number of sentences failed to be parsed     |  Percentage of failures in parsing (%)    |  Resource limits |
| ------------- | ----------: | -----------: | -------------: | ----------: |  ----------: |  ----------: |   ----------: |
|  SICK-FR | 19680 (9840*2)  |  19680    | 19409 | 98,62  | 271 |  1,37  | 0 |
|  FraCaS-FR | 881  |   881  | 847 | 96,14  | 34| 3,86   | 0|
|  GQNLI-FR | 703  |   703  | 635 | 90,33 | 68 |  9,67  | 0|
|  RTE3-TEST | 1828  |   1828  | 1723 |  94,26 | 105 |  5,74  | 0|
|  RTE3-DEV | 1959  |   1959  | 1799 | 91,83  | 158 |  8,07  | 2 (0,1%) |
|  XNLI-TEST |  10409 |  10409   | 9207 |  88,45 | 1196 | 11,49   | 6 (0,06%)|
|  XNLI-DEV |  5151 |  5151   | 4550 | 88,33  | 601 |  11,67  | 0|
|  DACCORD | 2341  |   2341  | 2094 |  89,45 | 240 | 10,25   | 7 (0,30%)|

With the same pipeline but with DeepGrailv1's POS-tagger and Supertagger (beta value set to 0.001), and spaCy's lemmatiser, the number and percentage of proofs generated (whether these proofs are correct or not) are as follows:

| Dataset       | Total sentences of the dataset | Total sentences given to Graillight | Number of sentences parsed successfully     |  Percentage of the sentences parsed successfully (%)       | Number of sentences failed to be parsed     |  Percentage of failures in parsing (%)    |  Resource limits |
| ------------- | ----------: | -----------: | -------------: | ----------: |  ----------: |  ----------: |   ----------: |
|  SICK-FR | 19680 (9840*2)  |  19680    | 19604 | 99,61  | 73 |  0,39  | 0 |
|  FraCaS-FR | 881  |   881  | 871 | 98,86  | 10 |  1,14  | 0|
|  GQNLI-FR | 703  |   703  | 650 | 92,46 | 53 |  7,54  | 0|
|  RTE3-TEST | 1828  |   1828  | 1765 | 96,55  | 49 | 2,68   | 14 (0,77%)|
|  RTE3-DEV | 1959  |   1959  | 1869 | 95,41  | 68 |  3,47  | 22 (1,12%)|
|  XNLI-TEST |  10409 |  10409   |  |   |  |    | |
|  XNLI-DEV |  5151 |  5151   | 4835  | 93,87  |284  |   5,51 | 32 (0,62%)| 
|  DACCORD | 2341  |   2341  | 2213 | 94,53  | 106 |  4,53  | 22 (0,94%)|



#### Remarks

- In the first tables, the big loss of sentences between the initial number of sentences and the number of sentences fed to Graillight occurs, for the moment, simply at step 4, with the second command that adds lemmas with Lefff in the prolog file. We replaced Lefff's lemmatisation with spaCy and the problem no longer reproduced.
- Fro XNLI_dev wtih beta value set to 0,001 with DeepGrailv1, Graillight needed to run from 08:55 until 18:31 29/03/2025.

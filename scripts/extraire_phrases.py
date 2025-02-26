from datasets import load_dataset
import pandas as pd

sick_train = load_dataset("maximoss/sick-fr-mt", split="train").to_pandas()
sick_test = load_dataset("maximoss/sick-fr-mt", split="test").to_pandas()
sick_dev = load_dataset("maximoss/sick-fr-mt", split="validation").to_pandas()

sick_train['Subset'] = 'TRAIN'
sick_test['Subset'] = 'TEST'
sick_dev['Subset'] = 'TRIAL'

sick = pd.concat([sick_train, sick_test, sick_dev], ignore_index=True)

sick_sorted = sick.sort_values(by='pair_ID', ascending=True).reset_index(drop=True)

with open('raw.txt', "w", encoding="utf-8") as f:
    for index, value in enumerate(sick_sorted['pair_ID']):
        premise = sick_sorted['sentence_A'][index]
        hypothesis = sick_sorted['sentence_B'][index]

        print(premise, file=f)
        print(hypothesis, file=f)
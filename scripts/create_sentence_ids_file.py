import pandas as pd

sick_train = load_dataset("maximoss/sick-fr-mt", split="train").to_pandas()
sick_test = load_dataset("maximoss/sick-fr-mt", split="test").to_pandas()
sick_dev = load_dataset("maximoss/sick-fr-mt", split="validation").to_pandas()

sick_train['Subset'] = 'TRAIN'
sick_test['Subset'] = 'TEST'
sick_dev['Subset'] = 'TRIAL'

sick = pd.concat([sick_train, sick_test, sick_dev], ignore_index=True)

sick_sorted = sick.sort_values(by='pair_ID', ascending=True).reset_index(drop=True)

with open('sick_fr_id.pl', 'w', encoding='utf-8') as prol:
	numero=0
	for index, value in enumerate(sick_sorted['pair_ID']):
		numero+=2
		if sick_sorted['entailment_label'][index]=='NEUTRAL':
			answer = "unknown"
		elif sick_sorted['entailment_label'][index]=='ENTAILMENT':
			answer = "yes"
		elif sick_sorted['entailment_label'][index]=='CONTRADICTION':
			answer = "no"
		sick_sentence_A = sick_sorted['sentence_A'][index].replace("'", "\\'")
		sick_sentence_B = sick_sorted['sentence_B'][index]
		if "'" in sick_sorted['sentence_A'][index]:
			sick_sentence_A = sick_sorted['sentence_A'][index].replace("'", "\\'")
		if "'" in sick_sorted['sentence_B'][index]:
			sick_sentence_B = sick_sorted['sentence_B'][index].replace("'", "\\'")
		prol.write(f"%problem id = {sick_sorted['pair_ID'][index]}\nsen_id({numero-1}, {sick_sorted['pair_ID'][index]}, 'p', '{sick_sorted['Subset'][index]}', '{answer}', '{sick_sentence_A}').\nsen_id({numero}, {sick_sorted['pair_ID'][index]}, 'h', '{sick_sorted['Subset'][index]}', '{answer}', '{sick_sentence_B}').\n")  # Each entry as a Prolog fact


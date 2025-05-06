from SuperTagger.SuperTagger import SuperTagger
from SuperTagger.Utils.helpers import read_csv_pgbar, load_obj

#### DATA ####
file_path = 'Datasets/m2_dataset.csv'

df = read_csv_pgbar(file_path,100)

texts = df['X'].tolist()
tags = df['Z'].tolist()

test_s = texts[:4]
tags_s = tags[:4]

texts = texts[4:]
tags = tags[4:]

index_to_super = load_obj('Datasets/index_to_super')

#### MODEL ####
tagger = SuperTagger()

tagger.create_new_model(len(index_to_super),'flaubert/flaubert_base_cased',index_to_super)
# tagger.load_weights("models/model_check.pt")

tagger.train(texts,tags,batch_size=16,validation_rate=0.1,tensorboard=True,checkpoint=True)


#### TEST ####
pred = tagger.predict(test_s)

print(test_s)
print()
print(pred)



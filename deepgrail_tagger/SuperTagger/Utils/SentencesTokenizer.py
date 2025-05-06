
class SentencesTokenizer():

    def __init__(self, tokenizer):
        """@params tokenizer (PretrainedTokenizer): Tokenizer that tokenizes text """
        self.tokenizer = tokenizer

    def fit_transform(self, sents):
        return self.tokenizer(sents, padding=True)

    def fit_transform_tensors(self, sents):
        temp = self.tokenizer(sents, padding=True, return_tensors = 'pt')

        return temp["input_ids"], temp["attention_mask"]

    def convert_ids_to_tokens(self, inputs_ids, skip_special_tokens=False):
        return self.tokenizer.batch_decode(inputs_ids, skip_special_tokens=skip_special_tokens)

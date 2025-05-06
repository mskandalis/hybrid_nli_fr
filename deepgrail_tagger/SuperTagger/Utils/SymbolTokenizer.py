import pickle

import numpy as np
import torch


def load_obj(name):
    with open(name + '.pkl', 'rb') as f:
        return pickle.load(f)


class SymbolTokenizer():

    def __init__(self, index_to_super):
        """@params index_to_super: Dict for convert ID to tags """
        self.index_to_super = index_to_super
        self.super_to_index = {v: int(k) for k, v in self.index_to_super.items()}

    def lenSuper(self):
        """@return len of dict for convert ID to tags """
        return len(self.index_to_super) + 1

    def convert_batchs_to_ids(self, tags, sents_tokenized):
        encoded_labels = []
        labels = [[self.super_to_index[str(symbol)] for symbol in sents] for sents in tags]
        for l, s in zip(labels, sents_tokenized):
            super_tok = pad_sequence(l, len(s))
            encoded_labels.append(super_tok)

        return torch.tensor(encoded_labels)

    def convert_ids_to_tags(self, sents):
        def convert(symbol):
            if isinstance(symbol, torch.Tensor):
                if symbol.numel() == 1:
                    symbol = symbol.item()
                else:
                    raise ValueError("The symbol tensor has more than one element. Can't convert to scalar.")
            tag = self.index_to_super.get(int(symbol), '<unk>')
            return tag if tag != '<unk>' else None

        # If sents is a single element (not a list), convert it to a list
        if isinstance(sents, (int, torch.Tensor)):
            sents = [sents]

        # Convert each symbol in sents to its corresponding tag
        return [tag for tag in (convert(symbol) for symbol in sents) if tag]

    def convert_id_to_tag(self, tags_ids):
        labels = [[self.index_to_super[int(symbol)] for symbol in sents if self.index_to_super[int(symbol)] != '<unk>']
                  for sents in tags_ids]

        return labels


def pad_sequence(sequences, max_len=400):
    padded = [0] * max_len
    padded[:len(sequences)] = sequences
    return padded

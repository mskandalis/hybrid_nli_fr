import torch
import transformers
from torch.nn import Module

from transformers import logging


class Tagging_bert_model(Module):
    """

    """

    def __init__(self, bert_name, num_labels):
        super(Tagging_bert_model, self).__init__()
        self.bert_name = bert_name
        self.num_labels = num_labels
        config = transformers.AutoConfig.from_pretrained(bert_name, output_hidden_states=True, num_labels=num_labels)
        self.bert = transformers.AutoModelForTokenClassification.from_pretrained(bert_name, config=config)

    def forward(self, batch):
        b_input_ids = batch[0]
        b_input_mask = batch[1]
        labels = batch[2]

        output = self.bert(
            input_ids=b_input_ids, attention_mask=b_input_mask, labels=labels)

        result = {'loss': output[0],'logit': output[1], 'word_embeding': output[2][0], 'last_hidden_state': output[2][1]}

        return result

    def predict(self, batch):
        b_input_ids = batch[0]
        b_input_mask = batch[1]

        output = self.bert(
            input_ids=b_input_ids, attention_mask=b_input_mask)

        result = {'logit' : output[0], 'word_embeding': output[1][0], 'last_hidden_state':output[1][1]}

        return result

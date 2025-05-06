import datetime
import os
import sys
import time

import torch
import transformers
from torch import Tensor
from torch.optim import Adam
from torch.utils.data import Dataset, TensorDataset, random_split, DataLoader
from torch.utils.tensorboard import SummaryWriter
from tqdm import tqdm
from transformers import AutoTokenizer
from transformers import logging

import torch.nn.functional as F

from .Utils.SentencesTokenizer import SentencesTokenizer
from .Utils.SymbolTokenizer import SymbolTokenizer
from .Utils.Tagging_bert_model import Tagging_bert_model

logging.set_verbosity(logging.ERROR)


# region Utils

def output_create_dir():
    """
    Create le output dir for tensorboard and checkpoint
    @return: output dir, tensorboard writter
    """
    from datetime import datetime
    outpout_path = 'TensorBoard'
    training_dir = os.path.join(outpout_path, 'Training_' + datetime.today().strftime('%d-%m_%H-%M'))
    logs_dir = os.path.join(training_dir, 'logs')
    writer = SummaryWriter(log_dir=logs_dir)
    return training_dir, writer


def categorical_accuracy(preds, truth):
    """
    Calculates how often predictions match argmax labels.
    @param preds: batch of prediction. (argmax)
    @param truth: batch of truth label.
    @return: scoring of batch prediction. (Categorical accuracy values)
    """
    good_label = 0
    nb_label = 0
    for i in range(len(truth)):
        sublist_truth = truth[i]
        sublist_preds = preds[i]
        for j in range(len(sublist_truth)):
            if sublist_truth[j] != 0:
                if sublist_truth[j] == sublist_preds[j]:
                    good_label += 1
                nb_label += 1
    return good_label / nb_label


def format_time(elapsed):
    '''
    Takes a time in seconds and returns a string hh:mm:ss
    '''
    # Round to the nearest second.
    elapsed_rounded = int(round(elapsed))

    # Format as hh:mm:ss
    return str(datetime.timedelta(seconds=elapsed_rounded))


# endregion Utils

# region Class

class SuperTagger:

    # region Constructor

    def __init__(self):
        """
        Python implementation of BertForTokenClassification using TLGbank data to develop supertaggers.
        """
        self.index_to_tags = None
        self.num_label = None
        self.bert_name = None
        self.sent_tokenizer = None
        self.tags_tokenizer = None
        self.model = None

        self.optimizer = None

        self.epoch_i = 0
        self.device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

        self.trainable = False
        self.model_load = False

    # endregion Constructor

    # region Instanciation

    def load_weights(self, model_file):
        """
        Loads an SupperTagger saved with SupperTagger.__checkpoint_save() (during a train) from a file.

        @param model_file: path of .pt save of model
        """
        self.trainable = False

        print("#" * 20)
        print("\n Loading...")
        try:
            params = torch.load(model_file, map_location=self.device)
            args = params['args']
            self.bert_name = args['bert_name']
            self.index_to_tags = args['index_to_tags']
            self.num_label = len(self.index_to_tags)
            self.model = Tagging_bert_model(self.bert_name, self.num_label)
            self.tags_tokenizer = SymbolTokenizer(self.index_to_tags)
            self.sent_tokenizer = SentencesTokenizer(transformers.AutoTokenizer.from_pretrained(
                self.bert_name,
                do_lower_case=True))
            self.model.load_state_dict(params['state_dict'])
            self.optimizer = params['optimizer']
            # self.epoch_i = args['epoch']
            print("\n The loading checkpoint was successful ! \n")
            print("\tBert model : ", self.bert_name)
            print("\tLast epoch : ", self.epoch_i)
            print()
        except Exception as e:
            print("\n/!\ Can't load checkpoint model /!\ because :\n\n " + str(e), file=sys.stderr)
            raise e
        print("#" * 20)

        self.model_load = True
        self.trainable = True

    def create_new_model(self, num_label, bert_name, index_to_tags):
        """
        Instantiation and parameterization of a new bert model

        @param num_label: number of diferent labels (tags)
        @param bert_name: name of model available on Hugging Face `<https://huggingface.co/models>`
        @param index_to_tags: Dict for convert ID to tags
        """
        assert len(
            index_to_tags) == num_label, f" len(index_to_tags) : {len(index_to_tags)} must be equels with num_label: {num_label}"

        self.model = Tagging_bert_model(bert_name, num_label + 1)
        index_to_tags = {k + 1: v for k, v in index_to_tags.items()}
        # <unk> is used for the pad AND unknown tags
        index_to_tags[0] = '<unk>'

        self.index_to_tags = index_to_tags
        self.bert_name = bert_name
        self.sent_tokenizer = SentencesTokenizer(AutoTokenizer.from_pretrained(
            bert_name,
            do_lower_case=True))
        self.optimizer = Adam(params=self.model.parameters(), lr=2e-4, eps=1e-8)
        self.tags_tokenizer = SymbolTokenizer(index_to_tags)
        self.trainable = True
        self.model_load = True

    # endregion Instanciation

    # region Usage

    def predict(self, sentences, beta):
        """
        Predict and convert sentences in tags (depends on the dictation given when the model was created)

        @param sentences: list of sentences : list[str] OR one sentence : str
        @return: tags prediction for all sentences (no argmax tags, convert tags, embedding layer of BERT )
        """
        assert self.trainable or self.model is None, "Please use the create_new_model(...) or load_weights(...) " \
                                                     "function before the predict, the model is not integrated "
        assert type(sentences) == str or type(sentences) == list, "param sentences: list of sentences : list[" \
                                                                  "str] OR one sentence : str "
        sentences = [sentences] if type(sentences) == str else sentences

        self.model.eval()

        with torch.no_grad():
            sents_tokenized_t, sents_mask_t = self.sent_tokenizer.fit_transform_tensors(sentences)

            self.model = self.model.cpu()
            self.last_beta = beta

            output = self.model.predict((sents_tokenized_t, sents_mask_t))

            if beta < 1.0 :
                logits = output['logit']
                probabilities = F.softmax(logits, dim=2)  # Apply softmax

                batch_results = []
                for sent_idx in range(probabilities.shape[0]):  # Iterate over sentences
                    sentence_result = []
                    for token_idx in range(probabilities.shape[1]):  # Iterate over tokens
                        token_probs = probabilities[sent_idx, token_idx]
                        max_prob = torch.max(token_probs)

                        # Compute threshold, which should just be beta * max_prob
                        threshold = beta * max_prob  # Compute threshold based on beta

                        selected_tags = []
                        for tag_id, prob in enumerate(token_probs):
                            # Convert the tag ID to a tag and check if it exceeds the threshold
                            tag = self.tags_tokenizer.convert_ids_to_tags(tag_id)

                            # Check if the returned list is not empty and the prob exceeds the threshold
                            if tag and len(tag) > 0 and prob >= threshold:
                                selected_tags.append([tag[0], prob.item()])  # Take the first tag and assign its probability
                                selected_tags = sorted(selected_tags, key=lambda x: x[1], reverse=True)

                        # If no tags meet the threshold, append the highest probability tag
                        if not selected_tags:
                            highest_tag_id = torch.argmax(token_probs)  # Get the tag with the highest probability
                            highest_tag = self.tags_tokenizer.convert_ids_to_tags(highest_tag_id)
                            if highest_tag and len(highest_tag) > 0:
                                selected_tags.append([highest_tag[0], token_probs[highest_tag_id].item()])

                        if selected_tags:
                            sentence_result.append(selected_tags)

                    batch_results.append(sentence_result)

                return batch_results

            else:
                return self.tags_tokenizer.convert_id_to_tag(torch.argmax(output['logit'], dim=2).detach())

    def forward(self, b_sents_tokenized, b_sents_mask):
        """
        Function used for the linker (same of predict)
        """
        with torch.no_grad():
            output = self.model.predict((b_sents_tokenized, b_sents_mask))
            return output

    def train(self, sentences, tags, validation_rate=0.1, epochs=20, batch_size=16,
              tensorboard=False,
              checkpoint=False):
        """
        Starts the training of the model, either new or previously loaded

        @param sentences: list of sentences for train (X)
        @param tags: list of tags for train (Y)
        @param validation_rate: percentage of validation data [0-1]
        @param epochs: number of epoch (50 recommended)
        @param batch_size:  number of sample in batch (32 recommended, attention to memory)
        @param tensorboard: use tensorboard for see loss and accuracy
        @param checkpoint: save the model after each epoch
        """
        assert self.trainable or self.model is None, "Please use the create_new_model(...) or load_weights(...) function before the train, the model is not integrated"

        assert len(sentences) == len(
            tags), f" num of sentences (X): {len(sentences)} must be equals with num of labels " \
                   f"(Y): {len(tags)} "

        if checkpoint or tensorboard:
            checkpoint_dir, writer = output_create_dir()

        training_dataloader, validation_dataloader = self.__preprocess_data(batch_size, sentences, tags,
                                                                            1 - validation_rate)
        epochs = epochs - self.epoch_i
        self.model = self.model.to(self.device)
        self.model.train()

        for epoch_i in range(0, epochs):
            print("")
            print('======== Epoch {:} / {:} ========'.format(epoch_i+1, epochs))
            print('Training...')

            # Train
            epoch_acc, epoch_loss, training_time = self.__train_epoch(training_dataloader)

            # Validation
            if validation_rate > 0.0:
                eval_accuracy, eval_loss, nb_eval_steps = self.__eval_epoch(validation_dataloader)

            print("")
            print(f'Epoch: {epoch_i+1:02} | Epoch Time: {training_time}')
            print(f'\tTrain Loss: {epoch_loss:.3f} | Train Acc: {epoch_acc * 100:.2f}%')
            if validation_rate > 0.0:
                print(f'\tVal Loss: {eval_loss:.3f} | Val Acc: {eval_accuracy * 100:.2f}%')

            if tensorboard:
                writer.add_scalars(f'Accuracy', {
                    'Train': epoch_acc}, epoch_i+1)
                writer.add_scalars(f'Loss', {
                    'Train': epoch_loss}, epoch_i+1)
                if validation_rate > 0.0:
                    writer.add_scalars(f'Accuracy', {
                        'Validation': eval_accuracy}, epoch_i+1)
                    writer.add_scalars(f'Loss', {
                        'Validation': eval_loss}, epoch_i+1)

            self.epoch_i += 1

            if checkpoint:
                self.__checkpoint_save(path=os.path.join(checkpoint_dir, 'model_check.pt'))

    # endregion Usage

    # region Private

    def __preprocess_data(self, batch_size, sentences, tags,
                          validation_rate):
        """
        Create torch dataloader for training

        @param batch_size: number of sample in batch
        @param sentences: list of sentences for train (X)
        @param tags: list of tags for train (Y)
        @param validation_rate: percentage of validation data [0-1]
        @return: (training dataloader, validation dataloader)
        """
        validation_dataloader = None

        sents_tokenized_t, sents_mask_t = self.sent_tokenizer.fit_transform_tensors(sentences)
        tags_t = self.tags_tokenizer.convert_batchs_to_ids(tags, sents_tokenized_t)
        dataset = TensorDataset(sents_tokenized_t, sents_mask_t, tags_t)

        train_size = int(validation_rate * len(dataset))
        print('{:>5,} training samples'.format(train_size))

        if validation_rate < 1:
            val_size = len(dataset) - train_size
            train_dataset, val_dataset = random_split(dataset, [train_size, val_size])
            print('{:>5,} validation samples'.format(val_size))
            validation_dataloader = torch.utils.data.DataLoader(val_dataset, batch_size=batch_size, shuffle=True)
        else:
            train_dataset = dataset
        training_dataloader = torch.utils.data.DataLoader(train_dataset, batch_size=batch_size, shuffle=True)
        return training_dataloader, validation_dataloader

    def __train_epoch(self, training_dataloader):
        """
        Train on epoch

        @param training_dataloader: dataloader of training data
        @return: (epoch accuracy, epoch loss, training time)
        """
        self.model.train()
        epoch_loss = 0
        epoch_acc = 0
        t0 = time.time()
        i = 0
        with tqdm(training_dataloader, unit="batch") as tepoch:
            for batch in tepoch:
                # Convert to device
                b_sents_tokenized = batch[0].to(self.device)
                b_sents_mask = batch[1].to(self.device)
                targets = batch[2].to(self.device)
                self.optimizer.zero_grad()

                output = self.model((b_sents_tokenized, b_sents_mask, targets))
                loss = output['loss']

                predictions = torch.argmax(output['logit'], dim=2).detach().cpu().numpy()
                label_ids = targets.cpu().numpy()

                acc = categorical_accuracy(predictions, label_ids)

                loss.backward()

                epoch_acc += acc
                epoch_loss += loss.item()

                self.optimizer.step()
                i += 1

        # Measure how long this epoch took.
        training_time = format_time(time.time() - t0)

        epoch_acc = epoch_acc / i
        epoch_loss = epoch_loss / i

        return epoch_acc, epoch_loss, training_time

    def __eval_epoch(self, validation_dataloader):
        """
        Validation on epoch

        @param validation_dataloader:  dataloader of validation data
        @return: (epoch accuracy, epoch loss, num step)
        """
        self.model.eval()
        eval_loss = 0
        eval_accuracy = 0
        nb_eval_steps, nb_eval_examples = 0, 0
        with torch.no_grad():
            print("Start eval")
            for step, batch in enumerate(validation_dataloader):
                # Convert to device
                b_sents_tokenized = batch[0].to(self.device)
                b_sents_mask = batch[1].to(self.device)
                b_symbols_tokenized = batch[2].to(self.device)

                output = self.model((b_sents_tokenized, b_sents_mask, b_symbols_tokenized))
                loss = output['loss']

                predictions = torch.argmax(output['logit'], dim=2).detach().cpu().numpy()
                label_ids = b_symbols_tokenized.cpu().numpy()

                accuracy = categorical_accuracy(predictions, label_ids)
                eval_loss += loss.item()
                eval_accuracy += accuracy
                nb_eval_examples += b_sents_tokenized.size(0)
                nb_eval_steps += 1

            eval_loss = eval_loss / nb_eval_steps
            eval_accuracy = eval_accuracy / nb_eval_steps
        return eval_accuracy, eval_loss, nb_eval_steps

    def __checkpoint_save(self, path='/model_check.pt'):
        """
        Save the model with good parameters
        @param path: poth and name for save
        """
        self.model.cpu()
        # print('save model parameters to [%s]' % path, file=sys.stderr)

        torch.save({
            'args': dict(bert_name=self.bert_name, index_to_tags=self.index_to_tags, epoch=self.epoch_i),
            'state_dict': self.model.state_dict(),
            'optimizer': self.optimizer,
        }, path)
        self.model.to(self.device)

    # endregion Private

# endregion Class

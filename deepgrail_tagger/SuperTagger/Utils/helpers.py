import pandas as pd
from tqdm import tqdm


def read_csv_pgbar(csv_path, nrows=float('inf'), chunksize=100):
    print("\n" + "#" * 20)
    print("Loading csv...")

    rows = sum(1 for _ in open(csv_path, 'r', encoding="utf8")) - 1  # minus the header
    chunk_list = []

    if rows > nrows:
        rows = nrows

    with tqdm(total=rows, desc='Rows read: ') as bar:
        for chunk in pd.read_csv(csv_path, converters={'Y1': pd.eval, 'Y2': pd.eval, 'Z': pd.eval}, chunksize=chunksize,
                                 nrows=rows):
            chunk_list.append(chunk)
            bar.update(len(chunk))

    df = pd.concat((f for f in chunk_list), axis=0)
    print("#" * 20)
    return df


def load_obj(name):
    with open(name + '.pkl', 'rb') as f:
        import pickle
        return pickle.load(f)


def categorical_accuracy_str(preds, truth):
    nb_label = 0
    good_label = 0
    for i in range(len(truth)):
        sublist_truth = truth[i]
        sublist_preds = preds[i]
        nb_label += len(sublist_truth)
        for j in range(min(len(sublist_truth), len(sublist_preds))):
            if str(sublist_truth[j]) == str(sublist_preds[j]):
                good_label += 1
    return good_label / nb_label

import re
import csv
from collections import defaultdict

def extract_fol_expressions(fol_path):
    fol_map = {}
    with open(fol_path, 'r', encoding='utf-8') as f:
        lines = f.readlines()
        for i, line in enumerate(lines):
            line = line.strip()
            match = re.match(r"#\s*fol\((\d+)\)", line)
            if match and i + 1 < len(lines):
                fol_id = int(match.group(1))
                expression = lines[i + 1].strip()
                if 'drs(' not in expression and 'drs_' not in expression and 'lambda(' not in expression and 'merge(' not in expression:
                    fol_map[fol_id] = expression
    print(f"Loaded {len(fol_map)} FOL expressions")
    return fol_map

def extract_sen_info(sen_path, fol_map):
    problem_labels = defaultdict(lambda: {'p': [], 'h': [], 'nli_label': None, 'subset': None})
    sen_info = {}

    with open(sen_path, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if line.startswith("sen_id("):
                # Example line: sen_id(1, 1, 'p', 'TEST', 'yes', '...')
                match = re.match(r"sen_id\((\d+),\s*(\d+),\s*'([ph])',\s*'([A-Z]+)',\s*'(yes|no|unknown|undef)',\s*'(.*)'\)\.$", line)
                if match:
                    sen_id = int(match.group(1))
                    problem_id = int(match.group(2))
                    label = match.group(3)
                    subset = match.group(4)
                    nli_label = match.group(5)
                    sentence = match.group(6)
                    problem_labels[problem_id][label].append(sen_id)
                    problem_labels[problem_id]['nli_label'] = nli_label
                    problem_labels[problem_id]['subset'] = subset
                    sen_info[sen_id] = (problem_id, label, sentence)

    # Debug print
    for pid, labels in problem_labels.items():
        p_ids = [f"{sid} ✅" if sid in fol_map else sid for sid in labels['p']]
        h_ids = [f"{sid} ✅" if sid in fol_map else sid for sid in labels['h']]
        print(f"Problem {pid} - p IDs: [{', '.join(str(x) for x in p_ids)}] | h IDs: [{', '.join(str(x) for x in h_ids)}]")

    return problem_labels, sen_info

def build_rows(fol_map, problem_labels, sen_info):
    rows = []
    max_p = 0
    max_h = 0

    for problem_id, labels in sorted(problem_labels.items()):
        p_exprs = [fol_map.get(sid, "") for sid in labels['p']]
        h_exprs = [fol_map.get(sid, "") for sid in labels['h']]

        p_nl = [sen_info[sid][2] for sid in labels['p']]
        h_nl = [sen_info[sid][2] for sid in labels['h']]

        max_p = max(max_p, len(p_exprs))
        max_h = max(max_h, len(h_exprs))

        rows.append({
            'problem_id': problem_id,
            'p': p_exprs,
            'h': h_exprs,
            'p_nl': p_nl,
            'h_nl': h_nl,
            'label': labels['nli_label'],
            'subset': labels['subset']
        })

    print(f"Max p expressions: {max_p}, Max h expressions: {max_h}")
    return rows, max_p, max_h

def write_tsv(rows, max_p, max_h, output_path):
    header = ['problem_id'] + [f"p{i+1}" for i in range(max_p)] + [f"p{i+1}_nl" for i in range(max_p)] + [f"h{i+1}" for i in range(max_h)] + [f"h{i+1}_nl" for i in range(max_h)] + ['label'] + ['dataset'] + ['subset']

    with open(output_path, 'w', encoding='utf-8', newline='') as f_out:
        writer = csv.writer(f_out, delimiter='\t')
        writer.writerow(header)

        for row in rows:
            p_exprs = row['p'] + [""] * (max_p - len(row['p']))
            h_exprs = row['h'] + [""] * (max_h - len(row['h']))

            p_nl = row['p_nl'] + [""] * (max_p - len(row['p_nl']))
            h_nl = row['h_nl'] + [""] * (max_h - len(row['h_nl']))
            writer.writerow([row['problem_id']] + p_exprs + p_nl + h_exprs + h_nl + [row['label']] + ['SICK'] + [row['subset']])

    print(f"TSV file written to: {output_path}")

# ==== Run the process ====

fol_path = 'fol_nltk_gqnli.txt'        # Your FOL expressions file path
sen_path = 'gqnli_fr_id_sentences_split.pl'     # Your sen_id file path
output_path = 'output_fol_gqnli.tsv'       # Output TSV file path

fol_map = extract_fol_expressions(fol_path)
problem_labels, sen_info = extract_sen_info(sen_path, fol_map)
rows, max_p, max_h = build_rows(fol_map, problem_labels, sen_info)
write_tsv(rows, max_p, max_h, output_path)

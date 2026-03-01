import re
import csv
import sys
from collections import defaultdict

sys.stdout.reconfigure(encoding='utf-8')


def extract_fol_expressions(fol_path):
    fol_map = {}
    fol_sentences = {}

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

                parts = line.split("): ", 1)
                if len(parts) == 2:
                    fol_sentence = parts[1].strip()
                    fol_sentences[fol_id] = fol_sentence
    print(f"Loaded {len(fol_map)} FOL expressions")
    print(f"Loaded {len(fol_sentences)} FOL sentences")

    return fol_map, fol_sentences


def normalize_sentence(s):
    """Normalize quotes, whitespace, and punctuation."""
    s = s.replace("\\'", "'").replace("’", "'")
    s = re.sub(r"\s?\\%", "%", s)
    s = re.sub(r"\s?\s([.,!?;:%-\)])", r"\1", s)
    s = re.sub(r"([\'\(])\s\s?", r"\1", s)
    s = s.replace("œ", "oe")
    # Normalize number separators: 20.000 / 20 000 / 20,000 -> 20000
    s = re.sub(r'(\d)[.\s,](\d{3})(?!\d)', r'\1\2', s)
    # Strip trailing punctuation for comparison
    s = s.rstrip('.!')
    return s.strip()
    
def sentences_match(fol_sentence, sen_sentence):
    """Check if FOL sentence matches SEN sentence approximately."""
    fol_norm = normalize_sentence(fol_sentence)
    sen_norm = normalize_sentence(sen_sentence)
    return (
        fol_sentence == sen_sentence
        or fol_norm == sen_norm
        or fol_norm.startswith(sen_norm[:25])
        or fol_sentence.startswith(sen_sentence[:25]) 
        or fol_norm.endswith(sen_norm[-25:]) 
        or fol_sentence.endswith(sen_sentence[-25:])
        or (fol_norm.startswith(sen_norm[:15]) and fol_norm.endswith(sen_norm[-15:]))
        or (fol_sentence.startswith(sen_sentence[:15]) and fol_sentence.endswith(sen_sentence[-15:]))
    )
    
def extract_sen_info(sen_path, fol_map, fol_sentences):
    problem_labels = defaultdict(lambda: {'p': [], 'h': [], 'nli_label': None, 'subset': None})
    sen_info = {}

    with open(sen_path, 'r', encoding='utf-8') as f:
        for idx, line in enumerate(f):
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
                    sen_info[sen_id] = (problem_id, label, sentence, subset, nli_label)

    # Step 2: Build reverse index from normalized sentence -> list of SEN IDs
    sen_by_sentence = defaultdict(list)  # normalized sentence -> [sen_id, ...]
    for sid, (pid, lbl, sentence, subset, nli) in sen_info.items():
        norm = normalize_sentence(sentence)
        sen_by_sentence[norm].append(sid)

    # Step 3: Pre-compute candidate SEN IDs for every FOL sentence
    all_candidates = {}  # fol_id -> set of candidate SEN IDs
    sorted_fol_ids = sorted(fol_sentences.keys())

    for fol_id in sorted_fol_ids:
        fol_sentence = fol_sentences[fol_id]
        fol_norm = normalize_sentence(fol_sentence)
        candidates = set()

        # a) Exact normalized match via reverse index
        if fol_norm in sen_by_sentence:
            candidates.update(sen_by_sentence[fol_norm])

        # b) Approximate matches (startswith/endswith) across all SEN
        if not candidates:
            for sid, (pid, lbl, sen_sentence, subset, nli) in sen_info.items():
                if sentences_match(fol_sentence, sen_sentence):
                    candidates.add(sid)

        all_candidates[fol_id] = candidates

    # Step 4: Assign FOL->SEN with look-ahead preference
    # When a FOL has multiple 'p' candidates, look at the next FOL's 'h' candidates
    # and prefer the 'p' from the same problem_id — keeps p/h pairs together.
    aligned = {}  # fol_id -> matched sen_id
    used_sen_ids = set()  # track SEN IDs already claimed by a FOL entry

    for i, fol_id in enumerate(sorted_fol_ids):
        candidates = all_candidates[fol_id]

        if not candidates:
            print(f"[WARNING] No SEN match found for FOL ID {fol_id}: '{fol_sentences[fol_id][:60]}'")
            continue

        # Among candidates, prefer: (1) same ID, (2) unused + problem-aware, (3) unused + closest, (4) reuse
        if fol_id in candidates and fol_id not in used_sen_ids:
            # Same ID match — always preferred
            aligned[fol_id] = fol_id
            used_sen_ids.add(fol_id)
            pid, lbl, _, _, nli = sen_info[fol_id]
            print(f"Matched FOL ID {fol_id} to same SEN ID {fol_id} (Problem {pid}, Label {lbl}, NLI {nli})")
        else:
            unused = [s for s in candidates if s not in used_sen_ids]

            if len(unused) > 1:
                # Look-ahead: peek at next FOL IDs' candidates for 'h' entries
                # to prefer the 'p' candidate from the same problem (up to 5 ahead, since max 5 p per problem)
                next_h_pids = set()
                for j in range(i + 1, min(i + 6, len(sorted_fol_ids))):
                    next_fol = sorted_fol_ids[j]
                    for nc in all_candidates.get(next_fol, set()):
                        if nc in sen_info and sen_info[nc][1] == 'h':
                            next_h_pids.add(sen_info[nc][0])  # problem_id
                    if next_h_pids:
                        break  # found at least one 'h' nearby, stop looking further

                if next_h_pids:
                    # Prefer 'p' candidates whose problem_id matches an upcoming 'h'
                    preferred = [s for s in unused
                                 if sen_info[s][1] == 'p' and sen_info[s][0] in next_h_pids]
                    if preferred:
                        best = min(preferred, key=lambda s: abs(s - fol_id))
                        print(f"Matched FOL ID {fol_id} to SEN ID {best} "
                              f"(Problem {sen_info[best][0]}, Label {sen_info[best][1]}, "
                              f"NLI {sen_info[best][4]}) [problem-aware look-ahead]")
                    else:
                        best = min(unused, key=lambda s: abs(s - fol_id))
                        pid, lbl, _, _, nli = sen_info[best]
                        print(f"Matched FOL ID {fol_id} to SEN ID {best} (Problem {pid}, Label {lbl}, NLI {nli})")
                else:
                    best = min(unused, key=lambda s: abs(s - fol_id))
                    pid, lbl, _, _, nli = sen_info[best]
                    print(f"Matched FOL ID {fol_id} to SEN ID {best} (Problem {pid}, Label {lbl}, NLI {nli})")

                aligned[fol_id] = best
                used_sen_ids.add(best)
            elif unused:
                best = unused[0]
                aligned[fol_id] = best
                used_sen_ids.add(best)
                pid, lbl, _, _, nli = sen_info[best]
                print(f"Matched FOL ID {fol_id} to SEN ID {best} (Problem {pid}, Label {lbl}, NLI {nli})")
            else:
                # All candidates used, pick closest (reuse fallback)
                best = min(candidates, key=lambda s: abs(s - fol_id))
                aligned[fol_id] = best
                pid, lbl, _, _, nli = sen_info[best]
                print(f"Matched FOL ID {fol_id} to SEN ID {best} (Problem {pid}, Label {lbl}, NLI {nli}) [reuse fallback]")

        # Step 3: Update problem_labels with matched FOL ID
        matched_sen_id = aligned[fol_id]
        problem_id, label, _, subset, nli_label = sen_info[matched_sen_id]

        problem_labels[problem_id][label].append(fol_id)
        # Only take nli_label and subset from the hypothesis match (unique per problem)
        # Fall back to premise match only if no hypothesis has been matched yet
        if label == 'h':
            problem_labels[problem_id]['nli_label'] = nli_label
            problem_labels[problem_id]['subset'] = subset
        elif label == 'p' and problem_labels[problem_id]['nli_label'] is None:
            problem_labels[problem_id]['nli_label'] = nli_label
            problem_labels[problem_id]['subset'] = subset
            print(f"NLI label and problem ID {problem_id} set based on premise match: {nli_label}")


    # Debug print
    for pid, labels in problem_labels.items():
        p_ids = [f"{sid} [OK]" if sid in fol_map else sid for sid in labels['p']]
        h_ids = [f"{sid} [OK]" if sid in fol_map else sid for sid in labels['h']]
        print(f"Problem {pid} - p IDs: [{', '.join(str(x) for x in p_ids)}] | h IDs: [{', '.join(str(x) for x in h_ids)}]")

    return problem_labels, sen_info, aligned

def build_rows(fol_map, problem_labels, sen_info, aligned_id):
    rows = []
    max_p = 0
    max_h = 0

    for problem_id, labels in sorted(problem_labels.items()):
        p_exprs = [fol_map.get(sid, "") for sid in labels['p']]
        h_exprs = [fol_map.get(sid, "") for sid in labels['h']]

        p_nl = [sen_info[aligned_id[sid]][2] for sid in labels['p']]
        h_nl = [sen_info[aligned_id[sid]][2] for sid in labels['h']]

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
            writer.writerow([row['problem_id']] + p_exprs + p_nl + h_exprs + h_nl + [row['label']] + ['XNLI'] + [row['subset']])

    print(f"TSV file written to: {output_path}")

# ==== Run the process ====

fol_path = 'fol_nltk_xnli_dev.txt'        # Your FOL expressions file path
sen_path = 'xnli_dev_id_sentences_split.pl'     # Your sen_id file path
output_path = 'output_fol_xnli_dev.tsv'       # Output TSV file path

fol_map, fol_sentences = extract_fol_expressions(fol_path)
problem_labels, sen_info, aligned_id = extract_sen_info(sen_path, fol_map, fol_sentences)
rows, max_p, max_h = build_rows(fol_map, problem_labels, sen_info, aligned_id)
write_tsv(rows, max_p, max_h, output_path)

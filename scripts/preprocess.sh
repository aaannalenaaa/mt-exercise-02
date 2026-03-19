#!/bin/bash
scripts=$(dirname "$0")
base=$(realpath $scripts/..)
PYTHON=$base/venvs/torch3/bin/python3
echo $base

mkdir -p $base/cleaned_data $base/preprocessed $base/test_train_validate_data

files=(
    "S01E18_All_The_Poker"
    "S01E23_The_Birth"
    "S01E10_The_Monkey"
    "S03E03_The_Jam"
    "S01E03_The_Thumb"
    "S03E17_The_Ski_Trip"
    "S07E21_The_Vows"
    "S08E04_The_Videotape"
    "S08E09_The_Rumor"
    "S08E20_The_Baby_Shower"
    "S09E18_The_Lottery"
    "S03E20_The_Dollhouse"
    "S10E07_The_Home_Study"
    "S09E04_The_Sharks"
    "S08E16_Joey_Tells_Rachel"
    "S05E14_Everybody_Finds_Out"
    "S01E07_The_Blackout"
    "S01E21_The_Fake_Monica"
    "S02E08_The_List"
    "S04E12_The_Embryos"
    "S02E14_The_Prom_Video"
    "S10E04_The_Cake"
    "S09E10_Christmas_In_Tulsa"
    "S08E15_The_Birthing_Video"
    "S08E14_The_Secret_Closet"
    "S10E15_Estelle_Dies"
)

# Step 1: clean raw scripts
for name in "${files[@]}"; do
    $PYTHON "$scripts/preprocess_raw.py" < "$base/friends_scripts/${name}.txt" > "$base/cleaned_data/${name}.cleaned.txt"
done

# Step 2: tokenize each episode separately
for name in "${files[@]}"; do
    $PYTHON "$scripts/preprocess.py" --vocab-size 5000 --tokenize --lang "en" --sent-tokenize \
    < "$base/cleaned_data/${name}.cleaned.txt" > "$base/preprocessed/${name}.preprocessed.txt"
done

# Step 3: shuffle and split
$PYTHON - <<EOF
import random, glob
random.seed(42)
all_lines = []
for f in sorted(glob.glob('preprocessed/*.preprocessed.txt')):
    with open(f) as fp:
        episode_lines = fp.readlines()
        random.shuffle(episode_lines)
        all_lines.append(episode_lines)

valid, test, train = [], [], []
for episode in all_lines:
    n = len(episode)
    v = max(1, int(n * 0.1))
    valid.extend(episode[:v])
    test.extend(episode[v:v*2])
    train.extend(episode[v*2:])

random.shuffle(train)
random.shuffle(valid)
random.shuffle(test)

import os
os.makedirs('test_train_validate_data', exist_ok=True)
with open('test_train_validate_data/valid.txt', 'w') as f: f.writelines(valid)
with open('test_train_validate_data/test.txt', 'w') as f: f.writelines(test)
with open('test_train_validate_data/train.txt', 'w') as f: f.writelines(train)
print(f"train: {len(train)}, valid: {len(valid)}, test: {len(test)}")
EOF
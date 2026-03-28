#! /bin/bash

scripts=$(dirname "$0")
base=$(realpath $scripts/..)

models=$base/models
data=$base/data
tools=$base/tools
samples=$base/samples

mkdir -p $samples

num_threads=4
device="mps"

(cd $tools/pytorch-examples/word_language_model &&
    OMP_NUM_THREADS=$num_threads /Users/annalena/university/masters/26FS/machine_translation/mt-exercise-02/venvs/torch3/bin/python3 generate.py \
        --accel \
        --data $base/test_train_validate_data \
        --words 100 \
        --temperature 1 \
        --outf $samples/sample_submission_d07 \
        --checkpoint $models/model_d07.pt \
)

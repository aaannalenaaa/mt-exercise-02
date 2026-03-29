# MT Exercise 2: Pytorch RNN Language Models

This repo shows how to train neural language models using [Pytorch example code](https://github.com/pytorch/examples/tree/master/word_language_model). Thanks to Emma van den Bold, the original author of these scripts. 

# Requirements

- the code was adjusted to work on Mac, changing devide to "mps"
- the -accel flag was used, to speed up training
- preprocess.py was changed from 
        t = tokenizer.tokenize(line)
    to
        t = tokenizer.tokenize(line, escape=False)
    in order to avoid & being turned into &amp;

# Steps

Start off by selecting the data.
The data used in this submission are 26 episode scripts from Friends. Download the .txt files here: https://www.kaggle.com/datasets/blessondensil294/friends-tv-series-screenplay-script. Some files have been renamed.
Select the desired episodes in ./scripts/preprocess.sh (or leave as is).

After adapting the necessary paths (where is the data stored) and file names (what are the names of the episdoes you want to work with), you can run the following script:

    ./scripts/preprocess.sh


Train a model on the just created data:

    ./scripts/train.sh


Generate some text from a trained model with:

    ./scripts/generate.sh


To train several models with different dropout rates, please adjust the dropout rates and use:

    ./scripts/batch_train.sh

This will automatically log the different perplexities into individual .csv-files.
All of them can be combined into one large .csv file. After adjusting the respective directory paths use:

    ./scripts/combining_csv.py

Further, feel free to check out the results or plot your own with the following jupyter notebook:

    ./scripts/log_plotting.ipynb
# MT Exercise 2: Pytorch RNN Language Models

This repo shows how to train neural language models using [Pytorch example code](https://github.com/pytorch/examples/tree/master/word_language_model). Thanks to Emma van den Bold, the original author of these scripts. 

# Requirements

- This code was adjusted to work on Mac, changing devide to "mps"
- preprocess.py was changed from 
        t = tokenizer.tokenize(line)
    to
        t = tokenizer.tokenize(line, escape=False)
    in order to avoid & being turned into &amp;
- direct paths to the used python were included (to avoid errors, eg. line 18 in ./scripts/train.sh)



# Steps

Start off by selecting the data.
The data used in this are 26 episode scripts from Friends. Download the .txt files here https://www.kaggle.com/datasets/divyansh22/friends-tv-show-script. 
Select the desired episodes in ./scripts/preprocess.sh (or leave as is).

After adapting the necessary paths, you can run the following script:

    ./scripts/preprocess.sh


Train a model on the just created data:

    ./scripts/train.sh


Generate (sample) some text from a trained model with:

    ./scripts/generate.sh

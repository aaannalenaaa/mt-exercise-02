#!/bin/bash

scripts=$(dirname "$0")
base=$(realpath $scripts/..)
PYTHON=$base/venvs/torch3/bin/python3
tools=$base/tools

(cd $tools/pytorch-examples/word_language_model &&
mkdir -p $base/logs &&
$PYTHON main.py --accel --dropout 0.0 --emsize 256 --nhid 256 --epochs 40 --save $base/models/model_d00.pt --logfile $base/logs/dropout_00.csv --data $base/test_train_validate_data &&
$PYTHON main.py --accel --dropout 0.3 --emsize 256 --nhid 256 --epochs 40 --save $base/models/model_d03.pt --logfile $base/logs/dropout_03.csv --data $base/test_train_validate_data &&
$PYTHON main.py --accel --dropout 0.6 --emsize 256 --nhid 256 --epochs 40 --save $base/models/model_d06.pt --logfile $base/logs/dropout_06.csv --data $base/test_train_validate_data &&
$PYTHON main.py --accel --dropout 0.7 --emsize 256 --nhid 256 --epochs 40 --save $base/models/model_d07.pt --logfile $base/logs/dropout_07.csv --data $base/test_train_validate_data &&
$PYTHON main.py --accel --dropout 0.9 --emsize 256 --nhid 256 --epochs 40 --save $base/models/model_d09.pt --logfile $base/logs/dropout_09.csv --data $base/test_train_validate_data)
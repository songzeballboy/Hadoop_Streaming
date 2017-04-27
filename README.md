# Hadoop_Streaming
This is a easy &amp; breif code to using the hadoop streaming to deal with word count problem

## 0. run_hadoop.sh
This file is to start the hadoop streaming job by shell.
With the sample to calculate the word count.
The data's shape is like (word, frequency, other_feature,...)

## 1. mapper.py
This file is to cat the data and split the data into (word, frequency) format.

## 2. reducer.py
This file is to collect the data from Map Process, then do a data stastic to output the word counted results.

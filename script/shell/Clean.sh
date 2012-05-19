#!/bin/bash

hadoop fs -rmr /neuro/output
hadoop fs -rmr /neuro/input
hadoop fs -rmr /neuro/lookup
hadoop fs -rmr /neuro/hive

hadoop fs -mkdir /neuro/input
hadoop fs -mkdir /neuro/lookup
hadoop fs -mkdir /neuro/hive
hadoop fs -mkdir /neuro/output/passes
hadoop fs -mkdir /neuro/output/phase

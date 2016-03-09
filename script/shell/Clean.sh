#!/bin/bash

hadoop fs -rm -r /neuro/output
hadoop fs -rm -r /neuro/input
hadoop fs -rm -r /neuro/lookup
hadoop fs -rm -r /neuro/hive

hadoop fs -mkdir /neuro/input
hadoop fs -mkdir /neuro/lookup
hadoop fs -mkdir /neuro/hive
hadoop fs -chmod 777 /neuro/hive
hadoop fs -mkdir /neuro/output
hadoop fs -mkdir /neuro/output/passes
hadoop fs -mkdir /neuro/output/phase

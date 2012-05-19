#!/bin/bash
NUM_BUCKETS=75

#Clean hdfs
hadoop fs -rmr /neuro/output
hadoop fs -rmr /neuro/input
hadoop fs -rmr /neuro/lookup
hadoop fs -rmr /neuro/hive

#Hdfs folders
hadoop fs -mkdir /neuro/input
hadoop fs -mkdir /neuro/lookup
hadoop fs -mkdir /neuro/hive
hadoop fs -mkdir /neuro/output/passes
hadoop fs -mkdir /neuro/output/phase

#Put data files into hdfs
hadoop fs -put /neuro/data/morlet-2000.csv /neuro/lookup/morlet-2000.dat
hadoop fs -put /neuro/data/signals/*.csv /neuro/input/
hadoop fs -put /neuro/data/passes/*.csv /neuro/output/passes/
hadoop fs -put /neuro/data/phase/*.csv /neuro/output/phase/

# Run the jobs
for S in SettingsJob ConvolutionJob Session Rats Ratsaverage Ratsstats Ratssubset Phasebucket Result

do
    START=$(date +%s)
    . $S.sh
    END=$(date +%s)
    DIFF=$(($END - $START))
    echo "$S took $DIFF seconds"
done

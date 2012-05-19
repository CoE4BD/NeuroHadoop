#!/bin/bash

NH_HOME="~/NeuroHadoop"
NUM_BUCKETS=75

# Run the jobs
for S in Clean Putdata SettingsJob ConvolutionJob Session Rats Ratsaverage Ratsstats Ratssubset Phasebucket Result

do
    START=$(date +%s)
    . $S.sh
    END=$(date +%s)
    DIFF=$(($END - $START))
    echo "$S took $DIFF seconds"
done

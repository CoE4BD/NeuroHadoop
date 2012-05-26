#!/bin/bash

NH_HOME="${HOME}/NeuroHadoop"
NUM_BUCKETS=75

# Run the jobs
for S in Clean Putdata Preaverage SettingsJob ConvolutionJob Session Rats Ratsstats Ratssubset Phasebucket Result

do
    START=$(date +%s)
    . $S.sh
    END=$(date +%s)
    DIFF=$(($END - $START))
    echo "$S took $DIFF seconds"
done

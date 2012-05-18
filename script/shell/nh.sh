#!/bin/bash
NUM_BUCKETS=75

#Clean hdfs
hadoop fs -rmr /neuro/output
hadoop fs -rmr /neuro/input
hadoop fs -rmr /neuro/lookup
hadoop fs -rmr /neuro/hive
rm /neuro/neurosrc/script/hive/createrats.q

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

#Run the job
cd /neuro/tmp
hadoop jar ~/NeuroHadoop/lib/NeuroHadoop.jar neurohadoop.SettingsJob /neuro/input /neuro/hive/session > /neuro/tmp/session.txt

START=$(date +%s)
hadoop jar ~/NeuroHadoop/lib/NeuroHadoop.jar neurohadoop.ConvolutionJob /neuro/input /neuro/output/rats > /neuro/tmp/output.txt
END=$(date +%s)
DIFF=$(($END - $START))
echo "ConvolutionJob took $DIFF seconds"

#Hive scripts
#Session Information
START=$(date +%s)
hive -S -f /neuro/neurosrc/script/hive/session.q
END=$(date +%s)
DIFF=$(($END - $START))
echo "Script Session took $DIFF seconds"

#Rats 
START=$(date +%s)
hive -S -f /neuro/neurosrc/script/hive/createrats.q
hive -S -f /neuro/neurosrc/script/hive/preparealterrats.q > /neuro/neurosrc/script/hive/alterrats.q
hive -S -f /neuro/neurosrc/script/hive/alterrats.q
END=$(date +%s)
DIFF=$(($END - $START))
echo "Script Rats took $DIFF seconds"

#Ratsaverage dynamic
START=$(date +%s)
hive -S -f /neuro/neurosrc/script/hive/prepareratsaverage.q > /neuro/neurosrc/script/hive/insertratsaverage.q
END=$(date +%s)
DIFF=$(($END - $START))
echo "Script Ratsaverage took $DIFF seconds"

#Ratsaverage
START=$(date +%s)
hive -S -f /neuro/neurosrc/script/hive/insertratsaverage.q
END=$(date +%s)
DIFF=$(($END - $START))
echo "Insert Ratsaverage took $DIFF seconds"

#Ratstats
START=$(date +%s)
hive -S -f /neuro/neurosrc/script/hive/ratstats.q
END=$(date +%s)
DIFF=$(($END - $START))
echo "Ratstats took $DIFF seconds"

#Passes
START=$(date +%s)
hive -S -f /neuro/neurosrc/script/hive/passesngc.q > /neuro/neurosrc/script/hive/ratssubset.q
END=$(date +%s)
DIFF=$(($END - $START))
echo "Passes & script for ratssubset took $DIFF seconds"

#Ratssubset
START=$(date +%s)
hive -S -f /neuro/neurosrc/script/hive/ratssubset.q
END=$(date +%s)
DIFF=$(($END - $START))
echo "Ratssubset took $DIFF seconds"

#Phasebucket
START=$(date +%s)
hive -S --hiveconf maxphaserange=$NUM_BUCKETS -f /neuro/neurosrc/script/hive/phasebucket.q
END=$(date +%s)
DIFF=$(($END - $START))
echo "Phasebucket took $DIFF seconds"

#Result
START=$(date +%s)
hive -S -f /neuro/neurosrc/script/hive/result.q
END=$(date +%s)
DIFF=$(($END - $START))
echo "Result took $DIFF seconds"

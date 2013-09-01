#!/bin/bash
echo "ADD JAR $NH_HOME/lib/NeuroHadoop.jar;" > $NH_HOME/script/hive/insertratsaverage.q
hive -hiveconf nhhome=$NH_HOME -f $NH_HOME/script/hive/prepareratsaverage.q >> $NH_HOME/script/hive/insertratsaverage.q
hive --auxpath $NH_HOME/lib/NeuroHadoop.jar -f $NH_HOME/script/hive/insertratsaverage.q
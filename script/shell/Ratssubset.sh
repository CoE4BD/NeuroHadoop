#!/bin/bash

hive -hiveconf nhhome=$NH_HOME -f $NH_HOME/script/hive/passesngc.q > $NH_HOME/script/hive/ratssubset.q
hive --auxpath $NH_HOME/lib/NeuroHadoop.jar -hiveconf nhhome=$NH_HOME -f $NH_HOME/script/hive/ratssubset.q
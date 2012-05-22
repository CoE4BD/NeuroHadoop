#!/bin/bash

hive --auxpath $NH_HOME/lib/NeuroHadoop.jar -hiveconf nhhome=$NH_HOME -f $NH_HOME/script/hive/createrats.q
hive -f $NH_HOME/script/hive/preparealterrats.q > ~/NeuroHadoop/script/hive/alterrats.q
hive --auxpath $NH_HOME/lib/NeuroHadoop.jar -f $NH_HOME/script/hive/alterrats.q

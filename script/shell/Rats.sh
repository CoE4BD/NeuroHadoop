#!/bin/bash

hive  -hiveconf nhhome=$NH_HOME -f $NH_HOME/script/hive/createrats.q
hive -f $NH_HOME/script/hive/preparealterrats.q > ~/NeuroHadoop/script/hive/alterrats.q
hive -f $NH_HOME/script/hive/alterrats.q
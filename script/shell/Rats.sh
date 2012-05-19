#!/bin/bash

hive -S -f $NH_HOME/script/hive/createrats.q
hive -S -f $NH_HOME/script/hive/preparealterrats.q > ~/NeuroHadoop/script/hive/alterrats.q
hive -S -f $NH_HOME/script/hive/alterrats.q
#!/bin/bash

hive -S -f $NH_HOME/script/hive/prepareratsaverage.q > $NH_HOME/script/hive/insertratsaverage.q
hive -S -f ~/NeuroHadoop/script/hive/insertratsaverage.q
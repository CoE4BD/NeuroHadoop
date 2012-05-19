#!/bin/bash

hive -S -f ~/NeuroHadoop/script/hive/prepareratsaverage.q > ~/NeuroHadoop/script/hive/insertratsaverage.q
hive -S -f ~/NeuroHadoop/script/hive/insertratsaverage.q
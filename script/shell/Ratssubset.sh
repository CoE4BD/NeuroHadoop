#!/bin/bash

hive -S -f ~/NeuroHadoop/script/hive/passesngc.q > ~/NeuroHadoop/script/hive/ratssubset.q
hive -S -f ~/NeuroHadoop/script/hive/ratssubset.q
#!/bin/bash

hive -S -f ~/NeuroHadoop/script/hive/createrats.q
hive -S -f ~/NeuroHadoop/script/hive/preparealterrats.q > ~/NeuroHadoop/script/hive/alterrats.q
hive -S -f ~/NeuroHadoop/script/hive/alterrats.q
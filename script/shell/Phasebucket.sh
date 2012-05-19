#!/bin/bash

hive -S --hiveconf maxphaserange=$NUM_BUCKETS -f ~/NeuroHadoop/script/hive/phasebucket.q
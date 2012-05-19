#!/bin/bash

hive -S --hiveconf maxphaserange=$NUM_BUCKETS -f $NH_HOME/script/hive/phasebucket.q
#!/bin/bash

hive -hiveconf nhhome=$NH_HOME -f $NH_HOME/script/hive/passesngc.q > $NH_HOME/script/hive/ratssubset.q
impala-shell -k -i w10 -f $NH_HOME/script/hive/ratssubset.q
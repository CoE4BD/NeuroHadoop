#!/bin/bash

hive -hiveconf nhhome=$NH_HOME -f $NH_HOME/script/hive/passesngc.q > temp 
head -n -2 temp >$NH_HOME/script/hive/ratssubset.q
impala-shell -k -i w10 -f $NH_HOME/script/hive/ratssubset.q
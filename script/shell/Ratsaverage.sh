#!/bin/bash

hadoop fs -chmod -R 777 /neuro/output/ratsaverage/
#impala-shell -k -i w10 -f $NH_HOME/script/hive/prepareratsaverage.q > $NH_HOME/script/hive/insertratsaverage.q
impala-shell -k -i w10 -f $NH_HOME/script/hive/insertratsaverage.q

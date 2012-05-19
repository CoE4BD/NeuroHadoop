#!/bin/bash

hive -S -f $NH_HOME/script/hive/passesngc.q > $NH_HOME/script/hive/ratssubset.q
hive -S -f $NH_HOME/script/hive/ratssubset.q
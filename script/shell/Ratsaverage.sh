#!/bin/bash

hive -f $NH_HOME/script/hive/prepareratsaverage.q > $NH_HOME/script/hive/insertratsaverage.q
hive -f $NH_HOME/script/hive/insertratsaverage.q

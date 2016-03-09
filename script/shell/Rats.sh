#!/bin/bash

impala-shell -k -i w10 -f $NH_HOME/script/hive/createrats.q
impala-shell -B -k -i w10 -f $NH_HOME/script/hive/preparealterrats.q >$NH_HOME/script/hive/alterrats.q
impala-shell -k -i w10 -f $NH_HOME/script/hive/alterrats.q

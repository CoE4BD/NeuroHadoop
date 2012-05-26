#!/bin/bash

hive --auxpath $NH_HOME/lib/NeuroHadoop.jar -hiveconf nhhome=$NH_HOME -f $NH_HOME/script/hive/ratstats.q
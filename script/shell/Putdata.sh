#!/bin/bash

hadoop fs -put ~/neuro/data/morlet-2000.csv /neuro/lookup/morlet-2000.dat
hadoop fs -put ~/neuro/data/signals/*.csv /neuro/input/
# hadoop fs -put /home/brad/R192-2009-11-19-CSC100a.csv /neuro/input/
hadoop fs -put ~/neuro/data/passes/*.csv /neuro/output/passes/
hadoop fs -put ~/neuro/data/phase/*.csv /neuro/output/phase/
hadoop fs -chmod -R 777 /neuro/output/


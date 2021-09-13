#!/bin/sh

for gz in $PWD/*.gz

do

#create a prefix
#@1,0,bz2,,sbatch -p short -n 1 -t 60:0 --mem 20G -c 1
gunzip -d $gz


done

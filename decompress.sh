#!/bin/sh

mkdir -p STARResults

for bz2 in *.bz2

do

#create a prefix
#@1,0,bz2,,sbatch -p short -n 1 -t 60:0 --mem 20G -c 1
bzip2 -d $bz2


done

#!/bin/sh

#modules needed:
#1) gcc/6.2.0   2) bcbio/latest   3) samtools/1.10   4) rcbio/1.1
for samFile in $PWD/*.sam

do

#create a prefix
base=`basename $samFile .sam`
#@1,0,samFileConvert,,sbatch -p short -n 1 -t 60:0 --mem 20G -c 1
samtools view -bS $samFile > $base.bam


done

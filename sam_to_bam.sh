#!/bin/sh

for samFile in $PWD/*.sam

do

#create a prefix
base=`basename $samFile .sam`
#@1,0,samFileConvert,,sbatch -p short -n 1 -t 60:0 --mem 20G -c 1
samtools view -bS $samFile > $base.bam


done

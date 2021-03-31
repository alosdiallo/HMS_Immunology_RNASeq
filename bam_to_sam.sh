#!/bin/sh

#modules needed:
#1) gcc/6.2.0   2) bcbio/latest   3) samtools/1.10   4) rcbio/1.1
for bamFile in $PWD/*.bam

do

#create a prefix
base=`basename $bamFile .bam`
#@1,0,samFileConvert,,sbatch -p short -n 1 -t 60:0 --mem 20G -c 1
samtools view -h -o $base.sam $bamFile


done

samtools view -h -o out.sam in.bam

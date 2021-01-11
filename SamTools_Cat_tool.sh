#!/bin/sh
#runAsPipeline SamTools_Cat_tool.sh "sbatch -p short -t 20:0 -n 1" noTmp run
#modules needed:
#1) gcc/6.2.0   2) bcbio/latest   3) samtools/1.10   4) rcbio/1.1
for lane1 in *L001*;

do 

#create a prefix
sample=`basename $lane1 L001_R1.Aligned.out.bam` 

#@1,0,samFileCat,,sbatch -p short -n 1 -t 60:0 --mem 20G -c 1
samtools cat -o "$sample"R1.Aligned.out.bam "$sample"L001_R1.Aligned.out.bam "$sample"L002_R1.Aligned.out.bam "$sample"L003_R1.Aligned.out.bam "$sample"L004_R1.Aligned.out.bam

done

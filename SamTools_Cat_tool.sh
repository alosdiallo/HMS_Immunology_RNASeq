#!/bin/sh
#runAsPipeline Cat_fastq.sh "sbatch -p short -t 20:0 -n 1" noTmp run
#modules needed:
#1) gcc/6.2.0   2) bcbio/latest   3) samtools/1.10   4) rcbio/1.1
for lane1 in *L001*;

do 

#create a prefix
sample=$(echo "$lane1" | cut -f 1,2,3 -d '_'); 

#@1,0,samFileCat,,sbatch -p short -n 1 -t 60:0 --mem 20G -c 1
samtools cat -o "$sample"_R1.Aligned.out.bam "$sample"_L001_R1.Aligned.out.bam "$sample"_L002_R1.Aligned.out.bam "$sample"_L003_R1.Aligned.out.bam "$sample"_L004_R1.Aligned.out.bam

done

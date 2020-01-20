#!/bin/sh

mkdir -p STARResults SortedResults  Counts

for fastq in $PWD/fastqFiles/*.fastq

do

#create a prefix
base=`basename $fastq .fastq`
#@1,0,star,,sbatch -p short -n 1 -t 60:0 --mem 50G -c 13
STAR --runThreadN 12 --genomeDir $PWD/Index/ --outFileNamePrefix $PWD/STARResults/$base. --readFilesIn $fastq



#@2,1,Samt,,sbatch -p short -n 1 -t 60:0 --mem 50G -c 10
samtools sort -n $PWD/STARResults/$base.Aligned.out.sam -o $PWD/SortedResults/$base.sorted.sam

#@3,2,htseqcount,,sbatch -p short -n 1 -t 60:0 --mem 50G
htseq-count -m union -r name -i gene_name -a 10 --stranded=no $PWD/SortedResults/$base.sorted.sam $PWD/genome/Mus_musculus.GRCm38.97.gtf > $PWD/Counts/$base.counts


done



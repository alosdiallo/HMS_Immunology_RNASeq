#!/bin/sh

module load fastqc/0.11.9

for fastq in $PWD/*.fastq

do

#create a prefix
#@1,0,fastqc,,sbatch -p short -n 1 -t 60:0 --mem 20G -c 1
fastqc --noextract $fastq


done

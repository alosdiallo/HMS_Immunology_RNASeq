#!/bin/sh

for fastq in $PWD/*.fastq

do

#create a prefix
base=`basename $fastq .fastq`
#@1,0,star,,sbatch -p short -n 1 -t 60:0 --mem 50G -c 13
STAR --runThreadN 12 --genomeDir /home/ad249/immdiv-bioinfo/mouse_genome_index_star --outFileNamePrefix $base. --readFilesIn $fastq


done


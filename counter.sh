#!/bin/sh

for sam in $PWD/*.sam

do

#@1,0,htseqcount,,sbatch -p short -n 1 -t 60:0 --mem 50G
htseq-count -m union -r name -i gene_name -a 10 --stranded=yes "$sam" /n/shared_db/hg19/uk/star/2.5.4a/genes.gtf > "$sam".counts

done

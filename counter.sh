#!/bin/sh

for sam in $PWD/*.sam

do

#@1,0,htseqcount,,sbatch -p short -n 1 -t 60:0 --mem 50G
htseq-count -m union -r name -i gene_name -a 10 --stranded=no "$sam" /home/ad249/immdiv-bioinfo/karni/mouse_genome/Mus_musculus.GRCm38.97.gtf > "$sam".counts

done

#!/bin/sh

# Load module and create results folder
module load salmon/1.2.1
mkdir -p SalmonResults

# Loop over each FASTQ file
for fastq in $PWD/*.fastq

do

#create a prefix
base=`basename $fastq .fastq`

#@1,0,Salmon,,sbatch -p short -n 1 -t 60:0 --mem 10G -c 10
salmon quant -i $PWD/salmon_index -l A -r $fastq -o $PWD/SalmonResults/$base.out --seqBias --useVBOpt --gcBias --validateMappings


done



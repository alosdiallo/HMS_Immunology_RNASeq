
#!/bin/sh

mkdir -p STARResults SortedResults  Counts

for bam in $PWD/*.bam

#@2,1,Samt,,sbatch -p short -n 1 -t 60:0 --mem 50G -c 10
samtools sort -n $PWD/STARResults/$base.Aligned.out.bam -o $PWD/SortedResults/$base.sorted.bam

done

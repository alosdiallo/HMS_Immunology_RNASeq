
#!/bin/bash

for i in $(find ./ -type f -name "*.fastq.bz2" | while read F; do basename $F | rev | cut -c 22- | rev; done | sort | uniq)

    do echo "Merging R1"

cat "$i"_S*_L001_R1.fastq.bz2 "$i"_S*_L002_R1.fastq.bz2 "$i"_S*_L003_R1.fastq.bz2 "$i"_S*_L004_R1.fastq.bz2 > "$i"R1.fastq.bz2

       echo "Merging R2"

cat "$i"_S*_L001_R2.fastq.bz2 "$i"_S*_L001_R2.fastq.bz2 "$i"_S*_L002_R2.fastq.bz2 "$i"_S*_L003_R2.fastq.bz2 "$i"_S*_L004_R2.fastq.bz2> "$i"R2.fastq.bz2

done;

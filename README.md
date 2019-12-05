# HMS Immunology RNASeq Pipeline
This is the pipeline for RNA Seq analysis for labs in the HMS Immunology Department



### Installation instructions
- You must have R & Rstudio installed on your computer. Instructions can be found in here.
- HMS O2 Cluster: Putty, WinSCP

### Steps to start running RNA-seq on O2 cluster 
1. Login to O2 cluster with your HMS username & password. 
2. Begin an interactive session by running:<br>
	`srun --pty -p interactive -t 0-2:0:0 --mem 150G -c 15 /bin/bash`<br>
	You can request extra memory or multiple cores (up to 20). More information is found [`here`](https://wiki.rc.hms.harvard.edu/display/O2/Using+Slurm+Basic).
3. Install the required modules by running:<br> 
	`module load conda2/4.2.13`<br>
	`module load rcbio/1.0`<br>
	`module load cellranger/2.2.0`<br>
	`module load bcl2fastq/2.20.0.422`<br>
	`module load gcc/6.2.0`<br>
	`module load star/2.5.4a`<br>
	`module load samtools/1.9`<br>
	`module load python/2.7.12`<br>
	`module load htseq/0.9.1`<br>
4. Generating a genome index using STAR should be done only once. If it already exists, this step should be ignored.<br>
	`STAR --runMode genomeGenerate --genomeDir /home/kb246/immdiv-bioinfo/karni/mouse_genome/ --genomeFastaFiles /home/kb246/immdiv-bioinfo/karni/mouse_genome/Mus_musculus.GRCm38.dna.primary_assembly.fa --sjdbGTFfile /home/kb246/immdiv-bioinfo/karni/mouse_genome/Mus_musculus.GRCm38.97.gtf --sjdbOverhang 50`<br>
	You can replace the directory in the above (`/home/kb246/immdiv-bioinfo/karni/mouse_genome/...`) with the one your fasta and gft files are found.<br>
5. Create a new directory to put your files and name it **RNA-seq**.<br>
	`mkdir RNA-seq`
5. Go inside the folder you generated in the previous step and create a new folder, name it **fastqFiles** as such:<br>
	`ls RNA-seq`<br>
	`mkdir fastqFiles`<br>
	Copy all your fastq files into this folder created using WinSCP (for Windows) & (for Linux).<br>
6. Download **pipeline.sh** from Github and copy it into **RNA-seq** folder using (WinSCP).<br>
6. Run the commands in the file **pipeline.sh** by running:<br>
	`runAsPipeline pipeline.sh "sbatch -p short -t 20:0 -n 1" noTmp run`



#### The follow species are currently supported by the App
1. mouse: mm9, mm10 <br>
2. human: Hg19, Hg38 <br>


### References
This application utilizes the following packages and libraries:<br>



Authors
--------------------
	Karni Bedirian - Department of Immunology, Harvard Medical School
	Alos Diallo - Department of Immunology, Harvard Medical School
  	
Copyright © 2018 the President and Fellows of Harvard College.
![Blavatnikimmunology](https://storage.googleapis.com/gencode_ch_data/Blavatnikimmunology.jpg)  
![Immgen](https://storage.googleapis.com/gencode_ch_data/immgen.png)  
![EVERGRANDE](https://storage.googleapis.com/gencode_ch_data/evergrande_logo_footer2.png)

### [MIT License](https://github.com/alosdiallo/HiC_Network_Viz_tool/blob/master/Licence.txt)

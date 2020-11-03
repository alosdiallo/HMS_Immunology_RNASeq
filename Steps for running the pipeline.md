### Steps to start running the RNA-seq pipeline on the O2 cluster 
1. Login to O2 cluster with your HMS username & password using Putty or .... 
2. Begin an interactive session by running:<br><br>
	`srun --pty -p interactive -t 0-2:0:0 --mem 150G -c 15 /bin/bash`<br><br>
	You can request extra memory or multiple cores (up to 20). More information is found [`here`](https://wiki.rc.hms.harvard.edu/display/O2/Using+Slurm+Basic).<br>
3. Install the required modules by running:<br><br>
	`module load conda2/4.2.13`<br>
	`module load rcbio/1.0`<br>
	`module load cellranger/2.2.0`<br>
	`module load bcl2fastq/2.20.0.422`<br>
	`module load gcc/6.2.0`<br>
	`module load star/2.5.4a`<br>
	`module load samtools/1.9`<br>
	`module load python/2.7.12`<br>
	`module load htseq/0.9.1`<br>
	`module load fastx/0.0.13`<br>
4. Create a new directory to put all your files and name it **RNA-seq**.<br><br>
	`mkdir RNA-seq`<br>
5. #### Generating a genome index using STAR:<br>
	*Step 5* can be ignored if you will use an index from a shared directory, which has the lastest version of the mouse genome. 		Otherwise you will have to create a new one as shown below.<br> 
     - Go to **RNA-seq** folder you created in *step 4*, generate a new folder and name it **Index** as such:<br><br>
	 `ls RNA-seq`<br><br>
   	 `mkdir Index`<br><br>
     - Go to **Index** folder you just created and generate a new genome index as such:<br><br>
   	 `ls Index`<br><br>
	 `STAR --runMode genomeGenerate --genomeDir /home/kb246/RNA-seq/Index/ --genomeFastaFiles /home/kb246/genome/Mus_musculus.GRCm38.dna.primary_assembly.fa --sjdbGTFfile /home/kb246/genome/Mus_musculus.GRCm38.97.gtf --sjdbOverhang 50`<br><br>
	You should replace the path of the directories above with your username. (`/home/username/RNA-seq/Index`).<br><br>
	
6. Go back to **RNA-seq** you generated in the previous step and create a new folder, name it **fastqFiles** as such:<br><br>
	`cd ..`<br><br>
	`mkdir fastqFiles`<br><br>
	Copy all your fastq files into this folder created using WinSCP (for Windows) & (...for Linux).<br>
7. Download **pipeline.sh** from Github and copy it into **RNA-seq** folder using (WinSCP).<br>
8. Run the commands in the file **pipeline.sh** by running:<br><br>
	`runAsPipeline pipeline.sh "sbatch -p short -t 20:0 -n 1" noTmp run`<br><br>
	**Note**: You must make sure that the file is in linux format and not windows. 
	If you see $'\r': command not found" That is what the issue is.
	**Note**: To be able to run the above, you should have the file **pipeline.sh** inside **RNA-seq** folder, otherwise you will face an error.
	
Extra: Make sure you look at the fastqc results and trim them if needed.  
fastx_trimmer -l N
[-l N]       = Last base to keep. Default is entire read.

Here is an example:

fastx_trimmer -Q33 -f 24 -l 42 -i LIB046235_GEN00183629_S1_L001_R1.fastq -o LIB046235_GEN00183629_S1_trimmed__L001_R1.fastq

fastqc -t 6 *.fq  #note the extra parameter we specified for 6 threads

To generate FPKM values from counts use https://cran.r-project.org/web/packages/countToFPKM/index.html

To combine lanes use cat like:
cat LIB047785_TRA00194831_S2_L001_R2.fastq LIB047785_TRA00194831_S2_L002_R2.fastq LIB047785_TRA00194831_S2_L003_R2.fastq LIB047785_TRA00194831_S2_L004_R2.fastq  > LIB047785_TRA00194831_S2_R2.fastq 


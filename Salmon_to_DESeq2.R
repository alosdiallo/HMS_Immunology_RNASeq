# Use tximport to load the results of Salmon into DESeq2
# More info can be found in the vignette
# https://bioconductor.org/packages/release/bioc/vignettes/tximport/inst/doc/tximport.html

# Load libraries
library(readr)
library(stringr)
library(tximport)
library(DESeq2)
library(biomaRt)

# File path to results
data <- 'SalmonResults/'

# Trim off the '.out' at the end of each directory
sampleFiles <- list.files(data)
sampleNames <- trimws(list.files(data), whitespace = '.out')

# Get the names of the quant.sf files
# These will be loaded directly through tximport into DESeq2
sampleFiles <- paste0(data, sampleFiles, '/quant.sf')
names(sampleFiles) <- sampleNames

# Create a dataframe to store info about the samples
sampleTable <- data.frame(row.names = sampleNames,
		          matrix(data = NA, nrow = length(sampleFiles), ncol = 2))

# This part will depend on the setup of the experiment and names of the files
# Add information to 'sampleTable' here

# Load gene map, which maps the transcript names
# to gene names for the GRCm38 mouse transcriptome
gene_map <- read.csv('gene_map.csv', header = FALSE)
colnames(gene_map) <- c("ensmust", "ensmusg")

# Load data into tximport
count_data <- tximport(files = sampleFiles,
		       type = "salmon",
		       tx2gene = gene_map,
		       ignoreTxVersion = TRUE)

# Load data into DESeq2
# Change the experiment design to match that of the actual experiment
dds <- DESeqDataSetFromTximport(txi = count_data,
				colData = sampleTable,
				design = Status)



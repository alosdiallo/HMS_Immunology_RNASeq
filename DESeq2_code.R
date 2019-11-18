#DESeq2 steps
#For more information go to: https://bioconductor.riken.jp/packages/3.7/bioc/vignettes/DESeq2/inst/doc/DESeq2.html
#https://www.biostars.org/p/343138/
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("biomaRt")
install.packages("BiocManager")
BiocManager::install("DESeq2")
BiocManager::install("edgeR")
BiocManager::install("PoiClaClu")
BiocManager::install("apeglm")
library("DESeq2")
library("edgeR")
library("PoiClaClu")
library(biomaRt)

sampleFiles <- NULL
sampleNames <- NULL
sampleCondition <- NULL
sampleTable <- NULL
ddsHTSeq <- NULL

#The path of directory to read count files from
directory <- "F:/Karni/Arlene's project/CD8_after removing samples/counts"

#reading the count files
sampleFiles <- grep("counts",list.files(directory),value=TRUE) 

#sample Names to be derived from the counts file names 
sampleNames <- sampleFiles
sampleNames <-   gsub("Aligned.out.sorted.counts", "", sampleNames)

#For now I am manually passing in the conditions (as they are ordered in the folder), (this should be changed later)
sampleCondition <- c("Cre_pos", "Cre_pos", "Cre_neg", "Cre_neg", "Cre_pos", "Cre_pos", "Cre_pos","Cre_pos","Cre_neg", "Cre_neg", "Cre_neg","Cre_neg", "Cre_pos", "Cre_pos", "Cre_neg","Cre_neg", "Cre_pos", "Cre_pos", "Cre_neg", "Cre_neg", "Cre_neg", "Cre_neg", "Cre_neg", "Cre_pos", "Cre_pos", "Cre_pos", "Cre_pos", "Cre_neg" )

#creating table that includes sample files with their corresponsing conditions, to create DESeq dataset in the next table 
sampleTable <- data.frame(sampleName = sampleNames,
                          fileName = sampleFiles,
                          condition = sampleCondition)

#creating DESeq dataset
ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable,
                                       directory = directory,
                                       design= ~ condition)

#remove those genes which have a total count of zero:
ddsHTSeq  <- ddsHTSeq [ rowSums(assay(ddsHTSeq )) >= 5, ]



#run the differential expression pipeline on the raw counts with a single call to the function DESeq:
#ddsHTSeq  <- DESeq(ddsHTSeq)
ddsHTSeq  <- DESeq(ddsHTSeq, minReplicatesForReplace=Inf)


#Building the results table
res <- results(ddsHTSeq)
##If results include p adjusted with NA values, set the filtering and the replacement for outliers off by including these commands in 'results(....)'  : 
#'cooksCutoff=FALSE' and 'independentFiltering=FALSE' as the following (ignore the previous command): 
res <- results(ddsHTSeq , cooksCutoff=FALSE, independentFiltering=FALSE)

#To check DESeq2 results run 'res' to see if the results are based on Group A vs Gourp B, or vice versa 
#You can control this using the follofing command after you call DESeq(...) function 
#ddsHTSeq$condition <- factor(ddsHTSeq$condition, levels = c("Cre_pos", "Cre_neg"))

#writing the results into a csv file
write.csv(as.data.frame(res), file = "DESeq2_results.csv")


########################################################################################################################### 
#PCA plot
library(ggplot2)
vsd <- vst(ddsHTSeq)
#check if the data is created for PCA plot
head(colData(vsd),3)
nudge <- position_nudge(y = 0.5)
z <- plotPCA(vsd, intgroup = "condition")
z + geom_text(aes(label = name), check_overlap = FALSE,size=2.5, position=nudge) + ggtitle("Inducible PD1 deletion: A: Cre+PD1- vs B: Cre+PD1+")


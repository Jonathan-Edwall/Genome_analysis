#if (!requireNamespace('BiocManager',quietly = TRUE)) 
#install.packages('BiocManager',force=TRUE)
library('BiocManager')
#BiocManager::install('DESeq2',force=TRUE) 
library('DESeq2')
#BiocManager::install("genefilter") # Used for finding genes with highest variances
#install.packages("gplots")
#install.packages("ggplot2")

getwd()
setwd("C:/Users/jonat/GitHub/Genome_analysis/results/04_differential_expression/htseq/")
getwd()

# List all files in the directory that match a specific pattern
sampleFiles <- list.files(pattern = "*_counts.txt")
print(sampleFiles)
# temp <- read.table("musang_king_aril_1_counts.txt", header = TRUE)
# htseq_result <- data.frame(temp[,1])
# colnames(htseq_result) <- c("Gene ID")




#############################################
#¤¤¤¤¤¤¤¤¤ Code to manually view the htseq-count result ¤¤¤¤¤¤¤¤¤
#############################################
# Iterate through the files
htseq_result <- list()
for (file in sampleFiles) {
  data <- read.table(file, header = TRUE)
  column_name <- sub("_counts.txt$","",file)
  htseq_result[[column_name]] <- data
.
  
}


#############################################
#¤¤¤¤¤¤¤¤¤ Creating DESEQ2-object ¤¤¤¤¤¤¤¤¤
#############################################
samplecondition <- c("MO_ARIL","MO_ARIL","MO_ARIL","MU_ARIL","MU_ARIL","MU_LEAF","MU_ROOT","MU_STEM")
# samplecondition
samplename <- c("MO_ARIL_1","MO_ARIL_2","MO_ARIL_3","MU_ARIL_2","MU_ARIL_3","MU_LEAF","MU_ROOT","MU_STEM")

#Creating DESEQ2-object
sampleTable <- data.frame(sampleName=samplename, fileName=sampleFiles,condition=samplecondition)
View(sampleTable)
directory = "C:/Users/jonat/GitHub/Genome_analysis/results/04_differential_expression/htseq"
ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable=sampleTable,directory=directory,design =~ condition) # design = ~ 1 means that no covariates influence gene expression, only overall difference between conditions is of interest


#Perform the necessary transformations and normalization
#(estimates the size factors and dispersions for each gene)
ddsHTSeq <- DESeq(ddsHTSeq)

#############################################
#¤¤¤¤¤¤¤¤¤ PCA plot ¤¤¤¤¤¤¤¤¤
#############################################

#Extract the regularized log-transformed (rlog) values from the DESeq2 object:
#The blind = FALSE argument prevents the blind dispersion estimation, which is desirable for PCA.
rld <- rlog(ddsHTSeq)

# Calculate the PCA:
plotPCA(rld)


#############################################
#¤¤¤¤¤¤¤¤¤ Heat map ¤¤¤¤¤¤¤¤¤
#############################################

library("genefilter")

topVarGenes <- head( order( rowVars( assay(rld) ), decreasing=TRUE ), 35 )
topVarGenes
library(gplots)
library(RColorBrewer)
# heatmap.2( assay(rld)[ topVarGenes, ], scale="row",
           # trace="none", dendrogram="column",
           # col = colorRampPalette( rev(brewer.pal(9, "RdBu")) )(255))

heatmap.2(assay(rld)[topVarGenes, ], scale = "row",
          trace = "none", dendrogram = "column",
          col = colorRampPalette(rev(brewer.pal(9, "RdBu")))(255),
          margins = c(8, 8))

#############################################
#¤¤¤¤¤¤¤¤¤ Volcano Plot ¤¤¤¤¤¤¤¤¤
#############################################
result <- results(ddsHTSeq)
View(result)
library(ggplot2)

# Convert DESeqResults object to a data frame
result_df <- as.data.frame(result)

# Replace NA values in padj and log2FoldChange with appropriate values
result_df$padj <- ifelse(is.na(result_df$padj), 1, result_df$padj)
result_df$log2FoldChange <- ifelse(is.na(result_df$log2FoldChange), 0, result_df$log2FoldChange)

# Plot with ggplot using the converted data frame
ggplot(result_df, aes(x = log2FoldChange, y = -log10(padj))) +
  geom_point(alpha = 0.5) +
  xlab("log2 fold change") +
  ylab("-log10 adjusted p-value")





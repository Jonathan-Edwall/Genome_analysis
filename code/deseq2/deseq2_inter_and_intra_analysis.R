#if (!requireNamespace('BiocManager',quietly = TRUE)) 
#install.packages('BiocManager',force=TRUE)
library('BiocManager')
#BiocManager::install('DESeq2',force=TRUE) 
library('DESeq2')
#BiocManager::install("genefilter") # Used for finding genes with highest variances
#install.packages("gplots")
#install.packages("ggplot2")

getwd()
#setwd("C:/Users/jonat/GitHub/Genome_analysis/results/04_differential_expression/htseq/")
setwd("C:/Users/jonat/GitHub/Genome_analysis/results/04_differential_expression/htseq_exon/")

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

  
}


#############################################
#¤¤¤¤¤¤¤¤¤ Creating DESEQ2-object ¤¤¤¤¤¤¤¤¤
#############################################
directory = "C:/Users/jonat/GitHub/Genome_analysis/results/04_differential_expression/htseq_exon"
# List all files in the directory that match a specific pattern
sampleFiles_inter <- list.files(pattern = "aril")
print(sampleFiles_inter)
sampleFiles_inter

sampleFiles_intra <- list.files(pattern = "musang")
print(sampleFiles_intra)
sampleFiles_intra


samplecondition_inter <- c("MO_ARIL","MO_ARIL","MO_ARIL","MU_ARIL","MU_ARIL")
# samplecondition
samplename_inter <- c("MO_ARIL_1","MO_ARIL_2","MO_ARIL_3","MU_ARIL_2","MU_ARIL_3")
sampleFiles_inter


samplecondition_intra <- c("MU_ARIL","MU_ARIL","MU_LEAF","MU_ROOT","MU_STEM")
# samplecondition
samplename_intra <- c("MU_ARIL_2","MU_ARIL_3","MU_LEAF","MU_ROOT","MU_STEM")
sampleFiles_intra

#Creating DESEQ2-object
sampleTable_inter <- data.frame(sampleName=samplename_inter, fileName=sampleFiles_inter,condition=samplecondition_inter)
View(sampleTable_inter)

sampleTable_intra <- data.frame(sampleName=samplename_intra, fileName=sampleFiles_intra,condition=samplecondition_intra)
View(sampleTable_intra)

ddsHTSeq_inter <- DESeqDataSetFromHTSeqCount(sampleTable=sampleTable_inter,directory=directory,design =~ condition) # design = ~ 1 means that no covariates influence gene expression, only overall difference between conditions is of interest
ddsHTSeq_intra <- DESeqDataSetFromHTSeqCount(sampleTable=sampleTable_intra,directory=directory,design =~ condition)

#Perform the necessary transformations and normalization
#(estimates the size factors and dispersions for each gene)
ddsHTSeq_inter <- DESeq(ddsHTSeq_inter)
ddsHTSeq_intra <- DESeq(ddsHTSeq_intra)

#############################################
#¤¤¤¤¤¤¤¤¤ PCA plot ¤¤¤¤¤¤¤¤¤
#############################################

#Extract the regularized log-transformed (rlog) values from the DESeq2 object:
#The blind = FALSE argument prevents the blind dispersion estimation, which is desirable for PCA.
rld_inter <- rlog(ddsHTSeq_inter)
rld_intra <- rlog(ddsHTSeq_intra)

# Calculate the PCA:
plotPCA(rld_inter)
plotPCA(rld_intra)


#############################################
#¤¤¤¤¤¤¤¤¤ Heat map ¤¤¤¤¤¤¤¤¤
#############################################

library("genefilter")

topVarGenes_inter <- head( order( rowVars( assay(rld_inter) ), decreasing=TRUE ), 10 )
topVarGenes_inter

topVarGenes_intra <- head( order( rowVars( assay(rld_intra) ), decreasing=TRUE ), 10 )
topVarGenes_intra

library(gplots)
library(RColorBrewer)
# heatmap.2( assay(rld)[ topVarGenes, ], scale="row",
           # trace="none", dendrogram="column",
           # col = colorRampPalette( rev(brewer.pal(9, "RdBu")) )(255))

heatmap.2(assay(rld_inter)[topVarGenes_inter, ], scale = "row",
          trace = "none", dendrogram = "column",
          col = colorRampPalette(rev(brewer.pal(9, "RdBu")))(255),
          margins = c(10,10))

heatmap.2(assay(rld_intra)[topVarGenes_intra, ], scale = "row",
          trace = "none", dendrogram = "column",
          col = colorRampPalette(rev(brewer.pal(9, "RdBu")))(255),
          margins = c(10,10))
#############################################
#¤¤¤¤¤¤¤¤¤ Volcano Plot ¤¤¤¤¤¤¤¤¤
#############################################
result_inter <- results(ddsHTSeq_inter)
View(result_inter)

result_intra <- results(ddsHTSeq_intra)
View(result_intra)

library(ggplot2)

# Convert DESeqResults object to a data frame
result_df_inter <- as.data.frame(result_inter)

result_df_intra <- as.data.frame(result_intra)

# Replace NA values in padj and log2FoldChange with appropriate values
result_df_inter$padj <- ifelse(is.na(result_df_inter$padj), 1, result_df_inter$padj)
result_df_inter$log2FoldChange <- ifelse(is.na(result_df_inter$log2FoldChange), 0, result_df_inter$log2FoldChange)

result_df_intra$padj <- ifelse(is.na(result_df_intra$padj), 1, result_df_intra$padj)
result_df_intra$log2FoldChange <- ifelse(is.na(result_df_intra$log2FoldChange), 0, result_df_intra$log2FoldChange)


# Plot with ggplot using the converted data frame
ggplot(result_df_inter, aes(x = log2FoldChange, y = -log10(padj))) +
  geom_point(alpha = 0.5) +
  xlab("log2 fold change") +
  ylab("-log10 adjusted p-value")

ggplot(result_df_intra, aes(x = log2FoldChange, y = -log10(padj))) +
  geom_point(alpha = 0.5) +
  xlab("log2 fold change") +
  ylab("-log10 adjusted p-value")



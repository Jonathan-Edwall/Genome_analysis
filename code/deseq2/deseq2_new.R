#if (!requireNamespace('BiocManager',quietly = TRUE)) 
install.packages('BiocManager',force=TRUE)
library('BiocManager')
BiocManager::install('DESeq2',force=TRUE) 
library('DESeq2')




if (!requireNamespace('BiocManager',quietly = TRUE)) 
install.packages('BiocManager',force=TRUE)
BiocManager::install('DESeq2',version = '3.8',force=TRUE) 

library('BiocManager')
install.packages('GenomeInfoDbData')

BiocManager::install("GenomeInfoDbData",force=TRUE) 
BiocManager::install("GenomeInfoDb",force=TRUE)
library('DESeq2')
install.packages('RCurl',force=TRUE)

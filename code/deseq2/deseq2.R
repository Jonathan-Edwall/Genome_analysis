if (!requireNamespace('BiocManager',quietly = TRUE)) 
install.packages('BiocManager',force=TRUE)
BiocManager::install('DESeq2',version = '3.17') 

library('BiocManager')
install.packages('GenomeInfoDbData')

BiocManager::install(GenomeInfoDbData) 
library('DESeq2')

#!/bin/bash -l
#SBATCH -A uppmax2023-2-8 -M snowy # Specifying the project ID for Genome Analysis
#SBATCH -p core
#SBATCH -n 16
#SBATCH -t 00:30:00 # Unclear how long the job will take
#SBATCH -J Star_durian_diff_expression # Job_name
#SBATCH --mail-type=ALL
#SBATCH --mail-user jonathan.edwall.4996@student.uu.se

cat $0
echo USER = $USER
echo QOS = $SLURM_JOB_QOS


# Changing directory to working directory (output files will also be saved in this directory)
cd /proj/genomeanalysis2023/nobackup/work/jonathane/star_diff_expression/
#export $HOME/Genome_analysis_local_rep/results/03_genome_annotation/04_differential_expression/star_diff_expression

# Loading the modules
module load bioinfo-tools star
module load bioinfo-tools samtools
mkdir /proj/genomeanalysis2023/nobackup/work/jonathane/star_diff_expression/star_genome_index_dir/


masked_assembly_dir=$HOME/Genome_analysis_local_rep/results/03_genome_annotation/repeatmasker_softmasked/
genome_index_dir=/proj/genomeanalysis2023/nobackup/work/jonathane/star_diff_expression/star_genome_index_dir/

trimmed_cDNA_dir=$HOME/Genome_analysis_local_rep/results/01_preprocessing/trimmomatic_star/
pre_trimmed_cDNA_dir=$HOME/Genome_analysis_local_rep/data/raw_external_data/transcriptomic_data/trimmed/


 

#1: Generating genome indices
STAR \
--genomeFastaFiles $masked_assembly_dir/pilon_assembly_improvement.fasta.masked \
--genomeDir $genome_index_dir \
--runMode genomeGenerate \
--genomeSAindexNbases 11

##########################################
#### Monthong cultivar
##########################################

#2: Monthong: Aril 1
# Mapping the RNA (cDNA) to the masked assembly
STAR \
--runThreadN 16 \
--genomeDir $genome_index_dir/ \
--readFilesIn $pre_trimmed_cDNA_dir/SRR6156069_scaffold_10*fastq.gz \
--readFilesCommand zcat \
--outFileNamePrefix ./monthong_aril_1_ \
--outSAMtype BAM SortedByCoordinate 

samtools index monthong_aril_1_Aligned.sortedByCoord.out.bam monthong_aril_1_Aligned.sortedByCoord.out.bai

#3: Monthong: Aril 2
# Mapping the RNA (cDNA) to the masked assembly
STAR \
--runThreadN 16 \
--genomeDir $genome_index_dir/ \
--readFilesIn $pre_trimmed_cDNA_dir/SRR6156066_scaffold_10*fastq.gz \
--readFilesCommand zcat \
--outFileNamePrefix ./monthong_aril_2_ \
--outSAMtype BAM SortedByCoordinate 

samtools index monthong_aril_2_Aligned.sortedByCoord.out.bam monthong_aril_2_Aligned.sortedByCoord.out.bai

#4: Monthong: Aril 3
# Mapping the RNA (cDNA) to the masked assembly
STAR \
--runThreadN 16 \
--genomeDir $genome_index_dir/ \
--readFilesIn $pre_trimmed_cDNA_dir/SRR6156067_scaffold_10*fastq.gz \
--readFilesCommand zcat \
--outFileNamePrefix ./monthong_aril_3_ \
--outSAMtype BAM SortedByCoordinate 

samtools index monthong_aril_3_Aligned.sortedByCoord.out.bam monthong_aril_3_Aligned.sortedByCoord.out.bai


##########################################
#### Musang king cultivar
##########################################

#5: Musang king: Leaf
# Mapping the RNA (cDNA) to the masked assembly
STAR \
--runThreadN 16 \
--genomeDir $genome_index_dir/ \
--readFilesIn $pre_trimmed_cDNA_dir/SRR6040092_scaffold_10*fastq.gz \
--readFilesCommand zcat \
--outFileNamePrefix ./musang_king_leaf_ \
--outSAMtype BAM SortedByCoordinate 

samtools index musang_king_leaf_Aligned.sortedByCoord.out.bam musang_king_leaf_Aligned.sortedByCoord.out.bai

#6: Musang King: Root
# Mapping the RNA (cDNA) to the masked assembly
STAR \
--runThreadN 16 \
--genomeDir $genome_index_dir/ \
--readFilesIn $pre_trimmed_cDNA_dir/SRR6040093_scaffold_10*fastq.gz \
--readFilesCommand zcat \
--outFileNamePrefix ./musang_king_root_ \
--outSAMtype BAM SortedByCoordinate \

samtools index musang_king_root_Aligned.sortedByCoord.out.bam musang_king_root_Aligned.sortedByCoord.out.bai

#7: Musang King: Stem
# Mapping the RNA (cDNA) to the masked assembly
STAR \
--runThreadN 16 \
--genomeDir $genome_index_dir/ \
--readFilesIn $pre_trimmed_cDNA_dir/SRR6040096_scaffold_10*fastq.gz \
--readFilesCommand zcat \
--outFileNamePrefix ./musang_king_stem_ \
--outSAMtype BAM SortedByCoordinate 

samtools index musang_king_stem_Aligned.sortedByCoord.out.bam musang_king_stem_Aligned.sortedByCoord.out.bai

#8:   Musang King: Aril 1
# Mapping the RNA (cDNA) to the masked assembly
STAR \
--runThreadN 16 \
--limitBAMsortRAM 2292618942 \
--genomeDir $genome_index_dir/ \
--readFilesIn $trimmed_cDNA_dir/illumina_cDNA_trimmed_*P.fq.gz \
--readFilesCommand zcat \
--outFileNamePrefix ./musang_king_aril_1_ \
--outSAMtype BAM SortedByCoordinate 

samtools index musang_king_aril_1_Aligned.sortedByCoord.out.bam musang_king_aril_1_Aligned.sortedByCoord.out.bai

#9: Musang King: Musang King: Aril 2
# Mapping the RNA (cDNA) to the masked assembly
STAR \
--runThreadN 16 \
--limitBAMsortRAM 2292618942 \
--genomeDir $genome_index_dir/ \
--readFilesIn $pre_trimmed_cDNA_dir/SRR6040094_scaffold_10*fastq.gz \
--readFilesCommand zcat \
--outFileNamePrefix ./musang_king_aril_2_ \
--outSAMtype BAM SortedByCoordinate 

samtools index musang_king_aril_2_Aligned.sortedByCoord.out.bam musang_king_aril_2_Aligned.sortedByCoord.out.bai

#10: Musang King: Musang King: Aril 3
# Mapping the RNA (cDNA) to the masked assembly
STAR \
--runThreadN 16 \
--limitBAMsortRAM 2292618942 \
--genomeDir $genome_index_dir/ \
--readFilesIn $pre_trimmed_cDNA_dir/SRR6040097_scaffold_10*fastq.gz \
--readFilesCommand zcat \
--outFileNamePrefix ./musang_king_aril_3_ \
--outSAMtype BAM SortedByCoordinate 

samtools index musang_king_aril_3_Aligned.sortedByCoord.out.bam musang_king_aril_3_Aligned.sortedByCoord.out.bai



ls -l # Checking if outputs was generated
module list # Useful for keeping track of the versions used
echo JOB = $SLURM_JOBID # makes the individual runs easier to identify


#!/bin/bash -l
#SBATCH -A uppmax2023-2-8 -M snowy # Specifying the project ID for Genome Analysis
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 00:15:00 --qos=short # Should be about 15 minute job?
#SBATCH -J Star_durian_softmasked # Job_name
#SBATCH --mail-type=ALL
#SBATCH --mail-user jonathan.edwall.4996@student.uu.se

cat $0
echo USER = $USER
echo QOS = $SLURM_JOB_QOS

export $HOME/joed4996/Genome_analysis_local_rep/results/03_genome_annotation/star_softmasked


masked_assembly_dir=$HOME/Genome_analysis_local_rep/results/03_genome_annotation/repeatmasker_softmasked
genome_index_dir=$HOME/Genome_analysis_local_rep/results/03_genome_annotation/star_softmasked_genome_index_dir
trimmed_cDNA_dir=$HOME/Genome_analysis_local_rep/results/01_preprocessing/trimmomatic_star

# Loading the modules
module load bioinfo-tools star



#1: Generating genome indices
STAR \
--genomeFastaFiles $masked_assembly_dir/pilon_assembly_improvement.fasta.masked \
--genomeDir $genome_index_dir \
--runMode genomeGenerate


#2: Mapping the RNA (cDNA) to the masked assembly
STAR \
--runThreadN 8 \
--genomeDir $genome_index_dir/ \
--readFilesIn $trimmed_cDNA_dir/illumina_cDNA_trimmed_*P.fq.gz \
--readFilesCommand zcat \
--outSAMtype BAM Unsorted SortedByCoordinate 




ls -l # Checking if outputs was generated

module list # Useful for keeping track of the versions used


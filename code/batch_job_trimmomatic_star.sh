#!/bin/bash -l
#SBATCH -A uppmax2023-2-8 -M snowy # Specifying the project ID for Genome Analysis
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:15:00 # 15 minute job?
#SBATCH -J trimmomatic_star # Job_name
#SBATCH --mail-type=ALL
#SBATCH --mail-user jonathan.edwall.4996@student.uu.se

cat $0
echo USER = $USER
echo QOS = $SLURM_JOB_QOS

# Loading the modules
module load bioinfo-tools trimmomatic

#Changing the working directory
Rna_untrimmed_reads_dir=$HOME/Genome_analysis_local_rep/data/raw_external_data/transcriptomic_data/untrimmed

export SRC_DIR=$HOME/Genome_analysis_local_rep/results/01_preprocessing/trimmomatic_star


# cd /home/joed4996/Genome_analysis_local_rep/data/raw_external_data/genomic_data/illumina_data
java -jar $TRIMMOMATIC_ROOT/trimmomatic.jar PE \
$Rna_untrimmed_reads_dir/SRR6040095_scaffold_10*fastq.gz \
-baseout illumina_cDNA_trimmed.fq.gz \
LEADING:3 \
TRAILING:3 \
SLIDINGWINDOW:4:15 \
MINLEN:36 \
\



#SNIC_TMP # Changing working directory to node-local storage

ls -l # Checking if outputs was generated

module list # Useful for keeping track of the versions used
echo JOB = $SLURM_JOBID # makes the individual runs easier to identify

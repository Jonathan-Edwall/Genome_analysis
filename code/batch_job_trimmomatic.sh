#!/bin/bash -l
#SBATCH -A uppmax2023-2-8 -M snowy # Specifying the project ID for Genome Analysis
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00 # 1 hour job?
#SBATCH -J trimmomatic # Job_name
#SBATCH --mail-type=ALL
#SBATCH --mail-user jonathan.edwall.4996@student.uu.se

cat $0
echo USER = $USER
echo QOS = $SLURM_JOB_QOS

# Loading the modules
module load bioinfo-tools trimmomatic

#Changing the working directory


# cd /home/joed4996/Genome_analysis_local_rep/data/raw_external_data/genomic_data/illumina_data
java -jar $TRIMMOMATIC_ROOT/trimmomatic.jar PE \
/home/joed4996/Genome_analysis_local_rep/data/raw_external_data/genomic_data/illumina_data/SRR6058604_scaffold_10.1P.fastq.gz \
/home/joed4996/Genome_analysis_local_rep/data/raw_external_data/genomic_data/illumina_data/SRR6058604_scaffold_10.2P.fastq.gz \
-baseout illumina_trimmed.fq.gz \
LEADING:3 \
TRAILING:3 \
SLIDINGWINDOW:4:15 \
MINLEN:36 \
\

#SNIC_TMP # Changing working directory to node-local storage

ls -l # Checking if outputs was generated

module list # Useful for keeping track of the versions used
echo JOB = $SLURM_JOBID # makes the individual runs easier to identify

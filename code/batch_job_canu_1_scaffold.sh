#!/bin/bash -l
#SBATCH -A uppmax2023-2-8 -M snowy # Specifying the project ID for Genome Analysis
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 18:00:00 # 17 hour job?
#SBATCH -J Canu_pac_bio_Durian_zibethinus_10 # Job_name
#SBATCH --mail-type=ALL
#SBATCH --mail-user jonathan.edwall.4996@student.uu.se

cat $0
echo USER = $USER
echo QOS = $SLURM_JOB_QOS

# Loading the modules
module load bioinfo-tools canu/2.0

#Changing the working directory

cd /home/joed4996/Genome_analysis_local_rep/data/raw_external_data/genomic_data/pacbio_data

canu \
-p canu_assembly \
-d /home/joed4996/Genome_analysis_local_rep/results/02_genome_assembly/canu \
genomeSize=24.2m \
-pacbio SRR6037732_scaffold_10.fq.gz \
useGrid=false corMaxEvidenceErate=0.15

#SNIC_TMP # Changing working directory to node-local storage

ls -l # Checking if outputs was generated

module list # Useful for keeping track of the versions used
echo JOB = $SLURM_JOBID # makes the individual runs easier to identify

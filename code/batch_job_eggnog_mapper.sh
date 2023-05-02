#!/bin/bash -l
#SBATCH -A uppmax2023-2-8 -M snowy # Specifying the project ID for Genome Analysis
#SBATCH -p core
#SBATCH -n 10
#SBATCH -t 01:00:00  # No idea about the length of this job!
#SBATCH -J eggNOG-mapper_durian # Job_name
#SBATCH --mail-type=ALL
#SBATCH --mail-user jonathan.edwall.4996@student.uu.se

cat $0
echo USER = $USER
echo QOS = $SLURM_JOB_QOS


#export SRC_DIR=$HOME/Genome_analysis_local_rep/results/03_genome_annotation/eggNOG_mapper



protein_fasta_file_dir=$HOME/Genome_analysis_local_rep/results/03_genome_annotation/braker_softmasked


# Loading the modules
module load bioinfo-tools eggNOG-mapper

# Running the program
emapper.py \
-i $protein_fasta_file_dir/test_get_Anno_Fasta.aa \
--output durian_genome \
--output_dir $HOME/Genome_analysis_local_rep/results/03_genome_annotation/eggNOG_mapper \
--cpu 10 \

#--output gives file prefix for the output files
# diamond blastp search is performed


ls -l # Checking if outputs was generated

module list # Useful for keeping track of the versions used
echo JOB = $SLURM_JOBID # makes the individual runs easier to identify



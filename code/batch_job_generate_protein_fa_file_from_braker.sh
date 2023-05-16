#!/bin/bash -l
#SBATCH -A uppmax2023-2-8 -M snowy # Specifying the project ID for Genome Analysis
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:15:00 --qos=short  # This is a quick job
#SBATCH -J Braker_durian # Job_name
#SBATCH --mail-type=ALL
#SBATCH --mail-user jonathan.edwall.4996@student.uu.se

cat $0
echo USER = $USER
echo QOS = $SLURM_JOB_QOS


# Changing working directory to the same as the braker output 
cd $HOME/Genome_analysis_local_rep/results/03_genome_annotation/braker_softmasked/


# Loading modules to run getAnnoFastaFromJoingenes.py, from which we will get an protein-fasta file & coding sequence, from the AUGUSTUS gene prediction
module load bioinfo-tools
module load braker
module load biopython/1.80-py3.10.8


#getAnnoFastaFromJoingenes.py -g genome.fa -f augustus.hints.gtf -o test_get_Anno_Fasta
getAnnoFastaFromJoingenes.py -g genome.fa -f GeneMark-ET/genemark.gtf -o get_Anno_Fasta




ls -l # Checking if outputs was generated

module list # Useful for keeping track of the versions used
echo JOB = $SLURM_JOBID # makes the individual runs easier to identify



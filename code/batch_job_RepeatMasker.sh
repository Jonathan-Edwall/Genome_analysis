#!/bin/bash -l
#SBATCH -A uppmax2023-2-8 -M snowy # Specifying the project ID for Genome Analysis
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00 # Should be about 30 minute job?
#SBATCH -J RepeatMasker_durian # Job_name
#SBATCH --mail-type=ALL
#SBATCH --mail-user jonathan.edwall.4996@student.uu.se

cat $0
echo USER = $USER
echo QOS = $SLURM_JOB_QOS


cd /home/joed4996/Genome_analysis_local_rep/results/03_genome_annotation/repeatmasker
assembly_dir=$HOME/Genome_analysis_local_rep/results/02_genome_assembly/pilon

# Loading the modules
module load bioinfo-tools RepeatMasker


RepeatMasker -species Durio zibethinus $assembly_dir/pilon_assembly_improvement.fasta



ls -l # Checking if outputs was generated

module list # Useful for keeping track of the versions used
echo JOB = $SLURM_JOBID # makes the individual runs easier to identify

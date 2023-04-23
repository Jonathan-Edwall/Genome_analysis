#!/bin/bash -l
#SBATCH -A uppmax2023-2-8 -M snowy # Specifying the project ID for Genome Analysis
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00 # Should be about 30 minute job?
#SBATCH -J Pilon_durian # Job_name
#SBATCH --mail-type=ALL
#SBATCH --mail-user jonathan.edwall.4996@student.uu.se

cat $0
echo USER = $USER
echo QOS = $SLURM_JOB_QOS


#cd $HOME
# Loading the modules
module load bioinfo-tools Pilon/1.24

bwa_dir=$HOME/Genome_analysis_local_rep/results/02_genome_assembly/bwa/
assembly_dir=/domus/h1/joed4996/Genome_analysis_local_rep/results/02_genome_assembly/canu/


Result_dir=$HOME/Genome_analysis_local_rep/results/02_genome_assembly/pilon # Results will be in this directory

java -jar $PILON_HOME/pilon.jar \
--genome $assembly_dir/canu_assembly.contigs.fasta \
--bam $bwa_dir/bwa_hybrid_aligned_sorted.bam \
--threads 2 \
--output pilon_assembly_improvement \
--outdir $Result_dir

#java -jar $PILON_HOME/pilon.jar \ 
#--genome $assembly_dir/canu_assembly.contigs.fasta \
#--bam $bwa_dir/bwa_hybrid_aligned_sorted.bam \
#--threads 2 \
#--output pilon_assembly_improvement \
#--outdir $Result_dir






ls -l # Checking if outputs was generated

module list # Useful for keeping track of the versions used
echo JOB = $SLURM_JOBID # makes the individual runs easier to identify

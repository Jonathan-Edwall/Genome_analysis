#!/bin/bash -l
#SBATCH -A uppmax2023-2-8 -M snowy # Specifying the project ID for Genome Analysis
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00 # Should be less than 15 minute job?
#SBATCH -J Quast_durian_pilon_with_reference # Job_name
#SBATCH --mail-type=ALL
#SBATCH --mail-user jonathan.edwall.4996@student.uu.se

cat $0
echo USER = $USER
echo QOS = $SLURM_JOB_QOS


cd $HOME
# Loading the modules
module load bioinfo-tools quast

#bwa_dir=$HOME/Genome_analysis_local_rep/results/02_genome_assembly/bwa/
reference_dir=$HOME/Genome_analysis_local_rep/data/reference_assembly
canu_assembly_dir=/domus/h1/joed4996/Genome_analysis_local_rep/results/02_genome_assembly/canu
pilon_assembly_dir=/domus/h1/joed4996/Genome_analysis_local_rep/results/02_genome_assembly/pilon


Result_dir=$HOME/Genome_analysis_local_rep/results/02_genome_assembly/quast_with_reference # Results will be in this directory


quast.py -t 2 \
-r $reference_dir/GCF_002303985.1_Duzib1.0_genomic.fna.gz \
--output-dir $Result_dir  \
$pilon_assembly_dir/pilon_assembly_improvement.fasta
#$canu_assembly_dir/canu_assembly.contigs.fasta \


# --est-ref-size 24200000 ==> Estimated reference size of 24.2 Mb (for computing NGx metrics without a reference)

#java -jar $PILON_HOME/pilon.jar \ 
#--genome $assembly_dir/canu_assembly.contigs.fasta \
#--bam $bwa_dir/bwa_hybrid_aligned_sorted.bam \
#--threads 2 \
#--output pilon_assembly_improvement \
#--outdir $Result_dir






ls -l # Checking if outputs was generated

module list # Useful for keeping track of the versions used
echo JOB = $SLURM_JOBID # makes the individual runs easier to identify

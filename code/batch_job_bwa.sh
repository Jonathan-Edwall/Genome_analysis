#!/bin/bash -l
#SBATCH -A uppmax2023-2-8 -M snowy # Specifying the project ID for Genome Analysis
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 02:00:00 # Should be about 1 hour job?
#SBATCH -J BWA_durian # Job_name
#SBATCH --mail-type=ALL
#SBATCH --mail-user jonathan.edwall.4996@student.uu.se

cat $0
echo USER = $USER
echo QOS = $SLURM_JOB_QOS

# Loading the modules
module load bioinfo-tools bwa
module load bioinfo-tools samtools


trimmed_short_reads_dir=$HOME/Genome_analysis_local_rep/results/01_preprocessing/trimmomatic/
# Assign the file path of the canu assembled genome to a variable
#assembly_contig="/domus/h1/joed4996/Genome_analysis_local_rep/results/02_genome_assembly/canu/canu_assembly.contigs.fasta"
assembly_contig_dir=/domus/h1/joed4996/Genome_analysis_local_rep/results/02_genome_assembly/canu/
#assembly_contig_dir= $HOME/Genome_analysis_local_rep/results/02_genome_assembly/canu/


cd /home/joed4996/Genome_analysis_local_rep/results/02_genome_assembly/bwa # Results will be in this directory
# "-a is" is added to deal with a short genome (25kb chromsome), which is smaller than 2gb

#cp /home/joed4996/Big_Data_in_Life_Sciences/lab_1/uppmax/test2/* $SNIC_TMP/  # Copying the files to node-local storage


#gunzip ref.fa.gz
# Changing directory to node-local storage, suitable for temporary files that can be deleted when the job finishes
#cd $TMPDIR



# 1: Using find to find files matching the wildcard pattern 2: Gunzipping the illumina reads
# "-type l" means that "the files are symbolic link"
#find . -name "/home/joed4996/Genome_analysis_local_rep/results/01_preprocessing/trimmomatic/illumina_trimmed*P.fq.gz" -type f -exec gunzip {} +
#find . -name "/domus/h1/joed4996/Genome_analysis_local_rep/results/01_preprocessing/trimmomatic/illumina_trimmed*P.fq.gz" -type f -exec gunzip {} +


#ls -l # Checking if outputs was generated

#gunzip illumina_trimmed*P.fq.gz




# Use the variable in subsequent commands
echo "The assembly contig file is: $assembly_contig"
# Assigning index to the assembly contig
# "-a is" is added to deal with a short genome (25kb chromsome), which is smaller than 2gb
#bwa index $assembly_contig 
bwa index $assembly_contig_dir/canu_assembly.contigs.fasta

# Aligning the files matched with the wildcard illumina_trimmed*P.fq.gz
bwa mem $assembly_contig_dir/canu_assembly.contigs.fasta $trimmed_short_reads_dir/illumina_trimmed*P.fq.gz \
-t 2 \
| samtools sort -O bam -> bwa_hybrid_aligned_sorted.bam

samtools index bwa_hybrid_aligned_sorted.bam bwa_hybrid_aligned_sorted.bai

# -t = 2 threads used
# Samtools sort -@ 2 => sorting and compression threads
# Samtools sort -O bam => outputformat is BAM

#-- output /home/joed4996/Genome_analysis_local_rep/results/02_genome_assembly/bwa


#$SNIC_TMP/sample.bam

ls -l # Checking if outputs was generated

module list # Useful for keeping track of the versions used
echo JOB = $SLURM_JOBID # makes the individual runs easier to identify

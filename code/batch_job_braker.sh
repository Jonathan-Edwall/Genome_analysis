#!/bin/bash -l
#SBATCH -A uppmax2023-2-8 -M snowy # Specifying the project ID for Genome Analysis
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 10:00:00  # No idea about the length of this job!
#SBATCH -J Braker_durian # Job_name
#SBATCH --mail-type=ALL
#SBATCH --mail-user jonathan.edwall.4996@student.uu.se

cat $0
echo USER = $USER
echo QOS = $SLURM_JOB_QOS


#export SRC_DIR=$HOME/Genome_analysis_local_rep/results/03_genome_annotation/braker
export SRC_DIR=$HOME/Genome_analysis_local_rep/results/03_genome_annotation/braker_softmasked



masked_assembly_dir=$HOME/Genome_analysis_local_rep/results/03_genome_annotation/repeatmasker_softmasked
rna_mapped_dir=$HOME/Genome_analysis_local_rep/results/03_genome_annotation/star_softmasked



#genome_index_dir=$HOME/Genome_analysis_local_rep/results/03_genome_annotation/star_01_genome_index_dir
#trimmed_cDNA_dir=$HOME/Genome_analysis_local_rep/results/01_preprocessing/trimmomatic_star

# Loading the modules
module load bioinfo-tools
module load braker/2.1.1_Perl5.24.1
module load augustus/3.2.3_Perl5.24.1
module load bamtools/2.5.1
module load blast/2.9.0+
module load GenomeThreader/1.7.0
module load samtools/1.8
module load GeneMark/4.33-es_Perl5.24.1

# Loading modules to run getAnnoFastaFromJoingenes.py, to get an coding sequence & protein-fasta files from AUGUSTUS gene predictions
module load biopython/1.80-py3.10.8



braker.pl \
--useexisting \
--workingdir=$HOME/Genome_analysis_local_rep/results/03_genome_annotation/braker_softmasked/ \
--AUGUSTUS_CONFIG_PATH=$HOME/Genome_analysis_local_rep/results/03_genome_annotation/braker_softmasked/augustus_config/ \
--AUGUSTUS_BIN_PATH=/sw/bioinfo/augustus/3.4.0/snowy/bin/ \
--AUGUSTUS_SCRIPTS_PATH=/sw/bioinfo/augustus/3.4.0/snowy/scripts/ \
--GENEMARK_PATH=/sw/bioinfo/GeneMark/4.33-es/snowy/ \
--softmasking \
--cores=8 \
--genome=$masked_assembly_dir/pilon_assembly_improvement.fasta.masked \
--bam=$rna_mapped_dir/RNAseq_aligned.out.bam \

#--species= Durio zibethinus
#--geneMarkGtf=<geneMark_output.gtf> \

#if the genome is masked, use the --softmasking flag of braker.
#Species needs to be updated with --useexisting flag once the new species file is created.


ls -l # Checking if outputs was generated

module list # Useful for keeping track of the versions used
echo JOB = $SLURM_JOBID # makes the individual runs easier to identify



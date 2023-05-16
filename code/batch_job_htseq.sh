#!/bin/bash -l
#SBATCH -A uppmax2023-2-8 -M snowy # Specifying the project ID for Genome Analysis
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 03:00:00  # Unclear how long the job will take
#SBATCH -J htseq_exon_durian # Job_name
#SBATCH --mail-type=ALL
#SBATCH --mail-user jonathan.edwall.4996@student.uu.se

cat $0
echo USER = $USER
echo QOS = $SLURM_JOB_QOS


# Changing directory to working directory (output files will also be saved in this directory)
cd /proj/genomeanalysis2023/nobackup/work/jonathane/htseq/

#export $HOME/Genome_analysis_local_rep/results/04_differential_expression/htseq

# Loading the modules
module load bioinfo-tools htseq

#samtools index monthong_aril_1Aligned.sortedByCoord.out.bam monthong_aril_1Aligned.sortedByCoord.out.bai




mapped_rna_dir=/proj/genomeanalysis2023/nobackup/work/jonathane/star_diff_expression

#gene_feature_file_dir=$HOME/Genome_analysis_local_rep/results/03_genome_annotation/braker_softmasked
gene_feature_file_dir=$HOME/Genome_analysis_local_rep/results/03_genome_annotation/braker_softmasked/GeneMark-ET


#htseq-count [options ] \ <alignment_files> \ <gff_file>

##########################################
#### Monthong cultivar
##########################################


#1: Monthong: Aril 1
# Mapping the RNA (cDNA) to the masked assembly
htseq-count --format bam --order pos --stranded no --nonunique none --type exon --idattr gene_id \
$mapped_rna_dir/monthong_aril_1_*.sortedByCoord.out.bam \
$gene_feature_file_dir/genemark.gtf \
> monthong_aril_1_counts.txt


#2: Monthong: Aril 2
# Mapping the RNA (cDNA) to the masked assembly
htseq-count --format bam --order pos --stranded no --nonunique none --type exon --idattr gene_id \
$mapped_rna_dir/monthong_aril_2_*.sortedByCoord.out.bam \
$gene_feature_file_dir/genemark.gtf \
> monthong_aril_2_counts.txt
 

#3: Monthong: Aril 3
# Mapping the RNA (cDNA) to the masked assembly
htseq-count --format bam --order pos --stranded no --nonunique none --type exon --idattr gene_id \
$mapped_rna_dir/monthong_aril_3_*.sortedByCoord.out.bam \
$gene_feature_file_dir/genemark.gtf \
> monthong_aril_3_counts.txt

##########################################
#### Musang king cultivar
##########################################

#4: Musang king: Leaf
# Mapping the RNA (cDNA) to the masked assembly
htseq-count --format bam --order pos --stranded no --nonunique none --type exon --idattr gene_id \
$mapped_rna_dir/musang_king_leaf_*.sortedByCoord.out.bam \
$gene_feature_file_dir/genemark.gtf \
> musang_king_leaf_counts.txt


#5: Musang King: Root
# Mapping the RNA (cDNA) to the masked assembly
htseq-count --format bam --order pos --stranded no --nonunique none --type exon --idattr gene_id \
$mapped_rna_dir/musang_king_root_*.sortedByCoord.out.bam \
$gene_feature_file_dir/genemark.gtf \
> musang_king_root_counts.txt


#6: Musang King: Stem
# Mapping the RNA (cDNA) to the masked assembly
htseq-count --format bam --order pos --stranded no --nonunique none --type exon --idattr gene_id \
$mapped_rna_dir/musang_king_stem_*.sortedByCoord.out.bam \
$gene_feature_file_dir/genemark.gtf \
> musang_king_stem_counts.txt


#7:   Musang King: Aril 1
# Mapping the RNA (cDNA) to the masked assembly
htseq-count --format bam --order pos --stranded no --nonunique none --type exon --idattr gene_id \
$mapped_rna_dir/musang_king_aril_1_*.sortedByCoord.out.bam \
$gene_feature_file_dir/genemark.gtf \
> musang_king_aril_1_counts.txt


#8: Musang King: Musang King: Aril 2
# Mapping the RNA (cDNA) to the masked assembly
htseq-count --format bam --order pos --stranded no --nonunique none --type exon --idattr gene_id \
$mapped_rna_dir/musang_king_aril_2_*.sortedByCoord.out.bam \
$gene_feature_file_dir/genemark.gtf \
> musang_king_aril_2_counts.txt

#9: Musang King: Musang King: Aril 3
# Mapping the RNA (cDNA) to the masked assembly
htseq-count --format bam --order pos --stranded no --nonunique none --type exon --idattr gene_id \
$mapped_rna_dir/musang_king_aril_3_*.sortedByCoord.out.bam \
$gene_feature_file_dir/genemark.gtf \
> musang_king_aril_3_counts.txt





ls -l # Checking if outputs was generated
module list # Useful for keeping track of the versions used
echo JOB = $SLURM_JOBID # makes the individual runs easier to identify


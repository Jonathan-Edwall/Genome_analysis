# Open the text file for reading


def symbolic_link_generator_fun(txt_file,path_original_file,path_symbolic_link):
    with open(txt_file, 'r') as inputfile:
        output_file = "symbolic_links_for_" + txt_file.split(".")[0]+"script.sh" 
        with open(output_file,"w") as outfile:
                outfile.truncate()
                outfile.write("#!/bin/bash")
                outfile.write("\n")
                # Loop through each line in the file
                for line in inputfile:
                    outfile.write("ln -s "+path_original_file+line.strip()+" "+path_symbolic_link+line.strip())
                    outfile.write("\n")
                    # Printing the command to create the symbolic link
                    # print("ln -s"+path_original_file+line.strip()+" "+path_symbolic_link+line.strip())
    print(f"*** Done! *** ")
    print(f"*To execute the generated script in the command line, type:\n$ source {output_file}")

# original_file_path = "/proj/genomeanalysis2023/Genome_Analysis/4_Tean_Teh_2017/pacbio_data/"
# symbolic_link_path = "/home/joed4996/Genome_analysis_local_rep/data/raw_external_data/genomic_data/pacbio_data/"
# input_file = "Pacbio_genomic_data.txt"
# symbolic_link_generator_fun(input_file,original_file_path,symbolic_link_path)


# original_file_path = "/proj/genomeanalysis2023/Genome_Analysis/4_Tean_Teh_2017/illumina_data/"
# symbolic_link_path = "/home/joed4996/Genome_analysis_local_rep/data/raw_external_data/genomic_data/illumina_data/"
# input_file = "Illumina_genomic_data.txt"
# symbolic_link_generator_fun(input_file,original_file_path,symbolic_link_path)




# original_file_path = "/proj/genomeanalysis2023/Genome_Analysis/4_Tean_Teh_2017/transcriptome/trimmed/"
# symbolic_link_path = "/home/joed4996/Genome_analysis_local_rep/data/raw_external_data/transcriptomic_data/trimmed/"
# input_file = "trimmed_transcriptomic_data.txt"
# symbolic_link_generator_fun(input_file,original_file_path,symbolic_link_path)

original_file_path = "/proj/genomeanalysis2023/Genome_Analysis/4_Tean_Teh_2017/transcriptome/untrimmed/"
symbolic_link_path = "/home/joed4996/Genome_analysis_local_rep/data/transcriptomic_data/untrimmed/"
input_file = "untrimmed_transcriptomic_data.txt"
symbolic_link_generator_fun(input_file,original_file_path,symbolic_link_path)


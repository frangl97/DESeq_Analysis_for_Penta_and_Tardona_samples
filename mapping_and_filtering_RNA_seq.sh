#!/bin/bash
#
#SBATCH --chdir=/home/alumno11/LABORATORIO/RNA_SEQ_Penta_y_Tardona/
#SBATCH -p eck-q
#SBATCH --cpus-per-task=2
#SBATCH -J mapping_penta_a_1


GENOME_FOLDER="/home/alumno11/LABORATORIO/RNA_SEQ_Penta_y_Tardona"
GENOME="/home/alumno11/LABORATORIO/RNA_SEQ_Penta_y_Tardona/Reference_genome/pdulcis26.chromosomes.fasta"
FILE_FOLDERS="/home/alumno11/LABORATORIO/RNA_SEQ_Penta_y_Tardona/Files_samples"

# Create the index of the genome
hisat2-build ${GENOME} ${GENOME_FOLDER}/texas_genome

# For each sample, we do the alignment and the filtering

for folder in ${FILE_FOLDERS}/* ; do
  # The folder name is the name of the sample
  sample=$(echo "$folder" | cut -d"/" -f 7)
  echo "El nombre de la carpeta es: $folder"
  # Do the alignment
  hisat2 -p 4 -x ${GENOME_FOLDER}/texas_genome -1 ${folder}/*1.fastq.gz -2 ${folder}/*2.fastq.gz -S mapping_${sample}.sam

  # Filter the SAM file and obtain the BAM, and sorter it
  samtools view -bS mapping_${sample}.sam | samtools view -b -q 30 - | samtools sort -o mapping_${sample}_sorted_filtered.bam
  rm mapping_${sample}.sam
  mv mapping_${sample}_sorted_filtered.bam ${folder}/
done

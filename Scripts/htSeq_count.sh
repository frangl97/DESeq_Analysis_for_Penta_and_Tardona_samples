#!/bin/bash
#
#SBATCH --chdir=/home/alumno11/LABORATORIO/RNA_SEQ_Penta_y_Tardona/
#SBATCH -p eck-q
#SBATCH --nodes=1
#SBATCH --cpus-per-task=2
#SBATCH -J Fran_covid

ANOTACION="/home/alumno11/LABORATORIO/RNA_SEQ_Penta_y_Tardona/Prudul26A.chromosomes.gff3"
FILE_FOLDERS="/home/alumno11/LABORATORIO/RNA_SEQ_Penta_y_Tardona/Files_samples"

# For each sample, we do the the counting using the bam file obtained from the mapping and filtering process and the annotation file of the genome

for folder in ${FILE_FOLDERS}/* ; do
  # The folder name is the name of the sample
  sample=$(echo "$folder" | cut -d"/" -f 7)
  BAM_FILE=${folder}/*.bam
  echo "The counting process for $BAM_FILE has started"
  htseq-count -s no -r pos -f bam --type=gene --mode=union --idattr=ID ${BAM_FILE} ${ANOTACION} > htseq-count_on_${sample}_gene_counts.tabular
  mv htseq-count_on_${sample}_gene_counts.tabular ${folder}/
  echo "The counting process for $BAM_FILE has ended"
done

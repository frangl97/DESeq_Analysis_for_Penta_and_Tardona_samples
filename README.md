# DESeq_Analysis_for_Penta_and_Tardona_samples

Previous RNA-Seq data from the BioProject PRJNA610711 (Prudencio et al., 2021) was used to identify genes related to the dormancy release, using for this study the P. dulcis cv. ‘Texas’ genome (used in the almond AxiomTM 60K array) and open source software. Two different almond cultivars with nonidentical blooming date: ‘Penta’ (extra-late flowering) and ‘Tardona’ (ultra-late flowering) and two different phenological states: ‘Stage A’ (ecodormant flower buds) and ‘Stage AB’ (when each cultivar had achieved at least 40% of their CRs) were selected. Three replicates for each cultivar and phenological state were used (with the exception of the ‘Penta’ A sample, where only two replicates were available). Each replicate has two SRA files as they were sequenced using paired-ends reads (Prudencio et al., 2021).

## Mapping of the fastq reads to the Texas genome and filtering the mapping results

For each replicate, the paired-ends were mapped into the reference genome of cultivar “Texas” v.2.0 (Alioto et al., 2020) by HISAT2 v.2.2.1 (Kim et al., 2019). After that, Bam files were filtered by minimum length of 35 pb and minimum phred-score value of 30 using Samtools v.13 software (Li et al., 2009). The mapping and filtering process were performed using the script 'mapping_and_filtering_RNA_seq.sh' The inputs for this script are:

1. The reference genome that we want to use for mapping the reads (${GENOME})
2. The two fastq files for each replicate (*1_fastq.gz and *2_fastq-gz). Before using these fastq files, a quality analysis should be done for these files, for example by using FASTQC (Andrew, 2010). For the mapping, the fastq must be put in order: -1 for fastq_1 file and -2 for fastq_2 file.

The output obtained from this script is a filtered bam file for each replicate.

The fastq sequences 1 and 2 for each replicate must be located in a folder called with the replicate's name. The output bam will be located in that folder after the procedure.

## 3) Counting of the reads

The counting process for each replicate was made using the function ‘htseq-count’ from the HTSeqv.0.9.1. (Anders et al., 2015) and the annotation file of the genome. The script for obtaining the counting files is 'htSeq_count.sh'. The input data are the bam file obtained for each sample and replicate, and the annotation file of the genome (previously used for the mapping step). The output file is a tabular file with two columns (the id of the genes and the counts). It should be notice that the last lines are a summary of the counting process, and those lines should be removed from each file.

The parameters used by htseq-count are:
1. -s no: the reads were not strand-specific
2. -r pos: the bam file is sort by the mapping position
3. -f bam: the input file for the counting is a bam file
4. --type=gene: the feature type used for the counting. In this case it was used the genes for the counting.
5. --mode=union: specifies the counting mode. The "union" mode is used when a read is assigned to all the features it overlaps.
6. --idattr=ID: This parameter specifies the attribute in the GFF/GTF file that contains the unique identifier for each feature. In the case of the GFF file used, the gene names have the 'ID' atributte.


## 4) Differential expression analysis

The differential expression analysis was performed using the R DESeq2 package (Love et al., 2014). Two different analyses were made: (1) A differential expression comparison between Stage A vs AB in ‘Penta’ and (2) a differential expression comparison between Stage A vs AB in ‘Tardona’.  To detect genes differentially expressed between stages, results of each analysis were filter by a p-adj ≤ 0.05 and a log2FC ≥ |2|.

The steps followed for conducting both differential expression analysis can be found on the 'scripts' folder ('Script_DESeq2_Penta_and_Tardona_def.R'). As inputs, this script requires the count files generated in the counting steps, and a excel file with the treatment information for each variety. The file 'information_Penta_samples.xlsx' is example of this file, and can be viewed in the Examples' folder. As output, it generated a csv file for each variety (Penta and Tardona in this case) with the differential expressed genes with have a p-adj ≤ 0.05 and a log2FC ≥ |2|.

## 5) Determination of differential expressed genes located at QTLs

For the identification of differentially expressed genes (DEGs) at the QTLs, a R script was made. Two type of inputs are needed: (1) The DEG file (In our case there are two DEG files, one for Penta and another for Tardona); (2) The file with all the QTLs. This file has a defined structure, wiThe file must be a txt file with 7 columns:

1. SNP_associated2_region: the name of the QTL
2. Initial_REGION: the physical starting position of the QTL
3. End_REGION: the physical ending position of the QTL
4. Chromosome: the name of the chromosome where the QTL is located
5. Gene_name: the ID of the gene located in the QTL
6. Initial: The physical starting position of the gene in the genome
7. End: the physical ending position of the gene in the genome

An example of the structure of this file can be seen at the Examples' folder.


  



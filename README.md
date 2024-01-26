# DESeq_Analysis_for_Penta_and_Tardona_samples

Previous RNA-Seq data from the BioProject PRJNA610711 (Prudencio et al., 2021) was used to identify genes related to the dormancy release, using for this study the P. dulcis cv. ‘Texas’ genome (used in the almond AxiomTM 60K array) and open source software. Two different almond cultivars with nonidentical blooming date: ‘Penta’ (extra-late flowering) and ‘Tardona’ (ultra-late flowering) and two different phenological states: ‘Stage A’ (ecodormant flower buds) and ‘Stage AB’ (when each cultivar had achieved at least 40% of their CRs) were selected. Three replicates for each cultivar and phenological state were used (with the exception of the ‘Penta’ A sample, where only two replicates were available). Each replicate has two SRA files as they were sequenced using paired-ends reads (Prudencio et al., 2021).

The process of obtaining the differential expressed genes between 'Stage A' and 'Stage B' for each cultivar has several steps:

## 1) Quality control of the SRA files

The quality control of the RNA sequences for each replicate was done by FASTQC v.0.12.1. (Andrew, 2010) at the GALAXY server (usegalaxy.org).

## 2) Mapping of the fastq reads to the Texas genome and filtering the mapping results

For each replicate, the paired-ends were mapped into the reference genome of cultivar “Texas” v.2.0 (Alioto et al., 2020) by HISAT2 v.2.2.1 (Kim et al., 2019). After that, Bam files were filtered by minimum length of 35 pb and minimum phred-score value of 30 using Samtools v.13 software (Li et al., 2009). The mapping and filtering process were performed using the script 'mapping_and_filtering_RNA_seq.sh'

## 3) Counting of the reads


## 4) PCA plot of the samples
## 5) Differential expression analysis
## 6) Determination of differential expressed genes located at QTLs

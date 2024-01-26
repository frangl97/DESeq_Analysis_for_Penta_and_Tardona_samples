# DESeq_Analysis_for_Penta_and_Tardona_samples

Previous RNA-Seq data from the BioProject PRJNA610711 (Prudencio et al., 2021) was used to identify genes related to the dormancy release, using for this study the P. dulcis cv. ‘Texas’ genome (used in the almond AxiomTM 60K array) and open source software. Two different almond cultivars with nonidentical blooming date: ‘Penta’ (extra-late flowering) and ‘Tardona’ (ultra-late flowering) and two different phenological states: ‘Stage A’ (ecodormant flower buds) and ‘Stage AB’ (when each cultivar had achieved at least 40% of their CRs) were selected. Three replicates for each cultivar and phenological state were used (with the exception of the ‘Penta’ A sample, where only two replicates were available). Each replicate has two SRA files as they were sequenced using paired-ends reads (Prudencio et al., 2021).

The process of obtaining the differential expressed genes between 'Stage A' and 'Stage B' for each cultivar has several steps:
## 1) Quality control of the SRA files
## 2) Mapping of the fastq reads to the Texas genome
## 3) Filtering the mapping results
## 4) Counting of the reads
## 5)
## 6) Differential expression analysis
## 7) Determination of differential expressed genes located at QTLs

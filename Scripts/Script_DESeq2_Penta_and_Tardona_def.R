### DESEQ2 ####

#if (!require("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")

#BiocManager::install("DESeq2")

library(DESeq2)
library(dplyr)
library(readxl)

setwd("C:/Users/franc/OneDrive - UNIVERSIDAD DE MURCIA/DOCTORADO/ENSAYOS/RNA-Seq_Mapa_genetico_almendro_Jorge/Resultados_HtSeq-count")



################################## DESEQ2 FOR PENTA SAMPLES ###################################################

## Loading the counts files

counts_Penta_A_R1 <- read.delim("htseq-count_on_Penta_A_1_gene_counts.tabular", header = FALSE, sep = "\t")
colnames(counts_Penta_A_R1) <- c("Gene_ID", "Penta_A_R1")

counts_Penta_A_R2 <- read.delim("htseq-count_on_Penta_A_2_gene_counts.tabular", header = FALSE, sep = "\t")
colnames(counts_Penta_A_R2) <- c("Gene_ID", "Penta_A_R2")

counts_Penta_AB_R1 <- read.delim("htseq-count_on_Penta_AB_1_gene_counts.tabular", header = FALSE, sep = "\t")
colnames(counts_Penta_AB_R1) <- c("Gene_ID", "Penta_AB_R1")

counts_Penta_AB_R2 <- read.delim("htseq-count_on_Penta_AB_2_gene_counts.tabular", header = FALSE, sep = "\t")
colnames(counts_Penta_AB_R2) <- c("Gene_ID", "Penta_AB_R2")

counts_Penta_AB_R3 <- read.delim("htseq-count_on_Penta_AB_3_gene_counts.tabular", header = FALSE, sep = "\t")
colnames(counts_Penta_AB_R3) <- c("Gene_ID", "Penta_AB_R3")

## Merging the data in a dataframe

count_Penta <- inner_join(counts_Penta_A_R1,counts_Penta_A_R2, by="Gene_ID")
count_Penta <- inner_join(count_Penta,counts_Penta_AB_R1, by="Gene_ID")
count_Penta <- inner_join(count_Penta,counts_Penta_AB_R2, by="Gene_ID")
count_Penta <- inner_join(count_Penta,counts_Penta_AB_R3, by="Gene_ID")
genes <- count_Penta$Gene_ID 
count_Penta$Gene_ID <- NULL
row.names(count_Penta) <- genes
  
## Sample files. This file indicates the treatment of each sample and replicate

information_Penta_samples <- read_excel("information_Penta_samples.xlsx")
information_Penta_samples$Stage <- as.factor(information_Penta_samples$Stage)
#View(information_Penta_samples)

dds_penta <- DESeqDataSetFromMatrix(countData = count_Penta, colData = information_Penta_samples, design = ~ Stage)


## Established the reference level

dds_penta$Stage <- relevel(dds_penta$Stage, ref = "A")

## Perform the DESeq2 analysis

dds_results_Penta <- DESeq(dds_penta)

## Saving the results

results_Penta_DESeq <- results(dds_results_Penta)

table_results_Penta_DESeq <- as.data.frame(results_Penta_DESeq)

#View(table_results_Penta_DESeq)

## Filtering the results by p-adj <= 0.05 and log2FoldChange >= |2|

DEG_Penta <- table_results_Penta_DESeq[table_results_Penta_DESeq$padj<= 0.05,]
DEG_Penta_padj <- DEG_Penta[complete.cases(DEG_Penta),]

DEG_Penta_downregulated <- DEG_Penta[DEG_Penta$log2FoldChange <= -2,]

DEG_Penta_downregulated <- DEG_Penta_downregulated[complete.cases(DEG_Penta_downregulated),]

DEG_Penta_upregulated <- DEG_Penta[DEG_Penta$log2FoldChange >= 2,]

DEG_Penta_upregulated <- DEG_Penta_upregulated[complete.cases(DEG_Penta_upregulated),]

PENTA_DEG <- rbind(DEG_Penta_upregulated, DEG_Penta_downregulated)

# Save the results of DEG

write.csv2(PENTA_DEG,"PENTA_DEG.csv", sep="\t", col.names = TRUE, dec=".", row.names = TRUE)




################################## DESEQ2 FOR TARDONA SAMPLES ###################################################

counts_Tardona_A_R1 <- read.delim("htseq-count_on_Tardona_A_1_gene_counts.tabular", header = FALSE, sep = "\t")
colnames(counts_Tardona_A_R1) <- c("Gene_ID", "Tardona_A_R1")

counts_Tardona_A_R2 <- read.delim("htseq-count_on_Tardona_A_2_gene_counts.tabular", header = FALSE, sep = "\t")
colnames(counts_Tardona_A_R2) <- c("Gene_ID", "Tardona_A_R2")

counts_Tardona_A_R3 <- read.delim("htseq-count_on_Tardona_A_3_gene_counts.tabular", header = FALSE, sep = "\t")
colnames(counts_Tardona_A_R3) <- c("Gene_ID", "Tardona_A_R3")

counts_Tardona_AB_R1 <- read.delim("htseq-count_on_Tardona_AB_1_gene_counts.tabular", header = FALSE, sep = "\t")
colnames(counts_Tardona_AB_R1) <- c("Gene_ID", "Tardona_AB_R1")

counts_Tardona_AB_R2 <- read.delim("htseq-count_on_Tardona_AB_2_gene_counts.tabular", header = FALSE, sep = "\t")
colnames(counts_Tardona_AB_R2) <- c("Gene_ID", "Tardona_AB_R2")

counts_Tardona_AB_R3 <- read.delim("htseq-count_on_Tardona_AB_3_gene_counts.tabular", header = FALSE, sep = "\t")
colnames(counts_Tardona_AB_R3) <- c("Gene_ID", "Tardona_AB_R3")

## Merging the data

count_Tardona <- inner_join(counts_Tardona_A_R1,counts_Tardona_A_R2, by="Gene_ID")
count_Tardona <- inner_join(count_Tardona,counts_Tardona_A_R3, by="Gene_ID")
count_Tardona <- inner_join(count_Tardona,counts_Tardona_AB_R1, by="Gene_ID")
count_Tardona <- inner_join(count_Tardona,counts_Tardona_AB_R2, by="Gene_ID")
count_Tardona <- inner_join(count_Tardona,counts_Tardona_AB_R3, by="Gene_ID")
genes <- count_Tardona$Gene_ID 
count_Tardona$Gene_ID <- NULL
row.names(count_Tardona) <- genes

## Sample files 

information_Tardona_samples <- read_excel("information_Tardona_samples.xlsx")
information_Tardona_samples$Stage <- as.factor(information_Tardona_samples$Stage)
#View(information_Tardona_samples)

dds <- DESeqDataSetFromMatrix(countData = count_Tardona, colData = information_Tardona_samples, design = ~ Stage)


## Established the reference level

dds$Stage <- relevel(dds$Stage, ref = "A")

## Perform the DESeq2 analysis

dds_results_Tardona <- DESeq(dds)


## Saving the results

results_Tardona_DESeq <- results(dds_results_Tardona)

summary(results_Tardona_DESeq)

table_results_Tardona_DESeq <- as.data.frame(results_Tardona_DESeq)

#View(table_results_Tardona_DESeq)

## Filtering the results by p-adj <= 0.05 and log2FoldChange >= |2|

DEG_Tardona <- table_results_Tardona_DESeq[table_results_Tardona_DESeq$padj<= 0.05,]

DEG_Tardona <- DEG_Tardona[complete.cases(DEG_Tardona),]

DEG_Tardona_downregulated <- DEG_Tardona[DEG_Tardona$log2FoldChange <= -2,]

DEG_Tardona_upregulated <- DEG_Tardona[DEG_Tardona$log2FoldChange >= 2,]

TARDONA_DEG <- rbind(DEG_Tardona_upregulated, DEG_Tardona_downregulated)

# Save the results of DEG

write.csv2(TARDONA_DEG,"TARDONA_DEG.csv", sep="\t", col.names = TRUE, dec=".", row.names = TRUE)

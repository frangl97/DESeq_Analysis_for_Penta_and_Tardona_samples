### SCRIPT FOR JOING THE DATASETS FROM THE DEG 

library(dplyr)

###### First of all, we obtain a file of DEG for each variety

# Penta_DEG y Tardona_DEG

Penta_DEG <- read.csv2("C:/Users/franc/OneDrive - UNIVERSIDAD DE MURCIA/DOCTORADO/ENSAYOS/RNA-Seq_Mapa_genetico_almendro_Jorge/Resultados_HtSeq-count/PENTA_DEG.csv", sep =";", header = TRUE)

Tardona_DEG <- read.csv2("C:/Users/franc/OneDrive - UNIVERSIDAD DE MURCIA/DOCTORADO/ENSAYOS/RNA-Seq_Mapa_genetico_almendro_Jorge/Resultados_HtSeq-count/TARDONA_DEG.csv", sep =";", header = TRUE)

Treatement <- rep("Penta A vs AB")

Penta_DEG <- cbind(Treatement, Penta_DEG)


Treatement <- rep("Tardona A vs AB")

Tardona_DEG <- cbind(Treatement, Tardona_DEG)


# Load the txt file with the genes located in the QTLs. The file must be a txt file with 7 columns:
  # 1) SNP_associated2_region: the name of the QTL
  # 2) Initial_REGION: the physical starting position of the QTL
  # 3) End_REGION: the physical ending position of the QTL
  # 4) Chromosome: the name of the chromosome where the QTL is located
  # 5) Gene_name: the ID of the gene located in the QTL
  # 6) Initial: The physical starting position of the gene in the genome
  # 7) End: the physical ending position of the gene in the genome

archivo_genes_qtls <- read.delim("C:/Users/franc/OneDrive - UNIVERSIDAD DE MURCIA/DOCTORADO/ENSAYOS/RNA-Seq_Mapa_genetico_almendro_Jorge/Resultados_HtSeq-count/GENES_DE_LAS_QTLS.txt", sep="\t", header = TRUE)


# First, the name of the column 'X' is changed for 'Gene_name' in order to do the join

Penta_DEG <- Penta_DEG %>% rename("Gene_name" = X)

Tardona_DEG <- Tardona_DEG %>% rename("Gene_name" = X)


#Penta

genes_qtl_vs_Penta_DEG <- merge(archivo_genes_qtls, Penta_DEG, by="Gene_name", all.x = TRUE)

genes_qtl_vs_Penta_DEG <- genes_qtl_vs_Penta_DEG[complete.cases(genes_qtl_vs_Penta_DEG),]

write.csv2(genes_qtl_vs_Penta_DEG, "C:/Users/franc/OneDrive - UNIVERSIDAD DE MURCIA/DOCTORADO/ENSAYOS/RNA-Seq_Mapa_genetico_almendro_Jorge/Resultados_HtSeq-count/Genes_qtl_vs_Penta_DEG.csv", sep="\t", col.names = TRUE, dec=".", row.names = FALSE)


#Tardona

genes_qtl_vs_Tardona_DEG <- merge(archivo_genes_qtls, Tardona_DEG, by="Gene_name", all.x = TRUE)

genes_qtl_vs_Tardona_DEG <- genes_qtl_vs_Tardona_DEG[complete.cases(genes_qtl_vs_Tardona_DEG),]

write.csv2(genes_qtl_vs_Tardona_DEG, "C:/Users/franc/OneDrive - UNIVERSIDAD DE MURCIA/DOCTORADO/ENSAYOS/RNA-Seq_Mapa_genetico_almendro_Jorge/Resultados_HtSeq-count/Genes_qtl_vs_Tardona_DEG.csv", sep="\t", col.names = TRUE, dec=".", row.names = FALSE)

# Create a file with all comparisons

genes_qtl_vs_all_comparations <- rbind(genes_qtl_vs_Penta_DEG, genes_qtl_vs_Tardona_DEG)


write.csv2(genes_qtl_vs_all_comparations, "C:/Users/franc/OneDrive - UNIVERSIDAD DE MURCIA/DOCTORADO/ENSAYOS/RNA-Seq_Mapa_genetico_almendro_Jorge/Resultados_HtSeq-count/Genes_qtl_vs_all_comparations_DEG.csv", sep="\t", col.names = TRUE, dec=".", row.names = FALSE)

lista_QTLs <- unique(genes_qtl_vs_all_comparations$SNP_associated2_region)

# Create different dataframes, one for each QTL. This part of the script depends on the number of QTLs it been analysed.

genes_qtl_FT_4 <- subset(genes_qtl_vs_all_comparations[genes_qtl_vs_all_comparations$SNP_associated2_region == "FT_4(6.7-62.41)",])
genes_qtl_FT_4_ord <- genes_qtl_FT_4 %>% arrange(Initial)
write.csv2(genes_qtl_FT_4_ord,"C:/Users/franc/OneDrive - UNIVERSIDAD DE MURCIA/DOCTORADO/ENSAYOS/RNA-Seq_Mapa_genetico_almendro_Jorge/Resultados_HtSeq-count/genes_qtl_FT_4_ord_DEG.csv", sep="\t", col.names = TRUE, dec=".", row.names = FALSE)

genes_qtl_FI_1 <- subset(genes_qtl_vs_all_comparations[genes_qtl_vs_all_comparations$SNP_associated2_region == "FI_1(69.89-80.37)",])
genes_qtl_FI_1_ord <- genes_qtl_FI_1 %>% arrange(Initial)
write.csv2(genes_qtl_FI_1_ord,"C:/Users/franc/OneDrive - UNIVERSIDAD DE MURCIA/DOCTORADO/ENSAYOS/RNA-Seq_Mapa_genetico_almendro_Jorge/Resultados_HtSeq-count/genes_qtl_FI_1_ord_DEG.csv", sep="\t", col.names = TRUE, dec=".", row.names = FALSE)

genes_qtl_FT_1 <- subset(genes_qtl_vs_all_comparations[genes_qtl_vs_all_comparations$SNP_associated2_region == "FT_1(49.72-59.97)",])
genes_qtl_FT_1_ord <- genes_qtl_FT_1 %>% arrange(Initial)
write.csv2(genes_qtl_FT_1_ord,"C:/Users/franc/OneDrive - UNIVERSIDAD DE MURCIA/DOCTORADO/ENSAYOS/RNA-Seq_Mapa_genetico_almendro_Jorge/Resultados_HtSeq-count/genes_qtl_FT_1_ord_DEG.csv", sep="\t", col.names = TRUE, dec=".", row.names = FALSE)


genes_qtl_FI_7 <- subset(genes_qtl_vs_all_comparations[genes_qtl_vs_all_comparations$SNP_associated2_region == "FI_7_(13.56-38.56)",])
genes_qtl_FI_7_ord <- genes_qtl_FI_7 %>% arrange(Initial)
write.csv2(genes_qtl_FI_7_ord,"C:/Users/franc/OneDrive - UNIVERSIDAD DE MURCIA/DOCTORADO/ENSAYOS/RNA-Seq_Mapa_genetico_almendro_Jorge/Resultados_HtSeq-count/genes_qtl_FI_7_ord_DEG.csv", sep="\t", col.names = TRUE, dec=".", row.names = FALSE)

genes_qtl_FI_5 <- subset(genes_qtl_vs_all_comparations[genes_qtl_vs_all_comparations$SNP_associated2_region == "FI_5 (19.42-20.72)",])
genes_qtl_FI_5_ord <- genes_qtl_FI_5 %>% arrange(Initial)
write.csv2(genes_qtl_FI_5_ord,"C:/Users/franc/OneDrive - UNIVERSIDAD DE MURCIA/DOCTORADO/ENSAYOS/RNA-Seq_Mapa_genetico_almendro_Jorge/Resultados_HtSeq-count/genes_qtl_FI_5_ord_DEG.csv", sep="\t", col.names = TRUE, dec=".", row.names = FALSE)


# Save the data

write.table(Penta_DEG, file = "C:/Users/franc/OneDrive - UNIVERSIDAD DE MURCIA/DOCTORADO/ENSAYOS/RNA-Seq_Mapa_genetico_almendro_Jorge/Resultados_HtSeq-countPenta_DEG.txt", sep = "\t", dec = ".", col.names = TRUE, row.names =  FALSE)

write.table(Tardona_DEG, file = "C:/Users/franc/OneDrive - UNIVERSIDAD DE MURCIA/DOCTORADO/ENSAYOS/RNA-Seq_Mapa_genetico_almendro_Jorge/Resultados_HtSeq-count/Tardona_DEG.txt", sep = "\t", dec = ".", col.names = TRUE, row.names =  FALSE)



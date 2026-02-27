# MENA eDNA Project — Questions for Jonah Ventures

### How to read the tags

| Tag | Meaning |
|---|---|
| `[SRA]` | Needed for NCBI Sequence Read Archive (FASTQ upload) |
| `[BioSample]` | Needed for NCBI BioSample registration |
| `[GBIF]` | Needed for Darwin Core / GBIF occurrence publication |
| `[Schema]` | Needed to finalize our internal data model |
| `[QC]` | Data quality — prevents errors or future revisions |

---

## 1. Sequencing Methods — Faecal (Amplicon: 12S + trnL)

1. `[SRA]` What **sequencing platform and instrument** were used? (e.g., Illumina MiSeq, NovaSeq 6000)
2. `[SRA]` What is the **library preparation protocol**? (Dual-indexed? Paired-end or single-end? Read length?)
3. `[SRA]` `[GBIF]` What **primer pair** was used for **12S vertebrate**? (Name and nucleotide sequences)
4. `[SRA]` `[GBIF]` What **primer pair** was used for **trnL**? (Name and nucleotide sequences)

## 2. Sequencing Methods — Soil (Shotgun)

5. `[SRA]` What **sequencing platform and instrument** were used for soil shotgun metagenomics?
6. `[SRA]` What is the **library preparation protocol**? (e.g., Nextera XT, read length, paired-end?)
7. `[Schema]` Are there plans to run **16S amplicon** on the soil samples as well? If so, same instrument?

## 3. DNA Extraction

8. `[BioSample]` Was DNA extraction performed **in-house at Jonah Ventures**, or by a partner?
9. `[BioSample]` What **extraction kit/protocol** was used? (e.g., Qiagen DNeasy PowerSoil, Zymo Quick-DNA Fecal/Soil — same for both faecal and soil, or different?)

## 4. Bioinformatics

10. `[GBIF]` `[QC]` What **bioinformatics pipeline** was used for faecal amplicon data? (e.g., DADA2, OBITools, QIIME2, proprietary)
11. `[GBIF]` `[QC]` What **bioinformatics pipeline** was used (or will be used) for soil shotgun data? (e.g., Kraken2, MetaPhlAn, HUMAnN)
12. `[GBIF]` What **reference database(s)** were used for taxonomic assignment? (e.g., GenBank/nt, BOLD, MIDORI, custom curated)
13. `[GBIF]` `[QC]` What **% identity threshold** was applied for species-level identification in the 12S results?
14. `[GBIF]` `[QC]` What **filtering or decontamination steps** were applied before generating the 12S results table? (e.g., minimum read thresholds, host read removal, contaminant filtering)

## 5. SRA Upload Coordination

15. `[SRA]` Can you confirm the upload workflow: **we provide a barcode → BioSample accession mapping**, you upload FASTQs referencing those accessions?
16. `[SRA]` What **format are the FASTQs** in? (Demultiplexed per sample? Per run? Compressed .fastq.gz?)
17. `[SRA]` `[QC]` Can you provide a **mapping file** linking your internal run IDs (JV327, JV339, etc.) to FASTQ filenames and sample barcodes?

## 6. Data Interpretation

These clarify fields in the results files you provided.

18. `[Schema]` `[QC]` In the faecal metadata, some `RunId_12SVert` values are **dates** (e.g., `2024-11-25`) rather than run codes (e.g., `JV327`). What do the date entries represent?
19. `[Schema]` What does `DNA_Species_Type_Consensus` mean? (What are the possible values and their definitions?)
20. `[Schema]` `[GBIF]` What does `RRA_Prey` represent? (Relative Read Abundance — of prey items? Calculated how?)
21. `[Schema]` What does `RepESVId` stand for?
22. `[GBIF]` `[QC]` Are the `Reads` values in the 12S results **raw counts** or **post-filtering counts**?
23. `[QC]` What does the `NEW COMMENT` column in the 12S file contain?
24. `[Schema]` What does the `samples/YEAR` column in the 12S results represent?


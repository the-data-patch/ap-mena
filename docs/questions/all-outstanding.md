# MENA eDNA Project — Outstanding Questions for Data Provider

### How to read the tags

| Tag | Meaning |
|---|---|
| `[SRA]` | Required or recommended for NCBI Sequence Read Archive submission (FASTQs) |
| `[BioSample]` | Required or recommended for NCBI BioSample registration |
| `[BioProject]` | Required or recommended for NCBI BioProject registration |
| `[GBIF]` | Required or recommended for Darwin Core / GBIF publication |
| `[Schema]` | Needed to finalize the LinkML data model |
| `[QC]` | Data quality — not required by any repo but prevents errors or future revisions |
| `[Protocol]` | For protocol documentation (protocols.io / Zenodo) |
| `[Policy]` | Organizational decision that affects all repositories |

---

## A. Questions for Jordana / African Parks Team

### Field Collection Protocols

1. Could you please share the collection protocols? If they're published publically, we can just share a link. If not published, we can get share them through Zenodo.
      1. **soil** (Depth, volume, tools, preservation method) `[Protocol]`
      1. **water** (Filtration method, filter type/pore size, target volume, preservation) `[Protocol]` 
      1. **faecal sample** (Swab vs. bulk, preservation method, storage temperature) `[Protocol]`
      1. **negative field controls** and/or **extraction/PCR blanks** (if used))`[BioSample]` `[QC]` 

### Data Structure and metadata

1. Could you please define these fields from the faecal metadata? `[Schema]`
    - `Ecological_Guild` — How is it determined?
    - `species_code` — (e.g., is `INP_24_GASA_1` park/year/species encoding?)
    - `swab` — Swab in addition to bulk, or swab-only?
    - `latrine`
    - `Reruns`
1. Could you please define these fields from the 12S results? `[Schema]`
    - `DNA_Species_Type_Consensus` — (e.g., categories like "prey", "host", "contaminant"?)
    - `RRA_Prey` — Relative Read Abundance of prey? Calculated how? `[GBIF]`
    - `RepESVId`
    - `samples/YEAR` — Just a stat of convenience?
1. Are the `Reads` values in the 12S results **raw counts** or **post-filtering counts**? `[GBIF]` `[QC]` 
1. Column `NEW COMMENT` the 12S is empty. Any reason it should be preserved? `[QC]` 

### Additional Results

1. ~ When are **additional results** expected? `[Schema]` 
    - trnL plant diet results (faecal)? `[GBIF]`
    - 16SU / 12S results from water (University of Porto)? `[GBIF]`
    - Shotgun results from soil? `[GBIF]`

### Publication & Access

1. What is the **full official project name** for BioProject registration? `[BioProject]` 
1. Are there other **institutional collaborators** to acknowledge? (University of Porto is now confirmed — any others?) `[BioProject]` 
1. **sensitive location data**: Do you have a preference for how we blur sensitive location data?  `[Policy]` `[GBIF]` 
1. Could you please confirm GBIF datasets should use **CC-BY-NC** license, restricting the data to non-commerical use? This is what I had in my notes. `[Policy]` `[GBIF]` 
1. Any progress on finding a **home for DNA extracts and physical samples**? Not critical, but we can include that in the metadata. `[QC]` 

## B. Questions about Faecal & Soil Samples

### Faecal Amplicon — Sequencing Methods

1. What **sequencing platform and instrument** were used for faecal amplicon sequencing? (e.g., Illumina MiSeq, NovaSeq 6000) `[SRA]` 
1. What is the **library preparation protocol**? (Dual-indexed, paired-end or single-end, read length) `[SRA]` 
1. What **primer pair** was used for **12S vertebrate**? (Name and nucleotide sequences — e.g., 12SV05F/12SV05R, MiFish-U) `[SRA]` `[GBIF]` 
1. What **primer pair** was used for **trnL**? (Name and nucleotide sequences) `[SRA]` `[GBIF]` 

### Soil Shotgun — Sequencing Methods

1. What **sequencing platform and instrument** were used for soil shotgun metagenomics? `[SRA]` 
1. What is the **library preparation protocol** for shotgun? (e.g., Nextera XT, read length, paired-end) `[SRA]` 

### DNA Extraction (Both)

1. Who (person or lab) performed **DNA extraction** for faecal and soil samples? (Jonah Ventures in-house, or a partner lab?) `[Protocol]` `[BioSample]` 
1. What **extraction kit/protocol** was used? (e.g., Qiagen DNeasy PowerSoil, Zymo Quick-DNA Fecal/Soil) `[Protocol]` `[BioSample]` 

### Bioinformatics

1. What **bioinformatics pipeline** was used for faecal amplicon data? (e.g., DADA2, OBITools, QIIME2, Jonah Ventures proprietary) `[GBIF]` `[QC]` 
1. What **bioinformatics pipeline** was used for soil shotgun data? (e.g., Kraken2, MetaPhlAn, HUMAnN, custom) `[GBIF]` `[QC]` 
1. What **protocol** was used for taxonomic assignment? 
    1. **reference database(s)** (e.g., GenBank/nt, BOLD, MIDORI, custom curated) `[GBIF]` 
    1. **% identity threshold** was applied for species-level identification in the 12S results? `[GBIF]` `[QC]` 
    1. What **filtering or decontamination steps** were applied before generating the 12S results table? (e.g., minimum read thresholds, host read removal, contaminant removal) `[GBIF]` `[QC]` 

---

## C. Questions about Water samples

### Sequencing & Lab Methods

1. What **sequencing platform and instrument** were used for water eDNA? (e.g., Illumina MiSeq) `[SRA]` 
1. What is the **library preparation protocol**? (Paired-end, read length, indexing strategy) `[SRA]` 
1. What **primer pair** is used for **16SU**? (Full name and nucleotide sequences) `[SRA]` `[GBIF]` 
1. What **primer pair** is used for **Vertebrate 12S** on water samples? Is it the same primer pair as Jonah Ventures uses on faecal, or different? `[SRA]` `[GBIF]` 

### DNA Extraction & Filtration

1. Who performed **DNA extraction** for water samples? `[Protocol]` `[BioSample]` 
1. What **extraction kit/protocol** was used? `[Protocol]` `[BioSample]` 
1. What **filtration method** was used? (Filter type, pore size — may already be in the water metadata but values are sparse) `[Protocol]` `[BioSample]` 

### Bioinformatics

1. What **bioinformatics pipeline** is used for water amplicon data? `[GBIF]` `[QC]` 
1. What **reference database(s)** are used for taxonomic assignment? `[GBIF]` 

---
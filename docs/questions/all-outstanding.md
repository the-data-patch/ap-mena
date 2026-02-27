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

## A. Questions for Jonah Ventures (Faecal & Soil)

### Faecal Amplicon — Sequencing Methods

1. `[SRA]` What **sequencing platform and instrument** were used for faecal amplicon sequencing? (e.g., Illumina MiSeq, NovaSeq 6000)
2. `[SRA]` What is the **library preparation protocol**? (Dual-indexed, paired-end or single-end, read length)
3. `[SRA]` `[GBIF]` What **primer pair** was used for **12S vertebrate**? (Name and nucleotide sequences — e.g., 12SV05F/12SV05R, MiFish-U)
4. `[SRA]` `[GBIF]` What **primer pair** was used for **trnL**? (Name and nucleotide sequences)

### Soil Shotgun — Sequencing Methods

5. `[SRA]` What **sequencing platform and instrument** were used for soil shotgun metagenomics?
6. `[SRA]` What is the **library preparation protocol** for shotgun? (e.g., Nextera XT, read length, paired-end)
7. `[Schema]` Are there plans to also run **16S amplicon** on soil samples? If so, same instrument and primers as faecal, or different?

### DNA Extraction (Both)

8. `[Protocol]` `[BioSample]` Who performed **DNA extraction** for faecal and soil samples? (Jonah Ventures in-house, or a partner lab?)
9. `[Protocol]` `[BioSample]` What **extraction kit/protocol** was used? (e.g., Qiagen DNeasy PowerSoil, Zymo Quick-DNA Fecal/Soil)

### Bioinformatics

10. `[GBIF]` `[QC]` What **bioinformatics pipeline** was used for faecal amplicon data? (e.g., DADA2, OBITools, QIIME2, Jonah Ventures proprietary)
11. `[GBIF]` `[QC]` What **bioinformatics pipeline** was used for soil shotgun data? (e.g., Kraken2, MetaPhlAn, HUMAnN, custom)
12. `[GBIF]` What **reference database(s)** were used for taxonomic assignment? (e.g., GenBank/nt, BOLD, MIDORI, custom curated)
13. `[GBIF]` `[QC]` What **% identity threshold** was applied for species-level identification in the 12S results?
14. `[GBIF]` `[QC]` What **filtering or decontamination steps** were applied before generating the 12S results table? (e.g., minimum read thresholds, host read removal, contaminant removal)

### SRA Upload Coordination

15. `[SRA]` We (African Parks) will create the **umbrella BioProject, park-level BioProjects, and all BioSamples**. We will provide Jonah Ventures a mapping file of `barcode_id → BioSample accession → BioProject accession`. Can Jonah Ventures use this to link FASTQs during SRA upload?
16. `[SRA]` What **format are the FASTQs** in? (Demultiplexed per sample, or per run? Compressed?)
17. `[SRA]` `[QC]` Can Jonah Ventures provide a **mapping file** linking their run IDs (JV327, JV339, etc.) to FASTQ filenames and sample barcodes?

### Data Interpretation

18. `[Schema]` `[QC]` In the faecal metadata, some `RunId_12SVert` values are **dates** (e.g., `2024-11-25`) rather than run codes (e.g., `JV327`). What do the date values represent? Are these unsequenced samples, or a data entry issue?
19. `[Schema]` What does `DNA_Species_Type_Consensus` mean? (e.g., categories like "prey", "host", "contaminant"?)
20. `[Schema]` `[GBIF]` What does `RRA_Prey` represent exactly? (Relative Read Abundance of prey — calculated how?)
21. `[Schema]` What does `RepESVId` stand for?
22. `[GBIF]` `[QC]` Are the `Reads` values in the 12S results **raw counts** or **post-filtering counts**?
23. `[QC]` What does the `NEW COMMENT` column in the 12S file contain?
24. `[Schema]` What does the `samples/YEAR` column in the 12S results represent?

---

## B. Questions for University of Porto / CBO (Water)

### Sequencing & Lab Methods

25. `[SRA]` What **sequencing platform and instrument** were used for water eDNA? (e.g., Illumina MiSeq)
26. `[SRA]` What is the **library preparation protocol**? (Paired-end, read length, indexing strategy)
27. `[SRA]` `[GBIF]` What **primer pair** is used for **16SU**? (Full name and nucleotide sequences)
28. `[SRA]` `[GBIF]` What **primer pair** is used for **Vertebrate 12S** on water samples? Is it the same primer pair as Jonah Ventures uses on faecal, or different?

### DNA Extraction & Filtration

29. `[Protocol]` `[BioSample]` Who performed **DNA extraction** for water samples?
30. `[Protocol]` `[BioSample]` What **extraction kit/protocol** was used?
31. `[Protocol]` `[BioSample]` What **filtration method** was used? (Filter type, pore size — may already be in the water metadata but values are sparse)

### Bioinformatics

32. `[GBIF]` `[QC]` What **bioinformatics pipeline** is used for water amplicon data?
33. `[GBIF]` What **reference database(s)** are used for taxonomic assignment?

### SRA Coordination

34. `[SRA]` `[Policy]` Will University of Porto submit **FASTQs to SRA**, or will African Parks coordinate this? (Same model as Jonah Ventures: we create BioSamples, you upload FASTQs.)
35. `[SRA]` If Porto uploads: can they reference BioSample accessions that African Parks creates?
36. `[Schema]` Are water eDNA **results files** available yet? (Equivalent to the 12S vertebrate results file for faecal data)

---

## C. Questions for Jordana / African Parks Team

### Field Collection Protocols

37. `[Protocol]` What is the standard **soil collection protocol**? (Depth, volume, tools, preservation method)
38. `[Protocol]` What is the standard **water eDNA collection protocol**? (Filtration method, filter type/pore size, target volume, preservation)
39. `[Protocol]` What is the standard **faecal sample collection protocol**? (Swab vs. bulk, preservation method, storage temperature)
40. `[BioSample]` `[QC]` Were **negative field controls** and **extraction/PCR blanks** collected? If so, are they tracked in these files or separately?
41. `[Schema]` When is the `location_other` field used?

### Faecal-Specific

42. `[QC]` `[GBIF]` When `species_id_field` (field ID) and `DNA_species_ID` (DNA ID) disagree, which takes **precedence** for host identification?
43. `[Schema]` Is `Ecological_Guild` assigned based on the **host species** (from literature), or derived from the **diet results**?
44. `[Schema]` What does `species_code` represent? (e.g., is `INP_24_GASA_1` park/year/species encoding?)
45. `[Schema]` What does the `swab` field mean? (Swab in addition to bulk, or swab-only?)
46. `[Schema]` What does `latrine` capture? (Communal defecation site?)
47. `[Schema]` What does `Reruns` indicate?

### Data Structure

48. `[Schema]` What is the **relationship** between the faecal metadata (5,409 rows) and the 12S results (6,560 rows)? Is each 12S row one ESV detection per sample (one-to-many)?
49. `[QC]` Are there **duplicate barcode_ids** across sample types?
50. `[QC]` The water metadata is **missing a `country` column**. Should we infer from park name, or is a correction coming?

### Additional Results

51. `[Schema]` Are **additional results files** expected?
    - trnL plant diet results (faecal)? `[GBIF]`
    - 16SU / 12S results from water (University of Porto)? `[GBIF]`
    - Shotgun results from soil? `[GBIF]`
52. `[Schema]` When are these expected?

### Publication & Access

53. `[BioProject]` What is the **full official project name** for BioProject registration?
54. `[BioProject]` Are there other **institutional collaborators** to acknowledge? (University of Porto is now confirmed — any others?)
55. `[Policy]` `[GBIF]` Are there **sensitive location data** concerns? (GPS for critically endangered species like Diceros bicornis — should coordinates be generalized for GBIF?)
56. `[BioProject]` Is there a **publication or report** in preparation to cite in the BioProject description?
57. `[Policy]` `[GBIF]` The meeting notes mention data **cannot be used for commercial purposes**. Does this mean GBIF datasets should use **CC-BY-NC**? (Note: GBIF strongly encourages CC0 or CC-BY for maximum reuse. CC-BY-NC limits reuse by conservation NGOs with any commercial activity and by data aggregators. Worth discussing with leadership.)
58. `[QC]` You're looking for a **home for DNA extracts and physical samples**. Has a repository been identified? (Affects `dwc:materialSampleID` and whether samples can be referenced as vouchers.)

---

## D. Internal Modeling Decisions

59. `[Schema]` **Normalized entity model** — Sample → Assay → SequencingRun → Occurrence. Confirmed acceptable.
60. `[Schema]` **Soil shotgun model** — Since soil is WGS not amplicon, the Assay entity needs a `library_strategy` field (AMPLICON vs WGS) and marker/primer fields become optional for WGS. Soil assays won't have primer sequences.
61. `[Schema]` **Two-lab coordination** — African Parks registers all BioSamples first, then provides accession mapping to both Jonah Ventures and University of Porto for SRA upload.
62. `[Schema]` `[GBIF]` **ENVO habitat mapping** — We will map `habitat_final` → ENVO terms. Field team review recommended.
63. `[Policy]` **GBIF license** — CC-BY-NC vs CC-BY vs CC0 needs a decision.
64. `[Schema]` **Template for other parks** — Design the MENA model so it can be reused across AP's 24–30 areas.

---

## Priority Summary

| Priority | Questions | Who | Needed For |
|---|---|---|---|
| 🔴 Critical | A.1–A.6 | Jonah Ventures | `[SRA]` Platform, instrument, library prep |
| 🔴 Critical | A.3–A.4 | Jonah Ventures | `[SRA]` `[GBIF]` Primer sequences |
| 🔴 Critical | B.25–B.28 | Univ. of Porto | `[SRA]` `[GBIF]` Water sequencing methods |
| 🔴 Critical | A.15–A.17 | Jonah Ventures | `[SRA]` FASTQ upload coordination |
| 🔴 Critical | B.34–B.35 | Univ. of Porto | `[SRA]` Water FASTQ upload coordination |
| 🟡 Important | A.10–A.14 | Jonah Ventures | `[GBIF]` Bioinformatics for identificationRemarks |
| 🟡 Important | B.32–B.33 | Univ. of Porto | `[GBIF]` Water bioinformatics |
| 🟡 Important | C.55 | Jordana / AP | `[Policy]` Coordinate sensitivity |
| 🟡 Important | C.57 | AP leadership | `[Policy]` License decision |
| 🟡 Important | C.53–C.54 | Jordana | `[BioProject]` Project name and collaborators |
| 🟢 Helpful | A.18–A.24 | Jonah Ventures | `[Schema]` Field definitions |
| 🟢 Helpful | C.37–C.39 | Jordana | `[Protocol]` For protocols.io registration |
| 🟢 Helpful | C.42–C.47 | Jordana | `[Schema]` Faecal field definitions |

---

*Revised: February 2026*

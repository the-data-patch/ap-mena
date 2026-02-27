# Conceptual Model

This diagram shows how the MENA experimental design maps to data entities and external repositories.

## Experimental Design → Data Model → Repositories

```mermaid
flowchart TD
    subgraph DESIGN["Experimental Design"]
        PROJ["MENA Project\n5 parks · 2 sites each"] --> PARK["Park\ne.g., Akagera, Kafue"]
        PARK --> SITE_P["Park Site\ninside protected area"]
        PARK --> SITE_C["Control Site\noutside boundaries"]
        SITE_P --> SAMPLING["Sampling Events\nGPS · date · habitat"]
        SITE_C --> SAMPLING
    end

    subgraph COLLECTION["Sample Collection\n~6,000 physical samples"]
        SAMPLING --> SOIL["Soil Samples\nn=451"]
        SAMPLING --> WATER["Water Samples\nn=217"]
        SAMPLING --> FAECAL["Faecal Samples\nn=5,409"]
    end

    subgraph SEQUENCING["Sequencing"]
        SOIL -->|"Jonah Ventures"| SHOTGUN["Shotgun\nMetagenomics\n(WGS)"]
        SOIL -->|"planned"| SOIL_16S["16S Amplicon"]
        WATER -->|"Univ. Porto"| W_16SU["16SU\nAmplicon"]
        WATER -->|"Univ. Porto"| W_12S["Vert 12S\nAmplicon"]
        FAECAL -->|"Jonah Ventures"| F_12S["Vert 12S\nAmplicon"]
        FAECAL -->|"Jonah Ventures"| F_TRNL["trnL Plant\nAmplicon"]
    end

    subgraph RESULTS["Analysis Results"]
        SHOTGUN --> TAXA_SOIL["Taxonomic\nDetections\n(soil community)"]
        SOIL_16S --> TAXA_SOIL
        W_16SU --> TAXA_WATER["Taxonomic\nDetections\n(aquatic community)"]
        W_12S --> TAXA_WATER
        F_12S --> TAXA_PREY["Prey/Diet\nDetections\n(vertebrates)"]
        F_TRNL --> TAXA_PLANT["Plant Diet\nDetections"]
        FAECAL --> HOST_ID["Host Species\nIdentification\n(DNA-confirmed)"]
    end

    subgraph REPOS["Repositories"]
        direction LR
        NCBI_BP["NCBI BioProject\n1 umbrella + 5 park"]
        NCBI_BS["NCBI BioSample\n~6,077 records"]
        NCBI_SRA["NCBI SRA\nFASTQ reads"]
        GBIF_OCC["GBIF Occurrences\nDwC + DNA extension"]
    end

    PROJ -->|"registered as"| NCBI_BP
    SOIL & WATER & FAECAL -->|"registered as"| NCBI_BS
    SHOTGUN & W_16SU & W_12S & F_12S & F_TRNL -->|"raw reads"| NCBI_SRA
    TAXA_SOIL & TAXA_WATER & TAXA_PREY & TAXA_PLANT & HOST_ID -->|"published as"| GBIF_OCC

    style DESIGN fill:#f0f7f0,stroke:#2e7d32
    style COLLECTION fill:#fff8e1,stroke:#f57f17
    style SEQUENCING fill:#e3f2fd,stroke:#1565c0
    style RESULTS fill:#fce4ec,stroke:#c62828
    style REPOS fill:#f3e5f5,stroke:#6a1b9a
    style SOIL fill:#8B6914,color:#fff
    style WATER fill:#1a6b8a,color:#fff
    style FAECAL fill:#6b4c1a,color:#fff
```

## Reading the Diagram

**Top to bottom** traces the flow from experimental design through sample collection, sequencing, and analysis to repository publication:

| Data | Repository | Format |
|---|---|---|
| Project structure | NCBI BioProject | Umbrella + 5 child projects |
| Physical samples | NCBI BioSample | 1 record per sample |
| Raw sequence reads | NCBI SRA | FASTQ files linked to BioSamples |
| Taxonomic detections + host IDs | GBIF | Darwin Core occurrences + DNA Derived Data extension |

## Key Design Points

1. **Three sample types, three sequencing strategies.** Soil uses shotgun metagenomics; water and faecal use targeted amplicon. This means the data model must accommodate both WGS and amplicon library strategies.

2. **Two sequencing labs.** Jonah Ventures handles faecal and soil; University of Porto handles water. Both will upload FASTQs to SRA referencing BioSample accessions created by African Parks.

3. **Faecal samples produce two kinds of occurrences.** The host animal (identified by DNA from the dung itself) and the prey/diet species (identified by 12S/trnL from the dung contents). Both are published as GBIF occurrences.

4. **Park × site pairs are the unit of comparison.** Every park has a managed site and an unmanaged control site. This paired design is central to the conservation effectiveness analysis but is not captured by NCBI — it lives in the LinkML schema and GBIF event hierarchy.
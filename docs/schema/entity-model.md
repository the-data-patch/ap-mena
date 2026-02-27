# Entity Model

## Class Hierarchy

```mermaid
flowchart TD
    DS[MENADataset] --> BP_U[MENABioProject\nUmbrella]
    DS --> BP_P[MENABioProject\nPer Park x5]
    BP_P --> SS[StudySite\nPark × Location x10]
    SS --> BS[BioSample]
    BS --> A[Assay\n1 per marker per sample]
    A --> SR[SequencingRun\nshared across assays]
    A --> OCC[Occurrence\n1 per detected taxon]

    BS -.-> SOIL[SoilSample\nMIMS.me.soil]
    BS -.-> WATER[WaterSample\nMIMS.me.water]
    BS -.-> FAECAL[FaecalSample\nMIMS.me.host-associated]

    style SOIL fill:#8B6914,color:#fff
    style WATER fill:#1a6b8a,color:#fff
    style FAECAL fill:#6b4c1a,color:#fff
```

## Entity Descriptions

### MENADataset

Root container. Holds the entire project.

### MENABioProject

NCBI BioProject record. One **umbrella** for the whole MENA project, plus one **child** per park.

### StudySite

A park × location_type combination (e.g., "Akagera-park", "Akagera-control"). Ten sites total. Not submitted to NCBI directly but provides organizational structure.

### BioSample (abstract)

One physical sample collected in the field. This is the abstract base class; three subclasses add type-specific fields:

| Subclass | NCBI Package | Organism | Samples |
|---|---|---|---|
| **SoilSample** | MIMS.me.soil | "soil metagenome" (taxid: 410658) | 451 |
| **WaterSample** | MIMS.me.water | "freshwater metagenome" (taxid: 449393) | 217 |
| **FaecalSample** | MIMS.me.host-associated | "gut metagenome" (taxid: 749906) | 5,409 |

### Assay

One assay = one marker (or shotgun library) applied to one sample. Maps to an **SRA Experiment**.

- Faecal samples typically have two assays: 12S vertebrate + trnL
- Water samples have two assays: 16SU + Vertebrate 12S
- Soil samples have one assay: shotgun metagenomics (16S amplicon may follow)

### SequencingRun

A physical run on the sequencing instrument. Maps to an **SRA Run**. Many assays from different samples are multiplexed on one run. Jonah Ventures run IDs follow the pattern `JV327`, `JV339`, etc.

### Occurrence

A single taxon detection from a single assay. Each row in the 12S vertebrate results file maps to one Occurrence. Maps to a **Darwin Core Occurrence** with the **DNA Derived Data extension**.

## Mapping to NCBI

| MENA Entity | NCBI Object | Cardinality |
|---|---|---|
| MENABioProject (umbrella) | Umbrella BioProject | 1 |
| MENABioProject (park) | BioProject | 5 |
| BioSample subclasses | BioSample | ~6,077 |
| Assay | SRA Experiment | ~1–2 per sample |
| SequencingRun | SRA Run | ~40+ runs |

## Mapping to Darwin Core / GBIF

| MENA Entity | DwC Object |
|---|---|
| StudySite | Parent Event (locationID) |
| BioSample | Event + MaterialSample |
| Occurrence | Occurrence |
| Assay fields | DNA Derived Data extension |

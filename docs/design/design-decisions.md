# Design Decisions

Key architectural decisions in the MENA eDNA schema and their rationale.

## 1. Normalized Entity Model

**Decision:** Separate Sample → Assay → SequencingRun → Occurrence into distinct classes.

**Rationale:** The faecal metadata file currently combines sample-level fields (location, date, host species) with assay-level fields (RunId, Reads, ESVs) in a single row. We separate these because:

- One faecal sample can have two assays (12S + trnL)
- Soil and water samples will have additional assays
- NCBI models these as separate SRA Experiments
- Keeping them combined would force duplication or restructuring after publication

## 2. Sample Type as Inheritance

**Decision:** Use LinkML `is_a` inheritance with an abstract `BioSample` base class and three subclasses.

**Rationale:** Soil, water, and faecal samples share ~23 common fields (location, date, habitat) but have type-specific fields. Inheritance keeps the common fields in one place and avoids repetition. Each subclass maps to a different NCBI BioSample package.

## 3. Verbatim + Standardized Fields

**Decision:** For every field with source data inconsistencies, maintain both a standardized field and a `_verbatim` field.

**Rationale:**

- NCBI and GBIF require standardized values
- Traceability back to the original spreadsheet is essential for QC
- No information is lost through harmonization
- If a standardization decision turns out to be wrong, the verbatim value is still available

## 4. Soil as Shotgun (Not Amplicon)

**Decision:** The Assay entity accommodates both amplicon and shotgun library strategies. Soil assays use `library_strategy = "WGS"` and marker/primer fields are optional.

**Rationale:** Soil samples were sequenced with shotgun metagenomics, not targeted amplicon. This means:

- No `marker` or primer fields for soil assays
- SRA submission uses library strategy "WGS" rather than "AMPLICON"
- The bioinformatics pipeline is different (e.g., Kraken2 vs DADA2)
- A future 16S amplicon run on soil would be a separate Assay with `library_strategy = "AMPLICON"`

## 5. One BioProject Per Park (Plus Umbrella)

**Decision:** One NCBI umbrella BioProject for MENA, with one child BioProject per park.

**Rationale:**

- Matches the natural grouping of the data
- Allows per-park DOIs for citation
- Enables incremental publication (each park as ready)
- Parks may have different collaborators, timelines, and sensitivities
- Mirrors the planned GBIF dataset structure (one dataset per park)

## 6. Two-Lab Coordination Model

**Decision:** African Parks registers all BioProjects and BioSamples. Labs (Jonah Ventures, University of Porto) upload FASTQs to SRA referencing those accessions.

**Rationale:**

- African Parks controls the metadata and project structure
- Prevents duplicate BioSample records
- Ensures consistent accession numbering across labs
- Labs only need a mapping file (`barcode_id → SAMN accession → PRJNA accession`)

## 7. GBIF as Event Core + Extensions

**Decision:** Publish to GBIF using Event Core + Occurrence Extension + DNA Derived Data Extension.

**Rationale:**

- Event Core captures the sampling event (location, date, protocol)
- Occurrence Extension captures each taxon detection
- DNA Derived Data Extension captures marker, primers, sequence
- This is the recommended structure from the [GBIF eDNA publishing guide](https://docs.gbif.org/publishing-dna-derived-data/en/)
- Host organisms published as occurrences in the same dataset

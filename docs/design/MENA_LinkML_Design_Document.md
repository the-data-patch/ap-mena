# MENA eDNA LinkML Schema — Design Document

**Version:** 0.1.0 (Draft)
**Date:** February 2026
**Schema file:** `mena_edna_schema.yaml`

---

## 1. Design Philosophy

This schema is built around three principles, ordered by your stated priorities:

1. **Prevent future problems.** Every field that NCBI or GBIF might require — now or later — is represented in the schema from the start, even if the value is currently TBD. This means we won't need to restructure data after publishing.

2. **Segregate NCBI-essential from project-specific.** Every slot description is tagged with one of: `NCBI_REQUIRED`, `NCBI_RECOMMENDED`, `DWC_REQUIRED`, `DWC_RECOMMENDED`, `PROJECT_SPECIFIC`, or `DERIVED`. This makes it easy to generate NCBI submission files that include only what's needed, while keeping the full scientific context in the master dataset.

3. **Preserve verbatim values alongside standardized ones.** For every field where source data has inconsistencies (country names, park names, habitats, dates), the schema includes both a standardized slot and a `_verbatim` slot. This means you can always trace a published record back to the original spreadsheet value, and you never lose information through harmonization.

### Field Classification Summary

| Tag | Count | Meaning |
|---|---|---|
| `NCBI_REQUIRED` | 17 | Must be populated for NCBI BioSample/SRA submission |
| `NCBI_RECOMMENDED` | 19 | Strongly encouraged by NCBI; improves discoverability |
| `DWC_REQUIRED` | 9 | Must be populated for GBIF occurrence publication |
| `DWC_RECOMMENDED` | 6 | Improves GBIF data quality and reuse |
| `PROJECT_SPECIFIC` | 13 | Not in any external standard; essential for MENA science |
| `DERIVED` | 3 | Computed from other fields (e.g., `geo_loc_name`, `lat_lon`) |

---

## 2. Entity Model

```
MENADataset (root container)
├── MENABioProject (umbrella)
│   └── MENABioProject[] (one per park)
│       └── StudySite[] (park × location_type)
│           └── BioSample[] (one per physical sample)
│               ├── SoilSample
│               ├── WaterSample
│               └── FaecalSample
│                   └── Assay[] (one per marker per sample)
│                       ├── → SequencingRun (many assays share one run)
│                       └── Occurrence[] (one per detected taxon per assay)
└── SequencingRun[] (shared across assays)
```

### Why This Structure

This normalized model mirrors the NCBI submission hierarchy:

| MENA Entity | NCBI Object | Relationship |
|---|---|---|
| MENABioProject (umbrella) | Umbrella BioProject | 1 per project |
| MENABioProject (park) | BioProject | 1 per park |
| BioSample | BioSample | 1 per physical sample |
| Assay | SRA Experiment | 1 per marker × sample |
| SequencingRun | SRA Run | 1 per actual run (shared) |

And the GBIF publication hierarchy:

| MENA Entity | Darwin Core Object | Notes |
|---|---|---|
| StudySite | dwc:Event (parent) | locationID groups samples |
| BioSample | dwc:Event + MaterialSample | eventDate, location, protocol |
| Occurrence | dwc:Occurrence | One per taxon detection |
| Assay fields | DNA Derived Data extension | Marker, primers, sequence |

### Key Decision: Separating Assay from Sample

The faecal metadata file currently combines sample-level fields (location, date, host species) with assay-level fields (RunId, Reads, ESVs) in a single row. The schema separates these because:

- One faecal sample can have two assays (12S vertebrate + trnL plant)
- Soil and water samples will eventually have additional marker assays
- NCBI models these as separate SRA Experiments
- Keeping them combined would force duplication or restructuring later

---

## 3. Sample Type Strategy

### NCBI BioSample Packages

| Sample Type | NCBI Package | Organism Value | NCBI Taxonomy ID |
|---|---|---|---|
| Soil | MIMS.me.soil | "soil metagenome" | 410658 |
| Water | MIMS.me.water | "freshwater metagenome" | 449393 |
| Faecal | MIMS.me.host-associated | "gut metagenome" | 749906 |

**Note on faecal package choice:** We recommend `MIMS.me.host-associated` over `MIMS.me.environmental` because it includes the `host` field, which is both scientifically critical (host species is central to the ecological network) and required by the package. The host value should be the DNA-confirmed species (Latin binomial). For samples where DNA host ID failed, use the field identification with a note in `identificationRemarks`.

**Alternative considered:** Using `MIMS.me.soil` for soil and `MIMS.me.water` for water (rather than the generic `MIMS.me.environmental`) gives access to environment-specific fields (soil pH, temperature, depth; water temperature, turbidity) that NCBI recognizes natively.

### Inheritance Model

```
BioSample (abstract)
├── Common fields (23 slots): barcode_id, date, lat/lon, habitat, etc.
├── SoilSample (7 additional): pH, temp, moisture, depth, burn history
├── WaterSample (8 additional): filtration vol, waterbody type, flow, etc.
└── FaecalSample (15 additional): host species, guild, faecal age, etc.
```

This uses LinkML's `is_a` inheritance. The abstract base class `BioSample` holds all fields common to every sample. Subclasses add type-specific fields. When generating NCBI submission templates, each subclass maps to a different BioSample package, and only the relevant fields are included.

---

## 4. Verbatim + Standardized Field Strategy

For fields where the source data has known inconsistencies, the schema implements paired fields:

| Standardized Field | Verbatim Field | Purpose |
|---|---|---|
| `country` (CountryEnum) | `country_verbatim` | "Republic of the Congo" vs "r.congo" |
| `park_name` (ParkNameEnum) | `park_name_verbatim` | "Odzala-Kokoua" vs "Odzala Okoua" |
| `habitat` (HabitatEnum) | `habitat_verbatim` | "bai" vs "Bai" |
| `collection_date` (date) | `collection_date_verbatim` | ISO 8601 vs "8/10/2024" |
| `host_taxon_id` | `host_species_field_verbatim` | Latin name vs "lion" |

**Processing rule:** During ETL (Extract, Transform, Load), the standardized field is populated by a lookup/transformation, while the verbatim field preserves the original value exactly. This means:

- NCBI submissions use standardized values
- GBIF publications use standardized values
- Traceability back to the original spreadsheet is always possible
- No information is lost through harmonization

---

## 5. Derived Fields

Three fields are computed from other fields and should be generated during ETL, not entered manually:

| Derived Field | Formula | NCBI Usage |
|---|---|---|
| `geo_loc_name` | `"{country}: {park_name} National Park"` | Required |
| `lat_lon` | `"{abs(lat)} {'N' if lat>=0 else 'S'} {abs(lon)} {'E' if lon>=0 else 'W'}"` | Required |
| `env_medium` | Lookup from `sample_type` → ENVO term | Required |

---

## 6. What's Blocking NCBI Submission

### Can Submit Now (with current data)

These NCBI-required fields are available from the existing spreadsheets:

- `sample_name` ← `barcode_id` ✅
- `organism` ← determined by sample type ✅
- `collection_date` ← `date` / `_date` (after format normalization) ✅
- `geo_loc_name` ← derived from `country` + `park_name` ✅
- `lat_lon` ← derived from `latitude` + `longitude` ✅
- `env_broad_scale` / `env_local_scale` / `env_medium` ← mappable from habitat + sample_type ✅ (once ENVO mapping done)
- `host` (faecal only) ← `DNA_species_ID` ✅

### Blocked — Awaiting Jonah Ventures

These are needed for SRA submission (raw sequence data):

| Field | Status | Impact |
|---|---|---|
| Sequencing platform/instrument | TBD | SRA required |
| Library layout (paired/single) | TBD | SRA required |
| Primer sequences (12S, trnL) | TBD | SRA + DwC DNA extension |
| Bioinformatics pipeline | TBD | SRA metadata, DwC identificationRemarks |
| Reference database | TBD | DwC identificationReferences |

**Recommendation:** BioSample registration can proceed independently of SRA. Consider registering BioSamples now (to lock in accession numbers) and adding SRA data once Jonah Ventures provides FASTQs and method details.

---

## 7. Recommendations: Extra Work That Prevents Future Problems

### 7.1 ENVO Mapping (HIGH PRIORITY)

**What:** Map each `habitat` value to specific ENVO terms for `env_broad_scale`, `env_local_scale`, and `env_medium`.

**Why:** NCBI requires these as formatted ENVO terms. GBIF benefits from them too. Getting this right now prevents revision after submission.

**Effort:** ~2 days. 20 habitat values × 3 ENVO fields = ~60 mappings. Some habitats (like "bai") may not have exact ENVO matches and will need the nearest parent term.

**Draft mapping to get started:**

| habitat | env_broad_scale (biome) | env_local_scale |
|---|---|---|
| forest | tropical moist broadleaf forest biome [ENVO:01000228] | forest [ENVO:00000111] |
| bai | tropical moist broadleaf forest biome [ENVO:01000228] | forest clearing [ENVO:00000149] |
| savanna_woodland | tropical savanna biome [ENVO:01000178] | woodland [ENVO:00000109] |
| grassland | tropical savanna biome [ENVO:01000178] | grassland [ENVO:00000106] |
| flood_plain | tropical savanna biome [ENVO:01000178] | flood plain [ENVO:00000255] |
| wetlands | tropical savanna biome [ENVO:01000178] | wetland [ENVO:00000043] |
| desert_dune | desert biome [ENVO:01000179] | dune [ENVO:00000170] |
| desert_gravelplain | desert biome [ENVO:01000179] | gravel plain [ENVO:TBD] |
| riverine | — (varies by park biome) | river [ENVO:00000022] |

*Note: The biome-level mapping is park-dependent. Odzala-Kokoua is tropical forest; Iona is desert; the others are savanna. This should be encoded as a park × habitat → ENVO lookup.*

### 7.2 Protocol Registration (MEDIUM PRIORITY)

**What:** Register field sampling and lab protocols on protocols.io (or similar).

**Why:** Both NCBI and Darwin Core have fields for referencing protocols (`dwc:samplingProtocol`, SRA library construction protocol). A registered protocol has a persistent DOI, is citable, and makes the data much more reproducible and trustworthy.

**Effort:** ~1 week total. Three protocols needed:
1. Soil eDNA sampling protocol
2. Water eDNA filtration protocol
3. Faecal sample collection protocol

The lab/bioinformatics protocol is likely Jonah Ventures' responsibility, but ask them if they have one registered.

**Impact:** This is exactly the kind of thing reviewers and funders notice. It also ensures that if MENA scales to more parks, future field teams follow the same methods.

### 7.3 Taxonomy Validation (MEDIUM PRIORITY)

**What:** Validate all species names (host and detected) against the NCBI Taxonomy and GBIF Backbone Taxonomy.

**Why:** Misspelled or outdated names will cause NCBI submission errors and GBIF indexing failures. Catching these now is far easier than fixing them after 6,000+ records are published.

**Specific issues spotted:**
- `Gorilla Gorilla` (capitalized genus in 12S results — should be `Gorilla gorilla`)
- `Profelis aurata` (synonym — current accepted name is `Caracal aurata`)
- `Giraffa camelopardalis antiquorum` — subspecies may need special handling
- Family-level and genus-level IDs (e.g., `Herpestidae`, `Dendroaspis`) — need `taxonRank` set correctly

**Effort:** ~1-2 days with scripted validation against NCBI Taxonomy API or GBIF species match API.

### 7.4 Coordinate Sensitivity Review (MEDIUM PRIORITY)

**What:** Review GPS coordinates for critically endangered species (e.g., Diceros bicornis — black rhino) and decide whether to generalize coordinates for public-facing datasets.

**Why:** Poaching is a real threat. Precise GPS locations of black rhino dung could be exploited. GBIF allows coordinate generalization (e.g., to 0.1° or park centroid). NCBI does not generalize coordinates but does support controlled access.

**Options:**
- Generalize coordinates in GBIF to 0.1° (~11km) for sensitive species
- Use park centroid for all GBIF records (simpler but loses spatial information)
- Submit precise coordinates to NCBI with controlled access, full precision to GBIF with generalization for specific taxa

**Recommendation:** Discuss with Jordana and African Parks security team. This is a decision that's very hard to reverse once data is public.

### 7.5 Barcode Cross-Validation (LOW PRIORITY BUT QUICK)

**What:** Verify that all barcode_ids in the 12S results file have corresponding entries in the faecal metadata file, and vice versa.

**Why:** Orphaned records (sequences without metadata, or metadata without sequences) will cause problems during both NCBI submission and GBIF publication.

**Effort:** ~1 hour scripted check.

### 7.6 RunId Reconciliation (LOW PRIORITY — BLOCKED)

**What:** Clarify why some `RunId_12SVert` values in the faecal metadata are dates rather than Jonah Ventures run codes.

**Why:** This affects how we populate the SequencingRun entity. If dates represent pending runs, those samples may not yet have results.

**Status:** Blocked — awaiting Jonah Ventures response (Question A.13 in the revised questions document).

---

## 8. GBIF Publication Architecture

Based on the confirmed plan to publish through African Parks' GBIF publisher via SANBI:

### Dataset Structure

**Recommended:** One dataset per park, published as **Event Core + Occurrence Extension + DNA Derived Data Extension**.

```
Event Core (sampling events)
├── eventID: {park_name}_{location_type}_{barcode_id}
├── eventDate, decimalLatitude, decimalLongitude
├── country, locality, habitat
├── samplingProtocol: "eDNA metabarcoding, {marker}"
│
├── Occurrence Extension (detected taxa)
│   ├── occurrenceID: {barcode_id}_{marker}_{esv_id}
│   ├── scientificName, taxonRank, kingdom...family...genus
│   ├── organismQuantity, organismQuantityType
│   ├── associatedTaxa: "host: {host_latin_name}" (for faecal)
│   └── basisOfRecord: "MaterialSample"
│
└── DNA Derived Data Extension
    ├── DNA_sequence: {esv_sequence}
    ├── pcr_primer_name_forward / pcr_primer_name_reverse
    ├── pcr_primer_seq_forward / pcr_primer_seq_reverse
    ├── target_gene: "12S rRNA" or "trnL"
    └── sop: {protocol DOI, if registered}
```

**Why one dataset per park:** Matches the one-BioProject-per-park structure on NCBI. Allows each park's data to be published as it's ready, without waiting for all five. Also allows park-level DOIs for citation.

**Host organisms as occurrences:** For faecal samples, the host animal is also a biodiversity observation. Publish host occurrences in the same dataset, with `basisOfRecord = "MaterialSample"` and `identificationRemarks = "host organism identified by DNA from faecal sample"`. This doubles the biodiversity value of the dataset.

### Alternative Considered: Metabarcoding Data Toolkit (MDT)

GBIF's MDT is designed for exactly this type of data. However, for a dataset of this complexity (three sample types, multiple markers, host + prey occurrences, rich metadata), a scripted conversion pipeline gives more control. **Recommendation:** Use MDT for initial prototyping/validation with a small subset, then build a custom Python/R pipeline for the full dataset.

---

## 9. Coordination with Jonah Ventures on SRA

The confirmed plan is that Jonah Ventures will submit FASTQs to SRA. This requires coordination:

### Recommended Workflow

1. **African Parks registers the umbrella BioProject** and five child BioProjects.
2. **African Parks registers BioSamples** for all ~6,077 samples (451 soil + 217 water + 5,409 faecal), receiving SAMN accession numbers.
3. **African Parks provides Jonah Ventures** with a mapping file: `barcode_id → SAMN accession → BioProject accession`.
4. **Jonah Ventures submits FASTQs to SRA**, referencing the BioSample accessions and park-level BioProject accessions.

This way African Parks controls the metadata and project structure, while Jonah Ventures handles the sequence data they generated.

**Risk if not coordinated:** If Jonah Ventures creates their own BioProject/BioSamples independently, there will be duplicate records, broken links, and significant cleanup needed.

---

## 10. Schema Gaps and Future Work

| Gap | When to Address | Notes |
|---|---|---|
| trnL results file | When available | Add plant-specific occurrence fields if needed |
| Additional markers (16S, 18S, COI, ITS) | When results available | MarkerEnum already includes placeholders |
| ENVO mappings | Before BioSample submission | Section 7.1 |
| Primer sequences | When Jonah Ventures responds | Slots exist, values TBD |
| Sequencing platform/instrument | When Jonah Ventures responds | Slots exist, values TBD |
| Bioinformatics pipeline details | When Jonah Ventures responds | For `identificationRemarks` |
| Coordinate sensitivity policy | Before GBIF publication | Section 7.4 |

---

## 11. File Inventory and How They Map

| Source File | Entity | Records | Processing Needed |
|---|---|---|---|
| Soil metadata xlsx | SoilSample | 451 | Normalize country, park, habitat, dates |
| Water metadata xlsx | WaterSample | 217 | Add country column (derive from park); normalize |
| Faecal metadata xlsx | FaecalSample + Assay | 5,409 | Split sample vs assay/run fields; normalize |
| 12S Vert results xlsx | Occurrence (+ Assay context) | 6,560 | Link to FaecalSample via barcode; validate taxonomy |

---

*This document should be updated as answers come in from Jonah Ventures and the African Parks team.*

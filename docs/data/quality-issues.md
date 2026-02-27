# Data Quality Issues

Issues identified during initial data review. Each must be resolved before NCBI/GBIF submission.

## Naming Inconsistencies

These are handled by the verbatim + standardized field strategy. Original values are preserved in `_verbatim` fields.

### Country Names

| Source Variants | Standardized | ISO Code |
|---|---|---|
| `rwanda` | Rwanda | RW |
| `chad` | Chad | TD |
| `angola` | Angola | AO |
| `r.congo`, `rep.congo` | Republic of the Congo | CG |
| `zambia`, `Zambia` | Zambia | ZM |

### Park Names

| Source Variants | Standardized |
|---|---|
| `Odzala Okoua`, `Odzala-Kokoua` | Odzala-Kokoua |
| `iona`, `Iona` | Iona |
| `Akagera` | Akagera |
| `Zakouma` | Zakouma |
| `Kafue` | Kafue |

### Habitat Terms

| Issue | Examples |
|---|---|
| Capitalization | `Bai` vs `bai` |
| Singular vs plural | `woodland` vs `woodlands` |
| Variant spelling | `desert_dunes` vs `desert_dune` |
| Non-breaking space | `\xa0` appearing as a habitat value |
| Zero value | `0` appearing as a habitat value |

## Structural Issues

### Mixed RunId Formats (Faecal)

The `RunId_12SVert` column contains two types of values:

- **Run codes:** `JV280`, `JV327`, `JV339`, etc. (~33 distinct codes)
- **Dates:** `2024-11-25`, `2025-03-14`, etc. (~10 distinct dates)

!!! warning "Awaiting Clarification"
    This is [Question A.18](../questions/jonah-ventures.md) for Jonah Ventures. The date values may represent unsequenced samples or a data entry convention.

### Missing Country in Water Metadata

The water metadata file has no `country` column. Country must be inferred from `name_of_park`:

| `name_of_park` | Country |
|---|---|
| `iona` | Angola |
| `kafue` | Zambia |
| `akagera` | Rwanda |
| `zakouma` | Chad |
| `odzala-kokoua` | Republic of the Congo |

### Date Format Variation

- Soil: String format `M/D/YYYY` (e.g., `8/10/2024`)
- Faecal: Mixed datetime objects and strings
- Water: String format `M/D/YYYY`
- 12S results: Datetime objects (e.g., `2024-11-08`)

All will be normalized to ISO 8601 (`YYYY-MM-DD`) for NCBI/GBIF.

### Barcode ID Format Variation

- Soil & Faecal: `S0XXXXX` (e.g., `S080121`, `S060201`)
- Water: Park-based codes (e.g., `APANGW01.1`)

### Taxonomy Issues Spotted

| Issue | Example | Fix |
|---|---|---|
| Capitalized species | `Gorilla Gorilla` | Should be `Gorilla gorilla` |
| Synonym | `Profelis aurata` | Accepted: `Caracal aurata` |
| Subspecies | `Giraffa camelopardalis antiquorum` | Needs `taxonRank` handling |
| Family-level only | `Herpestidae` | `taxonRank = "family"` |
| Genus-level only | `Dendroaspis` | `taxonRank = "genus"` |

!!! tip "Recommendation"
    Validate all species names against NCBI Taxonomy and GBIF Backbone Taxonomy before submission. See [Recommendations](../design/recommendations.md#taxonomy-validation).

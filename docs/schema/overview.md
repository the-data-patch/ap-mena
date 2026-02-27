# Schema Overview

The MENA eDNA schema is written in [LinkML](https://linkml.io/) and defines the data model for all sample types, sequencing assays, and taxonomic occurrences in the project.

**Schema file:** [`src/mena_edna/mena_edna_schema.yaml`](https://github.com/sformel/ap-mena/blob/main/src/mena_edna/mena_edna_schema.yaml)

**Version:** 0.1.0 (Draft)

## Design Principles

1. **Prevent future problems.** Every field that NCBI or GBIF might require is represented from the start, even if the value is currently TBD.

2. **Segregate NCBI-essential from project-specific.** Every field description is tagged with its purpose:

    | Tag | Count | Meaning |
    |---|---|---|
    | `NCBI_REQUIRED` | 17 | Must be populated for BioSample/SRA submission |
    | `NCBI_RECOMMENDED` | 19 | Strongly encouraged by NCBI |
    | `DWC_REQUIRED` | 9 | Must be populated for GBIF publication |
    | `DWC_RECOMMENDED` | 6 | Improves GBIF data quality |
    | `PROJECT_SPECIFIC` | 13 | Essential for MENA science, not required by any repo |
    | `DERIVED` | 3 | Computed from other fields |

3. **Preserve verbatim values.** For every field with source data inconsistencies, the schema includes both a standardized slot and a `_verbatim` slot for traceability.

## At a Glance

- **10 classes** (entities)
- **99 slots** (fields)
- **9 enumerations** (controlled vocabularies)

See [Entity Model](entity-model.md) for the full class hierarchy and [Field Reference](field-reference.md) for the complete field list.

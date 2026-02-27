# Recommendations

Extra work that prevents future problems or improves data quality. Ranked by priority.

## ENVO Mapping {: #envo-mapping }

🔴 **HIGH PRIORITY** — Blocks BioSample submission

**What:** Map each `habitat` value to ENVO terms for `env_broad_scale`, `env_local_scale`, and `env_medium`.

**Why:** NCBI requires these as formatted ENVO terms (e.g., `"tropical moist broadleaf forest biome [ENVO:01000228]"`). Getting this right now prevents revision after submission.

**Effort:** ~2 days. 20 habitat values × 3 ENVO fields.

**Note:** The biome-level mapping (`env_broad_scale`) is park-dependent:

| Park | Biome |
|---|---|
| Odzala-Kokoua | Tropical moist broadleaf forest |
| Iona | Desert |
| Akagera, Zakouma, Kafue | Tropical savanna |

## Protocol Registration {: #protocol-registration }

🟡 **MEDIUM PRIORITY** — Improves reproducibility and data trust

**What:** Register field sampling and lab protocols on [protocols.io](https://protocols.io) or Zenodo.

**Why:** Both NCBI and Darwin Core reference protocol DOIs (`dwc:samplingProtocol`, SRA library protocol). A registered protocol is citable and ensures future field teams follow the same methods.

**Effort:** ~1 week total. Three protocols:

1. Soil eDNA sampling protocol
2. Water eDNA filtration protocol
3. Faecal sample collection protocol

Lab/bioinformatics protocols are the responsibility of Jonah Ventures and University of Porto.

## Taxonomy Validation {: #taxonomy-validation }

🟡 **MEDIUM PRIORITY** — Prevents submission errors

**What:** Validate all species names (host and detected) against NCBI Taxonomy and GBIF Backbone Taxonomy.

**Why:** Misspelled or outdated names cause submission errors and indexing failures.

**Known issues:**

| Issue | Example | Fix |
|---|---|---|
| Capitalized species | `Gorilla Gorilla` | → `Gorilla gorilla` |
| Synonym | `Profelis aurata` | → `Caracal aurata` |
| Subspecies | `Giraffa camelopardalis antiquorum` | Set `taxonRank` appropriately |
| Family-level ID | `Herpestidae` | `taxonRank = "family"` |

**Effort:** ~1–2 days with scripted validation against NCBI Taxonomy API or GBIF species match API.

## Coordinate Sensitivity Review {: #coordinate-sensitivity }

🟡 **MEDIUM PRIORITY** — Hard to reverse once public

**What:** Review GPS coordinates for critically endangered species (e.g., *Diceros bicornis* — black rhino) and decide on generalization.

**Why:** Precise GPS of black rhino dung could be exploited by poachers. GBIF allows coordinate generalization; NCBI does not but supports controlled access.

**Options:**

- Generalize to 0.1° (~11km) for sensitive species in GBIF
- Use park centroid for all GBIF records
- Full precision to NCBI with controlled access

**Recommendation:** Discuss with African Parks security team before publication.

## Barcode Cross-Validation {: #barcode-validation }

🟢 **LOW PRIORITY** (but quick)

**What:** Verify all `barcode_id` values in the 12S results have matching faecal metadata entries, and vice versa.

**Why:** Orphaned records (sequences without metadata, or metadata without sequences) cause problems during NCBI and GBIF submission.

**Effort:** ~1 hour scripted.

## RunId Reconciliation {: #runid-reconciliation }

⏳ **BLOCKED** — Awaiting Jonah Ventures response

**What:** Clarify why some `RunId_12SVert` values in the faecal metadata are dates rather than run codes.

**Why:** Affects how we populate the SequencingRun entity.

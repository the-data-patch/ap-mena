# Field Reference

Complete list of all fields in the MENA eDNA schema, organized by entity.

## How to Read This Table

- **Required** = must be populated for the entity to be valid
- **Tag** = which repository/purpose needs this field (see legend)

| Tag | Meaning |
|---|---|
| `NCBI-R` | NCBI Required |
| `NCBI-rec` | NCBI Recommended |
| `DWC-R` | Darwin Core Required (for GBIF) |
| `DWC-rec` | Darwin Core Recommended |
| `PROJ` | Project-specific (MENA science) |
| `DERIV` | Computed from other fields |

---

## BioSample — Common Fields (all sample types)

| Field | Type | Required | Tag | Maps To |
|---|---|---|---|---|
| `barcode_id` | string | ✅ | `NCBI-R` | BioSample `sample_name` |
| `sample_name` | string | | `PROJ` | — |
| `lab_id` | string | | `PROJ` | — |
| `biosample_accession` | string | | `NCBI-R` | Assigned after registration |
| `sample_type` | SampleTypeEnum | ✅ | `NCBI-R` | Determines BioSample package |
| `collection_date` | date | ✅ | `NCBI-R` `DWC-R` | `collection_date` · `dwc:eventDate` |
| `collection_date_verbatim` | string | | `QC` | — |
| `collection_time` | string | | `NCBI-rec` | Appended to `collection_date` |
| `collection_year` | integer | | `PROJ` | — |
| `latitude` | double | ✅ | `NCBI-R` `DWC-R` | Part of `lat_lon` · `dwc:decimalLatitude` |
| `longitude` | double | ✅ | `NCBI-R` `DWC-R` | Part of `lat_lon` · `dwc:decimalLongitude` |
| `lat_lon` | string | | `DERIV` | NCBI `lat_lon` |
| `geo_loc_name` | string | | `DERIV` | NCBI `geo_loc_name` |
| `habitat` | HabitatEnum | | `NCBI-rec` `DWC-rec` | Source for ENVO terms · `dwc:habitat` |
| `habitat_verbatim` | string | | `QC` | — |
| `env_broad_scale` | string | | `NCBI-R` | ENVO biome term |
| `env_local_scale` | string | | `NCBI-R` | ENVO local environment term |
| `env_medium` | string | | `NCBI-R` | ENVO material term |
| `has_it_rained_in_the_past_week` | string | | `PROJ` | — |
| `collector` | string | | `DWC-rec` | `dwc:recordedBy` |
| `collection_notes` | string | | `PROJ` | — |
| `country` | CountryEnum | ✅ | `NCBI-R` `DWC-R` | Part of `geo_loc_name` · `dwc:country` |
| `country_verbatim` | string | | `QC` | — |

## SoilSample — Additional Fields

| Field | Type | Required | Tag | Maps To |
|---|---|---|---|---|
| `soil_type` | string | | `NCBI-rec` | MIMS.me.soil `soil_type` |
| `soil_moisture` | string | | `NCBI-rec` | MIMS.me.soil `water_content` |
| `soil_depth` | string | | `NCBI-rec` | MIMS.me.soil `depth` |
| `soil_temperature` | string | | `NCBI-rec` | MIMS.me.soil `temp` |
| `soil_ph` | string | | `NCBI-rec` | MIMS.me.soil `ph` |
| `burned_2024` | string | | `PROJ` | — |
| `burn_frequency` | string | | `PROJ` | — |

## WaterSample — Additional Fields

| Field | Type | Required | Tag | Maps To |
|---|---|---|---|---|
| `water_collection_method` | string | | `PROJ` | — |
| `waterbody_type` | string | | `NCBI-rec` | MIMS.me.water context |
| `water_body_name` | string | | `DWC-rec` | `dwc:waterBody` |
| `waterbody_substrate` | string | | `NCBI-rec` | — |
| `water_flow` | string | | `NCBI-rec` | — |
| `transparency` | string | | `NCBI-rec` | MIMS.me.water `turbidity` |
| `water_filtered_ml` | float | | `NCBI-rec` `DWC-rec` | `dwc:sampleSizeValue` |
| `water_temperature_c` | float | | `NCBI-rec` | MIMS.me.water `temp` |

## FaecalSample — Additional Fields

| Field | Type | Required | Tag | Maps To |
|---|---|---|---|---|
| `host_species_field` | string | | `PROJ` | — |
| `host_species_field_verbatim` | string | | `QC` | — |
| `host_taxon_id` | string | ✅ | `NCBI-R` | MIMS.me.host-associated `host` |
| `host_common_name` | string | | `NCBI-rec` | `host_common_name` |
| `host_taxonomic_order` | string | | `PROJ` | — |
| `host_taxonomic_family` | string | | `PROJ` | — |
| `host_diet_type` | string | | `NCBI-rec` | `host_diet` |
| `ecological_guild` | EcologicalGuildEnum | | `PROJ` | — |
| `faecal_age` | FaecalAgeEnum | | `PROJ` | — |
| `faecal_texture` | string | | `PROJ` | — |
| `host_sex` | string | | `NCBI-rec` `DWC-rec` | `host_sex` · `dwc:sex` |
| `host_age_class` | string | | `NCBI-rec` | `host_age` |
| `is_latrine` | string | | `PROJ` | — |
| `has_swab` | string | | `PROJ` | — |
| `swab_barcode_id` | string | | `PROJ` | — |

## Assay

| Field | Type | Required | Tag | Maps To |
|---|---|---|---|---|
| `assay_id` | string | ✅ | — | Internal key |
| `barcode_id` | string | ✅ | — | Links to BioSample |
| `marker` | MarkerEnum | ✅ | `NCBI-R` `DWC-R` | SRA `target_gene` · DwC DNA ext |
| `primer_forward_name` | string | | `DWC-rec` | DwC DNA ext `pcr_primer_name_forward` |
| `primer_forward_sequence` | string | | `DWC-rec` | DwC DNA ext `pcr_primer_seq_forward` |
| `primer_reverse_name` | string | | `DWC-rec` | DwC DNA ext `pcr_primer_name_reverse` |
| `primer_reverse_sequence` | string | | `DWC-rec` | DwC DNA ext `pcr_primer_seq_reverse` |
| `total_reads` | integer | | `PROJ` | — |
| `total_esvs` | integer | | `PROJ` | — |

## SequencingRun

| Field | Type | Required | Tag | Maps To |
|---|---|---|---|---|
| `run_id` | string | ✅ | `SRA` | SRA Run ID |
| `sra_accession` | string | | `SRA` | Assigned after upload |
| `date_run` | date | | `NCBI-rec` | — |
| `date_first_analyzed` | date | | `PROJ` | — |
| `sequencing_platform` | string | | `SRA` | SRA `platform` |
| `sequencing_instrument` | string | | `SRA` | SRA `instrument_model` |
| `library_layout` | string | | `SRA` | SRA `library_layout` |

## Occurrence

| Field | Type | Required | Tag | Maps To |
|---|---|---|---|---|
| `occurrence_id` | string | ✅ | `DWC-R` | `dwc:occurrenceID` |
| `dna_sequence` | string | | `DWC-R` | DwC DNA ext `DNA_sequence` |
| `replicate_esv_id` | string | | `PROJ` | — |
| `scientific_name` | string | ✅ | `DWC-R` | `dwc:scientificName` |
| `common_name` | string | | `DWC-rec` | `dwc:vernacularName` |
| `taxon_kingdom` | string | | `DWC-rec` | `dwc:kingdom` |
| `taxon_class` | string | | `DWC-rec` | `dwc:class` |
| `taxon_order` | string | | `DWC-rec` | `dwc:order` |
| `taxon_family` | string | | `DWC-rec` | `dwc:family` |
| `taxon_genus` | string | | `DWC-rec` | `dwc:genus` |
| `taxon_rank` | string | | `DWC-R` | `dwc:taxonRank` |
| `percent_match` | float | | `DWC-rec` | In `dwc:identificationRemarks` |
| `sequence_reads` | integer | | `DWC-rec` | `dwc:organismQuantity` |
| `relative_read_abundance` | float | | `DWC-rec` | `dwc:organismQuantity` |
| `detected_species_type` | string | | `PROJ` | — |
| `detected_diet_type` | string | | `PROJ` | — |
| `identification_references` | string | | `DWC-rec` | `dwc:identificationReferences` |
| `identification_remarks` | string | | `DWC-rec` | `dwc:identificationRemarks` |

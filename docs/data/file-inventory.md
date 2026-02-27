# File Inventory

## Source Data Files

| File | Sheet | Records | Sample Type | Key Content |
|---|---|---|---|---|
| `MENA_AFRICAN_PARKS_SOIL_METADATA_2023_24.xlsx` | `soil_metadata` | 451 | Soil | GPS, habitat, soil properties (pH, temp, moisture, depth), burn history |
| `MENA_AFRICAN_PARKS_WATER_eDNA_METADATA_2023_25.xlsx` | `Sheet1` | 217 | Water | GPS, habitat, filtration volume, waterbody type/substrate/flow |
| `MENA_AFRICAN_PARKS_FAECAL_METADATA_2023-2024_final.xlsx` | `Diet_Metadata` | 5,409 | Faecal | GPS, habitat, host species (field + DNA), guild, + run/assay info |
| `MENA_AFRICAN_PARKS_12S_VERT_SEQ_2023-2024_final.xlsx` | `12S.VERT_Clean` | 6,560 | Results | ESV detections: sequence, taxonomy, % match, reads, RRA |

## Record Counts by Park

| Park | Country | Soil | Water | Faecal | 12S Results |
|---|---|---|---|---|---|
| Akagera | Rwanda | ✅ | ✅ | ✅ | ✅ |
| Zakouma | Chad | ✅ | ✅ | ✅ | ✅ |
| Odzala-Kokoua | Rep. Congo | ✅ | ✅ | ✅ | ✅ |
| Iona | Angola | ✅ | ✅ | ✅ | ✅ |
| Kafue | Zambia | ✅ | ✅ | ✅ | ✅ |

!!! note "Exact per-park counts TBD"
    Detailed breakdowns by park × location_type will be added once data validation is complete.

## Sequencing Approaches by Sample Type

| Sample Type | Lab | Approach | Markers |
|---|---|---|---|
| Faecal | Jonah Ventures | Amplicon | 12S vertebrate, trnL (plant) |
| Soil | Jonah Ventures | Shotgun metagenomics | WGS (16S amplicon planned) |
| Water | University of Porto / CBO | Amplicon | 16SU, Vertebrate 12S |

## Expected Additional Files

| File | Status | Source |
|---|---|---|
| trnL plant diet results (faecal) | Not yet received | Jonah Ventures |
| 16SU / 12S results (water) | Not yet received | University of Porto |
| Shotgun metagenomics results (soil) | Not yet received | Jonah Ventures |
| 16S amplicon results (soil) | Planned, not started | Jonah Ventures |

# Enumerations

The schema defines 9 controlled vocabularies (enums). Values in the source spreadsheets are preserved in `_verbatim` fields; the standardized enum values are used for NCBI/GBIF submission.

## SampleTypeEnum

| Value | Description |
|---|---|
| `soil` | Environmental soil sample |
| `water` | Filtered environmental water sample (eDNA) |
| `faecal` | Faecal/dung sample from wildlife or domestic animal |

## LocationTypeEnum

| Value | Description |
|---|---|
| `park` | Inside the managed protected area |
| `control` | Outside park boundaries; unmanaged comparison site |

## CountryEnum

Standardized to INSDC vocabulary (required for NCBI `geo_loc_name`).

| Value | ISO Code | Source Variants |
|---|---|---|
| `Rwanda` | RW | rwanda |
| `Chad` | TD | chad |
| `Angola` | AO | angola |
| `Republic of the Congo` | CG | r.congo, rep.congo |
| `Zambia` | ZM | zambia, Zambia |

## ParkNameEnum

| Value | Country | Source Variants |
|---|---|---|
| `Akagera` | Rwanda | Akagera |
| `Zakouma` | Chad | Zakouma |
| `Odzala-Kokoua` | Republic of the Congo | Odzala Okoua, Odzala-Kokoua |
| `Iona` | Angola | Iona, iona |
| `Kafue` | Zambia | Kafue |

## HabitatEnum

20 values. Each should be mapped to an ENVO term.

!!! warning "ENVO Mapping Incomplete"
    The ENVO term mapping for `env_broad_scale` and `env_local_scale` is in progress. See [Recommendations](../design/recommendations.md#envo-mapping).

| Value | Description | ENVO Mapping Status |
|---|---|---|
| `bai` | Forest clearing (Odzala-Kokoua) | 🟡 TBD |
| `flood_plain` | Seasonally flooded plain | ✅ ENVO:00000255 |
| `forest` | Tropical forest | ✅ ENVO:00000111 |
| `grassland` | Grassland | ✅ ENVO:00000106 |
| `savanna_woodland` | Savanna woodland | ✅ ENVO:00000178 |
| `woodland` | Woodland | ✅ ENVO:00000109 |
| `shrubland` | Shrubland | ✅ ENVO:00000300 |
| `wetlands` | Wetland | ✅ ENVO:00000043 |
| `riverine` | Riverine habitat | ✅ ENVO:00000022 |
| `mountain` | Montane habitat | 🟡 TBD |
| `desert_dune` | Desert dune | ✅ ENVO:00000170 |
| `desert_gravelplain` | Desert gravel plain | 🟡 TBD |
| `desert_grassplain` | Desert grass plain | 🟡 TBD |
| `riverbed` | Dry or seasonal riverbed | 🟡 TBD |
| `agriculture` | Agricultural land | 🟡 TBD |
| `human_area` | Human-modified area | 🟡 TBD |
| `boma` | Livestock enclosure / kraal | 🟡 TBD |
| `savanna` | Open savanna | 🟡 TBD |
| `river` | Active river channel | 🟡 TBD |
| `unknown` | Not recorded | N/A |

## MarkerEnum

| Value | Target | Used In |
|---|---|---|
| `12S_vertebrate` | Vertebrate species (prey/diet) | Faecal, Water |
| `trnL` | Plant species (diet) | Faecal |
| `16S` | Bacteria/archaea | Water (16SU), Soil (planned) |
| `18S` | Eukaryotes | TBD |
| `COI` | Invertebrates | TBD |
| `ITS` | Fungi | TBD |

## EcologicalGuildEnum

18 trophic guild classifications. Project-specific; not required by NCBI or GBIF but central to the ecological network analysis.

| Value | Description |
|---|---|
| `Browser` | Feeds primarily on leaves, soft shoots, and fruits of woody plants |
| `Browser-Frugivore` | Browses on woody plants and consumes significant fruit |
| `Browser-Grazer` | Mixed feeder; browses and grazes |
| `Carnivore` | Feeds primarily on animal tissue |
| `Carnivore-Omnivore` | Primarily carnivorous, also consumes non-animal food |
| `Folivore` | Feeds primarily on leaves |
| `Grazer` | Feeds primarily on grasses |
| `Grazer-Omnivore` | Primarily grazes, also consumes non-grass food |
| `Herbivore` | General herbivore |
| `Herbivore-Frugivore` | Herbivore with significant fruit consumption |
| `Herbivore-Omnivore` | Primarily herbivorous, also consumes animal food |
| `Hypercarnivore` | Obligate carnivore (>70% animal tissue) |
| `Insectivore` | Feeds primarily on insects/arthropods |
| `Mixed Feeder` | No dominant food type |
| `Omnivore` | Plant and animal material in roughly equal measure |
| `Omnivore-Frugivore` | Omnivore with significant fruit consumption |
| `Scavenger` | Feeds primarily on carrion |
| `Scavenger-Carnivore` | Scavenges and actively hunts |

## FaecalAgeEnum

| Value | Description |
|---|---|
| `observed` | Defecation directly observed |
| `less_than_24hr` | Estimated <24 hours old |
| `greater_than_24hr` | Estimated >24 hours old |
| `1-2_days` | Estimated 1–2 days old |
| `2_days` | Estimated ~2 days old |
| `3-7_days` | Estimated 3–7 days old |
| `greater_than_2_weeks` | Estimated >2 weeks old |
| `old` | Visibly old, age not further estimated |
| `unknown` | Age could not be estimated |
| `other` | Other (see notes) |

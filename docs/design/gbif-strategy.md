# GBIF Publication Strategy

## Publisher

**African Parks** — registered GBIF publisher: [https://www.gbif.org/publisher/109b8e18-d6d8-4f8f-9313-9ee851959c5b](https://www.gbif.org/publisher/109b8e18-d6d8-4f8f-9313-9ee851959c5b)

Published via the **SANBI** GBIF node.

## Dataset Structure

**One dataset per park**, published as **Event Core + Occurrence Extension + DNA Derived Data Extension**.

This mirrors the one-BioProject-per-park structure on NCBI and allows incremental publication.

## Darwin Core Archive Structure

```
Event Core
├── eventID: {park}_{location}_{barcode_id}
├── parentEventID: {park}_{location}  (links to study site)
├── eventDate
├── decimalLatitude / decimalLongitude
├── country / countryCode
├── locality: "{park_name} National Park"
├── habitat
├── samplingProtocol: "eDNA metabarcoding, {marker}"
│
├── Occurrence Extension
│   ├── occurrenceID: {barcode_id}_{marker}_{esv_id}
│   ├── basisOfRecord: "MaterialSample"
│   ├── scientificName
│   ├── taxonRank
│   ├── kingdom / class / order / family / genus
│   ├── organismQuantity / organismQuantityType
│   ├── associatedTaxa: "host: {host_species}" (faecal prey)
│   ├── identificationRemarks: "% match: {value}; pipeline: {value}"
│   └── identificationReferences: "{reference_database}"
│
└── DNA Derived Data Extension
    ├── DNA_sequence
    ├── pcr_primer_name_forward / pcr_primer_name_reverse
    ├── pcr_primer_seq_forward / pcr_primer_seq_reverse
    ├── target_gene: "12S rRNA" | "trnL" | "16S rRNA"
    ├── target_subfragment
    └── sop: {protocol DOI}
```

## Host Organisms as Occurrences

For faecal samples, the **host animal** is also a biodiversity observation. Publish host occurrences in the same dataset:

- `basisOfRecord`: "MaterialSample"
- `identificationRemarks`: "Host organism identified by DNA from faecal sample"
- `occurrenceID`: `{barcode_id}_host`
- `scientificName`: DNA-confirmed host species

This doubles the biodiversity value of the dataset and is consistent with the project's conservation monitoring goals.

## MDT vs IPT

GBIF's [Metabarcoding Data Toolkit](https://www.gbif.org/tools/metabarcoding-data-toolkit) is designed for publishing eDNA datasets. 


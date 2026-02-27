# MENA eDNA Data Model

## Molecular Ecological Network Analysis — African Parks

This site documents the data model and publishing workflow for the **MENA eDNA project**, which combines environmental DNA metabarcoding with Ecological Network Analysis to assess biodiversity and ecosystem integrity across five African national parks.

!!! info "Project Status"
    **Draft** — Schema v0.1.0. Awaiting responses from Jonah Ventures on sequencing methods before finalizing. See [Status](status.md) for details.

## What is MENA?

The MENA project uses eDNA from **soil**, **water**, and **faecal** samples to detect species presence — from microbes to megafauna — and then reconstructs food webs and trophic relationships to measure ecosystem function. By comparing managed park sites with unmanaged control sites outside park boundaries, MENA provides a science-based framework for measuring conservation effectiveness.

- **Lead organization:** [African Parks](https://www.africanparks.org/)
- **Funder:** Paul G. Allen Foundation (~$1M)
- **Project Manager:** Jordana Morgan Meyer
- **Sequencing:** [Jonah Ventures](https://jonahventures.com/) (faecal, soil) · University of Porto / CBO (water)

## Study Sites

| Park | Country | Biome |
|---|---|---|
| Akagera | Rwanda | Savanna woodland, wetlands, grassland |
| Zakouma | Chad | Flood plain, savanna, woodland |
| Odzala-Kokoua | Republic of the Congo | Tropical forest, bai (forest clearings) |
| Iona | Angola | Desert, riverine |
| Kafue | Zambia | Woodland, flood plain, grassland |

Each park has a **park** site (inside protected area) and a **control** site (outside boundaries).

## Purpose of This Site

This documentation supports three goals:

1. **Data modeling** — A [LinkML schema](schema/overview.md) that defines every entity, field, and controlled vocabulary in the MENA dataset
2. **NCBI submission** — Metadata preparation for BioProject, BioSample, and SRA registration
3. **GBIF publication** — Mapping to Darwin Core and the DNA Derived Data extension for occurrence publishing

## Quick Links

- [Schema overview](schema/overview.md) — Entity model and field classification
- [Data inventory](data/file-inventory.md) — Source files and record counts
- [NCBI strategy](design/ncbi-strategy.md) — BioProject/BioSample/SRA plan
- [GBIF strategy](design/gbif-strategy.md) — Darwin Core mapping and publishing
- [Outstanding questions](questions/all-outstanding.md) — What we still need to know

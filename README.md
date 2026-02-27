# African Parks MENA eDNA Data Model

LinkML data model and project documentation for the **Molecular Ecological Network Analysis (MENA)** project, led by [African Parks](https://www.africanparks.org/).

MENA combines environmental DNA (eDNA) metabarcoding with Ecological Network Analysis to quantify biodiversity and ecosystem integrity across five African protected areas: Akagera (Rwanda), Zakouma (Chad), Odzala-Kokoua (Republic of the Congo), Iona (Angola), and Kafue (Zambia).

## Documentation

📖 **[Project documentation site](https://sformel.github.io/ap-mena/)**

## Repository Structure

```
ap-mena/
├── src/mena_edna/           # LinkML schema source
│   └── mena_edna_schema.yaml
├── project/                 # Generated artifacts (JSON Schema, etc.)
├── docs/                    # MkDocs documentation source
│   ├── index.md
│   ├── schema/              # Schema documentation
│   ├── data/                # Data inventory and quality notes
│   ├── design/              # Design decisions and rationale
│   └── questions/           # Outstanding questions tracker
├── mkdocs.yml               # MkDocs configuration
└── .github/workflows/       # GitHub Actions for deployment
```

## Local Quick Start

```bash
# Install dependencies
pip install linkml mkdocs mkdocs-material

# Serve docs locally
mkdocs serve

# Generate LinkML artifacts
gen-project -d project src/mena_edna/mena_edna_schema.yaml
```

## Status

**Draft** — Schema and documentation are under active development.

## License

Schema and documentation: [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/)

Data license TBD (pending African Parks policy decision).

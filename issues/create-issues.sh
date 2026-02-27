#!/bin/bash
# Run from the ap-mena repo directory
# Usage: bash create-issues.sh

REPO="the-data-patch/ap-mena"

echo "Creating labels..."
gh label create "blocked" --color "d73a4a" --description "Waiting on external input" --repo "$REPO" --force
gh label create "schema" --color "0075ca" --description "LinkML schema work" --repo "$REPO" --force
gh label create "ncbi" --color "7057ff" --description "NCBI BioProject/BioSample/SRA" --repo "$REPO" --force
gh label create "gbif" --color "2ea44f" --description "GBIF / Darwin Core publication" --repo "$REPO" --force
gh label create "data-quality" --color "fbca04" --description "Data validation and cleanup" --repo "$REPO" --force
gh label create "documentation" --color "bfdadc" --description "Docs and protocols" --repo "$REPO" --force
gh label create "policy" --color "f9812a" --description "Organizational decision needed" --repo "$REPO" --force

echo ""
echo "Creating issues..."

gh issue create --repo "$REPO" \
  --title "Register NCBI BioProjects" \
  --label "ncbi" \
  --body-file 01.md

gh issue create --repo "$REPO" \
  --title "Register NCBI BioSamples" \
  --label "ncbi,data-quality" \
  --body-file 02.md

gh issue create --repo "$REPO" \
  --title "Coordinate SRA uploads with sequencing labs" \
  --label "ncbi,blocked" \
  --body-file 03.md

gh issue create --repo "$REPO" \
  --title "Complete ENVO habitat mapping" \
  --label "schema,ncbi" \
  --body-file 04.md

gh issue create --repo "$REPO" \
  --title "Validate taxonomy" \
  --label "data-quality,gbif" \
  --body-file 05.md

gh issue create --repo "$REPO" \
  --title "Awaiting responses from Jonah Ventures" \
  --label "blocked" \
  --body-file 06.md

gh issue create --repo "$REPO" \
  --title "Awaiting responses from Jordana / African Parks" \
  --label "blocked,policy" \
  --body-file 07.md

gh issue create --repo "$REPO" \
  --title "Awaiting responses from University of Porto" \
  --label "blocked" \
  --body-file 08.md

gh issue create --repo "$REPO" \
  --title "Publish to GBIF" \
  --label "gbif" \
  --body-file 09.md

gh issue create --repo "$REPO" \
  --title "Register sampling protocols" \
  --label "documentation" \
  --body-file 10.md

gh issue create --repo "$REPO" \
  --title "Cross-validate barcodes across files" \
  --label "data-quality" \
  --body-file 11.md

echo ""
echo "Done! Created 11 issues."

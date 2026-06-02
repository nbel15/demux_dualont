# Dual-Barcoding ONT Amplicon Demultiplexing Workflow
## Overview

This Nextflow pipeline performs demultiplexing of dual-barcoded Oxford Nanopore Technologies (ONT) amplicon sequencing data starting from POD5 input files. It integrates read processing, barcode assignment, and downstream preparation steps for downstream analysis.

The workflow is designed to be reproducible and container-compatible but requires a few external basecalling tools to be installed separately.

## Input Requirements

The workflow requires:
  - POD5 files directory
  - Barcode/sample mapping file
Example structure:

```bash
data/
├── pod5/
└── mapping_names.txt
```
### Mapping file format

A tab-delimited file linking barcodes to sample names.

Example:
```bash
BC_name	SampleID
barcode01_barcode01	NT001
barcode01_barcode02	NT002
```
## Required External Tools (NOT included in Nextflow container)
1. Dorado (ONT basecaller)
2. Guppy (For demultiplexing)

### Pipeline Requirements (included in container)

The workflow container (nbelmokhtar/demux_dualont) includes:
seqkit
NanoFilt
NanoPlot
pycoQC
samtools
python3

## Usage
Run the workflow using:
```bash
nextflow run main.nf \
  --pod5 data/pod5/ \
  --names data/mapping_names.txt \
  --qscore 9
```

## Output

The workflow produces demultiplexed reads with new sample names assigned based on mapping_names.txt, saved in:
```bash
results/4_DemuxFq/BC_final/
```
Reads containing barcodes that are not listed in mapping_names.txt are stored separately in:
```bash
results/4_DemuxFq/BC_final/BC_notIncluded/
```


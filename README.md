# About this repo

This repo contains the code used in the publication:

Inhibiting Methanogenesis with Medium-Chain Fatty Acids: A Strategy for Rapid Start-up and Stable Operation of Food Waste Chain Elongation Systems

## Table of contents

Shell scripts used in up stream analysis were stored in the `upstream` folder:

1.  Quality control: `mgs_pre_processing.sh`

2.  Prokaryotic community structure profiling: `singlem.sh`

3.  Co-assembly: `assembly.sh`

4.  Unigene related process (CDS calling and clustering, function profiling and gene quantification): `unigenes.sh`

5.  Binning and post-binning process (de-replication, quality check, taxonomy classification, abundance estimation): `multi_binning.sh`

6.  Phylogenetic tree construction: `build_phylo_tree.sh`

7.  METABOLIC analysis: `run_metabolic_c_per_sample.sh`

8.  GWMM: `run_gapseq.sh`

9.  Scan MAGs for CE-related genes: `run_kofam_scan_on_all_mags.sh`

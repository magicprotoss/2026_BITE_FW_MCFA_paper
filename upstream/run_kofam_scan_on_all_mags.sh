#!/bin/bash

# we use a synology nas for data storage, if you datastore has sufficient I/O
# performance, you don't have to move things around like this

# file path in this script may not be identical on your side, create folders and
# change dir if necessary

# https://github.com/magicprotoss/Parallel-kofamscan

conda activate parallel_kofam_scan

pkofamscan \
    -i <path-to-your-working-dir>/dereplicated_genomes/*.faa \
    -o <path-to-your-working-dir>/per_genome_kofam_scan \
    -db /mnt/kofamscan-db/ \
    -p 56
    

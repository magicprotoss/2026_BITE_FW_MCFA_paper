#!/bin/bash

# we use a synology nas for data storage, if you datastore has sufficient I/O
# performance, you don't have to move things around like this

# file path in this script may not be identical on your side, create folders and
# change dir if necessary

conda activate gtdbtk-2.4.1

export GTDBTK_DATA_PATH="/mnt/gtdbtk-db/"

gtdbtk identify \
    --genome_dir dereplicated_genomes \
    --out_dir identify_output \
    --extension fa \
    --cpus 64
    
gtdbtk align \
    --identify_dir identify_output \
    --out_dir align_output \
    --cpus 64 \
    --skip_gtdb_refs

gunzip align_output/align/gtdbtk.bac120.user_msa.fasta.gz
gunzip align_output/align/gtdbtk.ar53.user_msa.fasta.gz

conda deactivate

conda activate qiime2-amplicon-2024.5

mkdir iqtree_arc && cd iqtree_arc

ln -s ../align_output/align/gtdbtk.ar53.user_msa.fasta .

iqtree \
    -s gtdbtk.ar53.user_msa.fasta \
    --mem 512G \
    -T 56 \
    -alrt 1000 \
    --ufboot 1000 \
    -m MFP
    
cd ..
    
mkdir iqtree_bac && cd iqtree_bac
    
ln -s ../align_output/align/gtdbtk.bac120.user_msa.fasta .

iqtree \
    -s gtdbtk.bac120.user_msa.fasta \
    --mem 512G \
    -T 56 \
    -alrt 1000 \
    --ufboot 1000 \
    -m MFP
    
conda deactivate
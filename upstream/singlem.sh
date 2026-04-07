#!/bin/bash

# we use a synology nas for data storage, if you datastore has sufficient I/O
# performance, you don't have to move things around like this

# file path in this script may not be identical on your side, create folders and
# change dir if necessary

conda activate seqkit-2.5.1

for gz_f in <path-to-your-working-dir>/20251025_gy_mgs/1.valid/*.gz; do
    out_fn=$(basename $gz_f)
    zcat $gz_f | seqkit sample --number 19500000 --rand-seed 7 -o <path-to-your-working-dir>/valid_subset/$out_fn
done

conda deactivate

conda activate singlem-0.19.0

export SINGLEM_METAPACKAGE_PATH="/mnt/singlem-db"

rm -rf /tmp/singlem_tmp

input_dir="valid_subset"

singlem pipe --forward ${input_dir}/*_1.fastq.gz \
    --reverse ${input_dir}/*_2.fastq.gz \
    --taxonomic-profile taxonomy.tsv \
    --otu-table otutab.txt \
    --working-directory /tmp/singlem_tmp \
    --threads 24 \
    --force &> singlem_pipe.log
    
rm -rf /tmp/singlem_tmp
    
singlem microbial_fraction \
    --forward ${input_dir}/*_1.fastq.gz \
    --reverse ${input_dir}/*_2.fastq.gz \
    --input-profile taxonomy.tsv \
    --output-tsv prokaryotic_fraction.tsv &> singlem_prokaryotic_fraction.log
    
for level in phylum class order family genus species; do
    singlem summarise --input-taxonomic-profiles taxonomy.tsv \
        --output-species-by-site-relative-abundance otutab_${level}.tsv \
        --output-species-by-site-level $level
done

# clusert OTU table to remove seqencing noise
singlem summarise --input-otu-tables otutab.txt --cluster \
    --output-otu-table clustered.otutab.txt
singlem summarise --input-otu-tables otutab.txt --cluster \
    --clustered-output-otu-table clustered_with_details.otutab.txt
    
# exract individual markers
singlem summarise --input-otu-table clustered.otutab.txt --unifrac-by-otu \
    clustered.otutab.per.spkg

conda deactivate
#!/bin/bash

# we use a synology nas for data storage, if you datastore has sufficient I/O
# performance, you don't have to move things around like this

# file path in this script may not be identical on your side, create folders and
# change dir if necessary

conda activate gapseq-1.4.0

cd <path-to-your-wokring-dir>/gapseq_wd

# bacteria
parallel -j 56 'cd {} && \
    gapseq find -p all -b 200 -m Bacteria -t Bacteria -O -K 1 *.fa &>> gapseq.log && \
    gapseq find-transport -b 200 -K 1 *.fa &>> gapseq.log && \
    gapseq draft -r *-all-Reactions.tbl -t *-Transporter.tbl -p *-all-Pathways.tbl -u 200 -l 50 -c *.fa &>> gapseq.log && \
    gapseq medium -m *-draft.RDS -p *-all-Pathways.tbl &>> gapseq.log && \
    gapseq fill -m *-draft.RDS -n *-medium.csv -c *-rxnWeights.RDS -g *-rxnXgenes.RDS -b 100 &>> gapseq.log' ::: *

# archaea
# acetate
cd <path-to-your-wokring-dir>/gapseq_wd
while IFS= read -r mag; do
    cd $mag
    gapseq find -p all -b 200 -m Archaea -t Archaea -O *.fa &>> gapseq.log
    gapseq find-transport -b 200 *.fa &>> gapseq.log
    gapseq draft -r *-all-Reactions.tbl -t *-Transporter.tbl -p *-all-Pathways.tbl -u 200 -l 50 -c *.fa &>> gapseq.log
    gapseq fill -m *-draft.RDS -n MM_anaerobic_Acetate_H2.csv -c *-rxnWeights.RDS -g *-rxnXgenes.RDS -b 100 &>> gapseq.log
    cd <path-to-your-wokring-dir>/gapseq_wd
done <<MAG_LST
sample.CoA5.bin.91
sample.JZW2.bin.57
sample.CoA4.bin.158
sample.JZW2.bin.155
sample.CoA6.bin.145
sample.JZW2.bin.188
sample.CoA1.bin.3
sample.JZW1.bin.203
MAG_LST
# h2-co2
cd <path-to-your-wokring-dir>/gapseq_wd
while IFS= read -r mag; do
    cd $mag
    gapseq find -p all -b 200 -m Archaea -t Archaea -O *.fa &>> gapseq.log
    gapseq find-transport -b 200 *.fa &>> gapseq.log
    gapseq draft -r *-all-Reactions.tbl -t *-Transporter.tbl -p *-all-Pathways.tbl -u 200 -l 50 -c *.fa &>> gapseq.log
    gapseq fill -m *-draft.RDS -n MM_anaerobic_CO2_H2.csv -c *-rxnWeights.RDS -g *-rxnXgenes.RDS -b 100 &>> gapseq.log
    cd <path-to-your-wokring-dir>/gapseq_wd
done <<MAG_LST
sample.CoA13.bin.48
sample.CoA4.bin.103
sample.JZW2.bin.2
sample.JZW1.bin.161
sample.JZW1.bin.8
MAG_LST

conda deactivate

for fp in <path-to-your-wokring-dir>/20251025_gy_mgs/5.binning/95ani_genomes/gapseq_wd/*; do
    sample_id=$(basename $fp)
    xz -d $fp/${sample_id}.RDS.xz
done


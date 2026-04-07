#!/bin/bash

# we use a synology nas for data storage, if you datastore has sufficient I/O
# performance, you don't have to move things around like this

# file path in this script may not be identical on your side, create folders and
# change dir if necessary

# https://github.com/magicprotoss/METABOLIC-container

# run 1st run on one sample
apptainer exec \
    -e \
    -B <path_to_gtdbtk_databse>:/metabolic_dbs/gtdbtk \
    -B <path_to_kofam_scan_database>:/metabolic_dbs/kofam_scan \
    <path_to_metabolic-4.0.sif> \
    METABOLIC-C.pl \
        -t 64 -m-cutoff 0.75 \
        -in-gn dereplicated_genomes \
        -kofam-db full \
        -r grouping/CY1-B1.txt \
        -o METABOLIC_outs

# backup the ourdir    
tar -I "xz -9 -T 64" -cvf METABOLIC_out_20251129_bak.tar.xz METABOLIC_outs

# perform 2nd run on the rest samples

mkdir -p METABOLIC_outs_2nd_runs/

for grouping_file in $(ls grouping/*.txt | grep -v "CY1-B1.txt"); do
    sample_id=$(basename $grouping_file .txt)
    mkdir -p METABOLIC_outs_2nd_runs/"$sample_id"
    ln -s <path-to-your-working-dir>/metabolic_c_per_sample_runs/METABOLIC_outs/* METABOLIC_outs_2nd_runs/"$sample_id"/
    apptainer exec \
        -e \
        -B <path_to_gtdbtk_databse>:/metabolic_dbs/gtdbtk \
        -B <path_to_kofam_scan_database>:/metabolic_dbs/kofam_scan \
        <path_to_metabolic-4.0.sif> \
        METABOLIC-C.2nd_run.pl \
            -t 4 \
            -in-gn dereplicated_genomes \
            -r ${grouping_file} \
            -o METABOLIC_outs_2nd_runs/"$sample_id" \
            -2nd-run true \
            -2nd-run-suffix "$sample_id"
        
done

mv METABOLIC_outs <path-to-your-working-dir>/20251025_gy_mgs/5.binning/95ani_genomes/
for dir in METABOLIC_outs_2nd_runs/*; do
    rsync -av ${dir}/* <path-to-your-working-dir>/20251025_gy_mgs/5.binning/95ani_genomes/METABOLIC_outs/
done
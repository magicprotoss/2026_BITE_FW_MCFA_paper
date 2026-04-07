#!/bin/bash

# we use a synology nas for data storage, if you datastore has sufficient I/O
# performance, you don't have to move things around like this

# file path in this script may not be identical on your side, create folders and
# change dir if necessary

mkdir reads spades_out

cd reads

cat valid/L1MKJ*JZW1_B*_1.fastq.gz > JZW1_1.fastq.gz
cat valid/L1MKJ*JZW1_B*_2.fastq.gz > JZW1_2.fastq.gz
cat valid/L1MKJ*JZW2_B*_1.fastq.gz > JZW2_1.fastq.gz
cat valid/L1MKJ*JZW2_B*_2.fastq.gz > JZW2_2.fastq.gz
cat valid/L1MKJ*CY1_B*_1.fastq.gz > CY1_1.fastq.gz
cat valid/L1MKJ*CY1_B*_2.fastq.gz > CY1_2.fastq.gz
cat valid/D0*_1.fastq.gz > D0_1.fastq.gz
cat valid/D0*_2.fastq.gz > D0_2.fastq.gz

# coassembly day 7 28 25 base on species bc dist < 0.5

cd valid

cat D35-H4-B2_1.fastq.gz D35-H4-B1_1.fastq.gz D28-O6-B2_1.fastq.gz D28-O6-B1_1.fastq.gz D7-O1-B2_1.fastq.gz  > ../CoA1_1.fastq.gz
cat D35-H4-B2_2.fastq.gz D35-H4-B1_2.fastq.gz D28-O6-B2_2.fastq.gz D28-O6-B1_2.fastq.gz D7-O1-B2_2.fastq.gz  > ../CoA1_2.fastq.gz
cat D7-H4-B2_1.fastq.gz D7-H4-B1_1.fastq.gz  > ../CoA2_1.fastq.gz
cat D7-H4-B2_2.fastq.gz D7-H4-B1_2.fastq.gz  > ../CoA2_2.fastq.gz
cat D35-O1-B2_1.fastq.gz D28-O1-B2_1.fastq.gz  > ../CoA3_1.fastq.gz
cat D35-O1-B2_2.fastq.gz D28-O1-B2_2.fastq.gz  > ../CoA3_2.fastq.gz
cat D28-H4-B1_1.fastq.gz D28-B1-B2_1.fastq.gz D28-CK-B1_1.fastq.gz D7-B1-B2_1.fastq.gz D7-B1-B1_1.fastq.gz  > ../CoA4_1.fastq.gz
cat D28-H4-B1_2.fastq.gz D28-B1-B2_2.fastq.gz D28-CK-B1_2.fastq.gz D7-B1-B2_2.fastq.gz D7-B1-B1_2.fastq.gz  > ../CoA4_2.fastq.gz
cat D7-O6-B2_1.fastq.gz D7-O6-B1_1.fastq.gz D7-CK-B2_1.fastq.gz D7-CK-B1_1.fastq.gz  > ../CoA5_1.fastq.gz
cat D7-O6-B2_2.fastq.gz D7-O6-B1_2.fastq.gz D7-CK-B2_2.fastq.gz D7-CK-B1_2.fastq.gz  > ../CoA5_2.fastq.gz
cat D28-B1-B1_1.fastq.gz D28-CK-B2_1.fastq.gz D28-H4-B2_1.fastq.gz D35-CK-B2_1.fastq.gz D35-CK-B1_1.fastq.gz  > ../CoA6_1.fastq.gz
cat D28-B1-B1_2.fastq.gz D28-CK-B2_2.fastq.gz D28-H4-B2_2.fastq.gz D35-CK-B2_2.fastq.gz D35-CK-B1_2.fastq.gz  > ../CoA6_2.fastq.gz
cat D7-O0p5-B2_1.fastq.gz D7-O0p5-B1_1.fastq.gz D7-H2-B2_1.fastq.gz D7-B4-B2_1.fastq.gz D7-B4-B1_1.fastq.gz D7-B2-B2_1.fastq.gz D7-B2-B1_1.fastq.gz D7-H1-B2_1.fastq.gz D7-H1-B1_1.fastq.gz  > ../CoA7_1.fastq.gz
cat D7-O0p5-B2_2.fastq.gz D7-O0p5-B1_2.fastq.gz D7-H2-B2_2.fastq.gz D7-B4-B2_2.fastq.gz D7-B4-B1_2.fastq.gz D7-B2-B2_2.fastq.gz D7-B2-B1_2.fastq.gz D7-H1-B2_2.fastq.gz D7-H1-B1_2.fastq.gz  > ../CoA7_2.fastq.gz
cat D35-H2-B2_1.fastq.gz D35-H2-B1_1.fastq.gz D28-H2-B2_1.fastq.gz D28-H2-B1_1.fastq.gz D28-O0p5-B2_1.fastq.gz D28-O0p5-B1_1.fastq.gz D35-O0p5-B2_1.fastq.gz D35-O0p5-B1_1.fastq.gz  > ../CoA8_1.fastq.gz
cat D35-H2-B2_2.fastq.gz D35-H2-B1_2.fastq.gz D28-H2-B2_2.fastq.gz D28-H2-B1_2.fastq.gz D28-O0p5-B2_2.fastq.gz D28-O0p5-B1_2.fastq.gz D35-O0p5-B2_2.fastq.gz D35-O0p5-B1_2.fastq.gz  > ../CoA8_2.fastq.gz
cat D35-O1-B1_1.fastq.gz D28-O1-B1_1.fastq.gz  > ../CoA9_1.fastq.gz
cat D35-O1-B1_2.fastq.gz D28-O1-B1_2.fastq.gz  > ../CoA9_2.fastq.gz
cat D7-O1-B1_1.fastq.gz D7-H2-B1_1.fastq.gz  > ../CoA10_1.fastq.gz
cat D7-O1-B1_2.fastq.gz D7-H2-B1_2.fastq.gz  > ../CoA10_2.fastq.gz
cat D35-O6-B2_1.fastq.gz D35-O6-B1_1.fastq.gz D35-B1-B2_1.fastq.gz D35-B1-B1_1.fastq.gz  > ../CoA11_1.fastq.gz
cat D35-O6-B2_2.fastq.gz D35-O6-B1_2.fastq.gz D35-B1-B2_2.fastq.gz D35-B1-B1_2.fastq.gz  > ../CoA11_2.fastq.gz
cat D28-H1-B2_1.fastq.gz D28-H1-B1_1.fastq.gz D35-H1-B2_1.fastq.gz D35-H1-B1_1.fastq.gz D28-B2-B2_1.fastq.gz D28-B2-B1_1.fastq.gz  > ../CoA12_1.fastq.gz
cat D28-H1-B2_2.fastq.gz D28-H1-B1_2.fastq.gz D35-H1-B2_2.fastq.gz D35-H1-B1_2.fastq.gz D28-B2-B2_2.fastq.gz D28-B2-B1_2.fastq.gz  > ../CoA12_2.fastq.gz
cat D35-B4-B2_1.fastq.gz D35-B4-B1_1.fastq.gz D28-B4-B2_1.fastq.gz D28-B4-B1_1.fastq.gz  > ../CoA13_1.fastq.gz
cat D35-B4-B2_2.fastq.gz D35-B4-B1_2.fastq.gz D28-B4-B2_2.fastq.gz D28-B4-B1_2.fastq.gz  > ../CoA13_2.fastq.gz
cat D35-B2-B2_1.fastq.gz D35-B2-B1_1.fastq.gz  > ../CoA14_1.fastq.gz
cat D35-B2-B2_2.fastq.gz D35-B2-B1_2.fastq.gz  > ../CoA14_2.fastq.gz

cd ..

conda activate spades-4.2.0

ulimit -n 10000

for fwd_gz in <path-to-your-working-dir>/*_1.fastq.gz; do
    rev_gz=${fwd_gz/_1.fastq.gz/_2.fastq.gz}
    sample_id=$(basename $fwd_gz _1.fastq.gz)
    if [[ -f "<path-to-your-working-dir>/spades_out/${sample_id}/scaffolds.fasta" ]]; then
        echo "Scafflods exist, skipping assembly for $sample_id"
    elif [[ -d "<path-to-your-working-dir>/spades_out/${sample_id}" ]]; then
        echo "Directory exists but no scaffolds, continuing assembly for $sample_id..."
        metaspades.py \
            -o <path-to-your-working-dir>/spades_out/${sample_id} \
            --continue
    else
        echo "Now Assembling ${sample_id}..."
        metaspades.py \
            -1 $fwd_gz \
            -2 $rev_gz \
            -o <path-to-your-working-dir>/spades_out/${sample_id} \
            -k 27,47,67,87,107,127 \
            --threads 80 \
            --memory 1024
    fi
    mv <path-to-your-working-dir>/spades_out/${sample_id}/scaffolds.fasta <path-to-your-working-dir>/assembly/${sample_id}.fasta
    mv <path-to-your-working-dir>/spades_out/${sample_id}/spades.log <path-to-your-working-dir>/assembly/${sample_id}.log
    rm -rf <path-to-your-working-dir>/spades_out/${sample_id}
done

conda deactivate

# assess assembly quality

conda activate quast-5.2.0

quast.py <path-to-your-wokring-dir>/20251025_gy_mgs/3.assembly/*.fasta.gz \
    -o <path-to-your-wokring-dir>/quast \
    --threads 24 \
    --contig-thresholds 0,500,1000,1500,5000,10000,25000,50000

conda deactivate
#!/bin/bash

# we use a synology nas for data storage, if you datastore has sufficient I/O
# performance, you don't have to move things around like this

# file path in this script may not be identical on your side, create folders and
# change dir if necessary

cd <path-to-your-working-dir>

mkdir -p ETC.QC 1.valid

mkdir -p <path-to-your-working-dir>/input <path-to-your-working-dir>/fastp_out && cd <path-to-your-working-dir>

ln -s <path-to-your-working-dir>/MJ20251027236*/rawdata/*.fastq.gz input/
ln -s <path-to-your-working-dir>/MJ20251027234-ZX-M-251028247*/rawdata/*.fastq.gz input/
ln -s <path-to-your-working-dir>/MJ20251027234-ZX-M-251031266*/rawdata/*.fastq.gz input/

conda activate fastp-1.0.1

parallel -j 10 '
  fwd="{}"
  sample_id="$(basename "$fwd" .R1.raw.fastq.gz)"
  rev="${fwd%.R1.raw.fastq.gz}.R2.raw.fastq.gz"
  fastp \
    -i "$fwd" \
    -I "$rev" \
    -o "fastp_out/${sample_id}_1.fastq.gz" \
    -O "fastp_out/${sample_id}_2.fastq.gz" \
    -h "fastp_out/${sample_id}.html" \
    -j "fastp_out/${sample_id}.json" \
    -R "$sample_id" \
    --thread 8 \
    --compression 9 \
    --n_base_limit 3 \
    --length_required 150 \
    --length_limit 150 \
    --average_qual 20
' ::: input/*.R1.raw.fastq.gz

conda deactivate

mv fastp_out/*.html fastp_out/*.json <path-to-your-working-dir>/ETC.QC/
mv fastp_out/*.fastq.gz <path-to-your-working-dir>/1.valid/

conda activate multiqc-1.30

cd <path-to-your-working-dir>/ETC.QC
multiqc --interactive .
conda deactivate
#!/bin/bash

# we use a synology nas for data storage, if you datastore has sufficient I/O
# performance, you don't have to move things around like this

# file path in this script may not be identical on your side, create folders and
# change dir if necessary

# the 'metawrap_binning_bwa_men2.sh' is essentially 'binning.sh' in metawrap
# we swapped bwa to bwa-mem2 for increased performance on morden EPYC platforms

# this step is very I/O intensive, use a loop if you don't have flash storage

cd <path-to-your-working-dir>/ssd_cache/gy

tmux new-session -s gybinning

conda activate metawrap-mg-1.3.2

process_assembly() {
    assembly=$1
    sample_id=$(basename ${assembly} .fasta)
    init_binning_outdir=<path-to-your-working-dir>/ssd_cache/gy/init_binning_outs/${sample_id}
    reads_lib=$(ls <path-to-your-working-dir>/gy_reads/*.fastq)
    metawrap_binning_bwa_men2.sh \
        -o ${init_binning_outdir} \
        -t 64 \
        -m 1024 \
        -a ${assembly} \
        --metabat2 \
        --maxbin2 \
        --concoct \
        $reads_lib &> <path-to-your-working-dir>/ssd_cache/gy/logs/${sample_id}.log
}

export -f process_assembly

parallel -j 12 process_assembly {} ::: <path-to-your-working-dir>/gy_assembly/*.fasta

conda deactivate

parallel -j 12 \
    'sample_id=$(basename {}) && \
    metawrap bin_refinement \
        -o <path-to-your-working-dir>/ssd_cache/gy/refine_out/${sample_id} \
        -t 32 \
        -m 1024 \
        -A {}/metabat2_bins/ \
        -B {}/maxbin2_bins/ \
        -C {}/concoct_bins/ \
        -c 50 -x 10 &> <path-to-your-working-dir>/ssd_cache/gy/refine_logs/${sample_id}_refine.log' \
    ::: <path-to-your-working-dir>/ssd_cache/gy/init_binning_outs/*
    
##################################

cd <path-to-your-working-dir>/ssd_cache/gy/refine_out

for sample_id in *; do
    for bin in ${sample_id}/metawrap_50_10_bins/*.fa; do
        cp $bin <path-to-your-working-dir>/ssd_cache/gy/renamed_bins/"sample."${sample_id}"."$(basename $bin)
    done
done

cd ../

conda deactivate

conda activate drep-3.6.2

dRep dereplicate \
    99ani_genomes \
    --genomes renamed_bins/*.fa \
    --processors 64 \
    --S_ani 0.99 \
    --cov_thresh 0.30
    
dRep dereplicate \
    95ani_genomes \
    --genomes 99ani_genomes/dereplicated_genomes/*.fa \
    --processors 64 \
    --S_ani 0.95 \
    --cov_thresh 0.30
    
conda deactivate
    
cd 99ani_genomes

conda activate checkm2-1.1.0
checkm2 predict --threads 128 --input dereplicated_genomes --output-directory checkm2_out -x fa
conda deactivate

conda activate gtdbtk-2.4.1
export GTDBTK_DATA_PATH=/mnt/hdd/bio_db/gtdb-tk/
gtdbtk classify_wf \
    --genome_dir dereplicated_genomes \
    --out_dir gtdbtk_out \
    --extension fa \
    --skip_ani_screen \
    --prefix tax \
    --cpus 64 \
    --pplacer_cpus 64
conda deactivate

conda activate coverm-0.7.0

coverm genome \
    --read1 unzipped_valid_subset/*_1.fastq \
    --read2 unzipped_valid_subset/*_2.fastq \
    --genome-fasta-directory <path-to-your-working-dir>/20251025_gy_mgs/5.binning/95ani_genomes/dereplicated_genomes \
    -x fa -t 56 \
    --min-read-aligned-percent 50 \
    --min-read-percent-identity 95 \
    --min-covered-fraction 0 \
    -m relative_abundance tpm rpkm count \
    -o coverm_quant_bins_relative_abundance_tpm_rpkm_count.tsv
mv coverm_quant_bins_relative_abundance_tpm_rpkm_count.tsv <path-to-your-working-dir>/20251025_gy_mgs/5.binning/95ani_genomes/

conda deactivate



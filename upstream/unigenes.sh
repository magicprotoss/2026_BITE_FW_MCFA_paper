#!/bin/bash

# we use a synology nas for data storage, if you datastore has sufficient I/O
# performance, you don't have to move things around like this

# file path in this script may not be identical on your side, create folders and
# change dir if necessary

mkdir assembly_relab
for assembly in assembly/*.fasta; do
    sample_id=$(basename $assembly .fasta)
    usearch11 -fastx_relabel $assembly -prefix "Sample_${sample_id}_Contig_" -fastaout "assembly_relab/${sample_id}.fasta" -keep_annots
done

conda activate pprodigal-1.0.1

mkdir prodigal_out
for assembly in assembly_relab/*.fasta; do
    sample_id=$(basename $assembly .fasta)
    pprodigal \
        -T 80 \
        -i $assembly \
        -c \
        -m \
        -p meta \
        -o "prodigal_out/${sample_id}.gbk" \
        -d "prodigal_out/${sample_id}.fna"
done

conda deactivate

conda activate cd-hit-4.8.1

cd prodigal_out && cat *.fna > CDS.fna
cd-hit-est -i CDS.fna \
    -o unigenes.fna \
    -aS 0.9 \
    -c 0.95 \
    -G 0 \
    -M 0 \
    -T 80 \
    -n 10 \
    -d 0 \
    -g 1
    
conda deactivate

# salmon
mkdir salmon_wd

conda activate salmon-1.10.3

salmon index -t unigenes.fna \
    -k 31 \
    -i salmon_wd/index \
    -p 80

for fwd in /mnt/project/datastore/admin/valid/*_1.fastq.gz; do
    sample_id=$(basename $fwd _1.fastq.gz)
    rev=${fwd/_1.fastq.gz/_2.fastq.gz}
        
    salmon quant \
        -i salmon_wd/index \
        -l A \
        -p 80 \
        --meta \
        -1 $fwd -2 $rev \
        -o salmon_wd/$sample_id

done

salmon quantmerge \
    --quants $(find salmon_wd/* -maxdepth 0 -type d) \
    --names $(find salmon_wd/* -maxdepth 0 -type d | cut -d "/" -f 2) \
    --column numreads \
    -o salmon_wd/gene_count.tsv
    
salmon quantmerge \
    --quants $(find salmon_wd/* -maxdepth 0 -type d) \
    --names $(find salmon_wd/* -maxdepth 0 -type d | cut -d "/" -f 2) \
    -o salmon_wd/gene_tpm.tsv

# emapper
conda activate eggnog-mapper-2.1.12

emapper.py \
    -m diamond \
    --itype CDS \
    --translate \
    --sensmode more-sensitive \
    -i unigenes.fna \
    --dbmem \
    --cpu 64 \
    --mp_start_method fork \
    -o eggnog_out
    
conda deactivate

################
# helper script, data, and detailed usage can be found at https://github.com/YongxinLiu/EasyMicrobiome
xzcat <path-to-your-working-dir>/20251025_gy_mgs/4.unigene/eggnog_out.emapper.annotations.xz \
    | grep -v '^##' | sed '1 s/^#//' > <path-to-your-working-dir>/gy/temp/eggnog.output
xzcat <path-to-your-working-dir>/20251025_gy_mgs/4.unigene/gene_tpm.tsv.xz > <path-to-your-working-dir>/gy/temp/gene_tpm.tsv
# Summary, the 7 columns COG_category are alphabetically separated, and the 12 columns KEGG_ko and 19 columns CAZy are comma-separated. The original values are summed.
# 汇总，7列COG_category按字母分隔，12列KEGG_ko和19列CAZy按逗号分隔，原始值累加。
<path-to-your-working-dir>/GY-Grad/summarizeAbundance.py \
    -i gene_tpm.tsv \
    -m eggnog.output --dropkeycolumn \
    -c '7,12,19' -s '*+,+,' -n raw \
    -o result/eggnog
sed -i 's#^ko:##' result/eggnog.KEGG_ko.raw.txt
sed -i '/^-/d' result/eggnog*
head -n3 result/eggnog*
# KO to level 1/2/3
<path-to-your-working-dir>/GY-Grad/summarizeAbundance.py \
    -i result/eggnog.KEGG_ko.raw.txt \
    -m <path-to-your-working-dir>/GY-Grad/KO1-4.txt \
    -c 2,3,4 -s ',+,+,' -n raw --dropkeycolumn \
    -o result/KEGG
head -n3 result/KEGG*
# CAZy
awk 'BEGIN{FS=OFS="\t"} NR==FNR{a[$1]=$2} NR>FNR{print a[$1],$0}' \
    <path-to-your-working-dir>/GY-Grad/CAZy_description.txt result/eggnog.CAZy.raw.txt | \
    sed 's/^\t/Unannotated\t/' > result/eggnog.CAZy.TPM.spf
head -n 3 result/eggnog.CAZy.TPM.spf

# COG
awk 'BEGIN{FS=OFS="\t"} NR==FNR{a[$1]=$2"\t"$3} NR>FNR{print a[$1],$0}' \
    <path-to-your-working-dir>/GY-Grad/COG.anno result/eggnog.COG_category.raw.txt > \
    result/eggnog.COG_category.TPM.spf
head -n 3 result/eggnog.COG_category.TPM.spf

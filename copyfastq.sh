#!/bin/bash

## NOTE!!! Run this from the xfer node ##
## Create directory to host fastq files and analysis directory ##

## save outdir -- modify if needed

outdir="./fsd-1_Analysis"

mkdir -p "$outdir/fastqFiles/ChIPseq"

## Before running scripts, also copy "fungiDB_GFFtoGTF_conversion.gtf" to base directory.
## Copy RNAseq files
    echo "Copying RNAseq files ...."
cp -r /project/zallab/SequencingArchive/BaseSpaceDownloads/FSD1_RNAseq "$outdir/fastqFiles"

## Copy WT RNAseq files from Liu et al. 2017
cp -r /project/zallab/SequencingArchive/BaseSpaceDownloads/FSD1_RNAseq/SRR_Liu2017 "$outdir/fastqFiles"

## Copy ChIPseq files
    echo "Copying ChIPseq files ...."
cp -r /project/zallab/SequencingArchive/BaseSpaceDownloads/2024_Run143_FASTQ/143-3_ChIP_fsd1-gfpXsad1_GFPtrap* "$outdir/fastqFiles/ChIPseq"
cp -r /project/zallab/SequencingArchive/BaseSpaceDownloads/2024_Run143_FASTQ/143-5_ChIP_fsd1-gfpXsad1_GFPtrap* "$outdir/fastqFiles/ChIPseq"
    echo "ChIPseq files copied!"

## Copy GFP-trap background ChIP-seq
    echo "Copying GFP-trap background ChIPseq files ...."
cp -r /project/zallab/SequencingArchive/BaseSpaceDownloads/2024_Run143_FASTQ/143-144_ChIP_WT_gfp-trap_Rep1* "$outdir/fastqFiles/ChIPseq"
cp -r /project/zallab/SequencingArchive/BaseSpaceDownloads/2025_Run153_Fastq/153-47_ChIP_WT_dpf6_gfp-trap_Rep1* "$outdir/fastqFiles/ChIPseq"

## Copy OX2 genomic DNA for A-to-I editing calls
    echo "Copying OX2 genomic DNA files ...."
cp -r /project/zallab/SequencingArchive/BaseSpaceDownloads/2026_Run156_FASTQ/156-N27_Genomic_fsd1GFP2_OX* "$outdir/fastqFiles/ChIPseq"
cp -r /project/zallab/SequencingArchive/BaseSpaceDownloads/2026_Run156_FASTQ/156-N28_Genomic_fsd1GFP2_OX* "$outdir/fastqFiles/ChIPseq"
cp -r /project/zallab/SequencingArchive/BaseSpaceDownloads/2026_Run156_FASTQ/156-N29_Genomic_fsd1GFP2_OX* "$outdir/fastqFiles/ChIPseq"
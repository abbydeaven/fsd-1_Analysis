#!/bin/bash

## NOTE!!! Run this from the xfer node ##
## Create directory to host fastq files and analysis directory ##

## save outdir -- modify if needed

outdir="./fsd-1_Analysis"

mkdir outdir
mkdir $outdir/fastqFiles

## Copy RNAseq files
    echo "Copying RNAseq files ...."
cp -r /project/zallab/SequencingArchive/BaseSpaceDownloads/FSD1_RNAseq $outdir/fastqFiles

## Copy WT RNAseq files from Liu et al. 2017
cp -r /project/zallab/SequencingArchive/BaseSpaceDownloads/FSD1_RNAseq/SRR_Liu2017 $outdir/fastqFiles

## Copy ChIPseq files
    echo "Copying ChIPseq files ...."
    mkdir $outdir/fastqFiles/ChIPseq
cp -r /project/zallab/SequencingArchive/BaseSpaceDownloads/2024_Run143_FASTQ/143-3_ChIP_fsd1-gfpXsad1_GFPtrap* $outdir/fastqFiles/ChIPseq
cp -r /project/zallab/SequencingArchive/BaseSpaceDownloads/2024_Run143_FASTQ/143-5_ChIP_fsd1-gfpXsad1_GFPtrap* $outdir/fastqFiles/ChIPseq
    echo "ChIPseq files copied!"

## Copy OX2 genomic DNA for A-to-I editing calls
    echo "Copying OX2 genomic DNA files ...."
cp -r /project/zallab/SequencingArchive/BaseSpaceDownloads/2026_Run156_FASTQ/156-N27_Genomic_fsd1GFP2_OX* $outdir/fastqFiles/ChIPseq
cp -r /project/zallab/SequencingArchive/BaseSpaceDownloads/2026_Run156_FASTQ/156-N28_Genomic_fsd1GFP2_OX* $outdir/fastqFiles/ChIPseq
cp -r /project/zallab/SequencingArchive/BaseSpaceDownloads/2026_Run156_FASTQ/156-N29_Genomic_fsd1GFP2_OX* $outdir/fastqFiles/ChIPseq
# fsd-1_Analysis
This directory contains all of the scripts and information required to replicate fsd-1 analysis in N. crassa.

Steps to Analyze:
1. Run copyfastq.sh to create analysis directory on the Linux cluster. Once all fastq files have downloaded, proceed to either RNA-seq or ChIP-seq analysis. Note that these two pipelines are modular and can be run in any order. 

MAPPING RNA-SEQ/A-TO-I EDITING
1. From fsd-1_Analysis/Call_AtoI_Editing, run:
   ```bash 
   sh submitMapAndEdit.sh Map_DNA_Controls.sh
   ```
   This will map the WGS files needed to map A-to-I editing sites.

2. When the previous line finishes, run:
   ```bash 
   sbatch merge_control_bams.sh
   ```
This script prepares the WGS files for A-to-I editing. This is necessary so that editing events can accurately be called in case SNPs are present in the data. 

3. Once controls are ready, run:
   ```bash 
   sh submitMapAndEdit.sh RNA_accessions.txt
   ```
This will submit, in parallel, jobs to map RNA-seq files, align to genome, extract featurecounts, and analyze A-to-I editing. This may take several hours to run.

4. Finalize RNA-seq analysis with the following:
   ```bash 
   sbatch RNAseq_Downstream.sh
   ```
This script merges .bam and .bigwig files for plotting, and extracts the edit tables from A-to-I editing. REDItools outputs a large table of every position in the genome, identified by a random string. This script will iterate through the parameter.txt files generated from REDItools to pull positions with A-to-I SNPs.

MAPPING CHIP-SEQ/MOTIF ANALYSIS
1.  Run:
   ```bash 
   cd fsd-1_Analysis/MapCUTnRunV2.0_fsd1
   sbatch submitMappingJob.sh Control_Accessions.txt
   ```
   This will map the ChIPseq files from WT chromatin immunoprecipitated against GFP-trap resin. This job should take ~20 minutes, but may run longer depending on memory. NOTE that this may fail at the peak calling step, which is fine - the important part is making the .bam files. 
2. Run:  
   ```bash 
   cd fsd-1_Analysis/MapCUTnRunV2.0_fsd1
   sbatch Merge_GFPtrap_Controls.sh
   ```
This should take ~5 minutes at most to create a merged BAM file. This will serve as the control for peakcalling.
3. Run:
   ```bash 
   cd fsd-1_Analysis/MapCUTnRunV2.0_fsd1
   sh submitMappingJob.sh fsd1_ChIP_Accessions.txt
   ```
4. Finally, to process ChIPseq files, analyze motifs, and create merged files for plotting, run:
   ```bash 
   cd fsd-1_Analysis/MapCUTnRunV2.0_fsd1
   sbatch DownstreamAnalysis.sh
   ```
You are finished on the cluster! Now download all files, maintaining the same folder architecture. Proceed to fsd1_paper_analysis.Rmd to analyze and generate plots. 



Updating the repository:
1. Authenticate before pushing:
	```bash
	unset GITHUB_TOKEN
	gh auth login --hostname github.com --git-protocol https --web
	gh auth setup-git
	```
2. In the parent repository, pull and initialize the submodules:
	```bash
	git pull origin main
	git submodule sync --recursive
	git submodule update --init --recursive
	```
3. Check whether a submodule is detached:
	```bash
	git -C Call_AtoI_Editing status --short --branch
	```
   `HEAD (no branch)` means the submodule is detached. This is normal when the parent repository checks out an exact commit.
4. If you are only running existing scripts, leave the submodule detached. Do not commit from it. To make changes, create a branch first:
   ```bash
   cd Call_AtoI_Editing
   git switch -c describe-your-change
   # edit files
   git add .
   git commit -m "Describe the change"
   git push -u origin describe-your-change
   ```
5. Merge that branch into the submodule's `main` branch, or push directly if that is your team's workflow. Then return to the parent repository and record the published submodule commit:
   ```bash
   cd ..
   git submodule update --remote Call_AtoI_Editing
   git add Call_AtoI_Editing
   git commit -m "Update A-to-I editing submodule"
   git push origin main
   ```
6. Repeat steps 3-5 for `MapCUTnRunV2.0_fsd1` when working in that submodule.

The submodule commit must be pushed to a branch or tag before the parent repository points to it. Otherwise, other computers cannot download the referenced commit and `git submodule update` fails with `not our ref`.
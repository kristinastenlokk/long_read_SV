#!/bin/bash

#Running jasmine and Iris to merge across tool - only keeping entries detected by at leas two tools

VCF_LIST_TOOLS='vcf.list' #List of paths to vcf-files from each tool. One file per line
BAM_LIST_TOOLS='bam.list' #List of paths to BAM-files corresponding to the vcf-files. Used by Iris
ASM='ref.fasta'

jasmine file_list=$VCF_LIST_TOOLS out_file=out.vcf genome_file=$ASM bam_list=$BAM_LIST_TOOLS max_dist_linear=0.1 min_dist=50 \
--mutual_distance min_support=2 --output_genotypes --normalize_type threads=15 --run_iris iris_args=--keep_long_variants

#Optional: Running jasmine to merge across sample

VCF_LIST_SAMPLES='vcf.list' #List of paths to VCFs merged across tool
ASM='ref.fasta'

jasmine file_list=$VCF_LIST_SAMPLES out_file=out.vcf max_dist_linear=0.1 min_dist=50 --mutual_distance --normalize_type min_support=1


#!/bin/bash

ASM='ref.fasta' #REFERENCE
READS='reads.fastq.gz' #LONG READS

meryl count k=15 output merylDB $ASM
meryl print greater-than distinct=0.9998 merylDB > repetitive_k15.txt

winnowmap -W repetitive_k15.txt -ax map-ont $ASM $READS --MD | samtools view -u | samtools sort -o ./out.bam
samtools index ./out.bam

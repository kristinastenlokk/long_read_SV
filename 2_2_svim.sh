#!/bin/bash

ASM='ref.fasta'
BAM='out.bam'

mkdir svim_output
svim alignment --insertion_sequences svim_output $BAM $ASM

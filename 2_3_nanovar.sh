#!/bin/bash

BAM='out.bam'
ASM='ref.fasta'

mkdir nanovar_output

nanovar -t $BAM $ASM ./nanovar_output


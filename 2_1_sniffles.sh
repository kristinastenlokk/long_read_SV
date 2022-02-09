#!/bin/bash

MED='10' #1/3 of the median read depth
OUT='sniffles_out.vcf'
BAM='out.bam'

sniffles -t 10 -l 50 --genotype -m $BAM -s $MED -n -1 -v $OUT

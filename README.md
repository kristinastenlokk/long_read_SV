# long_read_SV
Scripts for refining vcf's from the long read SV-callers SVIM, Sniffles and NanoVar before merging with Jasmine.

This pipeline was developed for long-read SV-detection on the repeated fish genomes whitefish and atlantic salmon. A combination of multiple tools are used to increase the precision of the calls.

# Pipeline for long-read SV-detection
1) Map reads to reference with Winnowmap2 (v2.0): 1_winnowmap.sh [1].
2) SV-calling with three separate programs: Sniffles (v1.0.12) [2] 2_1_sniffles.sh, SVIM (v1.2.0) [3] 2_2_svim.sh and NanoVar (v1.3.9) [4] 2_3_nanovar.sh. For Sniffles, -s (minimum number of reads that support SV to be reported) was set to 1/3 of the median read depth, as suggested by XX et al [5].
3) Remove entires in the VCFs annotated as breakpoints (BND). E.g. with sed '/"SVTYPE=BND"/d' in.vcf.
4) Run scripts to refine VCFs: 3_1_refine_sniffles.R, 3_2_refine_svim.R and 3_3_refine_nanovar.R.
5) Merge VCFs with Jasmine (v1.1.0) [6], including insertion sequnce refinement with Iris: 4_jasmine.sh
6) If multiple samples: merge VCFs across samples with Jasmine: 5_jasmine_samples.sh.

[1]
[2]
[3]
[4]
[5]
[6]

# long_read_SV

This pipeline was developed for long-read SV-detection on the repeated fish genomes whitefish and atlantic salmon. A combination of multiple tools are used to increase the precision of the calls.

# Pipeline for long-read SV-detection
1) Map reads to reference with Winnowmap2 (v2.0): 1_winnowmap.sh [1].
2) SV-calling with three separate programs: Sniffles (v1.0.12) [2] 2_1_sniffles.sh, SVIM (v1.2.0) [3] 2_2_svim.sh and NanoVar (v1.3.9) [4] 2_3_nanovar.sh. For Sniffles, -s (minimum number of reads that support SV to be reported) was set to 1/3 of the median read depth, as suggested by XX et al [5].
3) Remove entires in the VCFs annotated as breakpoints (BND). E.g. with sed '/"SVTYPE=BND"/d' in.vcf.
4) Run scripts to refine VCFs: 3_1_refine_sniffles.R, 3_2_refine_svim.R and 3_3_refine_nanovar.R.
5) Merge VCFs with Jasmine (v1.1.0) [6], including insertion sequnce refinement with Iris: 4_jasmine.sh
6) If multiple samples: merge VCFs across samples with Jasmine: 5_jasmine_samples.sh.

[1] Jain, C., Rhie, A., Hansen, N., Koren, S. & Phillippy, A. M. J. b. 2020 A long read mapping method for highly repetitive reference sequences. bioRxiv. (DOI:https://doi.org/10.1101/2020.11.01.363887).
[2] Sedlazeck, F. J., Rescheneder, P., Smolka, M., Fang, H., Nattestad, M., Von Haeseler, A. & Schatz, M. C. J. N. m. 2018 Accurate detection of complex structural variations using single-molecule sequencing. Nature methods 15, 461-468. (DOI:https://doi.org/10.1038/s41592-018-0001-7).
[3] Heller, D. & Vingron, M. J. B. 2019 SVIM: structural variant identification using mapped long reads. Bioinformatics 35, 2907-2915. (DOI:https://doi.org/10.1093/bioinformatics/btz041).
[4] Tham, C. Y., Tirado-Magallanes, R., Goh, Y., Fullwood, M. J., Koh, B. T., Wang, W., Ng, C. H., Chng, W. J., Thiery, A. & Tenen, D. G. J. G. b. 2020 NanoVar: accurate characterization of patients’ genomic structural variants using low-depth nanopore sequencing. Genome biology 21, 1-15. (DOI:https://doi.org/10.1186/s13059-020-01968-7).
[5] De Coster, W., De Rijk, P., De Roeck, A., De Pooter, T., D'Hert, S., Strazisar, M., Sleegers, K., & Van Broeckhoven, C. 2019 Structural variants identified by Oxford Nanopore PromethION sequencing of the human genome. Genome research, 29(7), 1178–1187. (DOI:https://doi.org/10.1101/gr.244939.118).
[6] Kirsche, M., Prabhu, G., Sherman, R., Ni, B., Aganezov, S. & Schatz, M. C. J. B. 2021 Jasmine: Population-scale structural variant comparison and analysis. bioRxiv. (DOI:https://doi.org/10.1101/2021.05.27.445886).

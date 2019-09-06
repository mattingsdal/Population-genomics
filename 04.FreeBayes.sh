freebayes -f ~/data/symphodus_melops.fasta *.bam > freebayes/freebayes.vcf




nohup ~/software/bamaddrg/bamaddrg -b H73JKBBXY_01-ZOS-198_CCGCGGTT-CTAGCGCT_L006.sorted.bam_sort.bam -s ZOS-198 \
-b H73JKBBXY_02-ZOS-188_TTATAACC-TCGATATC_L006.sorted.bam_sort.bam -s ZOS-188 \
-b H73JKBBXY_03-ZOS-197_GGACTTGG-CGTCTGCG_L006.sorted.bam_sort.bam -s ZOS-197 \
-b H73JKBBXY_04-ZOS-202_AAGTCCAA-TACTCATA_L006.sorted.bam_sort.bam -s ZOS-202 \
-b H73JKBBXY_05-ZOS-161_ATCCACTG-ACGCACCT_L006.sorted.bam_sort.bam -s ZOS-161 \
-b H73JKBBXY_06-ZOS-166_GCTTGTCA-GTATGTTC_L006.sorted.bam_sort.bam -s ZOS-166 \
-b H73JKBBXY_07-ZOS-119_CAAGCTAG-CGCTATGT_L006.sorted.bam_sort.bam -s ZOS-119 \
-b H73JKBBXY_08-ZOS-128_TGGATCGA-TATCGCAC_L006.sorted.bam_sort.bam -s ZOS-128 \
-b H73JKBBXY_09-ZOS-112_AGTTCAGG-TCTGTTGG_L006.sorted.bam_sort.bam -s ZOS-112 \
-b H73JKBBXY_10-ZOS-171_GACCTGAA-CTCACCAA_L006.sorted.bam_sort.bam -s ZOS-171 \
-b H73JKBBXY_11-ZOS-127_TCTCTACT-GAACCGCG_L006.sorted.bam_sort.bam -s ZOS-127 \
-b H73JKBBXY_12-ZOS-169_CTCTCGTC-AGGTTATA_L006.sorted.bam_sort.bam -s ZOS-169 \
-b H73JKBBXY_13-ZOS-348_CCAAGTCT-TCATCCTT_L006.sorted.bam_sort.bam -s ZOS-348 \
-b H73JKBBXY_14-ZOS-351_TTGGACTC-CTGCTTCC_L006.sorted.bam_sort.bam -s ZOS-351 \
-b H73JKBBXY_15-ZOS-352_GGCTTAAG-GGTCACGA_L006.sorted.bam_sort.bam -s ZOS-352 \
-b H73JKBBXY_16-ZOS-255_AATCCGGA-AACTGTAG_L006.sorted.bam_sort.bam -s ZOS-255 | ~/software/freebayes/bin/freebayes -f Zmarina_Olsen.fasta -c -v freebayes_last.vcf &







############################################################
### FreeBayes filter
### first remove indels
### second apply quality filter


vcftools --vcf freebayes.vcf --remove-indels --recode --recode-INFO-all --out freebayes.SNPs

vcffilter -f "SAF > 0 & SAR >0 & AB > 0.25 & AB < 0.75 & QUAL / DP > 0.25 & RPR > 1 & RPL > 1" freebayes.SNPs.recode.vcf >freebayes.SNPs.filtered.vcf

### minDP x 1/3 of averadge depth = 
### maxDP x2 averadge depth       =
vcftools --vcf freebayes.SNPs.filtered.vcf --minDP 3 --maxDP 20 --max-missing 1 --recode --out freebayes.SNPs.filtered.final

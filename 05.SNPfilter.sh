############################################################
### FreeBayes filter
### first remove indels
### second apply quality filter


vcftools --vcf freebayes.vcf --remove-indels --recode --recode-INFO-all --out freebayes.SNPs

vcffilter -f "SAF > 0 & SAR >0 & AB > 0.25 & AB < 0.75 & QUAL / DP > 0.25 & RPR > 1 & RPL > 1" freebayes.SNPs.recode.vcf >freebayes.SNPs.filtered.vcf

### minDP x 1/3 of averadge depth = 
### maxDP x2 averadge depth       =
vcftools --vcf freebayes.SNPs.filtered.vcf --minDP 3 --maxDP 20 --max-missing 1 --recode --out freebayes.SNPs.filtered.final

##### generate random names for the SNPs
vcf=freebayes.SNPs.filtered.final.recode.vcf

n=$(grep -c "scf" $vcf)

pwgen -1nc 15 $n >random_names
plink --vcf $vcf --allow-extra-chr --make-bed
paste plink.bim random_names >tmp
awk '{print $1"\t"$7"\t"$3"\t"$4"\t"$5"\t"$6}' tmp >plink2.bim
plink --bed plink.bed --bim plink2.bim --fam plink.fam --make-bed --allow-extra-chr 

#### VCF file with SNP names is not "plink.bed" files


# LD filtering
# plink --bfile freebayes.QC --allow-extra-chr --indep-pairwise 20kb 20 0.2
# plink --bfile freebayes.QC --allow-extra-chr --exclude plink.prune.out --maf 0.05 --make-bed --out freebayes.QC.r202.maf005




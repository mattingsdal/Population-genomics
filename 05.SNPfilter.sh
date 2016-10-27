############################################################
### FreeBayes filter
### first remove indels
### second apply quality filter


vcftools --vcf freebayes-parallel.vcf --remove-indels --min-alleles 2 --max-alleles 2 --recode --recode-INFO-all --out freebayes.SNPs

# SAF % SAR = remove alleles only seen in one strand
# AB = allelic balance
# RPL > 0 & RPR > 0 removes SNPs with reads only to the left / right

# vcffilter -f "SAF > 0 & SAR >0 & AB > 0.25 & AB < 0.75 & QUAL / DP > 0.25 & RPR > 1 & RPL > 1" freebayes.SNPs.recode.vcf >freebayes.SNPs.filtered.vcf

vcffilter -f "QUAL > 50 & QUAL / AO > 10 & SAF > 0 & SAR > 0 & RPR > 1 & RPL > 1" freebayes.SNPs.recode.vcf >freebayes.SNPs.filtered.vcf

### minDP x 1/3 of averadge depth = 
### maxDP x2 averadge depth       =
vcftools --vcf freebayes.SNPs.filtered.vcf --minDP 4 --maxDP 20 --max-missing 0.9 --recode --out freebayes.SNPs.filtered.final

#####################################################
##### generate random names for the SNPs
vcf=freebayes.SNPs.filtered.final.4.recode.vcf

grep -v "#" freebayes.SNPs.filtered.final.4.recode.vcf | wc -l
n=1331084

pwgen -1nc 15 $n >random_names
plink --vcf $vcf --allow-extra-chr --make-bed 
paste plink.bim random_names >tmp
awk '{print $1"\t"$7"\t"$3"\t"$4"\t"$5"\t"$6}' tmp >plink2.bim
plink --bed plink.bed --bim plink2.bim --fam plink.fam --make-bed --allow-extra-chr 

# prepare for imputaiton
plink --bfile plink --keep ../pop/south2plink --out south --recodeA --allow-extra-chr
plink --bfile plink --keep ../pop/west2plink --out west --recodeA --allow-extra-chr
plink --bfile plink --keep ../pop/ard2plink --out ard --recodeA --allow-extra-chr

# run linkimpute
java -jar ~/software/linkimpute/LinkImpute.jar south.raw south_linkimpute.raw
java -jar ~/software/linkimpute/LinkImpute.jar west.raw west_linkimpute.raw
java -jar ~/software/linkimpute/LinkImpute.jar ard.raw ard_linkimpute.raw

#### VCF file with SNP names is now  "plink.bed" files
######################################################

# LD filtering
# plink --bfile freebayes.QC --allow-extra-chr --indep-pairwise 20kb 20 0.2
# plink --bfile freebayes.QC --allow-extra-chr --exclude plink.prune.out --maf 0.05 --make-bed --out freebayes.QC.r202.maf005




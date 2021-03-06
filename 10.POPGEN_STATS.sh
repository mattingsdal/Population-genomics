# calculate allele frequencies for each population
$vcf=freebayes.SNPs.filtered.final.4.recode.vcf

mkdir popgen

### FREQUENCY
vcftools --vcf $vcf --keep ../pop/AR --freq2 --out popgen/AR 
vcftools --vcf $vcf  --keep ../pop/EG --freq2 --out popgen/EG 
vcftools --vcf $vcf  --keep ../pop/TV --freq2 --out popgen/TV
vcftools --vcf $vcf  --keep ../pop/ST --freq2 --out popgen/ST 
vcftools --vcf $vcf  --keep ../pop/NH --freq2 --out popgen/NH
vcftools --vcf $vcf  --keep ../pop/SM --freq2 --out popgen/SM 
vcftools --vcf $vcf  --keep ../pop/ARD --freq2 --out popgen/ARD 
vcftools --vcf $vcf  --keep ../pop/GF --freq2 --out popgen/GF 


### TAJIMA'S D
vcftools --vcf freebayes.SNPs.filtered.final.recode.vcf --keep ../pop/AR --TajimaD 10000 --out popgen/AR 
vcftools --vcf freebayes.SNPs.filtered.final.recode.vcf --keep ../pop/EG --TajimaD 10000 --out popgen/EG 
vcftools --vcf freebayes.SNPs.filtered.final.recode.vcf --keep ../pop/TV --TajimaD 10000 --out popgen/TV
vcftools --vcf freebayes.SNPs.filtered.final.recode.vcf --keep ../pop/ST --TajimaD 10000 --out popgen/ST 
vcftools --vcf freebayes.SNPs.filtered.final.recode.vcf --keep ../pop/NH --TajimaD 10000 --out popgen/NH
vcftools --vcf freebayes.SNPs.filtered.final.recode.vcf --keep ../pop/SM --TajimaD 10000 --out popgen/SM 
vcftools --vcf freebayes.SNPs.filtered.final.recode.vcf --keep ../pop/ARD --TajimaD 10000 --out popgen/ARD 

# HHETEROZYGOSITY
vcftools --vcf $vcf  --keep ../pop/AR --het --out popgen/AR 
vcftools --vcf $vcf  --keep ../pop/EG --het --out popgen/EG 
vcftools --vcf $vcf  --keep ../pop/TV --het --out popgen/TV
vcftools --vcf $vcf  --keep ../pop/ST --het --out popgen/ST 
vcftools --vcf $vcf  --keep ../pop/NH --het --out popgen/NH
vcftools --vcf $vcf  --keep ../pop/SM --het --out popgen/SM 
vcftools --vcf $vcf  --keep ../pop/ARD --het --out popgen/ARD
vcftools --vcf $vcf  --keep ../pop/GF --het --out popgen/GF


# HARDY-WINEBERG
vcftools --vcf freebayes.SNPs.filtered.final.recode.vcf --keep ../pop/AR --hardy --out popgen/AR 
vcftools --vcf freebayes.SNPs.filtered.final.recode.vcf --keep ../pop/EG --hardy --out popgen/EG 
vcftools --vcf freebayes.SNPs.filtered.final.recode.vcf --keep ../pop/TV --hardy --out popgen/TV
vcftools --vcf freebayes.SNPs.filtered.final.recode.vcf --keep ../pop/ST --hardy --out popgen/ST 
vcftools --vcf freebayes.SNPs.filtered.final.recode.vcf --keep ../pop/NH --hardy --out popgen/NH
vcftools --vcf freebayes.SNPs.filtered.final.recode.vcf --keep ../pop/SM --hardy --out popgen/SM 
vcftools --vcf freebayes.SNPs.filtered.final.recode.vcf --keep ../pop/ARD --hardy --out popgen/ARD

# DEPTH
vcftools --vcf freebayes.SNPs.filtered.final.recode.vcf --depth --out popgen/all 
vcftools --vcf freebayes.SNPs.filtered.final.recode.vcf --site-depth --out popgen/all 


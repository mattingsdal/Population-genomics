# generate multiple sequence alignmnent using variants called by freebayes
# vcffile must be zipped
# generate consensus sequences for all individuals using bcftools from my.vcf

vcf=freebayes.SNPs.filtered.final.recode.vcf

bgzip -c $vcf > ${vcf}.gz
tabix -p vcf ${vcf}.gz

mkdir fasta

ls *BWA.rgfix.dedup.bam | cut -f 1 -d . >samples

    while read p; do
         bcftools consensus -f ~/genome/symphodus_melops.fasta -s $p $vcf.gz > fasta/${p}.fasta
         done < samples
         
cd fasta
# extract contig of intereset and align them using muscle


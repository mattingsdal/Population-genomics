# generate multiple sequence alignmnent using variants called by freebayes

# generate consensus sequences for all individuals using bcftools from my.vcf

    for D in *bam
      do
      bcftools consensus -f ~/genome/symphodus_melops.fasta -S $D freebayes.vcf z > ${D}}.fasta
    done

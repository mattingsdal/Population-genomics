# submit gatk job to slurm cluster for all bam files

module load java
module load gatk


for D in *bam
do

srun -A cees -n 1 --mem-per-cpu=20G --time=4320 \
java -jar /cluster/software/VERSIONS/gatk-3.4-46/GenomeAnalysisTK.jar \
  -T HaplotypeCaller \
  -R /usit/abel/u1/mortema/software/bcbio/genomes/corkwing/version1/seq/version1.fa \
  -I ${D} \
  --emitRefConfidence GVCF \
  --variant_index_type LINEAR \
  --variant_index_parameter 128000 \
  -o ${D}.vcf &> gatk1.${D}.log &
  
  done

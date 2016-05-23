############################################################
## BWA
### this code walks through each directory and output a sam file in each
### be in raw directory

genome="path to genome fasta"

for D in *; do
  if [ -d "${D}" ]; then
     cd ${D}
     scp ${D}_R1_001.fastq.gz /home/morten/shared/temp
     scp ${D}_R2_001.fastq.gz /home/morten/shared/temp
     cd /home/morten/shared/temp
     gunzip *gz
     bwa mem $genome ${D}_R1_001.fastq ${D}_R2_001.fastq > ${D}.BWA.sam
     rm *fastq
     mv * /home/morten/data/raw/${D}
     cd /home/morten/data/raw
  fi
done

### end BWA
############################################################

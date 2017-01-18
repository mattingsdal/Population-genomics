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




##############
## alternative
#!/bin/sh

file=/usit/abel/u1/mortema/genome/corkwing.contigs.fasta

module load samtools

for R1 in ./*R1*.fastq.gz
    do
        echo $R1
        R2=`echo $R1 | sed 's/_R1_/_R2_/'`
        bname=`echo $R1 | sed 's/_R1_.\+//'`
        ~/software/bwa/bwa mem -M -t 20  $file $R1 $R2 | samtools view -@5 -Shb > $bname.sorted.bam
    done

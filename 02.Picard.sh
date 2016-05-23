############################################################
### add read groups using picard 
### be in bam directory

for D in *bam
 do

   rgid=$(echo $D | cut -f 1 -d .)
   rgsm=$(echo $D | cut -f 1 -d _)
   rgpu=$(echo $D | cut -f 1 -d .)
   platform=ILLUMINA
   tech=UiO_HiSeq_2500

   picard AddOrReplaceReadGroups I=$D O=$rgsm.BWA.rgfix.bam RGID=$rgid RGSM=$rgsm RGPL=$platform RGPU=$rgpu RGLB=$tech

done

### end add read groups using picard
############################################################
############################################################
### mark duplicates using picard
### be in bam rgfix directory

for D in *bam
do
  output=$(echo $D | cut -f 1,2,3 -d .)
  picard MarkDuplicates INPUT=$D OUTPUT=../bam_fixrg_dedup/$output.dedup.bam METRICS_FILE=../bam_fixrg_dedup/QC/$output.duplicates REMOVE_DUPLICATES=true MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=10
done

### end mark duplicates
############################################################
############################################################
### produce QC stats using picard for all bam files and place results in QC sub-folder
###
for D in *bam
do

  output=$(echo $D | cut -f 1,2,3,4 -d .)
  picard CollectAlignmentSummaryMetrics I=$D R=~/data/symphodus_melops.fasta O=QC/$output.CollectAlignmentSummaryMetrics.txt
  picard CollectInsertSizeMetrics I=$D O=QC/$output.CollectInsertSizeMetrics.txt M=0.5 H=QC/$output.CollectInsertSizeMetrics.pdf
  picard CollectGcBiasMetrics I=$D O=QC/$output.CollectGcBiasMetrics.txt CHART=QC/$output.CollectGcBiasMetrics.pdf S=QC/$output.CollectGcBiasMetrics.summary.txt R=~/data/symphodus_melops.fasta
  picard QualityScoreDistribution I=$D O=QC/$output.QualityScoreDistribution.txt CHART=QC/$output.QualityScoreDistribution.pdf

done
### end QC info
############################################################

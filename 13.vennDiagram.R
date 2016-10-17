# calculate frequencies using vcftools 

setwd("/home/morten/data/bam_fixrg_dedup/freebayes/popgen")
library(limma)

south=read.table("south.frq",row.names=NULL)
west=read.table("west.frq",row.names=NULL)
ard=read.table("ARD.frq",row.names=NULL)

venn=matrix(ncol=3,nrow=nrows(south))
venn[,1]=ifelse(as.numeric(west[,6])>0,0,1)
venn[,2]=ifelse(as.numeric(south[,6])>0,0,1)
venn[,3]=ifelse(as.numeric(ard[,6])>0,0,1)

colnames(venn)=c("West","South","Ardtoe")

a <- vennCounts(venn)
vennDiagram(a,circle.col=c("#ff4500","#4169e1","#ffd700"),cex=1,lwd=3)

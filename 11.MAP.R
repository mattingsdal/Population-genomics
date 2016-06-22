    # GOLD = ffd700
    # ROYLABLUE = 4169e1
    # ORANGE RED = ff4500

setwd("E:/data/bam_fixrg_dedup/freebayes/popgen")

#########################################################################
#########################################################################
library(scales)
library(rworldmap)
newmap <- getMap(resolution = "high")
plot(newmap, xlim = c(-6, 15), ylim = c(55, 63), asp = 2)
loc=matrix(ncol=2,nrow=7)

Tvedestrand=c(8.93140,58.62228)
Arendal=c(8.77245,58.46176)
Egersund=c(5.99980,58.45142)
Stavanger=c(5.73311,58.96998)
Norheimsund=c(6.14564,60.37089)
Smola=c(8.00687,63.38657)
Ardtoe=c(-5.88232,56.76745)
index=c("A","B","C","D","E","F","G")
col=c("#4169e1","#4169e1","#4169e1","#ff4500","#ff4500","#ff4500","#ffd700")


tmp=data.frame(rbind(Tvedestrand,Arendal,Egersund,Stavanger,Norheimsund,Smola,Ardtoe))
loc=cbind(tmp,index,col)

pdf("MAP.pdf")
par(mar = rep(0, 4))
plot(newmap, xlim = c(-6, 15), ylim = c(55, 63), asp = 2,lwd=1)
points(loc, col = "black", cex = 1,lwd=0,pch=19)
points(loc, col = alpha(loc$col,0.5), cex = 3,lwd=0,pch=19)
rect(loc[1,1]+0.5,loc[1,2]-0.25,loc[1,1]+1.5,loc[1,2]+0.25,col="white")
rect(loc[2,1]+0.5,loc[2,2]-0.25,loc[2,1]+1.5,loc[2,2]+0.25)
rect(loc[3,1]+0.5,loc[3,2]-0.25,loc[3,1]+1.5,loc[3,2]+0.25,col="white")
rect(loc[4,1]+0.5,loc[4,2]-0.25,loc[4,1]+1.5,loc[4,2]+0.25,col="white")
rect(loc[5,1]+0.5,loc[5,2]-0.25,loc[5,1]+1.5,loc[5,2]+0.25,col="white")
rect(loc[6,1]+0.5,loc[6,2]-0.25,loc[6,1]+1.5,loc[6,2]+0.25,col="white")
rect(loc[7,1]+0.5,loc[7,2]-0.25,loc[7,1]+1.5,loc[7,2]+0.25,col="white")
text(x=loc[,1]+1,y=loc[,2],label=index,cex=1,font=2,col=alpha("black",1))
dev.off()


#########################################################################
#########################################################################
### plot PCA
### first perform clustering analysis using PLINK then plot in R

cd /home/mortenma/data/bam_fixrg_dedup/freebayes
vcf=freebayes.SNPs.filtered.final.recode.vcf
plink --vcf $vcf --allow-extra-chr --cluster --mds-plot 2
mv plink.mds popgen/

R
pca=read.table("plink.mds",sep="",header=T)
tmp=c(rep("B",8),rep("G",8),rep("C",8),rep("E",8),rep("F",8),rep("D",8),rep("A",8))
tmp2=c(rep("#4169e1",8),rep("#ffd700",8),rep("#4169e1",8),rep("#ff4500",8),rep("#ff4500",8),rep("#ff4500",8),rep("#4169e1",8))
pca2=cbind(pca,tmp,tmp2)

pdf("PCA.pdf")
par(mar = rep(2, 4))
plot(pca$C1,pca$C2,pch=19,cex=3,lwd=0,col=alpha(as.character(pca2[,7]),0.5))
points(pca$C1,pca$C2,cex=0.5,pch=19)
dev.off()

#########################################################################
#########################################################################
### heterozygosity

het=read.table("all.het",sep="\t",header=T)

Group <- as.factor(c(
rep("Arendal",8),
rep("Ardtoe",8),
rep("Egersund",8),
rep("Norheimsund",8),
rep("Smola",8),
rep("Stavanger",8),
rep("Tvedestrand",8))
)
Location=c(rep(2,8),rep(7,8),rep(3,8),rep(5,8),rep(6,8),rep(4,8),rep(1,8))

HET=cbind(het,Group,Location)

pdf("Heterozygosity.pdf")
par(mar = rep(4, 4))
plot(HET$Location,HET$F,col=alpha(tmp2,0.5),pch=19,cex=3,lwd=0,ylab="F",xlab="Location", xaxt = "n")
points(HET$Location,HET$F,col="black",pch=19,cex=1,lwd=0)
axis(1, cex=2,at=1:7, labels=c("A","B","C","D","E","F","G"))
dev.off()

#########################################################################
#########################################################################
### site spesific Fst between south and west

vcftools --vcf freebayes.SNPs.filtered.final.recode.vcf --weir-fst-pop ../pop/south --weir-fst-pop ../pop/west --out popgen/fst

R
fst=read.table("fst.weir.fst",sep="",header=T)
pdf("Fst_distribution.pdf")
par(mar = rep(4, 4))
hist(fst[,3],breaks=50,col="gray95",main="",xlab="Fst")
legend(x=0.2,y=30000,legend=c("Mean Fst    = 0.09","Median Fst = 0.04"),bty="n",text.font=2)
dev.off()


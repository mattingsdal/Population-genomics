    # GOLD = ffd700
    # ROYLABLUE = 4169e1
    # ORANGE RED = ff4500

setwd("E:/data/bam_fixrg_dedup/freebayes/popgen")

#########################################################################
#########################################################################
#### construct map of interest, Northsea
library(scales)
library(rworldmap)
library(igraph)

newmap <- getMap(resolution = "high")
plot(newmap, xlim = c(-6, 15), ylim = c(55, 63), asp = 2)
loc=matrix(ncol=2,nrow=7)

Ardtoe=c(-5.88232,56.76745)
Smola=c(8.00687,63.38657)
Norheimsund=c(6.14564,60.37089)
Stavanger=c(5.73311,58.96998)
Egersund=c(5.99980,58.45142)
Arendal=c(8.77245,58.46176)
Tvedestrand=c(8.93140,58.62228)
Gullmarn=c(11.43333,58.25)


index=c("A","B","C","D","E","F","G","H")
col=c("#ffd700","#ff4500","#ff4500","#ff4500","#4169e1","#4169e1","#4169e1","#4169e1")


tmp=data.frame(rbind(Ardtoe,Smola,Norheimsund,Stavanger,Egersund,Arendal,Tvedestrand,Gullmarn))
loc=cbind(tmp,index,col)

Cairo(file="MAP.pdf",type="pdf",width=80,height=80,units="mm")
par(mar = rep(0, 4))
plot(newmap, xlim = c(-6, 15), ylim = c(55, 63), asp = 2,lwd=1,col="gray95")
points(loc, col = alpha(loc$col,0.5), cex = 2,lwd=0,pch=19)
points(loc, col = "black", cex = 0.5,lwd=0,pch=19)

rect(loc[1,1]+0.5,loc[1,2]-0.25,loc[1,1]+1.5,loc[1,2]+0.25,col="white",border=NA)
rect(loc[2,1]+0.5,loc[2,2]-0.25,loc[2,1]+1.5,loc[2,2]+0.25,col="white",border=NA)
rect(loc[3,1]+0.5,loc[3,2]-0.25,loc[3,1]+1.5,loc[3,2]+0.25,col="white",border=NA)
rect(loc[4,1]+0.5,loc[4,2]-0.25,loc[4,1]+1.5,loc[4,2]+0.25,col="white",border=NA)
rect(loc[5,1]+0.5,loc[5,2]-0.25,loc[5,1]+1.5,loc[5,2]+0.25,col="white",border=NA)
rect(loc[6,1]+0.5,loc[6,2]-0.25,loc[6,1]+1.5,loc[6,2]+0.25,col="white",border=NA)
rect(loc[7,1]+0.5,loc[7,2]-0.25,loc[7,1]+1.5,loc[7,2]+0.25,col="white",border=NA)
rect(loc[8,1]+0.5,loc[8,2]-0.25,loc[8,1]+1.5,loc[8,2]+0.25,col="white",border=NA)

#text(x=loc[,1]+1,y=loc[,2],label=index,cex=1,font=2,col=alpha("black",1))
loc[6,2]=58.17000

text(x=loc[,1]+1,y=loc[,2],label=index,cex=1,font=2,col=alpha("black",1))

dev.off()

loc=cbind(tmp,index,col)



# iArrows <- igraph:::igraph.Arrows
#  iArrows(x1=-5.88232,x2=5.73311, y1=56.76745, y2=58.96998,h.lwd=2, sh.lwd=2, sh.col="black",curve=0.5, width=1, size=0.7)
#  iArrows(x1=5.73311,x2=5.99980, y1=58.96998, y2=58.45142,h.lwd=2, sh.lwd=2, sh.col="black",curve=-3, width=1, size=0.7)
#  iArrows(x1=5.73311,x2=6.14564, y1=58.96998, y2=60.37089,h.lwd=2, sh.lwd=2, sh.col="black",curve=1, width=1, size=0.7)
  
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

Cairo(file="PCA.pdf",type="pdf",width=80,height=80,units="mm")
par(mar = c(2,2,1,1))
plot(pca$C1,pca$C2,pch=19,cex=2,cex.axis=0.5,cex.lab=0.5,lwd=0,col=alpha(as.character(pca2[,7]),0.5),xlab="PC1",ylab="PC2")
text(x=pca$C1,y=pca$C2,label=as.character(tmp),cex=0.5,font=2,col=alpha("black",1))
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

Cairo(file="F.pdf",type="pdf",width=80,height=80,units="mm")
par(mar = c(2,2,1,1))
plot(HET$Location,HET$F,cex.axis=0.5,cex.lab=0.5,col=alpha(tmp2,0.5),pch=19,cex=2,lwd=0,ylab="F",xlab="Location", xaxt = "n")
points(HET$Location,HET$F,col="black",pch=19,cex=0.5,lwd=0)
axis(1, cex.axis=0.5,at=1:7, labels=c("A","B","C","D","E","F","G"))
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

#########################################################################
#########################################################################
### Fst between all and plot Fst vs geographics distance
##################

vcftools --vcf freebayes.SNPs.filtered.final.recode.vcf --weir-fst-pop ../pop/TV --weir-fst-pop ../pop/AR --out popgen/TV_AR
vcftools --vcf freebayes.SNPs.filtered.final.recode.vcf --weir-fst-pop ../pop/AR --weir-fst-pop ../pop/EG --out popgen/AR_EG
vcftools --vcf freebayes.SNPs.filtered.final.recode.vcf --weir-fst-pop ../pop/EG --weir-fst-pop ../pop/ST --out popgen/EG_ST
vcftools --vcf freebayes.SNPs.filtered.final.recode.vcf --weir-fst-pop ../pop/ST --weir-fst-pop ../pop/NH --out popgen/ST_NH
vcftools --vcf freebayes.SNPs.filtered.final.recode.vcf --weir-fst-pop ../pop/NH --weir-fst-pop ../pop/SM --out popgen/NH_SM
vcftools --vcf freebayes.SNPs.filtered.final.recode.vcf --weir-fst-pop ../pop/west --weir-fst-pop ../pop/ARD --out popgen/west_ARD
vcftools --vcf freebayes.SNPs.filtered.final.recode.vcf --weir-fst-pop ../pop/south --weir-fst-pop ../pop/ARD --out popgen/south_ARD

R
setwd("E:/data/bam_fixrg_dedup/freebayes/popgen")
tv_ar=read.table("TV_AR.weir.fst",sep="",header=T)
ar_eg=read.table("AR_EG.weir.fst",sep="",header=T)
eg_st=read.table("EG_ST.weir.fst",sep="",header=T)
st_nh=read.table("ST_NH.weir.fst",sep="",header=T)
nh_sm=read.table("NH_SM.weir.fst",sep="",header=T)
w_ard=read.table("west_ARD.weir.fst",sep="",header=T)
s_ard=read.table("south_ARD.weir.fst",sep="",header=T)

res=matrix(ncol=2,nrow=7)


FST=c(
mean(na.omit(tv_ar[,3])),
mean(na.omit(ar_eg[,3])),
mean(na.omit(eg_st[,3])),
mean(na.omit(st_nh[,3])),
mean(na.omit(nh_sm[,3])),
mean(na.omit(w_ard[,3])),
mean(na.omit(s_ard[,3]))
)

res[,1]=as.numeric(c("20","200","70","180","500","500","500"))
res[,2]=FST

row.names(res)=c("A vs B","B vs C","C vs D","D vs E","E vs F","DEF vs G","ABC vs G")
colnames(res)=c("Geographical distance (km)","Genetic distance (mean Fst)")
res=as.data.frame(res)

Cairo(file="km_vs_fst.pdf",type="pdf",width=80,height=80,units="mm")
plot(res,pch=19,cex=1.5)
text(x=res[1,1]+10,y=res[1,2]+0.007,label="A vs B",cex=1,font=2)
text(x=res[2,1]+20,y=res[2,2]+0.007,label="B vs C",cex=1,font=2)
text(x=res[3,1]+10,y=res[3,2]+0.007,label="C vs D",cex=1,font=2)
text(x=res[4,1]-10,y=res[4,2]-0.007,label="D vs E",cex=1,font=2)
text(x=res[5,1]-10,y=res[5,2]+0.007,label="E vs F",cex=1,font=2)
text(x=res[6,1]-20,y=res[6,2]+0.007,label="DEF vs G",cex=1,font=2)
text(x=res[7,1]-20,y=res[7,2]+0.006,label="ABC vs G",cex=1,font=2)
dev.off()


#########################################################################
#########################################################################
### TREEMIX

wd=/home/mortenma/data/bam_fixrg_dedup/freebayes

cd $wd
plink --bfile plink --freq --missing --cluster --within ../pop/cluster2.txt --allow-extra-chr
gzip plink.frq.strat
python ~/software/treemix_0.1_src/utils/plink2treemix.py plink.frq.strat.gz 2treemix.frq.gz
treemix -i 2treemix.frq.gz -k 1000 -m 3 -root G -o corkwing -se -bootstrap -seed 666

setwd("E:/data/bam_fixrg_dedup/freebayes")

R
source("E:/data/plotting_funcs.R")

Cairo(file="popgen/treemix.pdf",type="pdf",width=80,height=80,units="mm")
par(mar = c(2,1,1,0))
plot_tree("corkwing",font=2,cex=0.8)
dev.off()

#########################################################################


#### LD decay
plink --bfile plink --r2 --ld-window-r2 0.2 --ld-window-kb 1000 --ld-window 10000 --keep ../pop/south --allow-extra-chr --out south
plink --bfile plink --r2 --ld-window-r2 0.2 --ld-window-kb 1000 --ld-window 10000 --keep ../pop/north --allow-extra-chr --out north
plink --bfile plink --r2 --ld-window-r2 0.2 --ld-window-kb 1000 --ld-window 10000 --keep ../pop/scotland --allow-extra-chr --out ard

R
setwd("E:/data/bam_fixrg_dedup/freebayes")
south=read.table("south.ld",sep="",header=T)
north=read.table("north.ld",sep="",header=T)
scotland=read.table("ard.ld",sep="",header=T)

south_bp=south$BP_B-south$BP_A
north_bp=north$BP_B-north$BP_A
scotland_bp=scotland$BP_B-scotland$BP_A

smoothingSpline_south = smooth.spline(south_bp,south$R2, spar=0.35)
smoothingSpline_north = smooth.spline(north_bp,north$R2, spar=0.35)
smoothingSpline_scotland = smooth.spline(scotland_bp,scotland$R2, spar=0.35)

plot(smoothingSpline_south,type="l",lwd=4,col="#4169e1",xlim=c(0,100000),ylab="pairwise LD (r2)",xlab="Physical distance between pairs of SNPs")
lines(smoothingSpline_north,type="l",lwd=4,col="#ff4500")
lines(smoothingSpline_scotland,type="l",lwd=4,col="#ffd700")



### Distribution of frequencies
# resultfile= plink.frq.strat
~/software/plink --bfile plink --allow-extra-chr --freq --within pop.txt




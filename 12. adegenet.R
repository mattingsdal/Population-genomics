plink --bfile plink --maf 0.05 --recodeA --out adegenet

R
    # GOLD = ffd700
    # ROYLABLUE = 4169e1
    # ORANGE RED = ff4500


library(adegenet)'

# read data
res=read.PLINK("adegenet.raw")
pop(res)=c(rep(3,7),rep(1,8),rep(3,18),rep(2,24),rep(3,8))

# set up variables
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


## PCA componenet analysis
pca1 <- glPca(res,parallel=TRUE,n.cores=3)

tmp=c(rep("F",7),rep("A",8),rep("E",8),rep("H",10),rep("C",8),rep("D",8),rep("B",8),rep("G",8))
tmp2=c(rep("#4169e1",7),rep("#ffd700",8),rep("#4169e1",8),rep("#4169e1",10),rep("#ff4500",8),rep("#ff4500",8),rep("#ff4500",8),rep("#4169e1",8))
pca2=cbind(pca1$scores,tmp,tmp2)

plot(pca2[,1:2],pch=19,cex=3,cex.axis=1,cex.lab=1,lwd=0,xlab="PC1",ylab="PC2",col=alpha(pca2[,4],0.5))
add.scatter.eig(pca1$eig[1:40],2,2,1, posi="bottomright", inset=(30,-30), ratio=.3)

### nice tree
plot(tre, typ="fan", show.tip=FALSE)
tiplabels(pch=20, col=alpha(pca2[,4],0.7), cex=4)


## DAPC
pop(res)=c(rep(3,7),rep(1,8),rep(3,18),rep(2,24),rep(3,8))
# remove scotland
res2=res[-8:-15,]

# perform dapc analysis
dapc1 <- dapc(res2,var.contrib = TRUE, scale = FALSE, n.pca = 30, n.da = nPop(res2) - 1)


loadingplot(tail(dapc1$var.contr[,1],100), thres=1e-3)

tmp=cbind(res2$loc.names,dapc1$var.contr)


### add snps to file "mysnps"
plink --bfile plink --extract mysnps --cluster --mds-plot 4 --allow-extra-chr --recode --out test
R
res=read.table("plink.mds")
tmp2=c(rep("#4169e1",7),rep("#ffd700",8),rep("#4169e1",8),rep("#4169e1",10),rep("#ff4500",8),rep("#ff4500",8),rep("#ff4500",8),rep("#4169e1",8))

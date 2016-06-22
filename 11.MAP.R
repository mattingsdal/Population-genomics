    # GOLD = ffd700
    # ROYLABLUE = 4169e1
    # ORANGE RED = ff4500

setwd("E:/data/bam_fixrg_dedup/freebayes/popgen")


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

loc=rbind(Tvedestrand,Arendal,Egersund,Stavanger,Norheimsund,Smola,Ardtoe)

plot(newmap, xlim = c(-6, 15), ylim = c(55, 63), asp = 2)
points(loc, col = "black", cex = 1,lwd=0,pch=19)
points(loc, col = alpha("black",0.1), cex = 3,lwd=0,pch=19)
text(x=loc[,1]+1.5,y=loc[,2],label=row.names(loc),cex=0.7,font=2,bg="white",col=alpha("black",0.7))



WC84<-function(x,pop){
x<-x[,!apply(is.na(x),2,any)]

  popNam<-sort(unique(pop))

  #number ind each population
  n<-table(pop)
  #number of populations
  npop<-nrow(n)
  #average sample size of each population
  n_avg<-mean(n)
  #total number of samples
  N<-length(pop)
  #frequency in samples
  p<-t(sapply(popNam,function(y) colMeans(x[pop==y,])/2))
 # p<-apply(x,2,function(x,pop){tapply(x,pop,mean)/2},pop=pop)
  #average frequency in all samples (apply(x,2,mean)/2)
  p_avg<-as.vector(n%*%p/N )
  #the sample variance of allele 1 over populations
  s2<-1/(npop-1)*(apply(p,1,function(x){((x-p_avg)^2)})%*%n)/n_avg
  #average heterozygouts
  #  h<-apply(x==1,2,function(x,pop)tapply(x,pop,mean),pop=pop)
  #average heterozygote frequency for allele 1
  #  h_avg<-as.vector(n%*%h/N)
  #faster version than above:
   h_avg<-apply(x==1,2,sum)/N
  #nc (see page 1360 in wier and cockerhamm, 1984)
  n_c<-1/(npop-1)*(N-sum(n^2)/N)
  #variance betwen populations
  a <- n_avg/n_c*(s2-(p_avg*(1-p_avg)-(npop-1)*s2/npop-h_avg/4)/(n_avg-1))
  #variance between individuals within populations
  b <- n_avg/(n_avg-1)*(p_avg*(1-p_avg)-(npop-1)*s2/npop-(2*n_avg-1)*h_avg/(4*n_avg))
  #variance within individuals
  c <- h_avg/2

  #inbreedning (F_it)
  F <- 1-c/(a+b+c)
  #(F_st)
  theta <- a/(a+b+c)
  #(F_is)
  f <- 1-c(b+c)
  #weigted average of theta
  theta_w<-sum(a)/sum(a+b+c)
  list(F=F,theta=theta,f=f,theta_w=theta_w,a=a,b=b,c=c,total=c+b+a)
}

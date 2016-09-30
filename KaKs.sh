### the folowing code used SPALN; MUSCLE AND SEQINR to calculate Ka and Ks values using a pairwise aligments and backtranslating them to cDNA

### format output from SPALN and align using MUSCLE

for G in *ALL.fa
	do
	muscle -in $G -out ${G}.msa.fa
	done

### run trinAL to trim aligments 

for G in *msa.fa
	do
	genome=$(echo $G | cut -f 1  -d ".")
	~/software/trimal/source/trimal -in ${genome}.fa.msa.fa -fasta -automated1 -backtrans ${genome}.cdna.fa -out ${genome}.trimal
	done



library(seqinr)

file.names <- dir(pattern ="*trimal")

result=matrix(ncol=3,nrow=length(file.names))
row.names(result)=file.names

for (j in 1:length(file.names)) {
	lala=read.alignment(paste(file.names[j]),format="fasta")
	lala2=kaks(lala)
	result[j,1]=lala2$ka
	result[j,2]=lala2$ks
	result[j,3]=lala2$ka/lala2$ks
}

write.table(result,"KaKs_result.txt",sep="\t")

	

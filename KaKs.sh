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



######################
######################
# KaKs calculation using scripts from bigBoy
#https://github.com/Bioboy2014/Scripts/tree/35dd405582042ffd1349696aa82a6298ea59aa56/FFgenome/03.evolution/kaks_pairwise/bin/script_KaKs_calculator 

for G in *trimal
	do
		perl KaKs.pl --kaks_calculator ~/software/KaKs_Calculator2.0/bin/Linux/KaKs_Calculator $G --outdir out
	done
	
	cd out
	
	for G in *axt
		do
		perl calculate_cds_aa_identity.pl $G > ${G}.identity
		perl sumKaKs.pl ${G}.kaks {G}.identity > ${G}_done	
	done


	

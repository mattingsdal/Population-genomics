##############
## first define plink binary files without extention
## run fastStructure using a simple model. It assumes strong structure. Run logistic if we have little structure
##############

# PLINK binary dataset:
snpdata=freebayes.QC.r202.maf005
outdir=/home/mortenma/data/bam_fixrg_dedup/freebayes/plink/structure

structure -K 1 --input $snpdata --out structure/freebayes --full --seed=100
structure -K 2 --input $snpdata --out structure/freebayes --full --seed=100
structure -K 3 --input $snpdata --out structure/freebayes --full --seed=100
structure -K 4 --input $snpdata --out structure/freebayes --full --seed=100
structure -K 5 --input $snpdata --out structure/freebayes --full --seed=100
structure -K 6 --input $snpdata --out structure/freebayes --full --seed=100
structure -K 7 --input $snpdata --out structure/freebayes --full --seed=100
structure -K 8 --input $snpdata --out structure/freebayes --full --seed=100

chooseK.py --input=structure/freebayes

## edit distruct2.2 to change colors
## edit pop file and poporder file

distruct2.2 -K 2 --input=freebayes --output=$outdir/freebayes_K2.svg --popfile=pop.txt --poporder=poporder.txt --title="K=2, Freebayes QC, no LD, MAF>5%, SNPs=119 066"
distruct2.2 -K 3 --input=freebayes --output=$outdir/freebayes_K3.svg --popfile=pop.txt --poporder=poporder.txt --title="K=3, Freebayes QC, no LD, MAF>5%, SNPs=119 066"
distruct2.2 -K 4 --input=freebayes --output=$outdir/freebayes_K4.svg --popfile=pop.txt --poporder=poporder.txt --title="K=4, Freebayes QC, no LD, MAF>5%, SNPs=119 066"


cd 
~/software/plink --bfile plink_imputed --chr tig00000001 tig00000004 tig00000025 tig00023313 tig00000069 tig00000092 tig00000104 tig00000123 tig00000112 tig00023367 tig00023308 tig00000175 tig00023325 tig00000191 tig00000156 tig00023380 tig00000166 tig00000178 tig00000165 tig00023422 tig00023431 tig00000185 tig00000224 tig00023309 tig00000280 tig00000243 tig00000334 tig00000406 tig00023455 tig00023334 tig00023437 tig00000348 tig00023543 tig00023450 tig00023331 tig00023368 tig00000410 tig00000430 tig00000479 tig00023498 tig00023302 tig00000575 tig00000555 tig00000579 tig00000590 tig00023461 tig00000532 tig00000570 tig00023535 tig00000691 tig00023572 tig00000659 tig00000714 tig00000604 tig00000609 tig00000683 tig00000626 tig00000759 tig00000647 tig00000787 tig00000906 tig00000693 tig00023349 tig00023328 tig00023419 tig00000819 --make-bed --out plink_imputed_mycontigs --allow-extra-chr

~/software/plink --bfile plink_imputed_mycontigs --keep south2plink --recode-vcf --out plink.imputed.mycontigs.south --allow-extra-chr
~/software/plink --bfile plink_imputed_mycontigs --keep west2plink --recode-vcf --out plink.imputed.mycontigs.west --allow-extra-chr
~/software/plink --bfile plink_imputed_mycontigs --keep ARD2plink --recode-vcf --out plink.imputed.mycontigs.ARD --allow-extra-chr

awk '{gsub(/^tig/,""); print}' plink.imputed.mycontigs.south.vcf > tmp1.vcf 
awk '{gsub(/^tig/,""); print}' plink.imputed.mycontigs.west.vcf > tmp2.vcf 
awk '{gsub(/^tig/,""); print}' plink.imputed.mycontigs.ARD.vcf > tmp3.vcf 

vcf-query tmp1.vcf -f '%CHROM\t%POS\t%REF\t[%GT]\n' | awk '{gsub ( "/","" ) ; print $0 }' >south.rare.popdata
vcf-query tmp2.vcf -f '%CHROM\t%POS\t%REF\t[%GT]\n' | awk '{gsub ( "/","" ) ; print $0 }' >west.rare.popdata
vcf-query tmp3.vcf -f '%CHROM\t%POS\t%REF\t[%GT]\n' | awk '{gsub ( "/","" ) ; print $0 }' >ARD.rare.popdata



scp west.popdata ~/software/Inferring-demography-from-IBS
scp south.popdata ~/software/Inferring-demography-from-IBS
scp ARD.popdata ~/software/Inferring-demography-from-IBS

python parse_within_pop_allpairs.py south.rare None 1
python parse_within_pop_allpairs.py west.rare None 1
python parse_within_pop_allpairs.py ARD.rare None 1

python infer_onepop_adaptive_cumulative.py south_lengths.ibs 10 20 5
python infer_onepop_adaptive_cumulative.py west_lengths.ibs 10 20 5
python infer_onepop_adaptive_cumulative.py ARD_lengths.ibs 10 20 5


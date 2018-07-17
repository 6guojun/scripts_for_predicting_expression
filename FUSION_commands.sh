rm bcac_fusion.out

echo "Running FUSION on chr1" &>> bcac_fusion.out
Rscript FUSION.assoc_test.R \
--sumstats ~/bcac/bcac_filtered.sumstats \
--weights ./WEIGHTS/GTEx.Breast_Mammary_Tissue.pos \
--weights_dir ./WEIGHTS/ \
--ref_ld_chr ./LDREF/1000G.EUR. \
--chr 1 \
--out bcac-chr1.dat &>> bcac_fusion.out

echo "Running FUSION on chr2" &>> bcac_fusion.out
Rscript FUSION.assoc_test.R \
--sumstats ~/bcac/bcac_filtered.sumstats \
--weights ./WEIGHTS/GTEx.Breast_Mammary_Tissue.pos \
--weights_dir ./WEIGHTS/ \
--ref_ld_chr ./LDREF/1000G.EUR. \
--chr 2 \
--out bcac-chr2.dat &>> bcac_fusion.out

echo "Running FUSION on chr3" &>> bcac_fusion.out
Rscript FUSION.assoc_test.R \
--sumstats ~/bcac/bcac_filtered.sumstats \
--weights ./WEIGHTS/GTEx.Breast_Mammary_Tissue.pos \
--weights_dir ./WEIGHTS/ \
--ref_ld_chr ./LDREF/1000G.EUR. \
--chr 3 \
--out bcac-chr3.dat &>> bcac_fusion.out

echo "Running FUSION on chr4" &>> bcac_fusion.out
Rscript FUSION.assoc_test.R \
--sumstats ~/bcac/bcac_filtered.sumstats \
--weights ./WEIGHTS/GTEx.Breast_Mammary_Tissue.pos \
--weights_dir ./WEIGHTS/ \
--ref_ld_chr ./LDREF/1000G.EUR. \
--chr 4 \
--out bcac-chr4.dat &>> bcac_fusion.out

echo "Running FUSION on chr5" &>> bcac_fusion.out
Rscript FUSION.assoc_test.R \
--sumstats ~/bcac/bcac_filtered.sumstats \
--weights ./WEIGHTS/GTEx.Breast_Mammary_Tissue.pos \
--weights_dir ./WEIGHTS/ \
--ref_ld_chr ./LDREF/1000G.EUR. \
--chr 5 \
--out bcac-chr5.dat &>> bcac_fusion.out

echo "Running FUSION on chr6" &>> bcac_fusion.out
Rscript FUSION.assoc_test.R \
--sumstats ~/bcac/bcac_filtered.sumstats \
--weights ./WEIGHTS/GTEx.Breast_Mammary_Tissue.pos \
--weights_dir ./WEIGHTS/ \
--ref_ld_chr ./LDREF/1000G.EUR. \
--chr 6 \
--out bcac-chr6.dat &>> bcac_fusion.out

echo "Running FUSION on chr7" &>> bcac_fusion.out
Rscript FUSION.assoc_test.R \
--sumstats ~/bcac/bcac_filtered.sumstats \
--weights ./WEIGHTS/GTEx.Breast_Mammary_Tissue.pos \
--weights_dir ./WEIGHTS/ \
--ref_ld_chr ./LDREF/1000G.EUR. \
--chr 7 \
--out bcac-chr7.dat &>> bcac_fusion.out

echo "Running FUSION on chr8" &>> bcac_fusion.out
Rscript FUSION.assoc_test.R \
--sumstats ~/bcac/bcac_filtered.sumstats \
--weights ./WEIGHTS/GTEx.Breast_Mammary_Tissue.pos \
--weights_dir ./WEIGHTS/ \
--ref_ld_chr ./LDREF/1000G.EUR. \
--chr 8 \
--out bcac-chr8.dat &>> bcac_fusion.out

echo "Running FUSION on chr9" &>> bcac_fusion.out
Rscript FUSION.assoc_test.R \
--sumstats ~/bcac/bcac_filtered.sumstats \
--weights ./WEIGHTS/GTEx.Breast_Mammary_Tissue.pos \
--weights_dir ./WEIGHTS/ \
--ref_ld_chr ./LDREF/1000G.EUR. \
--chr 9 \
--out bcac-chr9.dat &>> bcac_fusion.out

echo "Running FUSION on chr10" &>> bcac_fusion.out
 FUSION.assoc_test.R \
--sumstats ~/bcac/bcac_filtered.sumstats \
--weights ./WEIGHTS/GTEx.Breast_Mammary_Tissue.pos \
--weights_dir ./WEIGHTS/ \
--ref_ld_chr ./LDREF/1000G.EUR. \
--chr 10 \
--out bcac-chr10.dat &>> bcac_fusion.out

echo "Running FUSION on chr11" &>> bcac_fusion.out
Rscript FUSION.assoc_test.R \
--sumstats ~/bcac/bcac_filtered.sumstats \
--weights ./WEIGHTS/GTEx.Breast_Mammary_Tissue.pos \
--weights_dir ./WEIGHTS/ \
--ref_ld_chr ./LDREF/1000G.EUR. \
--chr 11
--out bcac-chr11.dat &>> bcac_fusion.out

echo "Running FUSION on chr12" &>> bcac_fusion.out
Rscript FUSION.assoc_test.R \
--sumstats ~/bcac/bcac_filtered.sumstats \
--weights ./WEIGHTS/GTEx.Breast_Mammary_Tissue.pos \
--weights_dir ./WEIGHTS/ \
--ref_ld_chr ./LDREF/1000G.EUR. \
--chr 12 \
--out bcac-chr12.dat &>> bcac_fusion.out

echo "Running FUSION on chr13" &>> bcac_fusion.out
Rscript FUSION.assoc_test.R \
--sumstats ~/bcac/bcac_filtered.sumstats \
--weights ./WEIGHTS/GTEx.Breast_Mammary_Tissue.pos \
--weights_dir ./WEIGHTS/ \
--ref_ld_chr ./LDREF/1000G.EUR. \
--chr 13 \
--out bcac-chr13.dat &>> bcac_fusion.out

echo "Running FUSION on chr14" &>> bcac_fusion.out
Rscript FUSION.assoc_test.R \
--sumstats ~/bcac/bcac_filtered.sumstats \
--weights ./WEIGHTS/GTEx.Breast_Mammary_Tissue.pos \
--weights_dir ./WEIGHTS/ \
--ref_ld_chr ./LDREF/1000G.EUR. \
--chr 14 \
--out bcac-chr14.dat &>> bcac_fusion.out

echo "Running FUSION on chr15" &>> bcac_fusion.out
Rscript FUSION.assoc_test.R \
--sumstats ~/bcac/bcac_filtered.sumstats \
--weights ./WEIGHTS/GTEx.Breast_Mammary_Tissue.pos \
--weights_dir ./WEIGHTS/ \
--ref_ld_chr ./LDREF/1000G.EUR. \
--chr 15 \
--out bcac-chr15.dat &>> bcac_fusion.out

echo "Running FUSION on chr16" &>> bcac_fusion.out
Rscript FUSION.assoc_test.R \
--sumstats ~/bcac/bcac_filtered.sumstats \
--weights ./WEIGHTS/GTEx.Breast_Mammary_Tissue.pos \
--weights_dir ./WEIGHTS/ \
--ref_ld_chr ./LDREF/1000G.EUR. \
--chr 16 \
--out bcac-chr16.dat &>> bcac_fusion.out

echo "Running FUSION on chr17" &>> bcac_fusion.out
Rscript FUSION.assoc_test.R \
--sumstats ~/bcac/bcac_filtered.sumstats \
--weights ./WEIGHTS/GTEx.Breast_Mammary_Tissue.pos \
--weights_dir ./WEIGHTS/ \
--ref_ld_chr ./LDREF/1000G.EUR. \
--chr 17 \
--out bcac-chr17.dat &>> bcac_fusion.out

echo "Running FUSION on chr18" &>> bcac_fusion.out
Rscript FUSION.assoc_test.R \
--sumstats ~/bcac/bcac_filtered.sumstats \
--weights ./WEIGHTS/GTEx.Breast_Mammary_Tissue.pos \
--weights_dir ./WEIGHTS/ \
--ref_ld_chr ./LDREF/1000G.EUR. \
--chr 18 \
--out bcac-chr18.dat &>> bcac_fusion.out

echo "Running FUSION on chr19" &>> bcac_fusion.out
Rscript FUSION.assoc_test.R \
--sumstats ~/bcac/bcac_filtered.sumstats \
--weights ./WEIGHTS/GTEx.Breast_Mammary_Tissue.pos \
--weights_dir ./WEIGHTS/ \
--ref_ld_chr ./LDREF/1000G.EUR. \
--chr 19 \
--out bcac-chr19.dat &>> bcac_fusion.out

echo "Running FUSION on chr20" &>> bcac_fusion.out
Rscript FUSION.assoc_test.R \
--sumstats ~/bcac/bcac_filtered.sumstats \
--weights ./WEIGHTS/GTEx.Breast_Mammary_Tissue.pos \
--weights_dir ./WEIGHTS/ \
--ref_ld_chr ./LDREF/1000G.EUR. \
--chr 20 \
--out bcac-chr20.dat &>> bcac_fusion.out

echo "Running FUSION on chr21" &>> bcac_fusion.out
Rscript FUSION.assoc_test.R \
--sumstats ~/bcac/bcac_filtered.sumstats \
--weights ./WEIGHTS/GTEx.Breast_Mammary_Tissue.pos \
--weights_dir ./WEIGHTS/ \
--ref_ld_chr ./LDREF/1000G.EUR. \
--chr 21 \
--out bcac-chr21.dat &>> bcac_fusion.out

echo "Running FUSION on chr22" &>> bcac_fusion.out
Rscript FUSION.assoc_test.R \
--sumstats ~/bcac/bcac_filtered.sumstats \
--weights ./WEIGHTS/GTEx.Breast_Mammary_Tissue.pos \
--weights_dir ./WEIGHTS/ \
--ref_ld_chr ./LDREF/1000G.EUR. \
--chr 22 \
--out bcac-chr22.dat &>> bcac_fusion.out

# sex genes?

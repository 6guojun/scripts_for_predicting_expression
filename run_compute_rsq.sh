# ! /bin/bash
#$ -V
#$ -S /bin/bash
#$ -o /cellar/users/jlz014/sge/out/
#$ -e /cellar/users/jlz014/sge/err/
#$ -cwd
#$ -l long
#$ -l h_vmem=32G
#$ -pe smp 8

Rscript /cellar/users/jlz014/fusion_twas-master/TCGA-BRCA_normed_weights/compute_rsq_for_tcga-brca_predictions.R

echo 'done'
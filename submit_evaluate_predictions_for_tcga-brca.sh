# ! /bin/bash
#$ -V
#$ -S /bin/bash
#$ -o /cellar/users/jlz014/sge/evaluate_predictions_out
#$ -e /cellar/users/jlz014/sge/evaluate_predictions_err
#$ -cwd
#$ -l h_vmem=32G
#$ -pe smp 4

python /cellar/users/jlz014/fusion_twas-master/TCGA-BRCA_normed_weights/evaluate_predictions-python.py
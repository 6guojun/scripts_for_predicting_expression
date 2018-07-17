# ! /bin/bash
#$ -V
#$ -S /bin/bash
#$ -o /cellar/users/jlz014/sge/parse_wgts_out
#$ -e /cellar/users/jlz014/sge/parse_wgts_err
#$ -cwd
#$ -l h_vmem=16G
#$ -l long
#$ -pe smp 8
#$ -t 1-16298

INFILE=`sed -n -e "$SGE_TASK_ID p" all_tcga-brca_weights.txt`

echo 'processing $INFILE'

Rscript parse_wgts.R --file $INFILE

echo 'done'

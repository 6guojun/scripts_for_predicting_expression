# ! /bin/bash
#$ -V
#$ -S /bin/bash
#$ -o /cellar/users/jlz014/sge/out/run_predict_tcga-brca
#$ -e /cellar/users/jlz014/sge/err/run_predict_tcga-brca
#$ -cwd
#$ -t 2-1883
#$ -l h_vmem=32G
#$ -pe smp 4
#$ -tc 60

FUSION_DIR='/cellar/users/jlz014/fusion_twas-master/'
MODELS_DIR='/cellar/users/jlz014/fusion_twas-master/TCGA-BRCA_normed_weights'
FILES=$MODELS_DIR/tcga-brca_enet_models_files_test_patients_significant_models.txt
OUT_DIR=$MODELS_DIR/prediction_results


if [[ ! -e $OUT_DIR ]]; then
    mkdir $OUT_DIR
fi

LINE=`awk -v line=$SGE_TASK_ID 'NR==line' $FILES`
GENE=`echo $LINE | awk '{ print $1 }'`
WGTS=`echo $LINE | awk '{ print $2 }'`
GENOS=`echo $LINE | awk '{ print $3 }'`
echo $GENE $WGTS $GENOS

OUT_FH=$OUT_DIR/$GENE.predictions.txt
echo $OUT_FH

Rscript $FUSION_DIR/predict_tcga-brca_expr.R --gene $GENE --weights $MODELS_DIR/EUR/$WGTS --genos $GENOS --out $OUT_FH

echo 'done'

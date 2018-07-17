# ! /bin/bash
#$ -V
#$ -S /bin/bash
#$ -o /cellar/users/jlz014/sge/out/compute_tcga_weights_7-12-2018
#$ -e /cellar/users/jlz014/sge/err/compute_tcga_weights_7-12-2018
#$ -cwd
#$ -t 2-18114
#$ -l h_vmem=32G
#$ -pe smp 4
#$ -tc 60
#$ -l long

# set -o xtrace

# # make *.ID for gene expression file before script is submitted with the following commands:
# THIS IS USED TO RESTRICT INPUT SNPS TO REFERENCE IDS ONLY
# PRE_GEXP_DIR='/data/cellardata/users/jlz014/TCGA/expression/'
# PRE_GEXP="TCGA-BRCA.ENSG.chr1-22.median-filt.log2RPKM.qnorm.train.txt"
# echo `awk 'NR==1' $PRE_GEXP_DIR/$PRE_GEXP` | tr ' ' '\n' | tail -n+5 > $PRE_GEXP.ID.tmp
# paste $PRE_GEXP.ID.tmp $PRE_GEXP.ID.tmp | column -s $'\t' -t > $PRE_GEXP.ID

# MAKE SURE FUSION.compute_weights.R IS IN YOUR PATH
# FILL IN THESE PATHS
GCTA="/cellar/users/jlz014/fusion_twas-master/gcta_nr_robust"
PLINK="<PATH TO PLINK>"
GEMMA="/cellar/users/jlz014/gemma/bin/gemma"

# PATH TO DIRECTORY CONTAINING IMPUTED TCGA GENOTYPES
TCGA_GENO='/cellar/users/jlz014/Data/TCGA/TCGA_EUR_imputed'

# PATH TO TCGA-BRCA GENE EXPRESSION MATRIX (training data):
PRE_GEXP_DIR='/data/cellardata/users/jlz014/TCGA/expression'
PRE_GEXP="TCGA-BRCA.ENSG.chr1-22.median-filt.log2RPKM.qnorm.train.txt"

# PATH TO TCGA GENOTYPES
PRE_GENO="EUR_imputed_females_filtered"

# Save final outputs to this directory
OUT_DIR='./TCGA-BRCA_normed_weights'
if [[ ! -e $OUT_DIR ]]; then
    mkdir -p $OUT_DIR
fi

# --- BEGIN SCRIPT:
echo 'checking for directories'
if [[ ! -e tmp/$PRE_GENO ]]; then
	echo 'mkdir tmp/$PRE_GENO'
    mkdir -p tmp/$PRE_GENO
fi
if [[ ! -e hsq/$PRE_GENO ]]; then
    mkdir -p hsq/$PRE_GENO
fi
if [[ ! -e out/$PRE_GENO ]]; then
    mkdir -p out/$PRE_GENO
fi

# current line
echo $SGE_TASK_ID
PARAM=`awk -v line=$SGE_TASK_ID 'NR==line' $PRE_GEXP_DIR/$PRE_GEXP`

# Get the gene positions +/- 500kb (1MB window)
CHR=`echo $PARAM | awk '{ print $2 }'`
P0=`echo $PARAM | awk '{ print $3 - 0.5e6 }'`
P1=`echo $PARAM | awk '{ print $4 + 0.5e6 }'`
GNAME=`echo $PARAM | awk '{ print $1 }'`

# This is where tmp files are written to - write to protected directory bc of genotype data
OUT="tmp/$PRE_GENO/$PRE_GEXP.$GNAME"
echo $GNAME $CHR $P0 $P1

# Pull out the current gene expression phenotype
echo $PARAM | tr ' ' '\n' | tail -n+5 | paste $PRE_GEXP.ID - > $OUT.pheno

# # Get the locus genotypes for all samples and set current gene expression as the phenotype
plink2 --bfile $TCGA_GENO/$PRE_GENO.$CHR --threads 8 --pheno $OUT.pheno --make-bed --out $OUT --keep $OUT.pheno --chr $CHR --from-bp $P0 --to-bp $P1 --extract $TCGA_GENO/$PRE_GENO.$CHR.bim

# Process EUR samples
if [[ ! -e $OUT_DIR/EUR ]]; then
    mkdir $OUT_DIR/EUR
fi
FINAL_OUT="$OUT_DIR/EUR/EUR.$GNAME"
echo $FINAL_OUT

Rscript FUSION.compute_weights.R --bfile $OUT --tmp $OUT.EUR.tmp --out $FINAL_OUT --verbose 1 --hsq_set 0.01 --PATH_gcta $GCTA --PATH_gemma $GEMMA --models enet,top1 --noclean --crossval 10

echo 'done'

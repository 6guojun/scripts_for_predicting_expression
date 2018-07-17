# ! /bin/bash
#$ -V
#$ -S /bin/bash
#$ -o /cellar/users/jlz014/sge/out
#$ -e /cellar/users/jlz014/sge/err
#$ -cwd
#$ -t 2-23514
#$ -l h_vmem=32G
#$ -pe smp 4
#$ -tc 60
#$ -l long

# set -o xtrace

# MAKE SURE FUSION.compute_weights.R IS IN YOUR PATH
# FILL IN THESE PATHS
GCTA="/cellar/users/jlz014/fusion_twas-master/gcta_nr_robust"
PLINK="<PATH TO PLINK>"
GEMMA="/cellar/users/jlz014/gemma/bin/gemma"
# ALTERNATIVELY: ENSURE THAT plink, gcta, gemma CAN BE CALLED FROM PATH AND REMOVE --PATH_* FLAGS BELOW

# PATH TO DIRECTORY CONTAINING IMPUTED TCGA GENOTYPES
TCGA_GENO='/cellar/users/jlz014/Data/TCGA/imputed/split_chr' 
# THIS IS USED TO RESTRICT INPUT SNPS TO REFERENCE IDS ONLY

# PATH TO TCGA-BRCA GENE EXPRESSION MATRIX:
PRE_GEXP_DIR='/data/cellardata/users/jlz014/TCGA/'
PRE_GEXP="TCGA-BRCA_train.txt"

# PATH TO PREFIX FOR GEUVADIS GENOTYPES SPLIT BY CHROMOSOME
# SUBSAMPLE THESE TO THE LDREF SNPS FOR EFFICIENCY
# test white population first
PRE_GENO="white_imputed_rsID1"

# PATH TO OUTPUT DIRECTORY (population-specific subdirs will be made)
OUT_DIR="/nrnb/users/jlz014/Data/WEIGHTS_save_hsq"

# make *.ID for gene expression file
echo `awk 'NR==1' $PRE_GEXP_DIR/$PRE_GEXP` | tr ' ' '\n' | tail -n+5 > $PRE_GEXP.ID.tmp
paste $PRE_GEXP.ID.tmp $PRE_GEXP.ID.tmp | column -s $'\t' -t > $PRE_GEXP.ID

# --- BEGIN SCRIPT:
NR="TCGA_BRCA_"$PRE_GENO
mkdir --parents tmp/$NR
mkdir --parents hsq/$NR
mkdir --parents out/$NR
# THIS IS DIRECTORY WHERE THE OUTPUT WILL GO:
mkdir $OUT_DIR

# current line
echo $SGE_TASK_ID
PARAM=`awk -v line=$SGE_TASK_ID 'NR==line' $PRE_GEXP_DIR/$PRE_GEXP`

# Get the gene positions +/- 500kb (1MB window)
CHR=`echo $PARAM | awk '{ print $2 }'`
P0=`echo $PARAM | awk '{ print $3 - 0.5e6 }'`
P1=`echo $PARAM | awk '{ print $4 + 0.5e6 }'`
GNAME=`echo $PARAM | awk '{ print $1 }'`

OUT="tmp/$NR/$PRE_GEXP.$GNAME"
echo $GNAME $CHR $P0 $P1

# Pull out the current gene expression phenotype
echo $PARAM | tr ' ' '\n' | tail -n+5 | paste $PRE_GEXP.ID - > $OUT.pheno

# # Get the locus genotypes for all samples and set current gene expression as the phenotype
plink2 --bfile $TCGA_GENO/$PRE_GENO.$CHR --pheno $OUT.pheno --make-bed --out $OUT --keep $OUT.pheno --chr $CHR --from-bp $P0 --to-bp $P1 --extract $TCGA_GENO/$PRE_GENO.$CHR.bim

# Process all samples together (for reference purposes only since this is multi-ethnic data)
mkdir $OUT_DIR/ALL
FINAL_OUT="$OUT_DIR/ALL/ALL.$GNAME"
echo $FINAL_OUT

Rscript FUSION.compute_weights.R --bfile $OUT --tmp $OUT.ALL.tmp --out $FINAL_OUT --verbose 0 --save_hsq --hsq_p 0.05 --PATH_gcta $GCTA --PATH_gemma $GEMMA

echo 'Append heritability output to hsq file'
# Append heritability output to hsq file
cat $FINAL_OUT.hsq >> hsq/$NR.hsq

# echo 'clean up'
# # Clean-up just in case
# rm -f $FINAL_OUT.hsq $OUT.tmp.*

# echo 'remove all intermediate files'
# # Remove all intermediate files
# rm $OUT.*

echo 'done'

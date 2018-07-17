# ! /bin/bash
#$ -V
#$ -S /bin/bash
#$ -o /cellar/users/jlz014/sge/out
#$ -e /cellar/users/jlz014/sge/err
#$ -cwd
#$ -t 2-1883
#$ -l h_vmem=32G
#$ -pe smp 4
#$ -tc 60
#$ -l long

#This code will generate .bed, .bim, .fam files for the patients in the test set in the windows of each gene in the test expression file

# PATH TO DIRECTORY CONTAINING IMPUTED TCGA GENOTYPES
TCGA_GENO='/cellar/users/jlz014/Data/TCGA/TCGA_EUR_imputed'

# PATH TO TEST GENE EXPRESSION MATRIX:
PRE_GEXP_DIR='/data/cellardata/users/jlz014/TCGA/expression/'
PRE_GEXP="TCGA-BRCA.ENSG.chr1-22.median-filt.log2RPKM.qnorm.test.for_predictions.txt"

# PATH TO PREFIX FOR GEUVADIS GENOTYPES SPLIT BY CHROMOSOME
# SUBSAMPLE THESE TO THE LDREF SNPS FOR EFFICIENCY
PRE_GENO="EUR_imputed_females_filtered"

# PATH TO OUTPUT DIRECTORY 
OUT_DIR="./brca_test_patients_tmp_plink"

# make *.ID for gene expression file
# echo `awk 'NR==1' $PRE_GEXP_DIR$PRE_GEXP` | tr ' ' '\n' | tail -n+5 > $PRE_GEXP.ID.tmp
# paste $PRE_GEXP.ID.tmp $PRE_GEXP.ID.tmp | column -s $'\t' -t > $PRE_GEXP.ID
# # rm $PRE_GEXP.ID.tmp

# --- BEGIN SCRIPT:
mkdir $OUT_DIR

PARAM=`awk -v line=$SGE_TASK_ID 'NR==line' $PRE_GEXP_DIR/$PRE_GEXP`

# Get the gene positions +/- 500kb (1MB window)
CHR=`echo $PARAM | awk '{ print $2 }'`
P0=`echo $PARAM | awk '{ print $3 - 0.5e6 }'`
P1=`echo $PARAM | awk '{ print $4 + 0.5e6 }'`
GNAME=`echo $PARAM | awk '{ print $1 }'`

# # output directory for tmp plink files generated 
OUT="$OUT_DIR/$PRE_GEXP.$GNAME"
echo $GNAME $CHR $P0 $P1
echo $OUT

# Pull out the current gene expression phenotype
echo $PARAM | tr ' ' '\n' | tail -n+5 | paste $PRE_GEXP.ID - > $OUT.pheno

echo 'running plink'
# # Get the locus genotypes for all samples and set current gene expression as the phenotype
plink2 --bfile $TCGA_GENO/$PRE_GENO.$CHR --pheno $OUT.pheno --make-bed --out $OUT --keep $OUT.pheno --chr $CHR --from-bp $P0 --to-bp $P1 --extract $TCGA_GENO/$PRE_GENO.$CHR.bim

echo 'done'
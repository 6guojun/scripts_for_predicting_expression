suppressMessages(library(dplyr))
suppressMessages(library(data.table))
suppressMessages(library('plink2R'))
suppressMessages(library("optparse"))

option_list = list(
	make_option("--gene", action="store", default=NA, type='character',
		help="Gene whose expression is being predicted."),
	make_option("--genos", action="store", default=NA, type='character',
		help="Path to PLINK binary input file prefix (minus bed/bim/fam) [required]"),
	make_option("--weights", action="store", default=NA, type='character',
		help="Path to Elastic Net coefficients for this gene (*.RDat file) [required]"),
	make_option("--out", action="store", default=NA, type='character',
		help="Path to write output files (required)")
)

opt = parse_args(OptionParser(option_list=option_list))

# load *RDat file with enet weights
load(opt$weights)

# load plink files
genos <- read_plink(opt$genos, impute='avg')
genos_for_predict <- genos$bed
rownames(genos_for_predict) <- sapply(rownames(genos_for_predict), function(x) unlist(strsplit(x,':'))[1])

# make sure SNPs in genos$bed match those in wgt.matrix
if (length(colnames(genos_for_predict) %in% rownames(wgt.matrix))!=nrow(wgt.matrix)) {
	genos_for_predict <- genos_for_predict[,which(colnames(genos_for_predict) %in% test_snps)]
}

# multiply enet weights with each patient's genotypes
matmult <- t(t(genos_for_predict) * wgt.matrix[, 'enet'])

# sum each row
predicted_expr <- rowSums(matmult)

print(predicted_expr)

# write results to file
write.table(as.data.frame(predicted_expr), file=opt$out, sep='\t', col.names=F, quote=F)


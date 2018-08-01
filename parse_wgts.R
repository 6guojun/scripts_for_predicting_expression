library("optparse")

option_list = list(make_option("--file", action="store", default=NA, type='character',
              help="*wgt.RDat file"))
opt = parse_args(OptionParser(option_list=option_list))

FILES_DIR <- '/cellar/users/jlz014/fusion_twas-master/TCGA-BRCA_weights_all_patients/EUR'

fh <- opt$file
print(fh)
MISSING_DIR <- '/cellar/users/jlz014/fusion_twas-master/TCGA-BRCA_weights_all_patients/genes_without_enet_models'
SUMMARY_DIR <- '/cellar/users/jlz014/fusion_twas-master/TCGA-BRCA_weights_all_patients/summary'

gene <- unlist(strsplit(fh, '[.]'))[2]
load(file.path(FILES_DIR,fh),verbose=T)

enet_coeffs <- wgt.matrix[,'enet']

if (length(unique(enet_coeffs))>1) {
    cat('enet has non-zero coefficients, appending summary data to *.dat file')
    line <- paste(fh, length(unique(enet_coeffs))-1, cv.performance['rsq','enet'], cv.performance['pval','enet'], sep='\t')
    write.table(line, file=file.path(SUMMARY_DIR,paste0(gene,'.txt')), quote=F, col.names=F, row.names=F, sep='\t')
} else {
    cat('enet has no non-zero coefficients, appending to list of genes without models')
    write.table(fh, file=file.path(MISSING_DIR,paste0(gene,'.txt')), quote=F, sep='\t',col.names=F, row.names=F)
}

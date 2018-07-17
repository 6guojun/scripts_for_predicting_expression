from sklearn.metrics import r2_score
import pandas as pd
import numpy as np
import glob

filtered_test_expr = pd.read_table('/data/cellardata/users/jlz014/TCGA/expression/TCGA-BRCA.ENSG.chr1-22.median-filt.log2RPKM.qnorm.test.for_predictions.txt', index_col=0)
filtered_test_expr.head()

def score_predictions(gene,expr_table = filtered_test_expr):
    predictions_fh = '/cellar/users/jlz014/fusion_twas-master/TCGA-BRCA_normed_weights/prediction_results/'+gene+'.predictions.txt'
    predicted = pd.read_table(predictions_fh,header=None, index_col=0)
    target_full = expr_table.loc[gene]
    # subset target expression to patients in predicted set, in the same order
    target_sub = []
    for index,row in predicted.iterrows():
        target_sub.append(target_full.loc[index])
    target_sub=np.array(target_sub)
    # compute r2 of prediction
    score = r2_score(target_sub, predicted.values) 
    return score

prediction_r2 = list(zip(filtered_test_expr.index, [score_predictions(g) for g in filtered_test_expr.index]))

out_df = pd.DataFrame(prediction_r2)
out_df.to_csv('/cellar/users/jlz014/fusion_twas-master/TCGA-BRCA_normed_weights/tcga-brca_prediction_r2.txt',sep='\t',header=False, index=False)


from brain.cv import CV, unid, Results
from brain.data import load_processed, _getbeh
import numpy as np
import matplotlib.mlab as ML
import os

nonadaptive = "/scratch/shopPredict/cvresults_Yhat_new/first_full"
adaptive = "/scratch/shopPredict/cvresults_Yhat_new_adaptive/first_full"
def getmean(i=0,d=nonadaptive):
    k = ML.csv2rec('%s/mean.csv' % d)['key'][i]
    if k.endswith('/'):
        k = k[:-1]
    k = os.path.split(k)[1]
    return Results("%s/%s" % (d, k))

best_mean = getmean()
#best_mean_adaptive = getmean(d=adaptive)

def getmedian(i=0,d=nonadaptive):
    k = ML.csv2rec('%s/median.csv' % d)['key'][i]
    if k.endswith('/'):
        k = k[:-1]
    k = os.path.split(k)[1]
    return Results("%s/%s" % (d,k))
best_median = getmedian()
#best_median_adaptive = getmedian(d=adaptive)

newl1 = [1.0,1e1,1e-1,1e2,1e-2,1e3,1e-3,1e4,1e-4,1e-5,1e5]
def adaptive(oldcv, newl1):
    import numpy as np, gc
    np.random.shuffle(newl1)
    splits = ['split%d' % i for i in range(10)]
    np.random.shuffle(splits)
    for n in newl1:
        a = CV.adaptive_from_old(oldcv, newl1=n)
        for k in splits:
            a.adaptive_fit(k)
            gc.collect()

import scipy
data = [i/1.0 for i in range(1000000)]
f = scipy.signal.savgol_filter
%timeit 
f(data, 5, 2, mode = "warp")



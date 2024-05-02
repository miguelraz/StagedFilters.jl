import scipy
import numpy as np
import timeit

N = 10_000_000
dataf64 = np.array([i for i in range(N)], dtype=np.float64)
dataf32 = np.array([i for i in range(N)], dtype=np.float32)
f = scipy.signal.savgol_filter

print(f'f32 savgol (5,2) for {N} elements')
%timeit f(dataf64, 5, 2, mode = "wrap")
print(f'f64 savgol (5,2) for {N} elements')
%timeit f(dataf32, 5, 2, mode = "wrap")

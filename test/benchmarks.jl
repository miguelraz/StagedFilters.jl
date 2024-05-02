using StagedFilters
using PyCall, Chairmarks;

N = 10_000_000

data = convert.(Float64,collect(range(1,N,length=N)));
smoothed = zeros(eltype(data),length(data)); # <--- wholesome, type stable code.
savgol = pyimport("scipy.signal")."savgol_filter";
x = PyObject(data);

@info "Julia f32x$N"
@b smooth!(SavitzkyGolayFilter{2,2}, data, smoothed)
@info "SciPy f32x$N"
@b pycall(savgol, PyObject, x,5,2,mode="mirror")

data = convert.(Float32,collect(range(1,N,length=N)));
smoothed = zeros(eltype(data),length(data)); # <--- wholesome, type stable$
savgol = pyimport("scipy.signal")."savgol_filter";
x = PyObject(data);

@info "Julia f64x$N"
@b smooth!(SavitzkyGolayFilter{2,2}, data, smoothed)
@info "SciPy f64x$N"
@b pycall(savgol, PyObject, x,5,2,mode="mirror")

"""
In [17]: import scipy.signal

In [18]: data = [i / 1.0 for i in range(1000000)]

In [19]: f = scipy.signal.savgol_filter

In [20]: %%timeit
    ...: f(data, 5, 2, mode="wrap")
        ...:
            ...:
            58 ms ± 257 µs per loop (mean ± std. dev. of 7 runs, 10 loops each)
"""

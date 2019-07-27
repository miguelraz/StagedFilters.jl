using StagedFilters
using Test

using PyCall, BenchmarkTools;

N = 1_000_000

data = convert.(Float64,collect(range(1,N,length=N)));
smoothed = zeros(eltype(data),length(data)); # <--- wholesome, type stable code.
savgol = pyimport("scipy.signal")."savgol_filter";
x = PyObject(data);

@info "Julia f32x$N"
@btime smooth!(SavitzkyGolayFilter{2,2}, $data, $smoothed);
@info "SciPy f32x$N"
@btime pycall($savgol, PyObject, $x,5,2,mode="wrap");

data = convert.(Float32,collect(range(1,N,length=N)));
smoothed = zeros(eltype(data),length(data)); # <--- wholesome, type stable$
savgol = pyimport("scipy.signal")."savgol_filter";
x = PyObject(data);

@info "Julia f64x$N"
@btime smooth!(SavitzkyGolayFilter{2,2}, $data, $smoothed);
@info "SciPy f64x$N"
@btime pycall($savgol, PyObject, $x,5,2,mode="wrap");
nothing;

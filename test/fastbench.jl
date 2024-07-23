using BenchmarkTools
using StagedFilters

N = 100_000_000;

data = rand(Float32, N);
smoothed = similar(data);
@info length(data)
@info length(smoothed)
@info "Julia f32 savgol (5,2) for $N"
smooth!(SavitzkyGolayFilter{2,2}, data, smoothed);
@btime smooth!($SavitzkyGolayFilter{2,2}, $data, $smoothed);

dataf64 = rand(Float64, N);
smoothedf64 = similar(dataf64);
@info length(data)
@info length(smoothed)
@info "Julia f64 savgol (5,2) for $N"
smooth!(SavitzkyGolayFilter{2,2}, dataf64, smoothedf64);
@btime smooth!($SavitzkyGolayFilter{2,2}, $dataf64, $smoothedf64);
0;

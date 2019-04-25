using StagedFilters
using Test

using PyCall, BenchmarkTools;
data = convert.(Float64,collect(range(1,1000,length=1000))); smoothed = zeros(eltype(data),length(data)); # <--- wholesome, type stable code.
savgol = pyimport("scipy.signal")."savgol_filter";
x = PyObject(data);
benchjl = @btime smooth!(SavitzkyGolayFilter{2,2}, data, smoothed);
benchpy = @btime $savgol($x,5,2,mode="wrap");
@testset "Correctness" begin
    @test benchpy ≈ benchjl
end

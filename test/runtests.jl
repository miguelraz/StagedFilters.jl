using StagedFilters
using Test
using PyCall
using BenchmarkTools;


@testset "StagedFilters.jl" begin
    N = 1000
    data = convert.(Float64, collect(range(1, N , length = N))); 
    smoothed = zeros(eltype(data), length(data)); # <--- wholesome, type stable code.
    savgol = pyimport("scipy.signal")."savgol_filter";
    x = PyObject(data);

    @info "Julia Float64"
    benchjl64 = @btime smooth!(SavitzkyGolayFilter{2,2}, data, smoothed);

    @info "Python Float64"
    benchpy64 = @btime $savgol($x,5,2,mode="wrap");

    data = convert.(Float32, collect(range(1, N, length = N))); 
    smoothed = zeros(eltype(data), length(data)); # <--- wholesome, type stable$
    #savgol = pyimport("scipy.signal")."savgol_filter";
    x = PyObject(data);

    @info "Julia Float64"
    benchjl32 = @btime smooth!(SavitzkyGolayFilter{2,2}, data, smoothed);

    @info "Python Float64"
    benchpy32 = @btime $savgol($x,5,2,mode="wrap");

    @test benchpy64 ≈ benchjl64
    @test benchpy32 ≈ benchjl32
end

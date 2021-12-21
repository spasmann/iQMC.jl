using BenchmarkTools
using Profile
include("../QMC.jl")

function performance()
    Nx = 10     # number of tally cells
    na2 = 11    # number of angles for angular mesh
    s = 1.0     # parameter in Garcia/Siewert
    N = 100   # number of particles per source itertion
    LB = 0.0   # left bound
    RB = 5.0   # right bound
    geometry = "Slab"
    generator = "Sobol"
    qmc_data = QMC.garcia_init(geometry, generator, N, LB, RB, Nx, na2, s)
    phi = ones(Nx)
    @btime QMC.qmc_sweep($phi, $qmc_data)
    @profiler QMC.qmc_sweep(phi,qmc_data)
end

performance()

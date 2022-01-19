
module QMC

using Sobol
using GoldenSequences
using Random
using PyPlot
using LinearAlgebra
using Statistics
using DelimitedFiles
pygui(true)
import Distributions: Uniform

export qmc_source_iteration
export qmc_sweep
export move_part
export qmc_init
export multiGroup_init
export garcia_init
export const_infMed_init
export linear_infMed_init
export quadratic_infMed_init
export rngInit
export nextBoundaryRN
export nextRN
export cellVolume
export surfaceArea
export sphere_edge
export cylinder_edge
export slab_edge
export distance_to_edge
export updatePosition
export getZone
export getNextZone
export getNextRadius
export getRadius
export getPath
export getDim
export inf_Med_BC_Mu
export qmc_garcia
export qmc_infMed
export qmc_multiGroup
export qmc_rngComparison

export Linear_QMC
export test2
export MMul
export test1
export TSweep
export getb
export GarciaInit
export MultiGroupInit

export reeds_init
export reeds_data
export reeds_sol
export qmc_reeds

include("functions/qmc_init.jl")
include("functions/qmc_source_iteration.jl")
include("functions/qmc_sweep.jl")
include("functions/move_part.jl")
include("functions/misc_functions.jl")
include("functions/Linear_QMC.jl")
include("functions/init_files/reeds_init.jl")
include("functions/reeds_data.jl")
include("functions/reeds_solution.jl")

include("tests/garcia.jl")
include("tests/infinite_medium.jl")
include("tests/multi_group.jl")
include("tests/RNG_Comparison.jl")
include("tests/reeds_problem.jl")


end

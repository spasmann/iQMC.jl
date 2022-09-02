module iQMC

using LinearAlgebra
using LinearAlgebra.BLAS
using SIAMFANLEquations
using FastGaussQuadrature
using LaTeXStrings
using Printf
using SparseArrays
using SuiteSparse
using Statistics
using DelimitedFiles
using Random
using Sobol
using GoldenSequences
using HaltonSequences
using BenchmarkTools
using DelimitedFiles
using PyPlot
pygui(true)
using QuadGK
import Distributions: Uniform

export fprintTeX
export qmc_init
export qmc_sweep
export garcia_init
export gs_tabulate
export Make_Plots_Iterations_GS
#
# functions to get the linear map organized
#
export SamFix
export SamFix!
export SamRhs
export SamMxv
export SamInitMV
#
# Functions for the plots and tables
#
export Results_Table
export Error_Table
export SamPicard
export readtab
export writetab
export TeX_Error_Table
export Solution_Compare
export Solver_Compare
#
#
export SamGarciaInit
export SamAA0
export SamAA
export FixedTest
export Sam_Bench
#
# Garcia/Siewert results
#
export sn_init
export garcia_test
export garcia_example
#
# MG prolbem
#
export multiGroup_init
export mg_example
export MG_Error_Table
export MG_Error_Table_Row
export Increase_N_MG
export mg_tabulate
export mg_texttab
export mg_Latex
#
# Reeds Problem
#
export reeds_example
export reeds_init
export reeds_data
export reeds_solution
export reeds_mcdc_sol
export reeds_Nx80_sol
export Reeds_Error_Table
export Reeds_Error_Table_Row
export Increase_N_Reeds
export reeds_tabulate
export reeds_texttab
export reeds_LaTeX
export reduce_flux
#
# Source code, linear solvers
#
include("src/solvers/Sam_Bench.jl")
include("src/solvers/fprintTeX.jl")
include("src/solvers/Data_Files.jl")
include("src/solvers/SamMaps.jl")
include("src/solvers/SamSolvers.jl")
include("src/solvers/Solver_Compare.jl")
include("src/solvers/Solution_Compare.jl")
#
# Source code, QMC
#
include("src/QMC/functions/qmc_sweep.jl")
include("src/QMC/functions/init_files/qmc_init.jl")
include("src/QMC/functions/init_files/reeds_init.jl")
include("src/QMC/functions/reeds_data.jl")
include("src/QMC/functions/reeds_solution.jl")
include("Sam_QMC/functions/move_part.jl")
include("src/QMC/functions/misc_functions.jl")
#
# Garcia-Siewert files
#
include("results/Garcia/Garcia_Scripts/garcia_test.jl")
include("results/Garcia/TeX_Error_Table.jl")
include("results/Garcia/SamGarciaInit.jl")
include("results/Garcia/gs_tabulate.jl")
include("results/Garcia/sn_init.jl")
include("results/Garcia/Make_Plots_Iterations_GS.jl")
include("results/Garcia/transport_sweep.jl")
include("results/Garcia/Results_Table.jl")
include("results/Garcia/Error_Table.jl")
include("results/Garcia/GS_Data_Read.jl")
include("results/Garcia/garcia_example.jl")
#
# Multi-group files
#
include("results/MultiGroup/mg_example.jl")
include("results/MultiGroup/MG_Error_Table.jl")
include("results/MultiGroup/mg_tabulate.jl")
#
# Reeds example
#
include("results/Reeds/reeds_example.jl")
include("results/Reeds/Reeds_Error_Table.jl")
include("results/Reeds/reeds_tabulate.jl")
#
end

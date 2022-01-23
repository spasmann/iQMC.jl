module Krylov_Test

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
using BenchmarkTools
using PyPlot
pygui(true)
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
#
#
export SamGarciaInit
#export SamGmres
export SamAA0
export SamAA
export FixedTest
export Sam_Bench
#
# Garcia/Siewert results
#
export sn_init
export garcia_test
#
# MG prolbem
#
export multiGroup_init
export mg_example
#
# Reeds Problem
#
export reeds_example
export reeds_init
export reeds_data
export reeds_solution

#
#
#
include("test/garcia_test.jl")
include("Tools/Sam_Bench.jl")
include("Tools/fprintTex.jl")
include("Garcia/TeX_Error_Table.jl")
include("Tools/Data_Files.jl")
include("Tools/SamMaps.jl")
#include("Tools/SamTests.jl")
#include("Tools/SamGmres.jl")
include("Tools/SamSolvers.jl")
include("Tools/Solver_Compare.jl")
#
# Garcia-Siewert files
#
include("Garcia/SamGarciaInit.jl")
include("Garcia/gs_tabulate.jl")
include("Garcia/sn_init.jl")
include("Garcia/Make_Plots_Iterations_GS.jl")
include("Garcia/transport_sweep.jl")
include("Garcia/Results_Table.jl")
include("Garcia/Error_Table.jl")
include("Garcia/GS_Data_Read.jl")
#
# Multi-group files
#
include("MultiGroup/mg_example.jl")
#
# Reeds example 
#
include("Reeds/reeds_example.jl")
#
# Sam's QMC tools
#
include("../Sam_QMC/functions/qmc_sweep.jl")
include("../Sam_QMC/functions/init_files/qmc_init.jl")
include("../Sam_QMC/functions/init_files/reeds_init.jl")
include("../Sam_QMC/functions/reeds_data.jl")
include("../Sam_QMC/functions/reeds_solution.jl")
#include("../Sam_QMC/functions/qmc_source_iteration.jl")
include("../Sam_QMC/functions/move_part.jl")
include("../Sam_QMC/functions/misc_functions.jl")



end

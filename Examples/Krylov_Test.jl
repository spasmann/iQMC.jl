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
using PyPlot
pygui(true)
import Distributions: Uniform

export fprintTeX
export qmc_init
export qmc_sweep
export garcia_init
export sn_tabulate
export it_compare
export gmrestst
export sanity
export SamFix
export SamFix!
export SamRhs
export SamMxv
export SamPicard
export SamGarciaInit
export SamGarciaInitMV
export SamGmres
export SamAA0
export SamAA
export FixedTest


include("Tools/fprintTex.jl")
include("Tools/SamMaps.jl")
include("Tools/SamTests.jl")
include("Tools/SamGmres.jl")
include("Tools/SamSolvers.jl")
include("Garcia/SamGarciaInit.jl")
include("Garcia/gmrestst.jl")
include("Garcia/sn_tabulate.jl")
include("Garcia/sn_init.jl")
include("Garcia/sanity.jl")
include("Garcia/it_compare.jl")
include("Garcia/transport_sweep.jl")

include("Sam_Dec_1/functions/qmc_sweep.jl")
include("Sam_Dec_1/functions/qmc_init.jl")
#include("Sam_Dec_1/functions/qmc_source_iteration.jl")
include("Sam_Dec_1/functions/move_part.jl")
include("Sam_Dec_1/functions/misc_functions.jl")



end

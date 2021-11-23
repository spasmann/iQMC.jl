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
export qmc_source_iteration
export qmc_test
export garcia_init
export sn_tabulate
export it_compare
export X_gmres
export xgmres_base
export gmrestst
export sanity
export Xbase


include("Tools/fprintTex.jl")
include("Garcia/X_gmres.jl")
include("Garcia/Xbase.jl")
include("Garcia/gmrestst.jl")
include("Garcia/sn_tabulate.jl")
include("Garcia/sn_init.jl")
include("Garcia/sanity.jl")
include("Garcia/it_compare.jl")
include("Garcia/transport_sweep.jl")

include("Sam_Original/functions/qmc_init.jl")
include("Sam_Original/functions/qmc_sweep.jl")
include("Sam_Original/functions/qmc_source_iteration.jl")
include("Sam_Original/functions/move_part.jl")
include("Sam_Original/functions/misc_functions.jl")



end

push!(LOAD_PATH,"/Users/sampasmann/Documents/GitHub/Krylov_QMC/Examples/")

using Krylov_Test

Krylov_Test.Reeds_Error_Table(Nxvals=[80],Nvals=[2^18,2^19,2^20],savedata=true,generator="Sobol")

Krylov_Test.Reeds_Error_Table(Nxvals=[160],Nvals=[2^18,2^19,2^20],savedata=true,generator="Sobol")

Krylov_Test.Reeds_Error_Table(Nxvals=[320],Nvals=[2^18,2^19,2^20],savedata=true,generator="Sobol")

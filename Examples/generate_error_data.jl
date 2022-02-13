
#push!(LOAD_PATH,"/Users/sampasmann/Documents/GitHub/Krylov_QMC/Examples/")

#using Kyrlov_Test
include("Krylov_Test.jl")

Krylov_Test.MG_Error_Table(savedata=true)

Krylov_Test.Error_Table(s=1.0, savedata=true) #Garcia

Krylov_Test.Error_Table(s=Inf, savedata=true) #Garcia

Krylov_Test.Reeds_Error_Table(savedata=true)

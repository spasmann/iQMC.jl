
include("iQMC.jl")

iQMC.MG_Error_Table(savedata=true)

iQMC.Error_Table(s=1.0, savedata=true) #Garcia

iQMC.Error_Table(s=Inf, savedata=true) #Garcia

iQMC.Reeds_Error_Table(savedata=true)

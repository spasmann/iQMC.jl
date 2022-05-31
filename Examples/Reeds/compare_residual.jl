push!(LOAD_PATH,"/Users/sampasmann/Documents/GitHub/Krylov_QMC/Examples/")
using Krylov_Test

data = reeds_init("Sobol", 2^12, 180)
mxv_data = SamInitMV(data)
gmres_sol = Krylov_Test.Solver_Compare(mxv_data, plabel="Reed's Problem")

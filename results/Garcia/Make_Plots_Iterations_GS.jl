"""
Make_Plots_Iterations_GS(N=2^11, Nx=100, s=1.0)

Make the plots comparing Picard, gmres, and bicgstab

Uses CTK's functions to hide stuff you don't need to know.
"""
function Make_Plots_Iterations_GS(N=2^11, Nx=100, s=1.0)
qmc_data=SamGarciaInit(N, Nx, s)
s == Inf ? strs = L"\infty" : strs = string(s)
plabel= string("s= ", strs)
mxv_data=SamInitMV(qmc_data)
Solver_Compare(mxv_data; plabel=plabel)
end

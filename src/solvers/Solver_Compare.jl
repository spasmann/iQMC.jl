"""
Solver_Compare(mxv_data; plabel=plabel)

Solver_Compare solves a problem specified with Sam's qmc_data as processed
into mxv_data by the SamMxv function in SamMaps.jl
"""
function Solver_Compare(mxv_data; plabel=plabel)
#
# Harvest the data from mxv_data
#
qmc_data=mxv_data.qmc_data
b=mxv_data.b
Nx=qmc_data.Nx
G=qmc_data.G
Nv=Nx*G
#
# V holds the data that the Krylov solvers use
#
V=zeros(Nv,20)
phi0=zeros(Nv,)
tol=1.e-10
maxit=200
#
# GMRES solve
#
gmres_out=kl_gmres(phi0,b,SamMxv,V,tol; pdata=mxv_data)
ghist=gmres_out.reshist
#
# BiCGSTAB solve
#
bicgstab_out=kl_bicgstab(phi0,b,SamMxv,V,tol; pdata=mxv_data, lmaxit=50)
bhist=bicgstab_out.reshist
#
# Picard solve
#
picard_out=SamPicard(phi0,SamFix,tol,maxit,qmc_data)
phist=picard_out.reshist
#
# Are the solutions the same?
#
gdiff=norm(picard_out.sol-gmres_out.sol)
bdiff=norm(picard_out.sol-bicgstab_out.sol)
#
# Make the plot.
#
Compare_Plot(ghist,phist,bhist,plabel)
println("gmres diff = $gdiff, BiCGSTAB diff = $bdiff")
return gmres_out.sol
end

"""
Compare_Plot(ghist,phist,bhist,plabel)

Use PyPlot to make the plots for the paper.
"""
function Compare_Plot(ghist,phist,bhist,plabel)
ghist=ghist/ghist[1]
bhist=bhist/bhist[1]
phist=phist/phist[1]
pl=1:length(phist)
gl=1:length(ghist)
bl=1:2:2*length(bhist)-1
figure()
semilogy(gl,ghist,"k-",pl,phist,"k--",bl,bhist,"k-.")
legend(["gmres", "source iteration", "bicgstab"])
xlabel("Transport Sweeps")
ylabel("Relative Residual")
tstring="QMC Residual Histories: $plabel"
title(tstring)
#savefig("reeds_residuals.png")
end

function Solver_Compare(mxv_data; plabel=plabel)
qmc_data=mxv_data.qmc_data
b=mxv_data.b
Nx=qmc_data.Nx
G=qmc_data.G
Nv=Nx*G
V=zeros(Nv,20)
phi0=zeros(Nv,)
tol=1.e-10
maxit=100
gmres_out=kl_gmres(phi0,b,SamMxv,V,tol; pdata=mxv_data)
ghist=gmres_out.reshist./gmres_out.reshist[1]
bicgstab_out=kl_bicgstab(phi0,b,SamMxv,V,tol; pdata=mxv_data)
bhist=bicgstab_out.reshist./bicgstab_out.reshist[1]
picard_out=SamPicard(phi0,SamFix,tol,maxit,qmc_data)
phist=picard_out.reshist./picard_out.reshist[1]
Compare_Plot(ghist,phist,bhist,plabel)
end

function Compare_Plot(ghist,phist,bhist,plabel)
pl=1:length(phist)
gl=1:length(ghist)
bl=1:2:2*length(bhist)-1
semilogy(gl,ghist,"k-",pl,phist,"k--",bl,bhist,"k-.")
legend(["gmres", "source iteration", "bicgstab"])
xlabel("Transport Sweeps")
ylabel("Relative Residual")
tstring="QMC Residual Histories: $plabel"
title(tstring)
end



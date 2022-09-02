function Solution_Compare(mxv_data; plabel=plabel)
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

midpoints = qmc_data.midpoints
sol = qmc_data.true_flux
gmres = gmres_out.sol

figure()
plot(midpoints, sol, label="Sol")
plot(midpoints, gmres, label="QMC")
legend()
end

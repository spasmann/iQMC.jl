function Results_Table(N=2^11, Nx=100, s=1.0)
qmc_data=SamGarciaInit(N, Nx, s)
s == Inf ? strs = L"\infty" : strs = string(s)
plabel= string("s= ", strs)
mxv_data=SamInitMV(qmc_data)
qmc_data=mxv_data.qmc_data
b=mxv_data.b
Nx=qmc_data.Nx
G=qmc_data.G
Nv=Nx*G
V=zeros(Nv,20)
phi0=zeros(Nv,)
tol=1.e-10
maxit=200
gmres_out=kl_gmres(phi0,b,SamMxv,V,tol; pdata=mxv_data, lmaxit=maxit)
sol=gmres_out.sol
tabout=sn_tabulate(s, Nx, sol; phiedge=false)
end

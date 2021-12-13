"""
Error_Table(s=1.0, tol=1.e-5, NLim=5, NxLim=7)

Makes the table of relative errors in the exit distributions.
"""
function Error_Table(s=1.0, tol=1.e-5, NLim=5, NxLim=7)
s==1.0 ? sp=1 : sp=Inf
fname="ErrorTab:$sp"
NxBase=50;
Nvals=[2^10, 2^11, 2^12, 2^13, 2^14]
NxVals=NxBase*[1, 2, 4, 8, 16, 32, 64]
Tout=zeros(NxLim,NLim)
for indx=1:NxLim
Zout=Error_Table_Row(NxVals[indx], s, Nvals[1:NLim],tol)
Tout[indx,:].=Zout
end
writetab(fname,Tout)
return Tout
end

"""
Error_Table_Row(Nx, s, Nvals, tol)

makes a row of the error table, fixing Nx and varying N.
In this way I can use the converged flux for one N as the initial
iterate for the next. 
"""
function Error_Table_Row(Nx, s, Nvals, tol)
phi0=zeros(Nx,)
maxit=200
#
N=Nvals[1]
NLen=length(Nvals)
qmc_data=SamGarciaInit(N, Nx, s)
mxv_data=SamInitMV(qmc_data)
b=mxv_data.b
G=qmc_data.G
Nv=Nx*G
V=zeros(Nv,20)
#
RelErrs=zeros(NLen,)
for Nind=1:NLen
gmres_out=kl_gmres(phi0,b,SamMxv,V,tol; pdata=mxv_data, lmaxit=maxit)
sol=gmres_out.sol; phi0.=sol;
gs_out=gs_tabulate(s, Nx, sol; maketab=false)
RelErrs[Nind]=gs_out.ExitErr
println(gs_out.ExitErr)
#
if Nind < NLen
phi0.=sol
mxv_data=Increase_N_GS(Nvals[Nind+1],Nx,s)
end
#
end
return RelErrs
end

function Increase_N_GS(N, Nx, s)
qmc_data=SamGarciaInit(N, Nx, s)
mxv_data=SamInitMV(qmc_data)
b=mxv_data.b
return mxv_data
end

"""
it_compare(N=2^11, Nx=100, s=1.0)

Make the plots comparing Picard, gmres, and bicgstab
"""
function it_compare(N=2^11, Nx=100, s=1.0) 
###############################################################################
#### Parameters
###############################################################################

na2 = 11;    # number of angles for angular mesh
LB = 0.0;   # left bound
RB = 5.0;   # right bound
geometry = "Slab";
generator = "Sobol";
tol=1.e-10

###############################################################################
#### Function Call
###############################################################################

qmc_data = garcia_init(geometry, generator, N, LB, RB, Nx, na2, s);
#
# copy qmc_data and zero out the boundary conditions to get
# the version you need for the matrix-vector product
#
qmc_data_it=deepcopy(qmc_data)
G=qmc_data.G
qmc_data_it.phi_left.=0.0
qmc_data_it.phi_right.=0.0
qmc_data_it.source .= 0.0
phi=zeros(Nx,G)
xphi=zeros(Nx,G)
phic=zeros(Nx,G)
b=getrhs(qmc_data)
Nv=G*Nx
V=zeros(Nv,20)
phi0=reshape(phic,Nv,)
phi1=copy(phi0)
phi2=copy(phi0)
b1=reshape(b,Nv,)
picard_out=picard(phic, 100, tol, qmc_data)
phip2 = picard_out.sol
phip=reshape(phip2,Nv,)
gmres_out=kl_gmres(phi1, b1, mxb_garcia, V, tol; pdata=qmc_data_it)
bicgstab_out=kl_bicgstab(phi1, b1, mxb_garcia, V, tol; pdata=qmc_data_it)
phig = gmres_out.sol
phib = bicgstab_out.sol
resg=b1-mxb_garcia(phig,qmc_data_it)
resb=b1-mxb_garcia(phib,qmc_data_it)
resp=b1-mxb_garcia(phip,qmc_data_it)
println(norm(resg)," ",norm(resb),"  ",norm(resp))
println(norm(phig-phib,Inf),"  ",norm(phig-phip,Inf))
println(norm(phig-phib),"  ",norm(phig-phip))
if false
figure(3)
plen=length(phig)
plot(1:plen,phig-phib,1:plen,phig-phip)
end
figure(1)
phist=picard_out.reshist./picard_out.reshist[1]
ghist=gmres_out.reshist./gmres_out.reshist[1]
bhist=bicgstab_out.reshist./bicgstab_out.reshist[1]
garcia_plot(phist,ghist,bhist,s)
return (phist=phist, ghist=ghist, bhist=bhist, gmres_out)
end

function garcia_plot(phist, ghist, bhist, s)
pl=length(phist)
gl=length(ghist)
bl=length(bhist)
semilogy(0:gl-1,ghist,"k-",0:pl-1,phist,"k--",0:bl-1,bhist,"k-.")
legend(["gmres", "source iteration", "bicgstab"])
xlabel("Transport Sweeps")
ylabel("Relative Residual")
s == Inf ? strs = L"\infty" : strs = string(s)
tstring = string("QMC Residual Histories: s= ", strs)
title(tstring)
end


#
# Source iteration as Sam did it
#
function picard(phi0, maxit, tol, qmc_data)
itc=0
del=1.0
phic=copy(phi0)
phi=copy(phi0)
reshist=Float64[]
sweep_out=qmc_sweep(phic,qmc_data)
phic .= sweep_out.phi_avg
while (itc < maxit) && (del > tol)
sweep_out=qmc_sweep(phic,qmc_data)
phi .= sweep_out.phi_avg
#del=norm(phic-phi,Inf)
# Switch to L2 norm for consistency with Krylov methods
del=norm(phic-phi)
push!(reshist,del)
phic .= phi
itc+=1
end
return (sol=phi, reshist=reshist)
end

#
# Do a single transport sweep with zero average flux
#
function getrhs(qmc_data)
zed=zeros(size(qmc_data.source))
bmat=qmc_sweep(zed,qmc_data)
b=bmat.phi_avg
return b
end


function mxb_garcia(phi,mat_data)
Nx=mat_data.Nx
G=mat_data.G
Nv=length(phi)
(Nv == Nx*G) || println("dimension error")
phix=copy(phi)
phiy=reshape(phix,Nx,G)
mout=axb_garcia(phiy,mat_data)
pout=reshape(mout,Nv,)
axpy!(-1.0,pout,phix)
return phix
end


function axb_garcia(phi,mat_data)
phiout=copy(phi)
#mat_data.phi_left .= 0.0
#mat_data.phi_right .= 0.0
#mat_data.source .= 0.0
sweep_out=qmc_sweep(phi,mat_data)
phiout.=sweep_out.phi_avg
return phiout
end

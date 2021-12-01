function gmrestst(N=2^11, Nx=50, s=1.0)
###############################################################################
#### Parameters
###############################################################################

#Nx = 50;     # number of tally cells
na2 = 11;    # number of angles for angular mesh
#s = 1.0;     # parameter in Garcia/Siewert
#N = 2^11;    # number of particles per source itertion
LB = 0.0;   # left bound
RB = 5.0;   # right bound
geometry = "Slab";
generator = "Sobol";

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
qmc_data_it.source.=0.0
#
# Is the function a function?
#
dnorm=0.0
xnorm=0.0
for ir=1:10
x1=rand(Nx,)
x2=copy(x1)
#out1=qmc_sweep(x1,qmc_data)
#out2=qmc_sweep(x2,qmc_data)
p1=mxb_garciav3(x1,qmc_data_it)
p2=mxb_garciav3(x2,qmc_data_it)
#p1=out1.phi_avg
#p2=out2.phi_avg
dnorm+=norm(p1-p2)
xnorm+=norm(x1-x2)
end
println("Function? = $dnorm,  $xnorm")
#
phi=zeros(Nx,G)
xphi=zeros(Nx,G)
phic=zeros(Nx,G)
b0=getrhsv2(qmc_data)
# 
# Is the rhs consistent?
#
b01=getrhsv2(qmc_data)
normrhs=norm(b0-b01,Inf)
Nv=G*Nx
b1=reshape(b0,Nv,)
b11=reshape(b01,Nv,)
normdim=norm(b1-b11,Inf)
println("Consistent rhs = $normrhs, $normdim")
#
# Make sure mxb_garcia is a linear operator
#
Nv=G*Nx
x=rand(Nv,)
y=rand(Nv,)
a=1.e2*rand()
b=1.e2*rand()
z=a*x + b*y; 
mz=mxb_garciav3(z,qmc_data_it)
mx=mxb_garciav3(x,qmc_data_it)
my=mxb_garciav3(y,qmc_data_it)
normtest= norm(mz - (a*mx + b*my))
println("linear test = $normtest")
#
# Now solve (I - M)x = b with GMRES
#
V=zeros(Nv,10)
phi1=reshape(phic,Nv,)
phi0=zeros(Nv,)
gmres_out=kl_gmres(phi0, b1, mxb_garciav3, V, 1.e-8; pdata=qmc_data_it)
gsol=gmres_out.sol
#
# Solve with Picard
#
#picardout=picardv2(phic,100,1.e-8, qmc_data)
picardout=picardv3(phi0,100,1.e-8,b1, qmc_data_it)
pout1=reshape(picardout,Nv,)
#
# Compare residuals
#
resg=b1-mxb_garciav3(gsol,qmc_data_it)
resp=b1-mxb_garciav3(pout1,qmc_data_it)
respn=norm(resp)
resn=norm(resg)
println("residial norms: gmres = $resn, picard = $respn")
#println(gmres_out.reshist./gmres_out.reshist[1])
return gmres_out
end

#
# Source iteration as Sam did it
#
function picardv2a(phi0, maxit, tol, qmc_data)
itc=0
del=1.0
phic=copy(phi0)
phi=copy(phi0)
sweep_out=qmc_sweep(phic,qmc_data)
phic .= sweep_out.phi_avg
while (itc < maxit) && (del > tol)
sweep_out=qmc_sweep(phic,qmc_data)
phi .= sweep_out.phi_avg
del=norm(phic-phi,Inf)
phic .= phi
itc+=1
#println(del)
end
return phi
end

#
# Source iteration via x <-- M x + b
#
function picardv3(phi0, maxit, tol, b1, mat_data)
itc=0
del=1.0
phic=copy(phi0)
phi=copy(phi0)
del=1.0
itc=0
while itc < maxit && del > tol 
mxb1 = axb_garciav3(phic,mat_data)
phi .= b1 + mxb1
del=norm(phic-phi)
phic .= phi
itc+=1
#println("del = $del; iteration = $itc")
end
return phi
end

#
# Source iteration as Sam did it
#
function picardv2(phi0, maxit, tol, qmc_data)
itc=0
del=1.0
phic=copy(phi0)
phi=copy(phi0)
sweep_out=qmc_sweep(phic,qmc_data)
phic .= sweep_out.phi_avg
while (itc < maxit) && (del > tol)
sweep_out=qmc_sweep(phic,qmc_data)
phi .= sweep_out.phi_avg
del=norm(phic-phi,Inf)
phic .= phi
itc+=1
#println(del)
end
return phi
end

#
# Do a single transport sweep with zero average flux
#
function getrhsv2(qmc_data)
zed=zeros(size(qmc_data.source))
bmat=qmc_sweep(zed,qmc_data)
b=bmat.phi_avg
return b
end

function mxb_garciav3(phi,mat_data)
Nx=mat_data.Nx
G=mat_data.G
Nv=length(phi)
(Nv == Nx*G) || println("dimension error")
phixout=axb_garciav3(phi,mat_data)
mout = reshape(phixout,Nv,)
phiz=copy(phi)
axpy!(-1.0,mout,phiz)
return phiz
end



function mxb_garciav2(phi,mat_data)
Nx=mat_data.Nx
G=mat_data.G
Nv=length(phi)
(Nv == Nx*G) || println("dimension error")
phix=reshape(phi,Nx,G)
phiz=ones(Nv,)
phiw=reshape(phiz,Nx,G)
phiw.=phix
phixout=axb_garciav2(phiw,mat_data)
mout = reshape(phixout,Nv,)
phiz.=phi
axpy!(-1.0,mout,phiz)
return phiz
end



function axb_garciav3(phi,mat_data)
G=mat_data.G
Nv=length(phi)
Nx=Int(Nv/G)
phi2=reshape(phi,Nx,G)
sweep_out=qmc_sweep(phi2,mat_data)
phiout2=copy(phi2)
phiout2 .= sweep_out.phi_avg
phiout = reshape(phiout2,Nv,)
return phiout
end

function axb_garciav2(phi,mat_data)
sweep_out=qmc_sweep(phi,mat_data)
phiout=copy(phi)
phiout.=sweep_out.phi_avg
return phiout
end

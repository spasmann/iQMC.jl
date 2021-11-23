function sanity(N=2^11, Nx=50, s=1.0)
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
qmc_data_it.exit_right_bins.=0.0
qmc_data_it.exit_left_bins.=0.0
phi=zeros(Nx,G)
xphi=zeros(Nx,G)
phic=zeros(Nx,G)
b=getrhsv1(qmc_data)
compare = false
testpicard = false
if testpicard
for iz=1:14
phic.=phi
phi .= b + axb_garciav1(phic,qmc_data_it)
delphi=norm(phi-phic,Inf)
if compare
sweep_out=qmc_sweep(phic,qmc_data)
xphi.=sweep_out.phi_avg
dellin=norm(phi-xphi,Inf)
println("itdiff = $delphi. Method diff = $dellin")
else
println("itdiff = $delphi")
end
end
else
Nv=G*Nx
V=zeros(Nv,10)
phi1=reshape(phic,Nv,)
b1=reshape(b,Nv,)
gmres_out=X_gmres(phi1, b1, mxb_garciav1, V, 1.e-8; pdata=qmc_data_it)
resg=b1-mxb_garciav1(gmres_out.sol,qmc_data_it)
resn=norm(resg)
println("residial norm = $resn")
println(gmres_out.reshist./gmres_out.reshist[1])
return gmres_out
end
#sn_tabulate(s,Nx,phi;phiedge=false)

#garcia_out= qmc_source_iteration(s,qmc_data);
#flux=garcia_out.phi_avg[:,1];
#println("starting Picard")
#fluxin=zeros(Nx,G)
#flux=picardv1(fluxin,25,1.e-8,qmc_data)
#sn_tabulate(s,Nx,flux;phiedge=false)
end

#
# Source iteration as Sam did it
#
function picardv1(phi0, maxit, tol, qmc_data)
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
println("Norm Picard step = $del")
end
return phi
end

#
# Do a single transport sweep with zero average flux
#
function getrhsv1(qmc_data)
zed=zeros(size(qmc_data.source))
bmat=qmc_sweep(zed,qmc_data)
b=bmat.phi_avg
return b
end


function mxb_garciav1(phi,mat_data)
Nx=mat_data.Nx
G=mat_data.G
Nv=length(phi)
(Nv == Nx*G) || println("dimension error")
phix=reshape(phi,Nx,G)
phixout=axb_garciav1(phix,mat_data)
mout = reshape(phixout,Nv,)
#println(norm(mout)/norm(phi))
phiz=copy(phi)
axpy!(-1.0,mout,phiz)
return phiz
#return phi-mout
end


function axb_garciav1(phi,mat_data)
sweep_out=qmc_sweep(phi,mat_data)
phiout=copy(phi)
phiout.=sweep_out.phi_avg
return phiout
end
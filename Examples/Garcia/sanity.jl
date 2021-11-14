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
qmc_data_it.phi_left.=0.0
qmc_data_it.phi_right.=0.0
phi=zeros(Nx,1)
xphi=zeros(Nx,1)
phic=zeros(Nx,1)
b=getrhs(qmc_data)
compare = false
picard = false
if picard
for iz=1:14
phic.=phi
phi .= b + axb_garcia(phic,qmc_data_it)
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
V=zeros(Nx,10)
phi1=reshape(phic,Nx,)
b1=reshape(b,Nx,)
gmres_out=kl_gmres(phi1, b1, axb_garcia, V, 1.e-8; pdata=qmc_data_it)
phi .= reshape(gmres_out.sol,Nx,1)
println(gmres_out.reshist./gmres_out.reshist[1])
end
sn_tabulate(s,Nx,phi;phiedge=false)

#garcia_out= qmc_source_iteration(s,qmc_data);
#flux=garcia_out.phi_avg[:,1];
#sn_tabulate(s,Nx,flux;phiedge=false)
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

function axb_garcia(phi,mat_data)
Nx=length(phi)
if isa(phi,Vector)
phix=reshape(phi,Nx,1)
else
phix=phi
end
sweep_out=qmc_sweep(phix,mat_data)
phiout=sweep_out.phi_avg
if isa(phiout,Vector)
else
phiout=reshape(phiout,Nx,)
end
return phi-phiout
end

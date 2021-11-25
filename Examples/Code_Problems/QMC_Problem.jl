"""
QMC_Problem()

Demonstrate what I think the problem is.

I create two vectors with the same image under qmc_sweep. This
cannot happen in the continuos or SN case and should not happen
QMC.
"""
function QMC_Problem()
#
# Init with usual stuff
#
Nx = 10;     # number of tally cells
na2 = 11;    # number of angles for angular mesh
s = 1.0;     # parameter in Garcia/Siewert
N = 100;    # number of particles per source itertion
LB = 0.0;   # left bound
RB = 5.0;   # right bound
geometry = "Slab";
generator = "Sobol";
qmc_data = garcia_init(geometry, generator, N, LB, RB, Nx, na2, s);
#
#
#
phi0=ones(Nx,);
phiout0=qmc_sweep(phi0,qmc_data)
phi1=phiout0.phi_avg
r0=phi1-phi0;
v0=r0/norm(r0);
#
# You can check that v0 is not zero!
#
phiout2=qmc_sweep(v0,qmc_data)
phi2=phiout2.phi_avg
#
# zed is zero, but the sweep returns the same thing as for v0.
#
zed=zeros(Nx,)
phiout4=qmc_sweep(zed,qmc_data)
phi4=phiout4.phi_avg
println(norm(phi2-phi4))
#
# It gets stranger. 
#
badsol=phi0 + r0
rout=qmc_sweep(badsol,qmc_data)
bad_avg=rout.phi_avg
println(norm(badsol-bad_avg))
end


function script1()
Nx = 10;     # number of tally cells
na2 = 11;    # number of angles for angular mesh
s = 1.0;     # parameter in Garcia/Siewert
N = 100;    # number of particles per source itertion
LB = 0.0;   # left bound
RB = 5.0;   # right bound
geometry = "Slab";
generator = "Sobol";
qmc_data = garcia_init(geometry, generator, N, LB, RB, Nx, na2, s);
#########
phi0=ones(Nx,);
rx=b-SamMxv(phi0,mxv_data);
vx=rx/norm(rx);
Mvx=SamFix(vx,qmc_data);
#r1=b-SamFix(vx,qmc_data);
r1=b-Mvx
println(norm(r1))
#########
phiout=qmc_sweep(phi0,qmc_data);
phi1=phiout.phi_avg
r0=phi1-phi0;
println(norm(r0-rx))
v0=r0/norm(r0)
phiout=qmc_sweep(v0,qmc_data);
phi2=phiout.phi_avg;
zed=zeros(Nx,)
phiout4=qmc_sweep(zed,qmc_data)
phi4=phiout4.phi_avg
print(norm(phi4-phi2))





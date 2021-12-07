function problem(N=100,Nx=10)
#Nx = 50;     # number of tally cells
na2 = 11;    # number of angles for angular mesh
#s = 1.0;     # parameter in Garcia/Siewert
#N = 2^11;    # number of particles per source itertion
LB = 0.0;   # left bound
RB = 5.0;   # right bound
geometry = "Slab";
generator = "Sobol";
s=1.0
qmc_data1 = garcia_init(geometry, generator, N, LB, RB, Nx, na2, s);
s=Inf
qmc_data2 = garcia_init(geometry, generator, N, LB, RB, Nx, na2, s);
phi0=zeros(Nx,1)
qout1=qmc_sweep(phi0, qmc_data1)
qout2=qmc_sweep(phi0, qmc_data2)
println(norm(qout2.phi_avg-qout1.phi_avg))
end


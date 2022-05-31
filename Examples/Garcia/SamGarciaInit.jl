function SamGarciaInit(N=100, Nx=10, s=1.0, generator="Sobol")
#Nx = 50;     # number of tally cells
na2 = 11;    # number of angles for angular mesh
#s = 1.0;     # parameter in Garcia/Siewert
#N = 2^11;    # number of particles per source itertion
LB = 0.0;   # left bound
RB = 5.0;   # right bound
geometry = "Slab";
qmc_data = garcia_init(geometry, generator, N, LB, RB, Nx, na2, s);
end

function SamGarciaInitMV(qmc_data)
b=SamRhs(qmc_data)
mxv_data = (b=b, qmc_data=qmc_data)
return mxv_data
end

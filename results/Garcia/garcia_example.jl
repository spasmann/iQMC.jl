function garcia_example(;N=2^11,Nx=50,s=1.0,generator="Sobol")
geometry = "Slab"
#Nx=50      # number of spatial cells
#N=2^11     # number of particles per QMC sweep
na2 = 11   # number of angles for angular mesh
#s = 1.0    # parameter in Garcia/Siewert
LB = 0.0   # left bound
RB = 5.0   # right bound
qmc_data = garcia_init(geometry, generator, N, LB, RB, Nx, na2, s)
#exact=qmc_data.true_flux
mxv_data = SamInitMV(qmc_data)
gmsol=Solver_Compare(mxv_data; plabel="Garcia/Siewart Problem")
end

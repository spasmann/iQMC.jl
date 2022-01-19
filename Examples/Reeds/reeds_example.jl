function reeds_example()
Nx=40; LB=0.0; RB=5.0;
geometry = "Slab"
generator = "Sobol"
N=2^11
qmc_data = reeds_init(generator,N,Nx)
exact=qmc_data.true_flux
mxv_data = SamInitMV(qmc_data)
gmsol=Solver_Compare(mxv_data; plabel="Reed's Problem")
end

function reeds_example()
generator = "Sobol"
Nx=160
N=2^11
qmc_data = reeds_init(generator,N,Nx)
exact=qmc_data.true_flux
mxv_data = SamInitMV(qmc_data)
gmsol=Solver_Compare(mxv_data; plabel="Reed's Problem")
end

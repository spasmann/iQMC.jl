function reeds_example(N=2^11, Nx=160; LB=-8.0, RB=8.0)
generator = "Sobol"
qmc_data = reeds_init(generator,N,Nx,LB=LB,RB=RB)
exact=qmc_data.true_flux
mxv_data = SamInitMV(qmc_data)
#gmsol=Solver_Compare(mxv_data; plabel="Reed's Problem")
Solution_Compare(mxv_data; plabel="Reed's Problem")
end

"""
mg_example(G=12, Nx=40, N=2^10)

Compare iterative methods for the mulitgroup problems
"""
function mg_example(G=12, Nx=40, N=2^10)
#
# Load Sam's data
#
LB=0.0; RB=5.0;
geometry = "Slab"
generator = "Sobol"
qmc_data = multiGroup_init(geometry, generator, N, LB, RB, Nx, G)
solex=qmc_data.true_flux
#
# Set up the linear system for the solvers
#
mxv_data = SamInitMV(qmc_data)
#
# Solve the problem with Picard, GMRES, BiCGSTAB.
# Plot results.
#
gmsol=Solver_Compare(mxv_data; plabel="$G group problem")
#
# Test agains the true solution
#
vsolex=reshape(solex,G*Nx,)
relerr=(vsolex-gmsol)./vsolex
println(norm(relerr,Inf))
end


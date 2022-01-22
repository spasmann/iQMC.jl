
"""
    reeds_problem(N, Nx)
...
# Arguments
* `N::Float64`: Number of particles.
* `Nx::Integer`: number of spatial cells.
...
"""
function qmc_reeds(N=2^12, Nx=160)
    ###############################################################################
    #### Parameters
    ###############################################################################
    generator = "Sobol"
    ###############################################################################
    #### Function Call
    ###############################################################################
    qmc_data = reeds_init(generator,N,Nx)
    phi_avg, phi_edge, dphi, J_avg, J_edge, psi_right, psi_left, history, itt = qmc_source_iteration(qmc_data)

    sol = qmc_data.true_flux
    xspan = LinRange(0,8,Nx)
    figure()
    plot(xspan, sol)
    plot(xspan,phi_avg)
end

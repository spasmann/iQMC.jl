
"""
    reeds_problem(N, Nx)
...
# Arguments
* `N::Float64`: Number of particles.
* `Nx::Integer`: number of spatial cells.
...
"""
function qmc_reeds(N=2^12, Nx=160; LB=-8.0, RB=8.0)
    ###############################################################################
    #### Parameters
    ###############################################################################
    generator = "Halton"
    ###############################################################################
    #### Function Call
    ###############################################################################
    qmc_data = reeds_init(generator,N,Nx)
    phi_avg, phi_edge, dphi, J_avg, J_edge, psi_right, psi_left, history, itt = qmc_source_iteration(qmc_data)
    println(phi_avg)
    sol = qmc_data.true_flux
    xspan = LinRange(qmc_data.LB,qmc_data.RB,Nx)
    figure()
    plot(xspan, sol, label="true")
    plot(xspan,phi_avg, label = "QMC")
    legend()

    fname = "Reeds-phi_avg-$generator-$N-$Nx"
    save_array(fname, phi_avg)
end

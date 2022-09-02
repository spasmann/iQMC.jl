"""
Sam Pasmann
"""
function qmc_rngComparison()

    ###############################################################################
    #### Parameters
    ###############################################################################

    Nx = 50 #number of tally cells
    na2 = 11 #number of angles for angular mesh
    s = [1] #parameter in Garcia/Siewert
    N = 2^11
    LB = 0      # left bound
    RB = 5      # right bound

    ###############################################################################
    #### Function Call
    ###############################################################################

    qmc_data1 = garcia_init("Slab", "Random", N, LB, RB, Nx, na2, s)
    qmc_data2 = garcia_init("Slab", "Sobol", N, LB, RB, Nx, na2, s)
    out1 = qmc_source_iteration(qmc_data1)
    out2 = qmc_source_iteration(qmc_data2)

    ###############################################################################
    #### Plots
    ###############################################################################
    midpoints = qmc_data1.midpoints

    figure()
    plot(midpoints, out1.phi_avg,label="Random")
    plot(midpoints, out2.phi_avg, label="Sobol")
    title("Scalar Flux")
    xlabel("Midpoints")
    ylabel("Flux")
    legend()
end

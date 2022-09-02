"""
Sam Pasmann
"""
function qmc_multiGroup(G=12, N=2^10)
    ###############################################################################
    #### Parameters
    ###############################################################################

    Nx = 20     # number of tally cells
    LB = 0      # left bound
    RB = 5    # right bound
    geometry = "Slab"
    generator = "Sobol"

    qmc_data = multiGroup_init(geometry, generator, N, LB, RB, Nx, G)
    phi_avg, phi_edge, dphi, J_avg, J_edge, history, itt = qmc_source_iteration(qmc_data)

    ###############################################################################
    #### Plots
    ###############################################################################
    midpoints = qmc_data.midpoints
    sol = qmc_data.true_flux

    counter = 1
    figure()
    color_sequence = ["#1f77b4", "#aec7e8", "#ff7f0e", "#ffbb78", "#2ca02c",
                      "#98df8a", "#d62728", "#ff9896", "#9467bd", "#c5b0d5",
                      "#8c564b", "#c49c94", "#e377c2", "#f7b6d2", "#7f7f7f",
                      "#c7c7c7", "#bcbd22", "#dbdb8d", "#17becf", "#9edae5"]
    title("Group Scalar Flux")
    for i in 1:1:G
        plot(midpoints, phi_avg[:,i], label=i,color=color_sequence[i]) #color=color_sequence[i]
        plot(midpoints,sol[:,i],"--",color=color_sequence[i])
    end
    ylabel("Cell Averaged Scalar Flux")
    xlabel("Spatial Position X")
    legend(loc="upper right")

end

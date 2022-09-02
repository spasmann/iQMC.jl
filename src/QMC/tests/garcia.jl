
"""
    qmc_garcia(N, Nx, s)
Function call for Garcia/Siewart problem. Left boundary source
and spatially dependent scattering cross section, sampled using Sobol Sequence.
JQSRT (27), 1982 pp 141-148.
...
# Arguments
* `N::Float64`: Number of particles.
* `Nx::Integer`: number of spatial cells.
* `s::Integer`: Garcia/Siewert cross section parameter.
...
"""
function qmc_garcia(N=2^11, Nx=40, s=1.0)
    ###############################################################################
    #### Parameters
    ###############################################################################
    #Nx = 50     # number of tally cells
    na2 = 11    # number of angles for angular mesh
    s = [s]     # parameter in Garcia/Siewert
    #N = 2^11    # number of particles per source itertion
    LB = 0      # left bound
    RB = 5      # right bound
    geometry = "Slab"

    ###############################################################################
    #### Function Call
    ###############################################################################

    qmc_data1 = garcia_init(geometry, "Sobol", N, LB, RB, Nx, na2, [1.0])
    qmc_data2 = garcia_init(geometry, "Sobol", N, LB, RB, Nx, na2, [Inf])
    out1 = qmc_source_iteration(qmc_data1)
    out2 = qmc_source_iteration(qmc_data2)
    #phi_avg, phi_edge, dphi, J_avg, J_edge, psi_right, psi_left, history, itt = qmc_source_iteration(qmc_data)

    ###############################################################################
    #### Plotting
    ###############################################################################

    midpoints = qmc_data1.midpoints
    figure(dpi=300,figsize=(6,6))
    plot(midpoints, out1.phi_avg, label=L"s=1.0")
    plot(midpoints, out2.phi_avg, label=L"s=\infty")
    xlabel("Cell Midpoints")
    ylabel("Scalar Flux " * L"\phi")
    legend()

    midpoints = qmc_data1.midpoints
    edges = qmc_data1.edges

    figure(figsize = (6,12))

    subplot(311)
    plot(midpoints,out1.phi_avg)
    ylabel("phi midpoints")
    xlabel("midpoints")
    title("Cell Averaged Scalar Flux")

    # cell Averaged Spatial Derivative of Scalar Flux
    subplot(312)
    plot(midpoints,out1.dphi)
    ylabel("dphi")
    xlabel("cell midpoints")
    title("Cell Flux Derivative")

    # cell averaged current
    subplot(313)
    plot(midpoints,out1.J_avg)
    ylabel("J avg")
    xlabel("midpoints")
    title("Cell Averaged Current")


    #left exit bins
    figure(figsize = (12,5))

    subplot(121)
    gsSol = zeros((11,2))
    gsSol[:,1] = -1*[0.05,.1,.2,.3,.4,.5,.6,.7,.8,.9,1]
    gsSol[:,2] = [0.58966,0.53112,0.44328,0.38031,0.33296,0.29609,0.26656,0.24239,
                                                            0.22223,0.20517,0.19055]
    plot(gsSol[:,1], gsSol[:,2],"+",label="Garcia et al.")
    plot(out1.psi_left[:,1], out1.psi_left[:,2],label="QMC_sweep")
    xlabel(L"Angle \mu")
    ylabel(L"Angular Flux \psi")
    title("Left Boundary")
    legend()

    #right exit bins
    subplot(122)
    gsSol = zeros((11,2))
    gsSol[:,1] = 1*[0.05,.1,.2,.3,.4,.5,.6,.7,.8,.9,1]
    gsSol[:,2] = [6.08E-06,6.93E-06,9.64E-06,1.62E-05,4.39E-05,1.69E-04,5.73E-04,
                                                1.51E-03,3.24E-03,5.96E-03,9.77E-03]
    plot(gsSol[:,1], gsSol[:,2],"+", label="Garcia et al.")
    plot(out1.psi_right[:,1], out1.psi_right[:,2], label="QMC_sweep")
    xlabel(L"Angle \mu")
    ylabel(L"Angular Flux \psi")
    title("Right Boundary")
    legend()


end

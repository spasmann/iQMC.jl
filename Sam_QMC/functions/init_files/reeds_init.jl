"""
    reeds_init(generator, N, LB, RB, Nx)
"""
function reeds_init(generator, N, Nx)

        hasLeft = false
        hasRight = false

        LB = 0.0
        RB = 8.0
        dx = (RB-LB)/Nx
        #define tally mesh
        low_edges = range(LB, stop=RB-dx, length=Nx)
        high_edges = low_edges.+dx
        midpoints = 0.5*(high_edges + low_edges)
        edges = range(LB, stop=RB, length=Nx+1)

        #define angular flux mesh
        #exit_left_bins data structure to hold the exiting angular flux,
        #the first column has the bin centers and
        #and the second holds the values.
        #exit_right_bins is the same
        na2 = 11
        dmu = 1/na2
        #right bins
        exit_right_bins = zeros((na2,2))
        exit_right_bins[:,1] = range(dmu/2, stop = 1- dmu/2, step = dmu)
        exit_right_bins[:,2] .= 0
        #left bins
        exit_left_bins = zeros((na2,2))
        exit_left_bins[:,1] = -1*range(dmu/2, stop = 1- dmu/2, step = dmu)
        exit_left_bins[:,2] .= 0

        G = 1 # number of groups
        sigt, sigs, siga, source = reeds_data(Nx)
        true_flux = reeds_sol(Nx)

        # phi_avg is defaulted to = zeros(Nx)
        phi_edge = zeros(Nx+1,G)
        phi_avg = zeros(Nx,G)

        dphi = zeros(Nx,G)
        phi_s = zeros(Nx,G) .+ 1e-6
        # current
        J_avg = zeros(Nx,G)
        J_edge = zeros(Nx+1,G)
        # Garcia parameter
        c = [1.0]
        # Geometry
        Geo = 1

        qmc_data = (        Geo = Geo,
                            N = N,
                            Nx = Nx,
                            G = G,
                            RB = RB,
                            LB = LB,
                            dmu = dmu,
                            exit_left_bins = exit_left_bins,
                            exit_right_bins = exit_right_bins,
                            phi_edge = phi_edge,
                            phi_avg = phi_avg,
                            true_flux = true_flux,
                            dphi = dphi,
                            phi_s = phi_s,
                            J_avg = J_avg,
                            J_edge = J_edge,
                            sigt = sigt,
                            sigs = sigs,
                            source = source,
                            c = c,
                            generator = generator,
                            hasRight = hasRight,
                            hasLeft = hasLeft,
                            low_edges = low_edges,
                            high_edges = high_edges,
                            midpoints = midpoints,
                            edges = edges)
        return qmc_data
end

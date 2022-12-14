
"""
    move_part(midpoints,mu,x,Nx,high_edges,low_edges,weight,
    phi_avg, dphi, phi_edge, phi_s, J_avg, J_edge,sigt,
    exit_right_bins,exit_left_bins,c,phi,z,y,Geo)

Sweep particle from emission site out of volume while tallying flux and current.
"""
function move_part(midpoints,mu,x,Nx,high_edges,low_edges,weight,
                    phi_avg, dphi, phi_edge, phi_s, J_avg, J_edge,sigt,
                    exit_right_bins,exit_left_bins,c,phi,z,y,Geo)

    # collect list of zones crossed and path lengths in each
    zoneList, dsList = getPath(Geo,x,y,z,mu,phi,low_edges,high_edges,Nx)
    counter = 1
    # sweep through all zones
    for z_prop in zoneList
        ds = dsList[counter]
        dV = cellVolume(Geo,z_prop,low_edges,high_edges)
        # update variables
        if (sigt[z_prop] > 1e-16)
            score_TL = weight.*(1 .- exp.(-(ds*sigt[z_prop,:])))./(sigt[z_prop,:].*dV) #implicit capture for track-length
        else
            score_TL = weight.*ds./dV
        end
        """
        if (any(isnan, score_TL))
            println("**************************************")
            println("sigt>0: ", weight.*(1 .- exp.(-(ds*sigt[z_prop,:])))./(sigt[z_prop,:].*dV))
            println("sigt=0: ", weight.*ds./dV)
            println("score_TL = ", score_TL)
            println("weight = ", weight)
            println("(1 .- exp.(-(ds*sigt[z_prop,:]))) =", (1 .- exp.(-(ds*sigt[z_prop,:]))))
            println("(sigt[z_prop,:].*dV) = ", (sigt[z_prop,:].*dV))
            println("wight.*(1 .- exp.(-(ds*sigt[z_prop,:])))./(sigt[z_prop,:].*dV) = ", weight.*(1 .- exp.(-(ds*sigt[z_prop,:])))./(sigt[z_prop,:].*dV))
            println("sigt = ", sigt[z_prop,:])
            println("ds = ", ds)
            println("**************************************")
        end
        """
        #

        @assert(!any(isnan, score_TL))

        phi_avg[z_prop,:] += score_TL
        J_avg[z_prop,:]   += score_TL*mu
#        phi_s[z_prop,:]   .+= (weight.*exp.(-low_edges[z_prop]./c)).*(1 .- exp.(-(ds*(sigt[z_prop,:] .+ mu./c))))./(sigt[z_prop,:] .+ mu./c)./dV
#        dphi[z_prop,:]    += (weight.*((-dV/2).*(1 .- exp.(-sigt[z_prop,:]*ds))
#                             .+ mu*((1 .- exp.(-sigt[z_prop,:]*ds))./sigt[z_prop,:])
#                             .- ds*exp.(-sigt[z_prop,:]*ds)))./sigt[z_prop,:]./dV
        weight            .*= exp.(-(ds*sigt[z_prop,:]))

        # edge angular flux tally.
        # only configured for slab geometry, intended for Garcia et al problem
        if (Geo == 1)
            if (mu > 0)
                J_edge[z_prop+1,:]   += weight
                phi_edge[z_prop+1,:] += weight./abs(mu)
                if (z_prop == last(zoneList))
                    # add to the exiting flux - find the bin and add it to that one
                    exit_right_bins[argmin(abs.(exit_right_bins[:,1] .- mu)),2] += (weight/mu)[1]
                end
            else
                J_edge[z_prop,:]   -= weight
                phi_edge[z_prop,:] += weight./abs(mu)
                if (z_prop == last(zoneList))
                    # add to the exiting flux - find the bin and add it to that one
                    exit_left_bins[argmin(abs.(exit_left_bins[:,1] .- mu)),2] += (weight/abs(mu))[1]
                end
            end
        end

        counter += 1
    end
    return
end

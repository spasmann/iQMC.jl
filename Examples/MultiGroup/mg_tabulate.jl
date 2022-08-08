"""
gs_tabulate(s,nx,flux; maketab=true, phiedge=false)

Make the tables to compare with Garcia/Siewert

Uses the converged flux from the solve.
"""
function mg_tabulate(G, Nx, true_flux, flux; maketab=true)
    if maketab
        println("Results for Multi-Group Problem, Nx = $nx")
        mg_texttab(true_flux,flux)
        mg_LaTeX(true_flux,flux)
    end

    true_flux = reshape(true_flux, G*Nx,)
    reldiff=(true_flux-flux)./true_flux
    ExitErr=norm(reldiff,Inf)
    return (ExitErr=ExitErr)
end

function mg_texttab(GS,PS)
labelgs="               Reeds Problem                         QMC"
header = " mu         I(0,-mu)        I(tau,mu)"
header2 = "      I(0,-mu)        I(tau,mu)"
@printf("%s \n", labelgs)
@printf("%s %s \n", header, header2)
for it=1:na
    @printf("%5.2f %15.5e %15.5e %15.5e %15.5e \n",
           angleout[it+na],
           GS[it,1], GS[it,2],
           PS[it,1], PS[it,2])
    end
end

function mg_LaTeX(GS,PS,angleout)
headers = [L"$\mu$",L"$\psi(0,-\mu)$",L"$\psi(\tau,\mu)$",
           L"$\psi(0,-\mu)$",L"$\psi(\tau,\mu)$"]
TData=[angleout[na+1:2*na] GS[:,1] GS[:,2] PS[:,1] PS[:,2]]
formats="%5.2f & %14.5e & %14.5e & %14.5e & %14.5e"
fprintTeX(headers, formats, TData)
end

"""
This function averages the scalar flux across spatial zones until the size
is (20,G).
"""
function reduce_flux(flux)
    len = size(flux)[1]
    I = log(len/20)/log(2)
    for i in range(1,I)
        left_edges = flux[1:2:len-1,:]
        right_edges = flux[2:2:len,:]
        flux = (right_edges + left_edges)*0.5
        len = size(flux)[1]
    end
    return flux
end

"""
gs_tabulate(s,nx,flux; maketab=true, phiedge=false)

Make the tables to compare with Garcia/Siewert

Uses the converged flux from the solve.
"""
function reeds_tabulate(nx, flux; maketab=true)
    PS = flux
    PS = reduce_flux(PS)
    #GS = reeds_sol(nx)
    GS = reeds_mcdc_sol()
    #GS = reeds_Nx80_sol()
    if maketab
        println("Results for Reeds Problem, Nx = $nx")
        reeds_texttab(GS,PS)
        reeds_LaTeX(GS,PS)
    end
    diff=(GS-PS)
    ExitErr=norm(diff,Inf)
    return (ExitErr=ExitErr)
end

function reeds_texttab(GS,PS)
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

function reeds_LaTeX(GS,PS,angleout)
headers = [L"$\mu$",L"$\psi(0,-\mu)$",L"$\psi(\tau,\mu)$",
           L"$\psi(0,-\mu)$",L"$\psi(\tau,\mu)$"]
TData=[angleout[na+1:2*na] GS[:,1] GS[:,2] PS[:,1] PS[:,2]]
formats="%5.2f & %14.5e & %14.5e & %14.5e & %14.5e"
fprintTeX(headers, formats, TData)
end


"""
This function averages the scalar flux across spatial zones until the size
is (80,1). This function is for comparison to MCDC's N=10^10 Nx=80 run.
"""
function reduce_flux(flux)
    len = length(flux)
    I = log(len/80)/log(2)
    for i in range(1,I)
        left_edges = flux[1:2:len-1]
        right_edges = flux[2:2:len]
        flux = (right_edges + left_edges)*0.5
        len = length(flux)
    end
    return flux
end

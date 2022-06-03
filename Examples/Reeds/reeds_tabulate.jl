"""
gs_tabulate(s,nx,flux; maketab=true, phiedge=false)

Make the tables to compare with Garcia/Siewert

Uses the converged flux from the solve.
"""
function reeds_tabulate(nx, flux; maketab=true)
    PS = flux
    GS = reeds_sol(nx)
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

"""
gs_tabulate(s,nx,flux; maketab=true, phiedge=false)

Make the tables to compare with Garcia/Siewert

Uses the converged flux from the solve.
"""
function gs_tabulate(s, nx, flux; maketab=true, phiedge=false)
    angleout = [-.05; collect(-.1:-.1:-1.0); 0.05; collect(0.1:0.1:1.0)]
    #
    # I don't really need the weights, but sn_init expects some
    weights = angleout
    #
    na2 = length(angleout)
    na = floor(Int, na2 / 2)
    phiedge ? np=nx : np=nx+1
    sn_data = sn_init(nx, na2, s; siewert=true, phiedge=phiedge)
    psi = sn_data.psi
    psi = transport_sweep!(psi, flux, sn_data; phiedge=phiedge)
    PS=zeros(na,2)
    PS[:,1].=psi[1:na,1]; 
    PS[:,2].=psi[na+1:2*na,np]
    GS=GS_Data_Read(s)
    if maketab
        println("Results for s = $s, Nx = $nx")
        gs_texttab(GS,PS,angleout,na,s)
        gs_LaTeX(GS,PS,angleout,na,s)
    end
    reldiff=(GS-PS)./GS
    ExitErr=norm(reldiff,Inf)
    return (left = psi[1:na, 1], right = psi[na+1:na2, np], ExitErr=ExitErr)
end

function gs_texttab(GS,PS,angleout,na,s)
labelgs="               Garcia/Siewert                         QMC"
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

function gs_LaTeX(GS,PS,angleout,na,s)
headers = [L"$\mu$",L"$\psi(0,-\mu)$",L"$\psi(\tau,\mu)$",
           L"$\psi(0,-\mu)$",L"$\psi(\tau,\mu)$"]
TData=[angleout[na+1:2*na] GS[:,1] GS[:,2] PS[:,1] PS[:,2]]
formats="%5.2f & %14.5e & %14.5e & %14.5e & %14.5e"
fprintTeX(headers, formats, TData)
end


"""
Error_Table(tol=1.e-5, NLim=5, NxLim=7;
            maketab=true, fname=nothing, rptprog=true, fluxplot=false, generator="Sobol")

Makes the table of relative errors in the exit distributions.
"""
function Reeds_Error_Table(tol=1.e-5; Nxvals=[80], Nvals = [2^10, 2^11, 2^12, 2^13, 2^14, 2^15, 2^16, 2^17],
         maketab=false, savedata=false, fname=nothing, rptprog=true, fluxplot=false, generator="Sobol",LB=-8.0,RB=8.0)
ltol=Int(log10(tol))
NLim = length(Nvals)
NxLim = length(Nxvals)
LongFname="ErrTabReed$generator($NxLim-$NLim, $ltol)Nx$(Nxvals[1])"
(fname == nothing) && (fname=LongFname)
Tout=zeros(NxLim,NLim)
for indx=1:NxLim
    Zout=Reeds_Error_Table_Row(Nxvals[indx], Nvals[1:NLim], tol; fluxplot=fluxplot, rptprog=rptprog, generator=generator)
    rptprog && println("Row $indx complete")
    Tout[indx,:].=Zout
end
#maketab && writetab(fname,Tout)
#writetab(fname,Tout)
if (savedata)
    writedlm(pwd()*"/Examples/Reeds/$fname.dat",Tout, ' ')
end

return Tout
end

"""
Error_Table_Row(Nx, s, Nvals, tol; rptprog=true, generator="Sobol")

makes a row of the error table, fixing Nx and varying N.
In this way I can use the converged flux for one N as the initial
iterate for the next.
"""
function Reeds_Error_Table_Row(Nx, Nvals, tol; fluxplot=false, rptprog=true, generator="Sobol",LB=-8.0,RB=8.0)
phi0=zeros(Nx,)
maxit=200
#
N=Nvals[1]
NLen=length(Nvals)
qmc_data=reeds_init(generator,N,Nx,LB=LB,RB=RB)
mxv_data=SamInitMV(qmc_data)
b=mxv_data.b
G=qmc_data.G
Nv=Nx*G
V=zeros(Nv,20)
#
Errs=zeros(NLen,)

if (fluxplot)
    figure(1)
    plot(qmc_data.midpoints, qmc_data.true_flux,label="sol")
end

for Nind=1:NLen
    gmres_out=kl_gmres(phi0,b,SamMxv,V,tol; pdata=mxv_data, lmaxit=maxit)
    sol=gmres_out.sol; phi0.=sol;
    ExitErr=reeds_tabulate(Nx, sol; maketab=false)
    Errs[Nind]=ExitErr
    #rptprog && println("Column $Nind, Nx = $Nx, N = $(Nvals[Nind]), RelErr= ",ExitErr)
    rptprog && @printf("Nx = %i, N = %i, RelErr = %.3e \n", Nx, (Nvals[Nind]), ExitErr)
    #
    if (fluxplot)
        figure(1)
        plot(qmc_data.midpoints, sol, label="gmres")
        legend()
    end
    if Nind < NLen
        phi0.=sol
        mxv_data=Increase_N_Reeds(Nvals[Nind+1],Nx,generator,LB=LB,RB=RB)
        b=mxv_data.b
    end
    #
end
return Errs
end

function Increase_N_Reeds(N, Nx, generator; LB=-8.0,RB=8.0)
qmc_data=reeds_init(generator,N,Nx,LB=LB,RB=RB)
mxv_data=SamInitMV(qmc_data)
#b=mxv_data.b
return mxv_data
end

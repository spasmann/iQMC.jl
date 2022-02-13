"""
Error_Table(tol=1.e-5, NLim=5, NxLim=7;
            maketab=true, fname=nothing, rptprog=true)

Makes the table of relative errors in the exit distributions.
"""
function MG_Error_Table(tol=1.e-5;
         maketab=false, savedata=false, fname=nothing, rptprog=true)
ltol=Int(log10(tol))
Nvals= [2^10, 2^11, 2^12, 2^13, 2^14, 2^15]
NLim = 6
NxBase=50;
NxVals=NxBase*[1, 2, 4, 8, 16, 32]
NxLim = 6
LongFname="ErrTab($NxLim-$NLim, $ltol)"
(fname == nothing) && (fname=LongFname)
Tout=zeros(NxLim,NLim)
for indx=1:NxLim
    Zout=MG_Error_Table_Row(NxVals[indx], Nvals[1:NLim],tol; rptprog=rptprog)
    rptprog && println("Row $indx complete")
    Tout[indx,:].=Zout
end
#maketab && writetab(fname,Tout)
writetab(fname,Tout)
if (savedata)
    writedlm(pwd()*"/Examples/MultiGroup/$fname.dat",Tout, ' ')
end

return Tout
end

"""
Error_Table_Row(Nx, s, Nvals, tol; rptprog=true)

makes a row of the error table, fixing Nx and varying N.
In this way I can use the converged flux for one N as the initial
iterate for the next.
"""
function MG_Error_Table_Row(Nx, Nvals, tol; rptprog=true)

maxit=200
#
N=Nvals[1]
NLen=length(Nvals)
generator="Sobol"
geo = "Slab"
LB = 0.0
RB = 5.0
G = 12
qmc_data=multiGroup_init(geo, generator, N, LB, RB, Nx, G)
mxv_data=SamInitMV(qmc_data)
true_sol = qmc_data.true_flux
b=mxv_data.b
Nv=Nx*G
V=zeros(Nv,20)
phi0=zeros(Nv,)
#
RelErrs=zeros(NLen,)
for Nind=1:NLen
    gmres_out=kl_gmres(phi0,b,SamMxv,V,tol; pdata=mxv_data, lmaxit=maxit)
    sol=gmres_out.sol; phi0.=sol;
    ExitErr=mg_tabulate(G, Nx, true_sol, sol; maketab=false)
    RelErrs[Nind]=ExitErr
    #rptprog && println("Column $Nind, Nx = $Nx, N = $(Nvals[Nind]), RelErr= ",ExitErr)
    rptprog && @printf("Nx = %i, N = %i, RelErr = %.3e \n", Nx, (Nvals[Nind]), ExitErr)
    #
    if Nind < NLen
        phi0.=sol
        mxv_data=Increase_N_MG(geo, generator, Nvals[Nind+1], LB, RB, Nx, G)
        b=mxv_data.b
    end
    #
end
return RelErrs
end

function Increase_N_MG(geo, generator, N, LB, RB, Nx, G)
qmc_data=multiGroup_init(geo, generator, N, LB, RB, Nx, G)
mxv_data=SamInitMV(qmc_data)
#b=mxv_data.b
return mxv_data
end

#
# This file has the functions that I need to take Sam's data files
# and map the problem to a linear system for a Krylov method.
#
# SamFix and SamFix! are the source iteration maps. SamFix! overwrites
# its input and SamFix does not.
#
function SamFix(phi_in,qmc_data)
G=qmc_data.G; Nx=qmc_data.Nx; Nv=length(phi_in);
(Nv == Nx*G) || error("dimension error in SamFix")
phi_avg=reshape(phi_in,Nx,G)
qout=qmc_sweep(phi_avg, qmc_data)
phi_out=reshape(qout.phi_avg,Nv,)
return phi_out
end

function SamFix!(phi_out,phi_in,qmc_data)
G=qmc_data.G; Nx=qmc_data.Nx; Nv=length(phi_in);
(Nv == Nx*G) || error("dimension error in SamFix!")
phi_avg=reshape(phi_in,Nx,G)
qout=qmc_sweep(phi_in, qmc_data)
phi_out.=reshape(qout.phi_avg,Nv,)
return phi_out
end

"""
SamRhs(qmc_data)

We solve A x = b with a Krylov method. This function extracts
b from Sam's qmc_data structure by doing a transport sweep with
zero scattering term.
"""
function SamRhs(qmc_data)
G=qmc_data.G; Nx=qmc_data.Nx; Nv=Nx*G;
zed=zeros(Nv,)
bout=SamFix(zed,qmc_data)
return bout
end


"""
SamMxv(phi_in,mxv_data)

We solve A x = b with a Krylov method. This function extracts the
matrix-vector product A * phi_in from Sam's qmc_data structure by 
doing a transport sweep with zero boundary conditions and zero external
source.
"""
function SamMxv(phi_in,mxv_data)
b=mxv_data.b
qmc_data=mxv_data.qmc_data
mxpb=SamFix(phi_in,qmc_data)
mxv=mxpb-b
axv=phi_in - mxv
return axv
end

"""
SamInitMV(qmc_data)

This function adds the right side of the linear system to Sam's 
qmc_data structure so I can pass it to the matrix-vector product.
"""
function SamInitMV(qmc_data)
b=SamRhs(qmc_data)
mxv_data = (b=b, qmc_data=qmc_data)
return mxv_data
end

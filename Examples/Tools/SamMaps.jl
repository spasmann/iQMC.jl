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

function SamRhs(qmc_data)
G=qmc_data.G; Nx=qmc_data.Nx; Nv=Nx*G;
zed=zeros(Nv,)
bout=SamFix(zed,qmc_data)
return bout
end


function SamMxv(phi_in,mxv_data)
b=mxv_data.b
qmc_data=mxv_data.qmc_data
mxpb=SamFix(phi_in,qmc_data)
mxv=mxpb-b
axv=phi_in - mxv
return axv
end

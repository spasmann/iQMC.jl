function Sam_Bench(N=2^11, Nx=100, s=1.0)
qmc_data=SamGarciaInit(N, Nx, s);
mxv_data=SamInitMV(qmc_data);
b=mxv_data.b;
Nx=qmc_data.Nx;
G=qmc_data.G;
Nv=Nx*G;
V=zeros(Nv,20);
phi0=zeros(Nv,);
tol=1.e-10;
maxit=200;
@btime gmtime($phi0,$b,$SamMxv,$V,$tol,$mxv_data)
end


function gmtime(phi0,b,SamMxv,V,tol,pdata)
kout=kl_gmres(phi0,b,SamMxv,V,tol; pdata=pdata)
end

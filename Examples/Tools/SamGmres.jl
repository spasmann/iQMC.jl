function SamGmres(N=100, Nx=10, s=1.0)
qmc_data=SamGarciaInit(N, Nx, s)
phi0=ones(Nx,); tol=1.e-10;
V=zeros(Nx,10);
mxv_data=SamGarciaInitMV(qmc_data)
b=mxv_data.b
gmres_out=X_gmres(phi0,b,SamMxv,V,tol; pdata=mxv_data)
sol=gmres_out.sol
if false
bicgstab_out=kl_bicgstab(phi0,b,SamMxv,V,tol; pdata=mxv_data)
solb=bicgstab_out.sol
psitestb=SamFix(solb,qmc_data)
soldiff=norm(sol-solb)
plot(sol-solb)
end
res=b - SamMxv(sol,mxv_data)
resn=norm(res)
psitest=SamFix(sol,qmc_data)
fixn=norm(sol-psitest)
println("ResNorm = $resn. FPerr = $fixn")
return gmres_out
end



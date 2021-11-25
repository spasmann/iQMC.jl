function FixedTest(N=100, Nx=10, s=1.0)
qmc_data=SamGarciaInit(N, Nx, s)
phi0=zeros(Nx,); maxit=100; tol=1.e-10;

pout=SamPicard(phi0,SamFix,tol,maxit,qmc_data);
aaout0=SamAA0(phi0,SamFix!,tol,maxit,qmc_data);
aaout00=SamAA(phi0,SamFix!,tol,maxit,qmc_data,0);

pdiff=norm(pout.sol-aaout0.sol)  
adiff=norm(pout.sol-aaout00.solution)
println("Picard diff = $pdiff. Diff from AA0 = $adiff")
Hdiff = pout.reshist-aaout00.history
println(norm(Hdiff))



end

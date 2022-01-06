#
# Test the transport solve with s=infty against the data 
# from Tables 1 and 2 of
#
# author="R.D.M. Garcia and C.E. Siewert",
# title = "Radiative transfer in finite inhomogeneous plane-parallel 
#          atmospheres",
# journal="J. Quant. Spectrosc. Radiat. Transfer",
# year = 1982,
# volume=27,
# pages="141--148"
# 
function garcia_test()
#
# Set up the test problem 
#
s=Inf; N=2^10; Nx=50;
qmc_data=SamGarciaInit(N, Nx, s)
mxv_data=SamInitMV(qmc_data)
b=mxv_data.b
Nx=qmc_data.Nx
G=qmc_data.G
Nv=Nx*G
V=zeros(Nv,40)
phi0=zeros(Nv,)
tol=1.e-10
#
kout=kl_gmres(phi0,b,SamMxv,V,tol; pdata=mxv_data)
#
(sn_left, sn_right) = short_tab(s, Nx, kout.sol)
(out_left, out_right) = ces_data();
diff=norm(out_left-sn_left,Inf) + norm(out_right-sn_right, Inf)
kynum=length(kout.reshist)
transok =  (diff < 1.e-1) && (kynum <= 18)
transok || println("Transport test fails: dataerr = $diff; itcount = $kynum")
return transok
end


function ces_data()
out_left=[8.97797e-01, 8.87836e-01, 8.69581e-01, 8.52299e-01, 8.35503e-01, 
8.18996e-01, 8.02676e-01, 7.86493e-01, 7.70429e-01, 7.54496e-01, 7.38721e-01];
out_right=[1.02202e-01, 1.12164e-01, 1.30419e-01, 1.47701e-01, 1.64497e-01, 
1.81004e-01, 1.97324e-01, 2.13507e-01, 2.29571e-01, 2.45504e-01, 2.61279e-01];
return (out_left, out_right)
end

function short_tab(s, nx, flux; phiedge=false)
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
    return (left = psi[1:na, 1], right = psi[na+1:na2, np])
end


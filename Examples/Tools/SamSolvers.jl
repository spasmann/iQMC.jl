"""
SamPicard(phi0,FPmap,tol,maxit,qmc_data)

Plain vanilla Picard
"""
function SamPicard(phi0,FPmap,tol,maxit,qmc_data)
itc=0
del=1.0
phic=copy(phi0)
phi=copy(phi0)
reshist=Float64[]
while itc < maxit && del > tol
phi = FPmap(phic,qmc_data)
del=norm(phic-phi)
push!(reshist,del)
phic .= phi
itc+=1
end
return (sol=phi, reshist=reshist)
end

"""
SamAA0(phi0,FPmap!,tol,maxit,qmc_data)

Plain vanilla Picard for the version used in Anderson acceleration
"""
function SamAA0(phi0,FPmap!,tol,maxit,qmc_data)
itc=0
del=1.0
phic=copy(phi0)
phi=copy(phi0)
reshist=Float64[]
while itc < maxit && del > tol
phi = FPmap!(phi,phic,qmc_data)
del=norm(phic-phi)
push!(reshist,del)
phic .= phi
itc+=1
end
return (sol=phi, reshist=reshist)
end

"""
SamAA(phi0,FPmap!,tol,maxit,qmc_data,m)

Solve with Anderson acceleration. Should be equivalent to GMRES.
"""
function SamAA(phi0,FPmap!,tol,maxit,qmc_data,m)
G=qmc_data.G; Nx=qmc_data.Nx; Nv=length(phi0);
(Nv == Nx*G) || error("dimension error in SamAA!")
Vstore=zeros(Nv,3*m+4)
aaout=aasol(FPmap!,phi0,m,Vstore; maxit=maxit, atol=tol, rtol=tol,
            pdata=qmc_data)
return aaout
end

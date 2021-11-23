function simplegm()
b=ones(2,)
x0=rand(2,)
V=zeros(2,3)
eta=1.e-9
xstar=[.5, .25]
gout=kl_gmres(x0, b, atv, V, eta)
println(norm(gout.sol-xstar))
println(gout.reshist)
end


function atv2(x2)
P=zeros(2,1)
P[1]=2.0
P[2]=4.0
mv=x2.*P
return mv
end

function atv3(x,nothing)
P=zeros(2,)
P[1]=2.0
P[2]=4.0
mv=x.*P
return mv
end

function atv(x)
y=reshape(x,2,1)
mx=atv2(y)
z=reshape(mx,2,)
return z
end

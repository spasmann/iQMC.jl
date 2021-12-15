function TeX_Error_Table(NLim, NxLim, fname="xxx"; textab=false)
Tout=zeros(NxLim,NLim)
readtab(fname,Tout)
PrintOut=zeros(NxLim,NLim+1)
rnum=0:1:NxLim-1; gnum=2 .^ rnum; gnum .*= 50
PrintOut[:,2:NLim+1] .= Tout
PrintOut[:,1].=gnum
if textab
NxBase=50;
Nvals=[2^10, 2^11, 2^12, 2^13, 2^14]
NxVals=NxBase*[1, 2, 4, 8, 16, 32, 64]
makeqmctex(Tout,Nvals,NxVals)
else
for ip=1:NxLim
   @printf("%3d ",PrintOut[ip,1])
   for ix=2:NLim+1
       @printf("%13.5e ",PrintOut[ip,ix])
   end
   @printf("\n")
end
end
return PrintOut
end

function makeqmctex(Tout,NVals,NxVals)
(md,nd)=size(Tout)
Parray=zeros(md, nd+1)
Parray[:,1].=NxVals
Parray[:,2:nd+1].=Tout
levels=length(NxVals)
Nrange=length(NVals)
headers=["Nx\\N"]
for i=1:Nrange
push!(headers,string(NVals[i]))
end
formats="%d "
for i=1:nd
formats=string(formats,"& %8.5e")
end
fprintTeX(headers,formats,Parray)
end




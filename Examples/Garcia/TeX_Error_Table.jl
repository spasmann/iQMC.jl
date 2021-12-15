function TeX_Error_Table(NLim, NxLim, fname="xxx")
Tout=zeros(NxLim,NLim)
readtab(fname,Tout)
PrintOut=zeros(NxLim,NLim+1)
rnum=0:1:NxLim-1; gnum=2 .^ rnum; gnum .*= 50
PrintOut[:,2:NLim+1] .= Tout
PrintOut[:,1].=gnum
for ip=1:NxLim
   @printf("%3d ",PrintOut[ip,1])
   for ix=2:NLim+1
       @printf("%13.5e ",PrintOut[ip,ix])
   end
   @printf("\n")
end
return PrintOut
end



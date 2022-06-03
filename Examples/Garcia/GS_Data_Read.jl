function GS_Data_Read(s)
DataGS=zeros(11,2);
s == 1.0 ? sstr=1 : sstr=Inf
dir = @__DIR__
file = "/Siewert:s=$sstr.dat"
#fname="/Users/sampasmann/Documents/GitHub/Krylov_QMC/Examples/Garcia_Scripts/Siewert:s=$sstr.dat"
fname = dir*file
readtab(fname,DataGS)
return DataGS
end

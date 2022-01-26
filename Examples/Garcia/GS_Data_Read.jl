function GS_Data_Read(s)
DataGS=zeros(11,2);
s == 1.0 ? sstr=1 : sstr=Inf
fname="/Users/sampasmann/Documents/GitHub/Krylov_QMC/Examples/Garcia_Scripts/Siewert:s=$sstr.dat"
readtab(fname,DataGS)
return DataGS
end

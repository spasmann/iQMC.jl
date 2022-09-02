function readtab(fname,data)
open(fname,"r") do io
read!(io,data)
end
end

function writetab(fname,data)
open(fname,"w") do io
write(io, data)
end
end

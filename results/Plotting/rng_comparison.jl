using Random
using Sobol
using GoldenSequences
using HaltonSequences
using PyPlot
#pygui(true)

N = 256     # number of samples
D = 2       # number of dimensions

# Collect samples
random = rand(N,D)
halton = reduce(hcat, HaltonPoint(D,length=N))
golden = [tup[k] for k in 1:2, tup in collect(Iterators.take(GoldenSequence(D), N))]
sobol = SobolSeq(D)
sobol = reduce(hcat, next!(sobol) for i = 1:N)

# Plot
fig = figure(dpi=300,figsize=(10,10))
markersize = 15

subplot(221)
scatter(random[:,1], random[:,2],s=markersize)
title("Random")
tight_layout()

subplot(222)
title("Sobol")
scatter(sobol[1,:], sobol[2,:],s=markersize)
tight_layout()

subplot(223)
title("Halton")
scatter(halton[1,:], halton[2,:],s=markersize)
tight_layout()

subplot(224)
title("Golden")
scatter(golden[1,:], golden[2,:],s=markersize)
tight_layout()

fig.savefig("rng_comparison")

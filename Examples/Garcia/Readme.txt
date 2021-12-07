The files here make the plots/tables for the Garcia-Siewert example.
We used different values for N that we did in the NDQ_QMC repo, so
the results are a bit different.

I am working on some tools that will let us take the qmc_init data
structure and make the runs for all the examples. I am not there yet.

The codes take some time to run.

- Make_Plots_Iterations_GS.jl 
  Compare the performance of Picard/GMRES/BiCGstab for N=2^11, Nx=100
  for the two cases s=1 and s=Inf.
  The call Make_Plots_Iterations_GS.jl() makes the plot for the s=1 case.
  The call Make_Plots_Iterations_GS.jl(2^11, 100, Inf) makes the plot 
    for the s=Inf case. 

  The plots are in the Krylov_QMC/FIGURES


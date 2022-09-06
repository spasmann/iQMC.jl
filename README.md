![alt text](https://raw.githubusercontent.com/spasmann/iQMC/main/post_process/figures/iQMC_logo_2.png)
Author: Sam Pasmann

iterative Quasi-Monte Carlo (iQMC) code for neutron transport.
The theory behind iQMC is outlined in [1]. iQMC uses Quasi-Monte Carlo 
methods to solve successive iterations of the Source Iteration and other advanced
linear solvers for neutron transport.
 
# Usage 
To load the iQMC package:
```julia
push!(LOAD_PATH,<path_to_repo>)
using(iQMC)
```
## Recreating Results:

### Infinite Medium Multi-Group
To recreate the convergence of residuals for the three linear solvers: source iteration, GMRES, and BiCGSTAB. Run the function:
```julia
iQMC.MG_Solver_Compare(Nx=80, N=2^14)
```
To recreate the relative error results, run the function:
```julia
iQMC.MG_Error_table(tol=1.e-5; Nxvals=[80, 160, 320], Nvals= [2^10, 2^11, 2^12, 2^13, 2^14, 2^15, 2^17, 2^18, 2^19, 2^20],
         maketab=false, savedata=true, fname=nothing, rptprog=true, generator="Sobol")
```
Note, change `generator="Sobol"` to generator="Random" to generate MC results.

### Reed's Problem
To recreate convergence of residuals for Reed's Problem use:
```julia
iQMC.Reeds_Solver_Compare(Nx=180, N=2^14, generator="Sobol")
```
For relative error results, run:
```julia
iQMC.Reeds_Error_Table(tol=1.e-5; Nxvals=[80], Nvals = [2^10, 2^11, 2^12, 2^13, 2^14, 2^15, 2^16, 2^17],
         maketab=false, savedata=false, fname=nothing, rptprog=true, fluxplot=false, generator="Sobol",LB=-8.0,RB=8.0)
```

### Garcia et al.


# Sources
[1] Pasmann, S., Variansyah, I., and McClarren, R. G. Convergent transport source iteration calculations with quasi-monte carlo. vol. 124, American Nuclear Society, pp. 192–195.

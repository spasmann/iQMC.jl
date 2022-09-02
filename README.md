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
iQMC.mg_solver_compare(Nx=20, N=2^10)
```

### Reed's Problem

### Garcia et al.


# Sources
[1] Pasmann, S., Variansyah, I., and McClarren, R. G. Convergent transport source iteration calculations with quasi-monte carlo. vol. 124, American Nuclear Society, pp. 192–195.

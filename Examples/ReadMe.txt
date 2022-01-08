These are the files that I use to make the plots and tables for the paper.
I think I've got it set up so that any problem with a qmc_data can use the codes.

Tools directory: 
The files that you care about are

SamMaps.jl, Solver_Compare.jl, and Sam_Bench.jl

SamMaps.jl takes Sam's qmc_data structure and makes the matrix-vector
product that Krylov solvers need. 

Solver_Compare is used in all the examples to make the plots comparing
the iterative methods. All Solver_Compare needs to do its job is the 
mxv_data file and a label for the plot.

Data_Files.jl and fprintTeX.jl read/write data and make tables in TeX. You can
ignore these files.

Garcia directory:

Error_Table.jl makes the table of relative errors in the paper. It is
only for the Garcia-Siewert example. It uses gs_tabulate.jl to map the
flux into the exit distributions.

Make_Plots_Iterations.jl sets up the data structures and calls Solver_Compare.

MulitGroup directory: mg_example.jl does the same job as 
Make_Plots_Iterations.jl does for the Garia-Siewert example. I use
Solver_Compare.jl to run the solvers and plot the results. I also add
a test at the end to make sure I'm getting correct results.

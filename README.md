# Krylov_NDA: some progress
Draft of Krylov-NDA paper
Sam, Ryan, this is the private repo for the paper. I am getting the data into the results section. This is more pain that I expected becasue the notebook->tex map
works out of the box for my book project and for a simple pdf job. It does not as work well for journal publications. I should be done pretty soon anyhow.

When we submit, we will need a new repo for reproducibility. The NDA-QMC repo is a bit to messy for that and I will start porting code from the NDA-QMC repo to
a stand-alone thing when I'm done with the results section. I will put those codes in this repo first so all of us can play with them and make sure we like the
results.

Organization: 

- Krylov_QMC.tex is the paper. It will have the abstract, conclusions, and our names and addresses. This main file uses LaTeX's \input command to include the sections

  - intro_Krylov_QMC.tex: __I am not touching this as of Oct 7 and will warn you if I want to. Feel free to put stuff in here.__
  - results_Krylov_QMC.tex: __I am actively working on this.__
  
- qmckrylov.bib is the BiBTeX file. As you add stuff to it, watch out for duplications.
- local.sty is the place to put our personal LaTeX commands/macros

- makefile I use Unix make to build the file. If you want to do __pdflatex Krylov_QMC__ and __bibtex Krylov_QMC__ that'll work.

- FIGURES is the obvious directory. 

I got the LaTeX style files from ANS and assume that you have __nseJournal.cls__ and __ans_js.bst__
  

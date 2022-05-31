SOURCES = Krylov_QMC.tex intro_Krylov_QMC.tex results_Krylov_QMC.tex
PROGRAM = Krylov_QMC
DVIFILE = $(PROGRAM).dvi
BIB  = qmckrylov.bib
PDF = $(PROGRAM).pdf
#
$(PDF): $(SOURCES) $(BIB) 
	pdflatex $(PROGRAM)
pdf:	$(PDF)
view: $(PDF) 
	open $(PDF)
bib: $(PDF)
	bibtex $(PROGRAM); pdflatex $(PROGRAM); pdflatex $(PROGRAM); 

DOC = C07_Paginacion_MMU
TEX = pdflatex -shell-escape -interaction=nonstopmode -file-line-error

.PHONY: all clean remove

all : $(DOC).pdf

$(DOC).pdf : $(DOC).tex
	make -C img/
	$(TEX) $(DOC).tex

clean:
	rm -f *.aux *.log *.nav *.out *.toc *.vrb *.snm *.synctex.gz

remove:
	make clean
	make -C img/ clean
	rm -f $(DOC).pdf

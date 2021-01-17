DOC = A02_Hola_mundo_y_gdb
TEX = pdflatex -shell-escape -interaction=nonstopmode -file-line-error

.PHONY: all clean remove

all : $(DOC).pdf

$(DOC).pdf : $(DOC).tex
	$(TEX) $(DOC).tex

clean:
	rm -f *.aux *.log *.nav *.out *.toc *.vrb *.snm *.synctex.gz

remove:
	make clean
	rm -f $(DOC).pdf

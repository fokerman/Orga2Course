.PHONY: all clean cleanall

SOURCES := $(shell find `pwd` -name '*.tex')
OUTPUT := $(SOURCES:%.tex=%.pdf)
NAME := $(shell pwd | grep -o '[^/]*$$')

TEX = pdflatex -shell-escape -interaction=nonstopmode -file-line-error

all: $(OUTPUT)

%.pdf: %.tex
ifneq (,$(wildcard ./img/Makefile))
	make -C img
endif
	cat $< > $(NAME).tex
	pdflatex $(NAME).tex #> /dev/null
	pdflatex $(NAME).tex #> /dev/null
	rm $(NAME).tex
	sed 's/\[aspectratio=169]/\[aspectratio=169, handout\]/g' $< > $(NAME)_handout.tex
	pdflatex $(NAME)_handout.tex #> /dev/null
	pdflatex $(NAME)_handout.tex #> /dev/null
	rm $(NAME)_handout.tex
	rm -f *.aux *.log *.nav *.out *.snm *.toc *.vrb *.synctex.gz

clean:
	rm -f *.aux *.log *.nav *.out *.snm *.toc *.vrb *.synctex.gz

cleanall:
ifneq (,$(wildcard ./img/Makefile))
	make -C img clean
endif
	rm -f $(OUTPUT) $(NAME)_handout.pdf $(NAME).pdf
	rm -f *.aux *.log *.nav *.out *.snm *.toc *.vrb *.synctex.gz

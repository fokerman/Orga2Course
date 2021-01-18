# EL MAKEFILE DE SVG QUE MAKEFILEA A TODOS LOS MAKEFILES DE SVG QUE EXISTAN!
# Este makefile esta preparado para la version 0.92.4 de inkscape. Si usas una
# version mas nueva o mas vieja los nombres de los comandos de consola cambian
# Todos los svg seran convertidos a pdf, si el svg contiene capas, estas seran
# convertidas en archivos pdf distintos, indicadas por el id de la capa.
# Ademas, si hay archivos dentro de una carpeta especial denominada RECURSOS
# estos no seran convertidos a svg.

SOURCES := $(shell find `pwd` -name '*.svg' | grep -v RECURSOS)
OUTPUT := $(SOURCES:%.svg=%.pdf)
RMOUTPUT := $(SOURCES:%.svg=%*.pdf)

inkscapeVersion := $(shell inkscape --version | awk '{print $$2}')

all: $(OUTPUT) figures

figures: graph.py
	python3 graph.py

%.pdf: %.svg
ifeq ($(inkscapeVersion),0.92.5)
	@if [ $$(inkscape --query-all $< | grep layer | wc -l ) = 1 ] ;\
	then \
	echo "(1) $@" ;\
		inkscape $< --without-gui --export-plain-svg=$$(pwd)/$$(basename $< .svg)-plain.svg ;\
		inkscape $$(pwd)/$$(basename $< .svg)-plain.svg --without-gui --export-pdf=$$(pwd)/$$(basename $< .svg).pdf ;\
		rm $$(pwd)/$$(basename $< .svg)-plain.svg ;\
	else \
	echo "(n) $@" ;\
		for i in $$(inkscape --query-all $< | grep layer | awk -F, '{print $$1}') ;\
		do \
		inkscape $< -jC -i $$i --without-gui --export-plain-svg=$$(pwd)/$$(basename $< .svg)-$$i.svg ;\
		inkscape $$(pwd)/$$(basename $< .svg)-$$i.svg --without-gui --export-pdf=$$(pwd)/$$(basename $< .svg)-$$i.pdf ;\
		rm $$(pwd)/$$(basename $< .svg)-$$i.svg ;\
		done ;\
		cp $$(pwd)/$$(basename $< .svg)-layer1.pdf $$(pwd)/$$(basename $< .svg).pdf ;\
	fi
endif
ifeq ($(inkscapeVersion),1.0.1)
	@if [ $$(inkscape --query-all $< | grep layer | wc -l ) = 1 ] ;\
	then \
	echo "(1) $@" ;\
		inkscape $< --export-plain-svg --export-filename=$$(pwd)/$$(basename $< .svg)-plain.svg ;\
		inkscape $$(pwd)/$$(basename $< .svg)-plain.svg --export-filename=$$(pwd)/$$(basename $< .svg).pdf ;\
		rm $$(pwd)/$$(basename $< .svg)-plain.svg ;\
	else \
	echo "(n) $@" ;\
		for i in $$(inkscape --query-all $< | grep layer | awk -F, '{print $$1}') ;\
		do \
		inkscape $< -jC -i $$i --export-plain-svg --export-filename=$$(pwd)/$$(basename $< .svg)-$$i.svg ;\
		inkscape $$(pwd)/$$(basename $< .svg)-$$i.svg --export-filename=$$(pwd)/$$(basename $< .svg)-$$i.pdf ;\
		rm $$(pwd)/$$(basename $< .svg)-$$i.svg ;\
		done ;\
		cp $$(pwd)/$$(basename $< .svg)-layer1.pdf $$(pwd)/$$(basename $< .svg).pdf ;\
	fi
else
		echo "Inkscape version does not supported"
endif
	
clean:
	rm -f $(RMOUTPUT)
	rm -f fig1A.pdf
	rm -f fig1B.pdf
	rm -f fig1C.pdf
	rm -f fig2A.pdf
	rm -f fig2B.pdf
	rm -f fig3A.pdf
	rm -f fig3B.pdf
	rm -f fig4A.pdf
	rm -f fig4B.pdf
	rm -f fig4C.pdf
	rm -f fig5A.pdf
	rm -f fig5B.pdf


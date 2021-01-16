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

all: $(OUTPUT)

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
else
		echo "Inkscape version does not supported"
endif
	
clean:
	rm -f $(RMOUTPUT)

	
	
# mkdir -p pdf
# 
# for i in $(ls *.svg -1)
# do
#     inkscape --file=$i --export-area-page --without-gui --export-pdf=pdf/$(basename $i .svg).pdf
# done

# SOURCES := $(shell find . -name '*.svg' | grep -v recursos)
# OUTPUT := $(SOURCES:%.svg=%.pdf)
# all: $(OUTPUT)
# 	echo $(OUTPUT)
# 	echo $(SOURCES)
# %.pdf: %.svg
# 	inkscape $< --export-area-page --without-gui --export-file=$@
# 	
# clean:
# 	rm -f $(OUTPUT)

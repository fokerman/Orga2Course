.PHONY: all cleanall

all:
	make -C A01_Preliminares
	make -C A02_Hola_mundo_y_gdb
	make -C A03_Pila_y_Convencion_C
	make -C A04_Punteros_Vectores_y_Matrices
	make -C A05_Memoria_Dinamica
	make -C A06_Estructuras_Recursivas_listas_y_arboles
	make -C B01_SIMD_Saturacion_Empaquetado_Extension_Mascaras
	make -C B02_SIMD_Conversiones_Shuffle_Blend
	make -C B03_Experimentacion_muestreo_y_analisis
	make -C C01_Introduccion_Bochs
	make -C C02_Modo_Protegido
	make -C C03_Interrupciones_basicas
	make -C C04_Interrupciones_externas
	make -C C05_Paginacion_IdentityMapping
	make -C C06_Conmutacion_basica_de_tareas
	make -C C07_Paginacion_MMU
	make -C C08_Scheduler_de_tareas
	make -C C09_Proteccion

 cleanall:
	make -C A01_Preliminares cleanall
	make -C A02_Hola_mundo_y_gdb cleanall
	make -C A03_Pila_y_Convencion_C cleanall
	make -C A04_Punteros_Vectores_y_Matrices cleanall
	make -C A05_Memoria_Dinamica cleanall
	make -C A06_Estructuras_Recursivas_listas_y_arboles cleanall
	make -C B01_SIMD_Saturacion_Empaquetado_Extension_Mascaras cleanall
	make -C B02_SIMD_Conversiones_Shuffle_Blend cleanall
	make -C B03_Experimentacion_muestreo_y_analisis cleanall
	make -C C01_Introduccion_Bochs cleanall
	make -C C02_Modo_Protegido cleanall
	make -C C03_Interrupciones_basicas cleanall
	make -C C04_Interrupciones_externas cleanall
	make -C C05_Paginacion_IdentityMapping cleanall
	make -C C06_Conmutacion_basica_de_tareas cleanall
	make -C C07_Paginacion_MMU cleanall
	make -C C08_Scheduler_de_tareas cleanall
	make -C C09_Proteccion cleanall


; En mac, las llamadas a funcion llevan _ adelante
; global _borrarUltimo
; global _agregarPrimero
; extern _free
; extern _malloc

global borrarUltimo
global agregarPrimero
extern free
extern malloc

%define NULL 0
; Definir los offsets para nodo
%define nodo_offset_dato 0
%define nodo_offset_prox 8
; Definir los offsets para lista
%define lista_offset_primero 0
; Definir el tamaño de los nodos
%define tam_nodo 16

; Recibo por RDI un puntero a la estructura lista
borrarUltimo:
	; Armo stackframe
	; Recordar! Si modifico rbx, r12, r13, r14 o r15 debo pushearlos
	; Alinear pila si está desalineada

	push rbp
	mov rbp, rsp
	push rbx
	push r12

	; Me fijo si la lista tiene algun elemento en proximo
	; salto al fin si no hay ninguno
	cmp qword[rdi + lista_offset_primero], NULL
	je fin_borrar

	; Vamos a buscar al ultimo
	; rbx va a tener siempre la direccion de memoria al proximo nodo
	mov rbx, [rdi + lista_offset_primero]
	; r12 va a tener siempre la direccion de memoria que apunta al puntero
	; que tiene la direccion de memoria al proximo nodo
	lea r12, [rdi + lista_offset_primero]
	; Con rbx y r12 nos aseguramos de que tengamos siempre acceso al proximo nodo y 
	; acceso al puntero que apunta al mismo para poder cambiarlo

	ciclo:
		; Me fijo si el nodo donde estoy apuntando con rbx es el ultimo
		; Para eso, me fijo si el puntero al proximo nodo en NULL
		cmp qword[rbx + nodo_offset_prox], NULL
		je borrado
		; No estamos parados en el ultimo elemento
		; Consigo la direccion de memoria al proximo nodo
		lea r12, [rbx + nodo_offset_prox]
		mov rbx, [r12]

	borrado:
		; Pongo en RDI la direccion del ultimo nodo
		mov rdi, rbx
		; Llamo a free para borrar el ultimo nodo
		call free
		; Pongo en el puntero que apuntaba al ultimo nodo un NULL
		mov qword[r12], NULL

fin_borrar:
	pop rbx
	pop r12
	pop rbp
	ret

; Recibo por RDI un puntero a la estructura lista
; Recibo por RSI el dato, un entero (4 bytes), cuidado al copiar datos!
agregarPrimero:
	; Armo stackframe
	; Recordar! Si modifico rbx, r12, r13, r14 o r15 debo pushearlos
	; Alinear pila si está desalineada

	push rbp
	mov rbp, rsp
	push rbx
	push r12

	; Guardo el puntero a la lista porque voy a necesitar rdi
	mov rbx, rdi

	; Guardo el dato a meter en el nodo
	mov r12d, esi

	; Pongo en rdi el tamanio del nodo como unico parametro
	mov rdi, tam_nodo

	; LLamo a malloc para que me devuelva en rax el puntero a la memoria que pedimos
	call malloc

	; Importante! comparar siepre si malloc no devolvio NULL
	cmp rax, NULL
	je fin_agregar

	; Copio el dato a nuestro nuevo nodo
	mov [rax + nodo_offset_dato], r12d

	; Consigo en r12 el puntero al primer nodo anterior
	mov r12, [rbx + lista_offset_primero]

	; Apunto el nuevo nodo al primer nodo anterior
	mov [rax + nodo_offset_prox], r12

	; Hago que nuestra lista apunte a nuestro nuevo nodo
	mov [rbx + lista_offset_primero], rax

fin_agregar:
	pop r12
	pop rbx
	pop rbp
	ret
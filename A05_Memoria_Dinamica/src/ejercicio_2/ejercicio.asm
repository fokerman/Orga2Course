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

; Definir los offsets para lista

; Definir el tamaño de un nodo para malloc


; Recibo por RDI un puntero a la estructura lista
borrarUltimo:
	; Armo stackframe
	; Recordar! Si modifico rbx, r12, r13, r14 o r15 debo pushearlos
	; Alinear pila si está desalineada


; Recibo por RDI un puntero a la estructura lista
; Recibo por RSI el dato, un entero (4 bytes), cuidado al copiar datos!
agregarPrimero:
	; Armo stackframe
	; Recordar! Si modifico rbx, r12, r13, r14 o r15 debo pushearlos
	; Alinear pila si está desalineada

	push rbp
	mov rbp, rsp

	pop rbp
	ret

%define NULL 0
; Completar!
%define offset_comision 0
; Completar!
%define offset_nombre 8
; Completar!
%define offset_edad 12

extern printf

global mostrarAlumno

section .data
	texto: db "Nombre: %s, comision: %d, edad: %d", 0x0a, 0x00

section .text

; Me llega por RDI el PUNTERO a la estructura
mostrarAlumno:
	push rbp
	mov rbp, rsp
	; Pila alineada

	; Poner los elementos del struct en los registros necesarios
	; y llamar a printf

	mov rax, rdi
	mov rdi, texto
	mov rsi, [rdi + offset_nombre]
	mov rdx, [rdi + offset_comision]
	mov rcx, [rdi + offset_edad]

	call printf

	; Desencolo
	pop rbp
	ret
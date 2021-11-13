%define NULL 0
; Completar!
%define offset_comision 0
; Completar!
%define offset_nombre 0
; Completar!
%define offset_edad 0

; En mac, las funciones llevan un _ adelante
; En caso de mac, _printf
extern printf

; En caso de mac, global _mostrarAlumno
global mostrarAlumno

section .data
	texto: db "Nombre: %s, comision: %d, edad: %d", 0x0a, 0x00

section .text

; En caso de mac, _mostrarAlumno
; Me llega por RDI el PUNTERO a la estructura
mostrarAlumno:
	push rbp
	mov rbp, rsp
	; Pila alineada
	; Recordar pushear RBX, R12, R13, R14 y R15 si se utilizan



	; Desencolo
	pop rbp
	ret

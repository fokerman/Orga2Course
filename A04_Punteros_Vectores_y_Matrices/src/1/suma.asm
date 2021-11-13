global suma

%define tam_short 2

section .text

    suma:
        push rbx
;short suma(short* vector, short n);

;RAX <- resultado
;RDI <- vector
;SI  <- n

        mov rax, 0
        mov rbx, 0
    ciclo:
            cmp si, bx
            je fin

            add ax, [rdi + rbx*tam_short]
            inc bx

            jmp ciclo

    fin:
        pop rbx
        ret
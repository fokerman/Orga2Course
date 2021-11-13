global diagonal

%define tam_short 2

section .text

diagonal:
    ; rdi <-- matriz
    ; rsi <-- largo de filas (y columnas)
    ; rdx <-- vector

    ; asumimos que la matriz tiene al menos un elemento

    ; limpio parte alta de rsi para que rsi tenga el valor de si
    shl rsi, 48
    shr rsi, 48

    lea r8, [rsi*tam_short + tam_short]; incremento fijo para acceder a la diagonal
    mov rcx, 0; contador para el ciclo

    ; en el ciclo, en rdi va a estar mi puntero a la diagonal de la matriz
    ; y en rdx mi puntero al vector que me piden llenar
    .ciclo:
        ; muevo el actual elemento de la diagonal al vector usando a ax como auxiliar
        mov ax, [rdi]
        mov [rdx], ax

        ; incremento mis punteros
        add rdi, r8
        add rdx, tam_short

        ; incremento el contador y evalúo si el ciclo sigue o no
        inc rcx
        cmp rcx, rsi
        jne .ciclo
    ret

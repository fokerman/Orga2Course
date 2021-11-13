; // == Suma Dos == 
; // Dado un vector de $n$ enteros con signo de 16 bits. Incrementa en 2 unidades cada uno y almacena el resultado en un vector de 32 bits ($n \equiv 0$ $(mod\ 8)$)
; extern void suma2(int16_t *vector, int32_t *resultado, uint8_t n);

; // == Suma Tres ==
; // Dado un vector de $n$ enteros con signo de 16 bits. Incrementa en 3 unidades cada uno y almacena el resultado en el mismo vector de forma saturada ($n \equiv 0$ $(mod\ 8)$)
; extern void suma3(int16_t *vector, uint8_t n);

; // == Incrementar Brillo ==
; // Dado una imagen 128x128 pixeles de un byte en escala de grises. Incrementar el brillo de la misma en 10 unidades.
; extern void incrementarBrillo10(uint8_t *imagen);

; // == Normalizar Vector ==
; // Dado un vector de 128 valores positivos en punto flotante de 32 bits. Normalizar los mismos y almacenar el resultado en el mismo vector.
; extern void normalizar(float *vector);

; // == Suma pares ==
; // Dado un vector de 128 enteros con signo de 16 bits. Sumar todos los valores pares y retornar el resultado de la suma en 32 bits.
; extern int32_t sumarPares(int16_t *v);

; // == Multiplicar vectores
; // Dado dos vectores de 128 enteros con signo de 16 bits. Multiplicar cada uno de ellos entre si y almacenar el resultado en un vector de enteros de 32 bits.
; extern void mulvec(int16_t *v1, int16_t *v2, int32_t *resultado);

; // == Efecto Blur ==
; // Aplicar un kernel de $3 \times 3$ \verb|[[1,2,1],[2,4,2],[1,2,1]] / 16| sobre cada pixel de una imagen de $34 \times 34$ de valores de 8 bits. 
; extern void blur(uint8_t *imgDst, uint8_t *imgSrc);

global suma1
global suma2
global suma3
global incrementarBrillo10
global normalizar
global sumar4pares
global mulvec
global blur

section .rodata
uno: times 8 dw 1
dos: times 4 dd 2
tres: times 8 dw 3
diez: times 16 db 10

section .text

suma1: ; rdi = vector, rsi = resultado, dx = n
  push rbp
  mov rbp,rsp
  movzx rcx, dx
  shr ecx, 3 ; divido por 8
  movdqu xmm8, [uno]
  .ciclo:
    movdqu xmm0, [rdi]  ; xmm0 = | d7 | d6 | d5 | d4 | d3 | d2 | d1 | d0 |
    paddw  xmm0, xmm8   ; xmm0 = | d7+1 | d6+1 | d5+1 | d4+1 | d3+1 | d2+1 | d1+1 | d0+1 |
    movdqu [rsi], xmm0
    add rdi, 16
    add rsi, 16
  loop .ciclo
  pop rbp
ret 

suma2: ; rdi = vector, rsi = resultado, dx = n
  push rbp
  mov rbp,rsp
  movzx rcx, dx
  shr ecx, 2 ; divido por 4
  movdqu xmm8, [dos]
  .ciclo:
    pmovsxwd xmm0, [rdi]  ; xmm0 = | d3 | d2 | d1 | d0 |
    paddd  xmm0, xmm8     ; xmm0 = | d3+2 | d2+2 | d1+2 | d0+2 |
    movdqu [rsi], xmm0
    add rdi, 8
    add rsi, 16
  loop .ciclo
  pop rbp
ret 

suma3: ; rdi = vector, rsi = n
  push rbp
  mov rbp,rsp
  movzx rcx, si
  shr ecx, 3 ; divido por 8
  movdqu xmm8, [tres]
  .ciclo:
    movdqu xmm0, [rdi]  ; xmm0 = | d7 | d6 | d5 | d4 | d3 | d2 | d1 | d0 |
    paddsw xmm0, xmm8   ; xmm0 = |d7+3|d6+3|d5+3|d4+3|d3+3|d2+3|d1+3|d0+3|
    movdqu [rdi], xmm0
    add rdi, 16
  loop .ciclo
  pop rbp
ret

incrementarBrillo10: ; rdi = imagen
  push rbp
  mov rbp,rsp
  mov rcx, (32*32 >> 4)
  movdqu xmm8, [diez]
  .ciclo:
    movdqu xmm0, [rdi]  ; xmm0 = | d15 | ... | d0 |
    paddusb xmm0, xmm8  ; xmm0 = | d15+10 | ... | d0+10 |
    movdqu [rdi], xmm0
    add rdi, 16
  loop .ciclo
  pop rbp
ret

normalizar: ; rdi = float *vector
  push rbp
  mov rbp,rsp
  ; (1) find max
  mov rdx, rdi
  mov rcx, (128 >> 2)
  movaps xmm1, [rdx]
  .cicloMax:
    movaps xmm0, [rdx]
    maxps xmm1, xmm0
    add rdx, 16
  loop .cicloMax
  movdqu xmm0, xmm1
  psrldq xmm0, 8
  maxps xmm1, xmm0
  movdqu xmm0, xmm1
  psrldq xmm0, 4
  maxps xmm1, xmm0
  ; (2) broadcast max
  pslldq xmm1, 12   ; xmm1 = |AA|00|00|00|
  movdqu xmm0, xmm1 ; xmm0 = |AA|00|00|00|
  psrldq xmm1, 4    ; xmm1 = |00|AA|00|00|
  por    xmm1, xmm0 ; xmm1 = |AA|AA|00|00|
  movdqu xmm0, xmm1 ; xmm0 = |AA|AA|00|00|
  psrldq xmm1, 8    ; xmm1 = |00|00|AA|AA|
  por    xmm1, xmm0 ; xmm1 = |AA|AA|AA|AA|
  ; (3) find min
  mov rdx, rdi
  mov rcx, (128 >> 2)
  movaps xmm2, [rdx]
  .cicloMin:
    movaps xmm0, [rdx]
    minps xmm2, xmm0
    add rdx, 16
  loop .cicloMin
  movdqu xmm0, xmm2
  psrldq xmm0, 8
  minps xmm2, xmm0
  movdqu xmm0, xmm2
  psrldq xmm0, 4
  minps xmm2, xmm0
  ; (2) broadcast min
  pslldq xmm2, 12   ; xmm2 = |AA|00|00|00|
  movdqu xmm0, xmm2 ; xmm0 = |AA|00|00|00|
  psrldq xmm2, 4    ; xmm2 = |00|AA|00|00|
  por    xmm2, xmm0 ; xmm2 = |AA|AA|00|00|
  movdqu xmm0, xmm2 ; xmm0 = |AA|AA|00|00|
  psrldq xmm2, 8    ; xmm2 = |00|00|AA|AA|
  por    xmm2, xmm0 ; xmm2 = |AA|AA|AA|AA|
  ; (3) normalizacion
  a:
  subps xmm1, xmm2
  mov rdx, rdi
  mov rcx, (128 >> 2)
  .ciclo:
    movaps xmm0, [rdx]
    divps xmm0, xmm1
    movaps [rdx], xmm0
    add rdx, 16
  loop .ciclo
  pop rbp
ret

sumarPares: ; rdi = int16_t *v
  push rbp
  mov rbp,rsp
  mov rcx, (128 >> 2)
  pxor xmm8, xmm8
  .ciclo:
    pmovsxwd xmm0, [rdi]
    pabsd xmm1, xmm0
    pslld  xmm1, 31
    psrad  xmm1, 31
    pandn  xmm1, xmm0
    paddd  xmm8, xmm1
    add rdi, 8
  loop .ciclo
  phaddd xmm8, xmm8
  phaddd xmm8, xmm8
  movd eax, xmm8
  pop rbp
ret

mulvec: ; rdi = int16_t *v1, rsi = int16_t *v2, rdx = int32_t *resultado
  push rbp
  mov rbp,rsp
  mov rcx, (128 >> 3)
  .ciclo:
    movdqa xmm0, [rdi]    ; xmm0 = |a7|a6|a5|a4|a3|a2|a1|a0|
    movdqa xmm1, [rsi]    ; xmm1 = |b7|b6|b5|b4|b3|b2|b1|b0|
    movdqa xmm2, xmm0     ; xmm2 = |a7|a6|a5|a4|a3|a2|a1|a0|
    pmulhw xmm2, xmm1     ; xmm2 = | hi(a7*b7)... hi(a0*b0)|
    pmullw xmm0, xmm1     ; xmm0 = |low(a7*b7)...low(a0*b0)|
    movdqa xmm1, xmm0     ; xmm1 = |low(a7*b7)...low(a0*b0)|
    punpcklwd xmm0, xmm2  ; xmm0 = |hi:low(a3*b3)...hi:low(0a*b0)|
    punpckhwd xmm1, xmm2  ; xmm1 = |hi:low(a7*b7)...hi:low(a4*b4)|
    movdqa [rdx], xmm0
    movdqa [rdx+16], xmm1
    add rdx, 32
    add rdi, 16
    add rsi, 16
  loop .ciclo
  pop rbp
ret

blur: ; rdi = uint8_t *imgDst, rsi = uint8_t *imgSrc
  push rbp
  mov rbp,rsp
  mov rdx, 32
  lea rsi, [rsi+34+1]
  .cicloFilas:
    mov rcx, 32 >> 3
      .cicloColumnas:
        pxor xmm0, xmm0
        ; 1*A 2*D 1*G
        ; 2*B 4*E 2*H
        ; 1*C 2*F 1*I
        pmovzxbw xmm1, [rsi-1+34] ; xmm1 = A
        pmovzxbw xmm2, [rsi-1]    ; xmm2 = B
        pmovzxbw xmm3, [rsi-1-34] ; xmm3 = C
        psllw xmm2, 1             ; xmm2 = 2*B
        paddw xmm0, xmm1
        paddw xmm0, xmm2
        paddw xmm0, xmm3

        pmovzxbw xmm1, [rsi+34]   ; xmm1 = D
        pmovzxbw xmm2, [rsi]      ; xmm2 = E
        pmovzxbw xmm3, [rsi-34]   ; xmm3 = F
        psllw xmm1, 1             ; xmm1 = 2*D
        psllw xmm2, 2             ; xmm2 = 4*E
        psllw xmm3, 1             ; xmm3 = 2*F
        paddw xmm0, xmm1
        paddw xmm0, xmm2
        paddw xmm0, xmm3

        pmovzxbw xmm1, [rsi+1+34] ; xmm1 = G
        pmovzxbw xmm2, [rsi+1]    ; xmm2 = H
        pmovzxbw xmm3, [rsi+1-34] ; xmm3 = I
        psllw xmm2, 1             ; xmm2 = 2*H
        paddw xmm0, xmm1
        paddw xmm0, xmm2
        paddw xmm0, xmm3

        psrlw xmm0, 4
        packuswb xmm0, xmm0

        movq [rdi], xmm0
        add rdi, 8
        add rsi, 8

      dec rcx
      cmp rcx, 0
      jnz .cicloColumnas
      lea rsi, [rsi+2]

  dec rdx
  cmp rdx, 0
  jnz .cicloFilas

  pop rbp
ret

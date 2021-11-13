; double ej2(float* a);

global ej2

section .rodata
transform5a4: db 0x00,0x01,0x02,0xFF,0x03,0x04,0x05,0xFF,0x06,0x07,0x08,0xFF,0x09,0x0A,0x0B,0xFF
transform5a1: db 0x0C,0x0D,0x0E,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF

section .text

ej2: ; rdi = a, esi = n;
  push rbp
  mov rbp,rsp
  movdqu xmm8, [transform5a4]
  movdqu xmm9, [transform5a1]
  movdqu xmm0, [rdi]         ; xmm0 = |_|xxx|xxx|xxx|xxx|xxx|
  movdqu xmm1, xmm0          ; xmm1 = |_|xxx|xxx|xxx|xxx|xxx|
  movdqu xmm2, [rdi+10*3-16] ; xmm2 = |yyy|yyy|yyy|yyy|yyy|_|
  psrldq xmm2, 1             ; xmm2 = |_|yyy|yyy|yyy|yyy|yyy|
  movdqu xmm3, xmm2          ; xmm3 = |_|yyy|yyy|yyy|yyy|yyy|
  pshufb xmm0, xmm8          ; xmm0 = |0xxx|0xxx|0xxx|0xxx| (*)
  pshufb xmm1, xmm9          ; xmm1 = |0000|0000|0000|0xxx|
  pshufb xmm2, xmm8          ; xmm2 = |0yyy|0yyy|0yyy|0yyy|
  pshufb xmm3, xmm9          ; xmm3 = |0000|0000|0000|0yyy|
  paddd  xmm0, xmm1          ; xmm0 = |0xxx|0xxx|0xxx|0xxx+0xxx|
  paddd  xmm2, xmm3          ; xmm2 = |0yyy|0yyy|0yyy|0yyy+0yyy|

  paddd  xmm0, xmm2          ; xmm0 = |  S3 |  S2 |  S1 |  S0 |
  pshufd xmm1, xmm0, 1110b   ; xmm1 = |-----|-----|  S3 |  S2 |
  paddd  xmm0, xmm1          ; xmm0 = |-----|-----|S1+S3|S0+S2|
  pshufd xmm1, xmm0, 0001b   ; xmm1 = |-----|-----|-----|S1+S3|
  paddd  xmm0, xmm1          ; xmm0 = |-----|-----|-----|S0+S1+S2+S3|

;  phaddd xmm0, xmm2          ; xmm0 = |0xxx+0xxx|0xxx+0xxx+0xxx|0yyy+0yyy|0yyy+0yyy+0yyy|
;  phaddd xmm0, xmm0          ; xmm0 = |_|_|0xxx+0xxx+0xxx+0xxx+0xxx|0yyy+0yyy+0yyy+0yyy+0yyy|
;  phaddd xmm0, xmm0          ; xmm0 = |_|_|_|0xxx+0xxx+0xxx+0xxx+0xxx+0yyy+0yyy+0yyy+0yyy+0yyy|

  cvtdq2pd xmm0, xmm0        ; xmm0 = |_|double(0xxx+0xxx+0xxx+0xxx+0xxx+0yyy+0yyy+0yyy+0yyy+0yyy)|
  pop rbp
ret

; (*) aca estoy dibujando los numeros como se verian en normal, es decir el cero en la parte menos significativa.

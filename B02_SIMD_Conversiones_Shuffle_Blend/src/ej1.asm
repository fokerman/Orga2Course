; void ej1(float* a, int n);

global ej1

section .rodata
val0703: dq 0.7, 0.3
val255:  dq 255.0, 255.0

section .text

ej1: ; rdi = a, esi = n;
  push rbp
  mov rbp,rsp
  mov ecx, esi
  shr ecx, 2
  movdqu xmm8, [val0703]
  movdqu xmm9, [val255]
  .ciclo:
    movdqu xmm0, [rdi]  ; xmm0 = | fp3 | fp2 | fp1 | fp0 |
    cvtPS2PD xmm1, xmm0 ; xmm1 = |    fp1    |    fp0    |
    psrldq xmm0, 8      ; xmm0 = |  0     0  | fp3 | fp2 |
    cvtPS2PD xmm2, xmm0 ; xmm2 = |    fp3    |    fp2    |
    mulpd xmm1, xmm8    ; xmm1 = | 0.3 * fp1 | 0.7 * fp0 |
    mulpd xmm2, xmm8    ; xmm2 = | 0.3 * fp3 | 0.7 * fp2 |

    movdqu xmm3, xmm1
    shufpd xmm3, xmm2, 1  ; XMM3 = pd2*0.7|pd1*0.3
    shufpd xmm1, xmm2, 2  ; XMM1 = pd3*0.3|pd0*0.7
    addpd xmm1, xmm3      ; XMM1 = pd2*0.7+pd3*0.3|pd0*0.7+pd1*0.3

;    haddpd xmm1, xmm2   ; xmm1 = | 0.3*fp3+0.7*fp2 | 0.3*fp1+0.7*fp0 |
    sqrtpd xmm1, xmm1   ; xmm1 = | sqrt(0.3*fp3+0.7*fp2) | sqrt(0.3*fp1+0.7*fp0) |
    mulpd xmm1, xmm9    ; xmm1 = | 255*sqrt(0.3*fp3+0.7*fp2 | 255*sqrt(0.3*fp1+0.7*fp0) |
    movdqu [rdi], xmm1
    add rdi, 16
  loop .ciclo
  pop rbp
ret 

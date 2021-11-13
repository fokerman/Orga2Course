; double* ej3(int* a, int n);
extern malloc

global ej3

section .rodata
bigendian: db 0x03,0x02,0x01,0x00,0x0B,0x0A,0x09,0x08,0x07,0x06,0x05,0x04,0x0F,0x0E,0x0D,0x0C

section .text

ej3: ; rdi = a, esi = n;
  push rbp
  mov rbp,rsp
  push r12
  push rbx
  mov r12, rdi  ; salvo puntero
  mov ebx, esi  ; salvo y limpio cantidad
  lea rdi, [rbx*8] ; armo el parametro para malloc 
  call malloc
  mov ecx, ebx   ; contador de iteraciones n
  shr ecx, 2     ; contador de iteraciones n/4
  mov rdx, rax         ; en rdx contador de primeros
  lea rbx, [rax+rbx*4] ; en rbx contador de segundos
  movdqu xmm8, [bigendian]
  .ciclo:
      movdqu xmm0, [r12]  ; xmm0 = | int3BIG | int2BIG | int1BIG | int0BIG |
      pshufb xmm0, xmm8   ; xmm0 = | int3 | int1 | int2 | int0 |
      cvtdq2pd xmm1, xmm0 ; xmm1 = |    fp2    |    fp0    |
      psrldq xmm0, 8      ; xmm0 = |  0     0  | fp3 | fp2 |
      cvtdq2pd xmm2, xmm0 ; xmm2 = |    fp3    |    fp1    |
      movdqu [rdx],xmm1
      movdqu [rbx],xmm2
      add r12, 16
      add rdx, 16
      add rbx, 16
  loop .ciclo
  pop rbx
  pop r12
  pop rbp
ret 

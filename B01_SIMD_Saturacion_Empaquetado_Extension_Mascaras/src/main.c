#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#define N 128

// == Suma Dos == 
// Dado un vector de $n$ enteros con signo de 16 bits. Incrementa en 2 unidades cada uno y almacena el resultado en un vector de 32 bits ($n \equiv 0$ $(mod\ 8)$)
extern void suma2(int16_t *vector, int32_t *resultado, uint8_t n);

// == Suma Tres ==
// Dado un vector de $n$ enteros con signo de 16 bits. Incrementa en 3 unidades cada uno y almacena el resultado en el mismo vector de forma saturada ($n \equiv 0$ $(mod\ 8)$)
extern void suma3(int16_t *vector, uint8_t n);

// == Incrementar Brillo ==
// Dado una imagen 128x128 pixeles de un byte en escala de grises. Incrementar el brillo de la misma en 10 unidades.
extern void incrementarBrillo10(uint8_t *imagen);

// == Normalizar Vector ==
; // Dado un vector de 128 valores positivos en punto flotante de 32 bits. Normalizar los mismos y almacenar el resultado en el mismo vector.
extern void normalizar(float *vector);

// == Suma pares ==
// Dado un vector de 128 enteros con signo de 16 bits. Sumar todos los valores pares y retornar el resultado de la suma en 32 bits.
extern int32_t sumarPares(int16_t *v);

// == Multiplicar vectores
// Dado dos vectores de 128 enteros con signo de 16 bits. Multiplicar cada uno de ellos entre si y almacenar el resultado en un vector de enteros de 32 bits.
extern void mulvec(int16_t *v1, int16_t *v2, int32_t *resultado);

// == Efecto Blur ==
// Aplicar un kernel de $3 \times 3$ \verb|[[1,2,1],[2,4,2],[1,2,1]] / 16| sobre cada pixel de una imagen de $34 \times 34$ de valores de 8 bits. 
extern void blur(uint8_t *imgDst, uint8_t *imgSrc);


void* getVector(uint32_t n, uint32_t size) {
   uint32_t count = n*size;
   uint8_t *v = (uint8_t*)malloc(count);
   for(int i = 0; i < count; i++)
      v[i] = rand() % 255;
   return v;
}

float* getVectorFloat(uint32_t n) {
   float *v = (float*)malloc(n*sizeof(float));
   for(int i = 0; i < n; i++)
      v[i] = (float)(rand() % 1024);
   return v;
}

int main(int argc, char* argv[]) {

   {
      printf("== Suma Uno ==\n");
      uint16_t *v = (uint16_t*)getVector(N,sizeof(uint16_t));
      uint16_t *r = (uint16_t*)malloc(N*sizeof(uint16_t));
      printf("Original:\n"); for(int i=0;i<N;i++) printf(" %i",v[i]); printf("\n\n");
      suma1(v, r, N);
      printf("Resultado:\n"); for(int i=0;i<N;i++) printf(" %i",r[i]); printf("\n\n");
      free(v);
      free(r);
   }

   {
      printf("== Suma Dos ==\n");
      int16_t *v = (int16_t*)getVector(N,sizeof(int16_t));
      int32_t *r = (int32_t*)malloc(N*sizeof(int32_t));
      printf("Original:\n"); for(int i=0;i<N;i++) printf(" %i",v[i]); printf("\n\n");
      suma2(v, r, N);
      printf("Resultado:\n"); for(int i=0;i<N;i++) printf(" %i",r[i]); printf("\n\n");
      free(v);
      free(r);
   }

   {
      printf("== Suma Tres ==\n");
      int16_t *v = (int16_t*)getVector(N,sizeof(int16_t));
      v[0] = 32767;
      printf("Original:\n"); for(int i=0;i<N;i++) printf(" %i",v[i]); printf("\n\n");
      suma3(v, N);
      printf("Resultado:\n"); for(int i=0;i<N;i++) printf(" %i",v[i]); printf("\n\n");
      free(v);
   }

   {
      printf("== Incrementar Brillo 10 ==\n");
      uint8_t *img = (uint8_t*)getVector(32*32,sizeof(uint8_t));
      img[0] = 255;
      printf("Original:\n"); for(int i=0;i<32;i++) { for(int j=0;j<32;j++) { printf(" %i",img[i*32+j]); } printf("\n"); } printf("\n\n");
      incrementarBrillo10(img);
      printf("Resultado:\n");  for(int i=0;i<32;i++) { for(int j=0;j<32;j++) { printf(" %i",img[i*32+j]); } printf("\n"); } printf("\n\n");
      free(img);
   }

   {
      printf("== Normalizar Vector ==\n");
      float *v = (float*)getVectorFloat(128);
      printf("Original:\n"); for(int i=0;i<128;i++) printf(" %f",v[i]); printf("\n\n");
      normalizar(v);
      printf("Resultado:\n"); for(int i=0;i<128;i++) printf(" %f",v[i]); printf("\n\n");
      free(v);
   }

   {
      printf("== Suma cuatro pares ==\n");
      int16_t *v = (int16_t*)getVector(128,sizeof(int16_t));
      printf("Original:\n"); for(int i=0;i<128;i++) printf(" %i",v[i]); printf("\n\n");
      int32_t r = sumarPares(v);
      printf("Resultado:\n"); printf(" %i\n\n",r);
      free(v);
   }

   {
      printf("== Multiplicar Vectores ==\n");
      int16_t *v1 = (int16_t*)getVector(128, sizeof(uint16_t));
      int16_t *v2 = (int16_t*)getVector(128, sizeof(uint16_t));
      int32_t *r = (int32_t*)malloc(128*sizeof(int32_t));
      printf("Original V1:\n"); for(int i=0;i<128;i++) printf(" %i",v1[i]); printf("\n\n");
      printf("Original V2:\n"); for(int i=0;i<128;i++) printf(" %i",v2[i]); printf("\n\n");
      mulvec(v1, v2, r);
      printf("Resultado:\n"); for(int i=0;i<128;i++) printf(" %i",r[i]); printf("\n\n");
      free(v1);
      free(v2);
      free(r);
   }

   {
      printf("== Blur ==\n");
      uint8_t *imgSrc = (uint8_t*)getVector(34*34, sizeof(uint8_t));
      uint8_t *imgDst = (uint8_t*)malloc(32*32*sizeof(uint8_t));
      printf("Original:\n");  for(int i=0;i<34;i++) { for(int j=0;j<34;j++) { printf(" %i",imgSrc[i*34+j]); } printf("\n"); } printf("\n\n");
      blur(imgDst, imgSrc);
      printf("Resultado:\n");  for(int i=0;i<32;i++) { for(int j=0;j<32;j++) { printf(" %i",imgDst[i*32+j]); } printf("\n"); } printf("\n\n");
      free(imgSrc);
      free(imgDst);
   }

 return 0;
}

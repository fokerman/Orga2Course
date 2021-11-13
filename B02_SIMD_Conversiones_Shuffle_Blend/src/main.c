#include <stdio.h>
#include <stdlib.h>

#define N 16

extern void    ej1(float* a, int n);
extern double  ej2(char* a);
extern double* ej3(int*   a, int n);

int main(int argc, char* argv[]) {

 {
    printf("== ej1 ==\n");
    int i;
    float f[N];
    for(i=0;i<N;i++) f[i] = (float)(i+1);
    printf("ORIGINAL:"); for(i=0;i<N;i++) printf(" %f",f[i]); printf("\n");
    ej1(f,N);
    double* fd = (double*)(f);
    printf("RESULTADO:"); for(i=0;i<N/2;i++) printf(" %f",fd[i]); printf("\n\n");
 }
 {
    printf("== ej2 ==\n");
    int i, s=0;
    char v[10*3] = {1,0,0, 1,0,0, 1,0,0, 1,0,0, 1,0,0, 1,0,0, 1,0,0, 1,0,0, 1,0,0, 1,0,0,};
    printf("POSTA:"); for(i=0;i<10*3;i++) printf(" %i",v[i]); printf("\n");
    printf("ORIGINAL:"); for(i=0;i<10;i++) { int n = (v[i*3+2]<<16)+(v[i*3+1]<<8)+v[i*3];
      s=s+n; printf(" %i",n); } printf("\n");
    double f = ej2(v);
    printf("RESULTADO:"); printf("%f (%i %f)",f,s,(double)s); printf("\n\n");
 }
 {
    printf("== ej3 ==\n");
    int i;
    int v[N];
    for(i=0;i<N;i++) v[i] = i+1;
    printf("POSTA:"); for(i=0;i<N;i++) printf(" %i",v[i]); printf("\n");
    for(i=0;i<N;i++) {char* g=(char*)v;v[i]=(g[4*i+0]<<24|g[4*i+1]<<16|g[4*i+2]<<8|g[4*i+3]);}
    printf("ORIGINAL:"); for(i=0;i<N;i++) printf(" %i",v[i]); printf("\n");
    double* f = ej3(v,N);
    printf("RESULTADO:"); for(i=0;i<N;i++) printf(" %f",f[i]); printf("\n\n");
    free(f);
 }
 
 return 0;
}

#include <stdio.h>

#define sizeF 4 
#define sizeC 5

extern void obtenerPosicionDelPrimerMaximo(int (*matriz)[sizeC] , int* f, int* c);

void printMatriz(int (*matriz)[sizeC], int f, int c) {
    int i,j;
    for( i=0; i < f; i++ ){
        for( j=0; j < c; j++ )
            printf( "%i ", matriz[i][j] );
        printf("\n");
    }
}

int main(){
    int matriz[sizeF][sizeC] = {{3,1,2,3,4},{5,3,6,7,8},{9,0,3,1,2},{3,4,5,3,6}};
    printMatriz(matriz,sizeF,sizeC);
    int f=sizeF, c=sizeC;
    obtenerPosicionDelPrimerMaximo(matriz,&f,&c);
    printf("Primer maximo en (%i, %i)\n",f,c);
    return 0;
}



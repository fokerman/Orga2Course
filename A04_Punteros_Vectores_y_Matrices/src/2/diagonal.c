#include "stdio.h"

extern void diagonal(short (*matriz)[3], short lado, short d[]);

int main() {

    short a[3][3] = {{1,2,3},{4,5,6},{7,8,9}};
    short d[3];

    printf("Una matriz:\n");
    int i, j;
    for (i = 0; i < 3; i++) {
        for (j = 0; j < 3; j++)
            printf("%d ", a[i][j]);
        printf("\n");
    }

    diagonal(a, 3, d);

    printf("Su diagonal:\n");
    for (i = 0; i < 3; i++)
        printf("%d ", d[i]);
    printf("\n");

    return 0;
}

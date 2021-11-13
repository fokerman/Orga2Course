#include <stdio.h>

extern short suma(short a[], short n);

int main() {
    short a[] = {1,2,3,4,5,6,7,8,9,10};

    printf("Un vector:\n");
    int i;
    for (i = 0; i < 10; i++)
        printf("%d ", a[i]);
    printf("\n");

    short res = suma(a, 10);

    printf("La suma de sus elementos: %d\n", res);
    return 0;
}

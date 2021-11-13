NASMFLAGS = -felf64 -g -F dwarf
CFLAGS=-Wall -Wextra -Wno-unused-parameter -no-pie -pedantic -O0 -ggdb

make:
	nasm $(NASMFLAGS)funcion.asm -o funcion.o
	gcc $(CFLAGS) -o programa programa.c funcion.o

clean:
	rm programa funcion.o

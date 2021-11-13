NASMFLAGS = -felf64 -g -F dwarf
CFLAGS=-Wall -Wextra -Wno-unused-parameter -no-pie -pedantic -O0 -ggdb

all:
	nasm $(NASMFLAGS) diagonal.asm -o diagonal.o
	gcc $(CFLAGS) -o diagonal diagonal.c diagonal.o

clean:
	rm diagonal diagonal.o

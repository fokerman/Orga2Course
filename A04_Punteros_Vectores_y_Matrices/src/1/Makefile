NASMFLAGS = -felf64 -g -F dwarf
CFLAGS=-Wall -Wextra -Wno-unused-parameter -no-pie -pedantic -O0 -ggdb

all:
	nasm $(NASMFLAGS) suma.asm -o suma.o
	gcc $(CFLAGS) -o suma suma.c suma.o

clean:
	rm suma suma.o

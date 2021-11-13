all:
	nasm -f elf64 -g -F dwarf -o ejercicio.o ejercicio.asm
	gcc -o ejercicio -m64 -ggdb main.c  ejercicio.o

mac:
	nasm -f macho64 -g ejercicio.asm -o ejercicio.o
	gcc -c main.c -o main.o
	ld -macosx_version_min 10.10 -lSystem -o ejercicio ejercicio.o main.o

clean:
	rm -f *~ ejercicio *.o
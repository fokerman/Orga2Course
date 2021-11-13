#include <stdio.h>

struct alumno {
    short comision;
    char * nombre;
    int edad;

};

struct alumno nuevo_alumno = {4, "Pepe", 21};

extern void mostrar_alumno(struct alumno * un_alumno);

int main(int argc, char * argv[]) {
    mostrarAlumno(&nuevo_alumno);
    return 0;
}

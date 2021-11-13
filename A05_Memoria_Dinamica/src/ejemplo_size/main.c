
#include <stdio.h>      /* printf, scanf, NULL */
#include <stdlib.h>     /* malloc, free, rand */

struct alumno{
	char* nombre;
	char comision;
	int dni;
};

struct alumno2{
	char comision;
	char* nombre;
	int dni;
};

struct alumno3{
	char* nombre;
	int dni;
	char comision;
} __attribute__((packed));

struct alumno4 { 
	char* nombre;
	short comision;
};

struct alumno5 { 
	short comision;
	char division;
};

enum tipos {
  tipo_auto, tipo_camion
};

int main(){
 
	struct alumno alu;
	struct alumno2 alu2;
	struct alumno3 alu3;

	// Tamaño de tipos básicos
	printf("int\t%d bytes \n", (int) sizeof(int));
	printf("short\t%d bytes \n", (int) sizeof(short));
	printf("char\t%d bytes \n", (int) sizeof(char));
	printf("float\t%d bytes \n", (int) sizeof(float));
	printf("double\t%d bytes \n", (int) sizeof(double));
	printf("\n");
	
	// Tamaño de punteros a tipos de datos
	printf("int*\t%d bytes \n", (int) sizeof(int*));
	printf("short*\t%d bytes \n", (int) sizeof(short*));
	printf("char*\t%d bytes \n", (int) sizeof(char*));
	printf("float*\t%d bytes \n", (int) sizeof(float*));
	printf("double*\t%d bytes \n", (int) sizeof(double*));
	printf("\n");
	
	// Tamaño de enum
	printf("enum tipos\t%d bytes \n", (int) sizeof(enum tipos));
	printf("enum tipos*\t%d bytes \n", (int) sizeof(enum tipos*));
	printf("\n");
	
	// Tamaño de structs
	printf("struct alumno\t%d bytes \n", (int) sizeof(struct alumno));
	printf("struct alumno2\t%d bytes \n", (int) sizeof(struct alumno2));
	printf("struct alumno3\t%d bytes \n", (int) sizeof(struct alumno3));
	printf("struct alumno4\t%d bytes \n", (int) sizeof(struct alumno4));
	printf("struct alumno5\t%d bytes \n", (int) sizeof(struct alumno5));
	printf("\n");
	
	// Tamaño de punteros a structs
	printf("struct alumno*\t%d bytes \n", (int) sizeof(struct alumno*));
	printf("struct alumno2*\t%d bytes \n", (int) sizeof(struct alumno2*));
	printf("struct alumno3*\t%d bytes \n", (int) sizeof(struct alumno3*));
	printf("struct alumno4*\t%d bytes \n", (int) sizeof(struct alumno4*));
	printf("struct alumno5*\t%d bytes \n", (int) sizeof(struct alumno5*));
	printf("\n");

	// Tamaño y offsets del struct alumno
	printf("struct alumno\n");
	printf("OFFSET alumno.nombre\t%d bytes \n", (int)((long long int)(&(alu.nombre)) - (long long int)(&(alu))) );
	printf("OFFSET alumno.comision\t%d bytes \n", (int)((long long int)(&(alu.comision)) - (long long int)(&(alu))) );
	printf("OFFSET alumno.dni\t%d bytes \n", (int)((long long int)(&(alu.dni)) - (long long int)(&(alu))) );
	printf("SIZE struct alumno\t%d bytes \n", (int) sizeof(struct alumno));
	printf("\n");
	
	// Tamaño y offsets del struct alumno2
	printf("struct alumno2\n");
	printf("OFFSET alumno2.comision\t%d bytes \n", (int)((long long int)(&(alu2.comision)) - (long long int)(&(alu2))) );
	printf("OFFSET alumno2.nombre\t%d bytes \n", (int)((long long int)(&(alu2.nombre)) - (long long int)(&(alu2))) );
	printf("OFFSET alumno2.dni\t%d bytes \n", (int)((long long int)(&(alu2.dni)) - (long long int)(&(alu2))) );
	printf("SIZE struct alumno2\t%d bytes \n", (int) sizeof(struct alumno2));
	printf("\n");
	
	// Tamaño y offsets del struct alumno3
	printf("struct alumno3\n");
	printf("OFFSET alumno3.nombre\t%d bytes \n", (int)((long long int)(&(alu3.nombre)) - (long long int)(&(alu3))) );
	printf("OFFSET alumno3.dni\t%d bytes \n", (int)((long long int)(&(alu3.dni)) - (long long int)(&(alu3))) );
	printf("OFFSET alumno3.comision\t%d bytes \n", (int)((long long int)(&(alu3.comision)) - (long long int)(&(alu3))) );
	printf("SIZE struct alumno3\t%d bytes \n", (int) sizeof(struct alumno3));
	
	return 0;
}

# POTENCIAS CON RECURSIVIDID
##### Este código en C++ calcula la potencia de un número utilizando sumas y recursividad en lugar de la multiplicación directa. 
```c++
#include <iostream>
//POTENCIAS CON SUMAS RECURSIVAS.


int multiplicar(int a, int b) {
    if (b == 0) {
    	return 0; 
	} else {
		return a + multiplicar(a, b - 1); 
	}
    
}


//////

int potencia(int bas, int exp){
	
	if (exp==0){
		return 1;
	} else {
		return multiplicar(bas, potencia(bas, exp - 1));
		
	}

	}
////////////	
	


int main(int argc, char** argv) {
	
	int bas;
	int exp;
	int res;
	
	
	printf("Ingrese la base: ");
    scanf("%d", &bas);
    printf("Ingrese el exponente: ");
    scanf("%d", &exp);
    printf("\n\n");
    
    res = potencia(bas, exp);

  	printf("\n\n");
  	printf("%d ^ %d = %d", bas, exp, res);
    
	
	return 0;
}
```
## Descripción General del Código:
* ### Función multiplicar(int a, int b)

###### Implementa la multiplicación de a * b utilizando sumas sucesivas.
 ######     Si b == 0, devuelve 0 (caso base).
 ######     Si b > 0, retorna a + multiplicar(a, b - 1), sumando a repetidamente.
* ### Función potencia(int bas, int exp)

###### Calcula bas^exp usando multiplicaciones sucesivas con la función multiplicar().
###### Caso base: Si exp == 0, devuelve 1.
###### Si exp > 0, retorna multiplicar(bas, potencia(bas, exp - 1)), lo que efectúa la potencia mediante multiplicaciones recursivas.
* ### Función main()

###### Solicita al usuario la base y el exponente.
###### Llama a la función potencia() para calcular el resultado.
###### Muestra en pantalla el resultado de bas^exp.

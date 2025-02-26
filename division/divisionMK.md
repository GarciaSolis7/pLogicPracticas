# DIVISION RECURSIVA 
####
###### Este programa en C++ implementa una división utilizando restas sucesivas y recursividad, sin emplear el operador / ni %. 
###### Además, calcula una aproximación decimal de la división.
###
 ### DESCRIPCION DEL CODIGO
###
* #### Función dividir(int div, int dendo)
###### Realiza la división por restas sucesivas.
###### Caso base: Si el dendo (dividendo) es menor que div (divisor), guarda el resto en una variable global y retorna 0.
###### Caso recursivo: Resta div a dendo y suma 1 al resultado de la siguiente llamada recursiva.
* #### Función main()
###### Solicita al usuario el divisor y el dividendo.
###### Si el divisor es 0, muestra un mensaje de error.
###### Si no, usa la función dividir() para calcular:
###### La parte entera de la división.
###### Multiplica el resto por 10 y lo divide nuevamente para obtener la primera cifra decimal.
###### Imprime el resultado en formato decimal (entero.deci).
###
```c++
#include <iostream>

int resto=0;

int dividir(int div, int dendo){
	int next;
	if(dendo < div){
		resto= dendo;
		return 0;
		
	} else{
		next= dendo - div;
		return (1 + (dividir(div, next)) );
	}
}

int main(int argc, char** argv) {
	
	int divisor;
	int dividendo;
	int den;
	int entero;
	int deci;

	
	
	printf("Ingrese el divisor: ");
    scanf("%d", &divisor);
    printf("Ingrese el dividendo: ");
    scanf("%d", &dividendo);
    printf("\n\n");
    
    if (divisor == 0) {
    printf("NO SE PUEDE DIVIDIR ENTRE 0! ");
  } else {
  	
  	entero = dividir(divisor, dividendo);
  	den= resto *10;
  	
  	deci = dividir(divisor, den);

  	printf("\n\n");
  	printf("%d / %d = %d.%d",dividendo, divisor, entero, deci);
  	
    
  }
    
	
	return 0;
}
````


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

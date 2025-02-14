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



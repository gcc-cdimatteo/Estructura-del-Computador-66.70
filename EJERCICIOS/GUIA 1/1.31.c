#include <stdio.h>

int main(int argc,char** argv){
    float puntoFlotante;

    //Prueba 1:
    printf("PRUEBA 1: \n\n");
    puntoFlotante = 276.2546;
    printf("%f \n",puntoFlotante);

    //--------------------------------

    //Prueba 2:
    printf("\nPRUEBA 2: \n\n");
    puntoFlotante = 0.8;
    printf("%f \n",puntoFlotante);
    if(puntoFlotante < 0.8)
    printf("Es menor \n");
    else if(puntoFlotante == 0.8)
    printf("Es igual \n");
    else
    printf("Es mayor \n");

    //--------------------------------

    //Prueba 3:
    printf("\nPRUEBA 3: \n\n");
    puntoFlotante = 4000.25;
    printf("%f \n",puntoFlotante);
    puntoFlotante += 0.005;
    printf("%f \n",puntoFlotante);

    //--------------------------------
}
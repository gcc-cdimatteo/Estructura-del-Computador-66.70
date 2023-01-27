#include <stdio.h>

int main(){

    for(double iDb=0.0; iDb<2; iDb+=0.1)
    printf("%.15lf \n", iDb);
    printf("\n");
    
    for(float iFt=0.0; iFt<2; iFt+=0.1)
    printf("%.15lf \n", iFt);
    printf("\n");
    
    return 0;

}
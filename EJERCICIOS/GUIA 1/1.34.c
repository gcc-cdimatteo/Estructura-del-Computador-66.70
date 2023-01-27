#include <stdio.h>

int main(){
    for(double iDb=0.0; iDb<3; iDb+=0.25)
    printf("%.15lf \n", iDb);
    printf("\n");

    for(float iFt=0.0; iFt<3; iFt+=0.25)
    printf("%.15lf \n", iFt);
    printf("\n");
    
    return 0;
}
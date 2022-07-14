#include <stdlib.h>
#include <stdio.h>

int main ( void )
{
        int x = 4;
        int * p1x = &x;
        int * p2x = x;
        printf("%X\n%X\n%X\n", x, p1x, p2x);
        printf("%X\n%X\n%X\n", &x, &p1x, &p2x);

        p2x = 5;
        printf("%X\n%X\n%X\n", x, p1x, p2x);
        
        x = 6;
        printf("%X\n%X\n%X\n", x, p1x, p2x);


        return 0;
}

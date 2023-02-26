#include <stdlib.h>
#include <stdio.h>

int main( void )
{
        int a, b;
        int *c, *d;

        a = 5;
        b = 7;

        c = &a;
        d = &b;

        printf("%d %d\n", a, b);
        printf("%d %d\n", *c, *d);

        *c = 4;
        *d = 6;
        printf("%d %d\n", a, b);
        printf("%d %d\n", *c, *d);


        return 0;
}

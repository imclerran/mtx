/******************** tc.s file ********************/
#include <stdio.h>

extern int g;
int h;

extern int getpb();
extern int mysum(int x, int y);

main()
{
    int a,b,c,*bp;
    g = 100;
    *bp = getpb();
    a = 1; b = 2; h = 200;
    c = mysum(a,b);
    printf("a=%d b=%d c=%d\n", a,b,c);
}
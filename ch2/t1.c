/*********************** t1.c file ******************************/
int g = 100;                   // initialized global variable
int h;                         // uninitialized global variable
static int s;                  // static global variable

// Forward declaration of mysum, which is defined in t2.c
extern int mysum(int x, int y);

main(int argc, char *argv[ ])  // main function
{
    int a = 1; int b;
    static int c = 3;
    b = 2;
    c = mysum(a,b);
}
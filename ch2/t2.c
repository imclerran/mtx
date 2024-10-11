/*********************** t2.c file ******************************/
extern int g;                  // extern global variable
int mysum(int x, int y)
{
    return x + y + g;
}
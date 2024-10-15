/****** longjump.c demonstrating long jump in Linux ******/
#include <stdio.h>
#include <setjmp.h>

jmp_buf env; /* for saving longjmp environment */

/* Function prototypes */
void A();
void B();

main()
{
    int r, a = 100;
    printf("call setjmp to save environment\n");
    if ((r = setjmp(env)) == 0)
    {
        A();
        printf("normal return");
    }
    else
        printf("back to main() via long jump, r=%d a=%d\n", r, a);
}
void A()
{
    printf("enter A()\n");
    B();
    printf("exit A()\n");
}
void B()
{
    printf("enter B()\n");
    printf("long jump? (y|n) ");
    if (getchar() == 'y')
        longjmp(env, 1234);
    printf("exit B()\n");
}

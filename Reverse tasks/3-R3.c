#include <stdio.h>
//function M return median of sequence
//program outputs this number on the screen

int M(int a, int b, int c)
{
    if ((a <= b && b <= c) || (c <= b && b <= a)) return b;
    if ((b <= a && a <= c) || (c <= a && a <= b)) return a;
    return c;
}

int main(void)
{
    int a, b, c;
    scanf("%d%d%d", &a, &b, &c);
    printf("%d", M(a, b, c));
    return 0;
}

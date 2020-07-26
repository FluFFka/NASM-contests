#include <stdio.h>
//smallest number of sequence
//"0" ends sequence and isn't included in sequence
//if sequence if empty - 0xffffffff
int main(void)
{
    unsigned a, b = 0xffffffff;
    while (scanf("%u", &a), a) {
        if (a < b) {
            b = a;
        }
    }
    printf("%u", b);
    return 0;
}

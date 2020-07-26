#include <stdio.h>
//swap near bits
//swap couples bits
//swap quadruples bits
//...
//eventually program reverses bit's order
int main(void)
{
    unsigned a;
    scanf("%u", &a);
    unsigned mask[] = {0xffff, 0xff00ff, 0xf0f0f0f, 0x33333333, 0x55555555};
    unsigned sh = 1;
    for (int i = 4; i >= 0; --i) {
        unsigned mask1 = mask[i], mask2 = ~mask[i];
        mask1 &= a;
        mask2 &= a;
        mask1 <<= sh;
        mask2 >>= sh;
        a = mask1 | mask2;
        sh *= 2;
    }
    printf("%u", a);
    return 0;
}

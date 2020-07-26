#include <stdio.h>

#define BUF_SIZE 4095

//program calculate special hash function of string
//function hash generate array (h_ar)
//h_ar don't depends on the input string
//result of function depends on every symbol of input string

unsigned int hash(char *buf)
{
    unsigned edx = 0, eax = 0, j = 0;
    unsigned h_ar[256];
    eax = edx;
    while (edx != 256) {
        if ((eax & 1) == 0) {
            eax >>= 1;
        } else {
            eax >>= 1;
            eax ^= -306674912;
        }
        j++;
        if (j == 8) {
            h_ar[edx] = eax;
            edx++;
            eax = edx;
            j = 0;
        }
    }
    eax = -1;
    unsigned i = 0;
    edx >>= 8;
    edx <<= 8;
    edx |= buf[i];
    while (buf[i] != 0) {
        edx ^= eax;
        i++;
        edx &= 0xff;
        eax >>= 8;
        eax ^= h_ar[edx];
        edx >>= 8;
        edx <<= 8;
        edx |= buf[i];
    }
    eax = ~eax;
    return eax;
}

int main(void)
{
    char buf[BUF_SIZE + 1];
    fgets(buf, BUF_SIZE, stdin);

    printf("%x", hash(buf));
    return 0;
}

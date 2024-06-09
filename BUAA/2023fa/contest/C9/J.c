#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double
#define UL unsigned long long
#define UU unsigned int
#define SWAP(a, b) (((a) ^ (b)) && ((b) ^= (a) ^= (b), (a) ^= (b)))

#define IO_TYPE int
IO_TYPE read() {
    register IO_TYPE x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= (c == '-'), c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f ? -x : x;
}
void write(IO_TYPE x) {
    static short sta[23];
    short top = 0;
    if(x < 0) putchar('-'), x = -x;
    do {
        sta[top++] = x % 10, x /= 10;
    } while(x);
    while(top) putchar(sta[--top] + '0');
}
#undef IO_TYPE

int main() {
    
    return 0;
}

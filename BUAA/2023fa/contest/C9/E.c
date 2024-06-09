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

#define IO_TYPE unsigned int
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
    puts("");
}
#undef IO_TYPE

const UU ta[6][6] = {{0, 1, 2, 3}, {1, 2, 3, 0}, {2, 3, 0, 1}, {3, 0, 1, 2}};

UU f(UU a, UU b) {
    static UU c[100];
    int top = 0;
    while(a || b) {
        UU x = a & 3, y = b & 3;
        c[top++] = ta[x][y];
        a >>= 2;
        b >>= 2;
    }
    UU res = 0;
    while(top >= 0) {
        res <<= 2;
        res += c[top--];
    }
    return res;
}

int main() {
    UU n = read(), ans = read();
    int i;
    for(i = 1; i < n; ++i) {
        ans = f(ans, read());
    }
    printf("%u", ans);
    return 0;
}

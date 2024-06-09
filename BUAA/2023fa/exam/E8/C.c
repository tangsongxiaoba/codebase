#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

void write(int x) {
    static int sta[35];
    int top = 0;
    if(x < 0) putchar('-'), x = -x;
    do {
        sta[top++] = x % 10, x /= 10;
    }while(x);
    while(top) putchar(sta[--top] + '0');
}

unsigned LL popcount(unsigned LL x) {
    int cnt = 0;
    while(x) {
        cnt++;
        x -= x & -x;
    }
    return cnt;
}

unsigned LL f(unsigned LL a, unsigned LL b) {
    return (b == 0) ? 0 : popcount(a&b) + f(a^b, (a&b)<<1);
}

int main() {
    unsigned int a, b;
    while(scanf("%u%u", &a, &b) != EOF) {
        printf("%llu\n", f(a, b));
    }
    return 0;
}

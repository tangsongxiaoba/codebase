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

int a[3000];

int main() {
    int m = read(), n = read(), s = read(), i, j;
    for(i = 0; i < m*n; ++i) a[i] = read();
    if(s == 1) {
        for(i = 0; i < m; ++i) {
            for(j = 0; j < n; ++j) {
                printf("%lld ", 1LL*a[i*n+j]+read());
            }
            puts("");
        }
    }
    else if(s == 2) {
        for(i = 0; i < m; ++i) {
            for(j = 0; j < n; ++j) {
                printf("%lld ", 1LL*a[i*n+j]-read());
            }
            puts("");
        }
    }
    return 0;
}

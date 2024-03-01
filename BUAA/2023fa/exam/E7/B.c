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

long long a[50][50], b[50][50], res[50][50];

int main() {
    int m = read(), n = read(), k = read();
    int i, j, p;
    for(i = 1; i <= m; ++i) {
        for(j = 1; j <= n; ++j) {
            a[i][j] = read();
        }
    }
    for(i = 1; i <= n; ++i) {
        for(j = 1; j <= k; ++j) {
            b[i][j] = read();
        }
    }
    for(i = 1; i <= m; ++i) {
        for(j = 1; j <= k; ++j) {
            for(p = 1; p <= n; ++p) {
                res[i][j] += a[i][p]*b[p][j];
            }
        }
    }
    for(i = 1; i <= m; ++i) {
        for(j = 1; j <= k; ++j) {
            printf("%lld ", res[i][j]);
        }
        puts("");
    }
    return 0;
}

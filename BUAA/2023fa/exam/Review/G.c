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

int range[1000100];

int main() {
    int a, b;
    while(scanf("%d%d", &a, &b) != EOF) {
        if(b > range[a]) range[a] = b;
    }
    int i, n;
    for(i = 0; i < 1000100; ++i) {
        if(!range[i]) continue;
        write(i); putchar(' ');
        for(n = range[i]; i <= n; ++i) {
            if(range[i] > n) n = range[i];
        }
        --i;
        write(i); puts("");
    }
    return 0;
}

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
    do {
        sta[top++] = x % 10, x /= 10;
    }while(x);
    while(top) putchar(sta[--top] + '0');
}

int a[21];
int s[21], top;

int check(int x, int i) {
    if(a[i] != 0 && x % a[i] == 0) return 1;
    while(x) {
        if(x % 10 == a[i]) return 1;
        x /= 10;
    }
    return 0;
}

int main() {
    int n, m, i, j;
    n = read(), m = read();
    for(i = 1; i <= m; ++i) {
        a[i] = read();
    }
    for(i = 1; i <= n; ++i) {
        top = 0;
        for(j = 1; j <= m; ++j) {
            if(check(i, j) == 1) s[top++] = j;
        }
        if(top == 0) puts("count out");
        else {
            for(j = 0; j < top; ++j) {
                printf("%d", s[j]);
            }
            puts("");
        }
    }
    return 0;
}

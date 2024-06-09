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

int ma[110][110];
char buf[10];
int bomb[10010], p;

int main() {
    int n = read(), m = read();
    int i, j, k, i1, j1;
    for(i = 1; i <= n; ++i) {
        for(j = 1; j <= m; ++j) {
            if(getchar() == 'M') {
                bomb[p++] = (i-1)*m+j;
                ma[i][j] = -1;
            }
        }
        gets(buf);
    }
    for(k = 0; k < p; ++k) {
        j1 = bomb[k]%m;
        if(j1 == 0) j1 = m, i1 = bomb[k] / m;
        else i1 = bomb[k] / m + 1;
        for(i = i1-1; i <= i1+1; ++i) {
            for(j = j1-1; j <= j1+1; ++j) {
                if(ma[i][j] != -1) {
                    ++ma[i][j];
                }
            }
        }
    }
    for(i = 1; i <= n; ++i) {
        for(j = 1; j <= m; ++j) {
            if(ma[i][j] == -1) {
                putchar('M');
            }
            else printf("%d", ma[i][j]);
        }
        puts("");
    }
    return 0;
}

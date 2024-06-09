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
    if(x < 0) {
        putchar('-');
        x = -x;
    }
    static int sta[35];
    int top = 0;
    do {
        sta[top++] = x % 10, x /= 10;
    }while(x);
    while(top) putchar(sta[--top] + '0');
    putchar(' ');
}

int x[41][41], y[41][41], n, m;

int f(int a, int b) {
    int sum = 0, i, j;
    for(i = 0; i < n; ++i) {
        for(j = 0; j < n; ++j) {
            sum += y[i+a][j+b] * x[i][j];
        }
    }
    return sum;
}

int main() {
    int i, j;
    n = read(), m = read();
    for(i = 0; i < n; ++i) {
        for(j = 0; j < n; ++j) {
            x[i][j] = read();
        }
    }
    for(i = 0; i < m; ++i) {
        for(j = 0; j < m; ++j) {
            y[i][j] = read();
        }
    }    
    for(i = 0; i < m-n+1; ++i) {
        for(j = 0; j < m-n+1; ++j) {
            write(f(i, j));
        }
        puts("");
    }
    return 0;
}

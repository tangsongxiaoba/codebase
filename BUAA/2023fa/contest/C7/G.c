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

int num[3];

void exgcd(int a, int b, int* d, int* x, int *y) {
    if(b == 0) {
        *d = a;
        *x = 1;
        *y = 0;
    }
    else {
        int dd, xx, yy;
        exgcd(b, a%b, &dd, &xx, &yy);
        *d = dd;
        *x = yy;
        *y = xx-(a/b)*yy;
    }
}

int main() {
    int a = read(), b = read();
    int d, x, y;
    exgcd(a, b, &d, &x, &y);
    printf("%d = %d*(%d) + %d*(%d)", d, a, x, b, y);
    return 0;
}

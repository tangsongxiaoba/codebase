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
}

const int MAXX = 255431605;

double f(int x) {
    return 1.0*x*log10(1.0*x);
}

int main() {
    int n = read();
    int l = 1, r = MAXX, m = (l + r) / 2;
    while(r >= l) {
        double res = f(m);
        //printf("%d %f\n", m, res);
        if(res - n > 1e-10) r = m-1;
        else if(res - n < 1e-10) l = m+1;
        else l = m;
        m = (l + r) / 2.0;
    }
    printf("%d\n", m);
    return 0;
}

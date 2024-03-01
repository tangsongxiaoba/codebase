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

int main() {
    int n = read();
    int i, j, x, h1 = n/3*2, h2 = n/3;
    for(i = 1; i <= h1; ++i) {
        for(j = 1; j <= h1-i; ++j) putchar(' ');
        for(j = 1; j <= 2*i-1; ++j) putchar('*');
        for(j = 1; j <= h1-i; ++j) putchar(' ');        
        puts("");
    }
    for(i = 1, x = (h2>>2)*2+1; i <= h2; ++i) {
        for(j = 1; j <= (2*h1-1-x)/2; ++j) putchar(' ');
        for(j = 1; j <= x; ++j) putchar('|');
        for(j = 1; j <= (2*h1-1-x)/2; ++j) putchar(' ');
        puts("");    
    }
    return 0;
}

#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double

unsigned int read() {
    register unsigned int x = 0;
    register char c = getchar();
    while(c < '0' || c > '9') c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return x;
}

void write(unsigned int x) {
    static int sta[35];
    int top = 0;
    if(x < 0) putchar('-'), x = -x;
    do {
        sta[top++] = x % 10, x /= 10;
    }while(x);
    while(top) putchar(sta[--top] + '0');
    putchar(32);
}

int p;
unsigned int a[1010];

void insert(unsigned int x) {
    if(!a[x%p]) a[x%p] = x;
    else {
        int i;
        for(i = x%p+1; i < p; ++i) {
            if(!a[i]) {
                a[i] = x;
                return;
            }
        }
        for(i = 0; i < x%p; ++i) {
            if(!a[i]) {
                a[i] = x;
                return;
            }
        }
    }
}

int main() {
    int i, m = read(), n = read();
    p = m;
    for(i = 1; i <= n; ++i) {
        insert(read());
    }
    for(i = 0; i < m; ++i) write(a[i]);
    return 0;
}

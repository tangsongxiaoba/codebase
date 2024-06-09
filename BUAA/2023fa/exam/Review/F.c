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
    do {
        sta[top++] = x % 10, x /= 10;
    } while(x);
    while(top) putchar(sta[--top] + '0');
}

int popcount(unsigned int x) {
    int cnt = 0;
    while(x) {
        cnt++;
        x -= x & -x;
    }
    return cnt;
}

int main() {
    unsigned int a = read(), b = read();
    while(popcount(b) > a) {
        b &= (b - 1);
    }
    while(popcount(b) < a) {
        b |= (b + 1);
    }
    write(b);
    return 0;
}

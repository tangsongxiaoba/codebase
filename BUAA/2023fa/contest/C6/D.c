#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double

void write(int x) {
    static int sta[35];
    int top = 0;
    do {
        sta[top++] = x % 10, x /= 10;
    }while(x);
    while(top) putchar(sta[--top] + '0');
}

int popcount(int x) {
    int cnt = 0;
    while(x) {
        cnt++;
        x -= x & -x;
    }
    return cnt;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int main() {
    unsigned int x, y, z;
    while(scanf("%u%u%u", &x, &y, &z) != EOF) {
        printf("%d\n", max(popcount(y^z), max(popcount(x^y), popcount(x^z))));
    }
    return 0;
}

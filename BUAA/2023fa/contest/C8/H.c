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

int i, n;

void hanoi(int m, char A, char B, char C) {
    if(m == 1) {
        ++i;
        /*printf("%d %c->%c\n", m, A, C);*/
        if(i == n) {
            printf("%d\n", m);
        }
    }
    else {
        hanoi(m-1, A, C, B);
        ++i;
        /*printf("%d %c->%c\n", m, A, C);*/
        if(i == n) {
            printf("%d\n", m);
        }
        hanoi(m-1, B, A, C);
    }
}

int main() {
    int m;
    while(scanf("%d%d", &m, &n) != EOF) {
        i = 0;
        hanoi(m, 'A', 'B', 'C');
    }
    return 0;
}

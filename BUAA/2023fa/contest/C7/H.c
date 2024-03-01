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

int num[30][30][30];

int beta(int a, int b, int c) {
    if(a <= 0 || b <= 0 || c <= 0) return 1;
    else if(a > 25 || b > 25 || c > 25) return beta(25, 25, 25);
    if(num[a][b][c]) return num[a][b][c];
    else if(a < b && b < c) return num[a][b][c] = beta(a,b,c-1)+beta(a,b-1,c-1)-beta(a,b-1,c);
    else return num[a][b][c] = beta(a-1, b, c) + beta(a-1, b-1, c) + beta(a-1, b, c-1) - beta(a-1, b-1, c-1);
}

int main() {
    int t = read();
    while(t--) {
        int a = read(), b = read(), c = read();
        printf("%d\n", beta(a, b, c));
    }
    return 0;
}

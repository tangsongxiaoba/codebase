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

int ans[] = {0, 1, 0, 0, 2, 10, 12, 8, 12, 30, 72, 106, 128, 186, 316, 546, 836, 1186, 1756, 2720, 4224, 6366, 9374, 13932, 20958, 31470};

int main() {
    int n;
    while(scanf("%d", &n) != EOF) {
        printf("%d\n", ans[n]);
    }
    return 0;
}

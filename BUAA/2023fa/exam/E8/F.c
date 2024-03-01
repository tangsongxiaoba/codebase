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
    puts("");
}

struct node{
    int x, y;
}a[13];

LL ans;

int check(int x, int y) {
    int i;
    for(i = 1; i <= 10; ++i) {
        if(a[i].x == 0 && a[i].y == 0) break;
        if(a[i].x == x && a[i].y == y) return 0;
    }
    return 1;
}

void dfs(int x, int y, int m, int n) {
    if(x > m || y > n) return;
    if(x == m && y == n) ++ans;
    if(check(x+1, y)) dfs(x+1, y, m, n);
    if(check(x, y+1)) dfs(x, y+1, m, n);
}

int main() {
    int m = read(), n = read(), t = read(), i;
    for(i = 1; i <= t; ++i) {
        a[i].x = read(), a[i].y = read();
    }
    dfs(0, 0, m, n);
    printf("%lld", ans);
    return 0;
}

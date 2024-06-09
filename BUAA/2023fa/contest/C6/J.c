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
    do {
        sta[top++] = x % 10, x /= 10;
    }while(x);
    while(top) putchar(sta[--top] + '0');
}

int fa[40];
int time[40];
bool vis[40];

int f(int x){
    if(vis[x]) return 0;
    vis[x] = 1;
    if(fa[x] == x) return x;
    return f(fa[x]);
}

int main() {
    int i, n = read(), s = read(), k, x;
    int res = 0;
    for(i = 1; i <= n; ++i) {
        fa[i] = i;
        time[i] = read();
    }
    for(i = 1; i <= n; ++i) {
        k = read();
        while(k) {
            x = read();
            if(x != s) fa[x] = i;
            k--;
        }
    }
    int F = f(s);
    bool flag = false;
    for(i = 1; i <= n; ++i) {
        memset(vis, 0, sizeof vis);
        int t = f(i);
        if(t == 0 && vis[s]) {
            flag = true;
            break;
        }
        else if(t == F) res += time[i];
    }
    if(flag) {
        printf("Dead Lock!!");
    }
    else {
        printf("%d", res);
    }
    return 0;
}

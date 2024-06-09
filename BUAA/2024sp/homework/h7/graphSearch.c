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
    putchar(' ');
}

bool g[110][110];
bool vis[110];
int n, m;

void dfs(int s) {
    vis[s] = true;
    write(s);
    for(int i = 0; i < n; ++i) {
        if(g[s][i] && !vis[i]) {
            dfs(i);
        }
    }
}

void bfs(int s) {
    int q[110], he = 0, re = -1;
    q[++re] = s;
    vis[s] = true;
    while(he <= re) {
        int u = q[he++];
        vis[u] = true;
        write(u);
        for(int i = 0; i < n; ++i) {
            if(g[u][i] && !vis[i]) {
                q[++re] = i;
                vis[i] = true;
            }
        }
    }
}

int main() {
    // freopen("in", "r", stdin);
    n = read(), m = read();
    for(int i = 1; i <= m; ++i) {
        int u = read(), v = read();
        g[u][v] = g[v][u] = 1;
    }
    dfs(0);
    puts("");
    memset(vis, 0, sizeof(vis));
    bfs(0);
    puts("");
    memset(vis, 0, sizeof(vis));
    int op = read();
    for(int i = 0; i < n; ++i) {
        g[op][i] = g[i][op] = 0;
    }
    vis[op] = true;
    dfs(0);
    puts("");
    memset(vis, 0, sizeof(vis));
    vis[op] = true;
    bfs(0);
    puts("");
    return 0;
}

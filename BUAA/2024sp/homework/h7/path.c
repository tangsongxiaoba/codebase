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

#define MAXN 2010
#define MAXM 1010

int n, m, e, fst[MAXN];
typedef struct {
    int u, v, w, nxt;
}Edge;
Edge a[MAXN];

void add(int u, int v, int w) {
    a[++e] = (Edge){u, v, w, fst[u]};
    fst[u] = e;
}

bool vis[MAXN];
int path[MAXM];
char *ans[1000];
int tot;

void dfs(int s, int dep) {
    if(s == n-1) {
        char *res = (char *)malloc(sizeof(char) * dep);
        for(int i = 0; i < dep; ++i) {
            res[i] = path[i]+'0';
        }
        ans[tot++] = res;
        return;
    }
    vis[s] = true;
    for(int i = fst[s]; i; i = a[i].nxt) {
        if(!vis[a[i].v]) {
            vis[a[i].v] = true;
            path[dep] = a[i].w;
            dfs(a[i].v, dep+1);
            // path[dep] = -1;
            vis[a[i].v] = false;
        }
    }
}

int cmp(const void *a, const void *b) {
    return strcmp(*(char **)a, *(char **)b);
}

int main() {
    // freopen("in", "r", stdin);
    n = read();
    m = read();
    for(int i = 0; i < m; ++i) {
        int w = read(), u = read(), v = read();
        add(u, v, w); add(v, u, w);
        path[i] = -1;
    }
    dfs(0, 0);
    qsort(ans, tot, sizeof(ans[0]), cmp);
    for(int i = 0; i < tot; ++i) {
        int len = strlen(ans[i]);
        for(int j = 0; j < len; ++j) {
            printf("%d ", ans[i][j] - '0');
        }
        puts("");
    }
    return 0;
}

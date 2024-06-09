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

#define MAXM 1000
#define MAXN 100

int n, m, e, fst[MAXN];
typedef struct {
    int u, v, w, id;
}Edge;
Edge a[MAXM];

int fa[MAXN];

int cmp(const void *p1, const void *p2) {
    Edge *a = (Edge *)p1;
    Edge *b = (Edge *)p2;
    return a->w == b->w ? a->id - b->id : a->w - b->w;
}

int cmp2(const void *p1, const void *p2) {
    int *a = (int *)p1;
    int *b = (int *)p2;
    return *a - *b;
}

int findFa(int x) {
    while(x != fa[x]) x = fa[x] = fa[fa[x]];
    return x;
}

int ans[MAXM], res, tot, cnt;

int main() {
    // freopen("in", "r", stdin);
    n = read(), m = read();
    for(int i = 1; i <= n; ++i) fa[i] = i;
    for(int i = 0; i < m; ++i) {
        a[i].id = read(), a[i].u = read(), a[i].v = read(), a[i].w = read();
    }
    qsort(a, m, sizeof(a[0]), cmp);
    for(int i = 0; i < m; ++i) {
        int fau = findFa(a[i].u), fav = findFa(a[i].v);
        if(fau == fav) continue;
        res += a[i].w;
        ans[tot++] = a[i].id;
        fa[fav] = fau;
        if(++cnt == n-1) break;
    }
    qsort(ans, tot, sizeof(int), cmp2);
    printf("%d\n", res);
    for(int i = 0; i < tot; ++i) {
        printf("%d ", ans[i]);
    }
    return 0;
}

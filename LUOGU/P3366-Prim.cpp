//Luogu P3366 【模板】最小生成树
#include <iostream>
#include <cstdio>
#include <cstring>
#include <algorithm>
using namespace std;

const int MAXN = 5e3+10;
const int MAXM = 2e5+10;
int n, m, e, ans, cnt, now=1;
int fst[MAXN];
int dis[MAXM];
bool vis[MAXN];
struct node {
    int u, v, w, nxt;
}edge[MAXM<<1];

inline void add(const int &u, const int &v, const int &w) {
    edge[++e].u = u;
    edge[e].v = v;
    edge[e].w = w;
    edge[e].nxt = fst[u];
    fst[u] = e;
}

inline int read() {
    register int x = 0, f = 1;
    char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = -1; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return x*f;
}

inline void gmin(int &x, const int &y) {
    if(x > y) x = y;
}

int main() {
    n = read(), m = read();
    memset(dis, 0x3f3f3f3f, sizeof dis);
    dis[1] = dis[0] = 0;
    for(register int i = 1, u, v, w; i <= m; ++i) {
        u = read(), v = read(), w = read();
        add(u, v, w), add(v, u, w);
    }
    for(register int i = fst[1]; i; i = edge[i].nxt) 
        gmin(dis[edge[i].v], edge[i].w);
    while(++cnt < n) {
        register int minn = 0x3f3f3f3f;
        vis[now] = 1;
        for(register int i = 1; i <= n; ++i)
            if(!vis[i] && minn > dis[i]) {
                minn = dis[i];
                now = i;
            }
        ans += minn;
        for(register int i = fst[now]; i; i = edge[i].nxt) {
            register int v = edge[i].v, w = edge[i].w;
            if(dis[v] > w && !vis[v]) dis[v] = w;
        }
    }
    printf("%d", ans);
    return 0;
}
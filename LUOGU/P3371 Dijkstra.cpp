// Luogu P3371 【模板】单源最短路径（弱化版）
#include <iostream>
#include <cstdio>
#include <cstring>
#include <queue>
using namespace std;

const int INF = 0x7fffffff;
const int MAXN = 1e4+10;
const int MAXM = 5e5+10;

int n, m, s, e;
int fst[MAXN], d[MAXN];
struct edge {
    int u, v, w, nxt;
}a[MAXM];
struct node {
    int d, u;
    bool operator < (const node& rhs) const {
        return d > rhs.d;
    }
};

inline void push(const int &u, const int &v, const int &w) {
    a[++e].u = u;
    a[e].v = v;
    a[e].w = w;
    a[e].nxt = fst[u];
    fst[u] = e;
}

inline void dijkstra(int s) {
    priority_queue<node> Q;
    for(int i = 1; i <= n; ++i) d[i] = INF;
    d[s] = 0;
    Q.push((node){0, s});
    while(!Q.empty()) {
        node x = Q.top();
        Q.pop();
        int u = x.u;
        if(x.d != d[u]) continue;
        for(int i = fst[u]; i; i = a[i].nxt) {
            int v = a[i].v, w = a[i].w;
            if(d[v] > d[u] + w) {
                d[v] = d[u] + w;
                Q.push((node){d[v], v});
            }
        }
    }
}

int main() {
    scanf("%d%d%d", &n, &m, &s);
    for(int i = 1; i <= m; ++i) {
        int u, v, w;
        scanf("%d%d%d", &u , &v, &w);
        push(u, v, w);
    }
    dijkstra(s);

    for(int i = 1; i <= n; ++i)
        printf("%d ", d[i]);
    return 0;
}

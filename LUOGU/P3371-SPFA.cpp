//Luogu P3371 【模板】单源最短路径（弱化版）
#include <iostream>
#include <cstdio>
#include <cstring>
#include <queue>
using namespace std;

const int INF = 0x7fffffff;
const int MAXN = 1e4+10;
const int MAXM = 5e5+10;
int n, m, s, e;
int d[MAXN], fst[MAXN];
bool vis[MAXN];
struct edge{
    int u, v, w, nxt;
}a[MAXM];

inline void push(const int &u, const int &v, const int &w) {
    a[++e].u = u;
    a[e].v = v;
    a[e].w = w;
    a[e].nxt = fst[u];
    fst[u] = e;
};

inline void spfa() {
    queue<int> Q;
    for(int i = 1; i <= n; ++i) d[i] = INF;
    d[s] = 0, vis[s] = true;
    Q.push(s);
    while(!Q.empty()) {
        int u = Q.front();
        Q.pop(); vis[u] = false;
        for(int i = fst[u]; i; i = a[i].nxt) {
            int v = a[i].v, w = a[i].w;
            if(d[v] > d[u] + w) {
                d[v] = d[u] + w;
                if(!vis[v]) {
                    vis[v] = true;
                    Q.push(v);
                }
            }
        }
    }
}

int main() {
    scanf("%d%d%d", &n, &m, &s);
    for(int i = 1; i <= m; ++i) {
        int u, v, w;
        scanf("%d%d%d", &u, &v, &w);
        push(u, v, w);
    }
    spfa();
    for(int i = 1; i <= n; ++i) {
        if(s == i) printf("0 ");
        else printf("%d ", d[i]);
    }
    return 0;
}

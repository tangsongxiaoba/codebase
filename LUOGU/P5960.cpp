//Luogu P5960 【模板】差分约束算法
#include<cstdio>
#include<cstring>
#include<queue>
using namespace std;

const int MAXN = 5e3+10;
const int MAXM = 5e3+10;
int n, m;
int fst[MAXM], e;
struct Edge {
    int u, v, w, nxt;
}a[MAXM<<1];
int dis[MAXN], cnt[MAXN];
bool vis[MAXN];

inline void add(const int& u, const int& v, const int& w) {
    a[++e].u = u;
    a[e].v = v;
    a[e].w = w;
    a[e].nxt = fst[u];
    fst[u] = e;
}

inline int read() {
    register int x = 0, f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = -1; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return x*f;
}

inline bool spfa() {
    queue<int> Q;
    dis[0] = 0, vis[0] = true;
    Q.push(0), ++cnt[0];
    register int u = 0, v = 0, w = 0;
    while(!Q.empty()) {
        u = Q.front(), Q.pop();
        vis[u] = false;
        for(register int i = fst[u]; i; i = a[i].nxt) {
            v = a[i].v, w = a[i].w;
            if(dis[v] > dis[u] + w) {
                dis[v] = dis[u] + w;
                if(!vis[v]) {
                    Q.push(v);
                    vis[v] = true;
                    if(++cnt[v] == n+1) return false;
                }
            }
        }
    }
    return true;
}

int main() {
    n = read(), m = read();
    memset(dis, 0x3f, sizeof dis);
    for(register int i = 1; i <= n; ++i) add(0, i, 0);
    register int u = 0, v = 0, w = 0;
    for(register int i = 1; i <= m; ++i) {
        v = read(), u = read(), w = read();
        add(u, v, w);
    }
    if(!spfa()) puts("NO");
    else for(register int i = 1; i <= n; ++i) printf("%d ", dis[i]);
    return 0;
}
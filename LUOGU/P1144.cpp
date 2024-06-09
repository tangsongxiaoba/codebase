//Luogu P1144 最短路计数
#include<iostream>
#include<cstdio>
#include<queue>
using namespace std;

const int MOD = 1e5+3;
const int INF = 0x3f3f3f3f;
const int MAXN = 1e6+10;
const int MAXM = 2e6+10;
int n, m, s=1, e, fst[MAXN], d[MAXN], res[MAXN];
bool vis[MAXN];
struct Edge{
    int u, v, nxt;
}a[MAXM<<1];

inline char nc() {
    static char buf[1<<21], *p1 = buf, *p2 = buf;
    return p1 == p2 && (p2 = (p1 = buf) + fread (buf, 1, 1<< 21, stdin), p1 == p2) ? EOF : *p1++;
}

inline int read() {
    register int x = 0, f = 1;
    register char c = nc();
    while(c < '0' || c > '9') {if(c == '-') f = 0; c = nc();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = nc();
    return f?x:-x;
}

inline void add(const int &u, const int &v) {
    a[++e].u = u;
    a[e].v = v;
    a[e].nxt = fst[u];
    fst[u] = e;
}

inline void spfa() {
    queue<int> Q;
    for(register int i = 1; i <= n; ++i) d[i] = INF;
    d[s] = 0, vis[s] = true, res[s] = 1;
    Q.push(s);
    while(!Q.empty()) {
        register int u = Q.front();
        Q.pop(); vis[u] = false;
        for(register int i = fst[u]; i; i = a[i].nxt) {
            register int v = a[i].v;
            if(d[v] > d[u] + 1) {
                d[v] = d[u] + 1;
                res[v] = res[u];
                if(!vis[v]) {
                    vis[v] = true;
                    Q.push(v);
                }
            }
            else if(d[v] == d[u] + 1) {
                (res[v] += res[u]) %= MOD;
            }
        }
    }
}

int main() {
    n = read(), m = read();
    for(register int i = 1; i <= m; ++i) {
        register int x = read(), y = read();
        add(x, y), add(y, x); 
    }
    spfa();
    for(register int i = 1; i <= n; ++i) {
        printf("%d\n", res[i]);
    }
    return 0;
}
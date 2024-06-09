//Luogu P5663 [CSP-J2019] 加工零件
#include<iostream>
#include<cstdio>
#include<cstring>
#include<queue>
using namespace std;

const int MAXN = 1e6+10;
const int INF = 0x3f3f3f3f;
int n, m, c, fst[MAXN], e, d[MAXN][2];
bool vis[MAXN][2];
struct Edge{
    int u, v, nxt;
}a[MAXN<<1];
struct node{
    int data, dis;
    bool operator < (const node &rhs) const{
        return rhs.dis < dis;
    }
};

inline int read() {
    register int x = 0, f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = -1; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return x*f;
}

inline void add(const int &u, const int &v) {
    a[++e].u = u;
    a[e].v = v;
    a[e].nxt = fst[u];
    fst[u] = e;
}

void dijkstra() {
    memset(d, 0x3f, sizeof d);
    priority_queue<node> Q;
    Q.push((node){1, 0}), d[1][0] = 0;
    while(!Q.empty()) {
        node x = Q.top();
        Q.pop();
        int u = x.data;
        for(register int i = fst[u]; i; i = a[i].nxt) {
            register int v = a[i].v;
            if(d[v][0] > d[u][1] + 1) {
                d[v][0] = d[u][1] + 1;
                if(!vis[v][0]) {
                    vis[v][0] = true;
                    Q.push((node){v, d[v][0]});
                }
            }
            if(d[v][1] > d[u][0] + 1) {
                d[v][1] = d[u][0] + 1;
                if(!vis[v][1]) {
                    vis[v][1] = 1;
                    Q.push((node){v, d[v][1]});
                }
            }
        }
    }
}

int main() {
    n = read(), m = read(), c = read();
    for(register int i = 1; i <= m; ++i) {
        int u = read(), v = read();
        add(u, v), add(v, u);
    }
    dijkstra();
    while(c--) {
        int a = read(), l = read();
        if(!fst[1]) puts("No");
        else if(d[a][l%2] <= l) puts("Yes");
        else puts("No");
    }
    return 0;
}
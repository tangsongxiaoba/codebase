//Luogu P3385 【模板】负环
#include<cstdio>
#include<cstring>
#include<queue>
using namespace std;

const int MAXN = 2e3+10;
const int MAXM = 3e3+10;
int n, m;
int fst[MAXN], e;
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
    register int x = 0;
    register bool f = true;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = false; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?x:-x;
}

inline int spfa() {
    queue<int> Q;
    dis[1] = 0;
    vis[1] = true;
    Q.push(1);
    register int u = 0, v = 0, w = 0;
    while(!Q.empty()) {
        u = Q.front(), Q.pop();
        vis[u] = false;
        for(register int i = fst[u]; i; i = a[i].nxt) {
            v = a[i].v, w = a[i].w;
            if(dis[v] > dis[u] + w) {
                dis[v] = dis[u] + w;
                cnt[v] = cnt[u] + 1;
                if(cnt[v] >= n) return puts("YES"), 0;
                if(!vis[v]) {
                    vis[v] = true;
                    Q.push(v);
                }
            }
        }
    }
    return puts("NO"), 0;
}

int main() {
    register int T = read();
    register int u = 0, v = 0, w = 0;
    while(T--) {
        n = read(), m = read();
        e = 0;
        memset(fst, 0, sizeof fst);
        memset(dis, 0x3f, sizeof dis);
        memset(cnt, 0, sizeof cnt);
        memset(vis, false, sizeof vis);
        memset(a, 0, sizeof a);
        for(register int i = 1; i <= m; ++i) {
            u = read(), v = read(), w = read();
            add(u, v, w);
            if(w >= 0) add(v, u, w);
        }
        spfa();
    }
    return 0;
}
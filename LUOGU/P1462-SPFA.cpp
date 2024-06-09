//Luogu P1462 通往奥格瑞玛的道路
#include<cstdio>
#include<cmath>
#include<algorithm>
#include<queue>
using namespace std;

const int INF = 0x3f3f3f3f;
const int MAXN = 1e4+10;
const int MAXM = 1e5+10;
int n, m, hp, e, ans;
int fst[MAXN], d[MAXN];
int fi[MAXN], ffi[MAXN];
bool vis[MAXN];
struct Edge{
    int u, v, w, nxt;
}a[MAXM<<1];

inline int read() {
    register int x = 0, f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = -1; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return x*f;
}

inline int gmax(int &a, const int &b) {
    if(a < b) a = b;
}

inline void add(const int &u, const int &v, const int &w) {
    a[++e] = Edge{u, v, w, fst[u]};
    fst[u] = e;
}

inline bool check(const int &x) { // spfa
    queue<int> Q;
    for(register int i = 1; i <= n; ++i) d[i] = INF;
    for(register int i = 1; i <= n; ++i) vis[i] = false;
    d[1] = 0, vis[1] = true;
    Q.push(1);
    while(!Q.empty()) {
        int u = Q.front(); Q.pop();
        vis[u] = false;
        for(register int i = fst[u]; i; i = a[i].nxt) {
            register int v = a[i].v, w = a[i].w;
            if(d[v] > d[u] + w && fi[v] <= x) {
                d[v] = d[u] + w;
                if(!vis[v]) {
                    vis[v] = true;
                    Q.push(v);
                }
            }
        }
    }
    if(d[n] <= hp) return true;
    else return false;
}

int main() {
    n = read(), m = read(), hp = read();
    for(register int i = 1; i <= n; ++i)
        fi[i] = read(), ffi[i] = fi[i];
    for(register int i = 1; i <= m; ++i) {
        register int u = read(), v = read(), w = read();
        if(u == v) continue;
        add(u, v, w), add(v, u, w);
    }
    sort(ffi+1, ffi+n+1);
    if(!check(INF)) {
        printf("AFK");
        return 0;
    }
    register int l = 1, r = n, mid;
    while(l <= r) {
        mid = l + r >> 1;
        if(check(ffi[mid])) {
            ans = ffi[mid];
            r = mid - 1;
        }
        else l = mid + 1;
    }
    printf("%d", ans);
    return 0;
}

//CF786B Legacy
#include<iostream>
#include<cstdio>
#include<cstring>
#include<queue>
using namespace std;
#define int long long

const int MAXN = 9e5+10;
const int MAXM = 5e6+10;
struct Edge {
    int v; int nxt; int w;
} a[MAXM];
int fst[MAXN], e;
int n, q, s;
struct Node {
    int l, r;
} t[MAXN];
int d[MAXN];
bool vis[MAXN];
struct node {
    int u, w;
    bool operator < (const node & rhs) const {
        return w > rhs.w;
    }
};

inline void add(const int& u, const int& v, const int& w) {
    a[++e].v = v;
    a[e].w = w;
    a[e].nxt = fst[u];
    fst[u] = e;
}

void build(const int& o, const int& l, const int& r) {
    t[o].l = l, t[o].r = r;
    if(l == r) {
        add(l+(n<<3), o, 0);
        add(o+(n<<2), l+(n<<3), 0);
        add(o, l+(n<<3), 0);
        add(l+(n<<3), o+(n<<2), 0);
        return;
    }
    add(o, o<<1, 0);
    add((o<<1)+(n<<2), o+(n<<2), 0);
    add(o, (o<<1)|1, 0);
    add(((o<<1)|1)+(n<<2), o+(n<<2), 0);
    build(o<<1, l, (l+r)>>1);
    build(o<<1|1, ((l+r)>>1)+1, r);
}

void addh(const int& o, const int& x, const int& y, const bool& type, const int& u, const int& w) {
    register int l = t[o].l, r = t[o].r, mid = (l+r) >> 1;
    if(l == x && y == r) {
        if(!type) return add(u+(n<<3), o, w);
        else return add(o+(n<<2), u+(n<<3), w);
    }
    if(y <= mid) addh(o<<1, x, y, type, u, w);
    else if(x > mid) addh(o<<1|1, x, y, type, u, w);
    else addh(o<<1, x, mid, type, u, w), addh(o<<1|1, mid+1, y, type, u, w);
}

void dijkstra() {
    memset(d, 0x3f, sizeof d);
    d[s] = 0;
    priority_queue<node> Q;
    Q.push((node){s, 0ll});
    while(!Q.empty()) {
        register int u = Q.top().u; Q.pop();
        if(vis[u]) continue;
        vis[u] = 1;
        for(register int i = fst[u], v; i; i = a[i].nxt) {
            if(!vis[v=a[i].v] && d[v] > d[u] + a[i].w) {
                d[v] = (d[v] < d[u] + a[i].w ? d[v] : d[u] + a[i].w);
                Q.push((node){v, d[v]});
            }
        }
    }
}

inline int read() {
    register int x = 0, f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = 0; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?x:-x;
}

signed main() {
    n = read(), q = read(), s = read();
    build(1, 1, n);
    for(register int i = 1, op, v, u, w, l, r; i <= q; ++i) {
        op = read();
        if(op == 1) v = read(), u = read(), w = read(), add(v + (n<<3), u + (n<<3), w);
        else if(op == 2) v = read(), l = read(), r = read(), w = read(), addh(1, l, r, 0, v, w);
        else if(op == 3) v = read(), l = read(), r = read(), w = read(), addh(1, l, r, 1, v, w);
    }
    s += (n << 3);
    dijkstra();
    for(register int i = 1; i <= n; ++i) {
        if(d[i+(n<<3)] < 2e18) printf("%lld ", d[i+(n<<3)]);
        else printf("-1 ");
    }
    return 0;
}
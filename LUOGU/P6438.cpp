//Luogu P6348 [PA2011]Journeys
#include<iostream>
#include<cstdio>
#include<cstring>
#include<queue>
using namespace std;

const int MAXN = 5e6+10;
const int MAXM = 2e6+10;
struct Node {
    int l, r;
} t[MAXN];
struct Edge {
    int v; int nxt; int w;
} a[MAXM<<2];
int fst[MAXN], e;
int n, m, s, id[MAXN], cnt;
int d[MAXN];

inline void add(const int& u, const int& v, const int& w) {
    a[++e].v = v;
    a[e].w = w;
    a[e].nxt = fst[u];
    fst[u] = e;
}

void build(const int& o, const int& l, const int& r) {
    t[o].l = l, t[o].r = r;
    if(l == r) {
        id[l] = o;
        return;
    }
    add(o, o<<1, 0);
    add((o<<1)+(n<<2), o+(n<<2), 0);
    add(o, (o<<1)|1, 0);
    add(((o<<1)|1)+(n<<2), o+(n<<2), 0);
    build(o<<1, l, (l+r)>>1);
    build(o<<1|1, ((l+r)>>1)+1, r);
}

void adds(const int& o, const int& x, const int& y, const bool& type, const int& u) {
    register int l = t[o].l, r = t[o].r, mid = (l+r) >> 1;
    if(l == x && y == r) {
        if(!type) return add(u, o, 0);
        else return add(o+(n<<2), u, 0);
    }
    if(y <= mid) adds(o<<1, x, y, type, u);
    else if(x > mid) adds(o<<1|1, x, y, type, u);
    else adds(o<<1, x, mid, type, u), adds(o<<1|1, mid+1, y, type, u);
}

inline void bfs() {
    deque<int> q; q.push_front(s);
    memset(d, 0x3f, sizeof d); d[s] = 0;
    while(!q.empty()) {
        register int u = q.front();
        q.pop_front();
        for(register int i = fst[u], v; i; i = a[i].nxt) {
            if(d[v=a[i].v] > d[u] + a[i].w) {
                d[v] = d[u] + a[i].w;
                if(!a[i].w) q.push_front(v);
                else q.push_back(v);
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
    n = read(), m = read(), s = read();
    build(1, 1, n);
    cnt = n << 3;
    for(register int i = 1, a, b, c, dd; i <= m; ++i) {
        a = read(), b = read(), c = read(), dd = read();
        register int x = ++cnt, y = ++cnt;
        add(y, x, 1), adds(1, c, dd, 0, x), adds(1, a, b, 1, y);
        x = ++cnt, y = ++cnt;
        add(y, x, 1), adds(1, a, b, 0, x), adds(1, c, dd, 1, y);
    }
    for(register int i = 1; i <= n; ++i) add(id[i], id[i] + (n<<2), 0), add(id[i] + (n<<2), id[i], 0);
    s = id[s] + (n<<2);
    bfs();
    for(register int i = 1; i <= n; ++i) printf("%d\n", d[id[i]]);
    return 0;
}
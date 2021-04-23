//Luogu P2403 [SDOI2010]所驼门王的宝藏
#include<cstdio>
#include<iostream>
#include<cstring>
#include<algorithm>
#include<queue>
using namespace std;

const int MAXN = 1e5+10;
const int MAXT = 3e6+10;
const int MAXM = 1e6+10;
const int dx[] = {1, 1, 1, 0, 0, -1, -1, -1};
const int dy[] = {1, 0, -1, 1, -1, 1, 0, -1};
int n, r, c, t, e;
int ee, uu[MAXM], vv[MAXM];
int fst[MAXT], in[MAXT], dp[MAXT];
queue<int> Q;
int s[MAXT], top, val[MAXT], col[MAXT];
int bIndex, dfn[MAXT], low[MAXT], scc;
bool inStack[MAXT];
struct Edge {
    int v, nxt;
} a[MAXM];
struct Node {
    int x, y, t;
    bool operator < (const Node& rhs) const {
        return x < rhs.x || x == rhs.x && y < rhs.y;
    }
} b[MAXN];

inline int read() {
    register int x = 0, f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = -1; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return x * f;
}

inline void add(const int& u, const int& v) {
    uu[++ee] = u;
    vv[ee] = v;
    a[++e].v = v;
    a[e].nxt = fst[u];
    fst[u] = e;
}

inline void add2(const int& u, const int& v) {
    a[++e].v = v;
    a[e].nxt = fst[u];
    fst[u] = e;
}

inline void gmin(int& a, const int& b) {
    if(a > b) a = b;
}

inline void gmax(int& a, const int& b) {
    if(a < b) a = b;
}

void tarjan(const int& u) {
    dfn[u] = low[u] = ++bIndex;
    s[++top] = u, inStack[u] = true;
    for(register int i = fst[u]; i; i = a[i].nxt) {
        register int v = a[i].v;
        if(!dfn[v]) {
            tarjan(v);
            gmin(low[u], low[v]);
        }
        else if(inStack[v]) gmin(low[u], dfn[v]);
    }
    if(dfn[u] == low[u]) {
        col[u] = ++scc;
        val[scc] = u > r+c;
        while(s[top] != u) {
            col[s[top]] = scc;
            val[scc] += (s[top] > r+c);
            inStack[s[top--]] = false;
        }
        inStack[s[top--]] = false;
    }
}

inline int getid(const int& x, const int& y) {
    register int l = 1, r = n;
    while(l <= r) {
        register int mid = l+r >> 1;
        if(b[mid].x == x && b[mid].y == y) return mid;
        else if(b[mid].x < x || b[mid].x == x && b[mid].y < y) l = mid + 1;
        else r = mid - 1;
    }
    return -1;
}

int main() {
    n = read(), r = read(), c = read();
    for(register int i = 1; i <= n; ++i)
        b[i].x = read(), b[i].y = read(), b[i].t = read();
    sort(b+1, b+1+n);
    for(register int i = 1; i <= n; ++i) {
        add(b[i].x, r+c+i);
        add(b[i].y+r, r+c+i);
        if(b[i].t == 1) add(r+c+i, b[i].x);
        else if(b[i].t == 2) add(r+c+i, b[i].y+r);
        else {
            for(register int k = 0; k < 8; ++k) {
                register int x = b[i].x + dx[k], y = b[i].y + dy[k];
                if(x >= 1 && x <= r && y >= 1 && y <= c) {
                    register int id = getid(x, y);
                    if(id != -1) add(r+c+i, r+c+id);
                }
            }
        }
    }
    t = r+c+n;
    for(register int i = 1; i <= t; ++i) if(!dfn[i]) tarjan(i);
    e = 0; memset(fst, 0, sizeof fst);
    for(register int i = 1; i <= ee; ++i) 
        if(col[uu[i]] != col[vv[i]]) {
            add2(col[uu[i]], col[vv[i]]);
            ++in[col[vv[i]]];
        }
    for(register int i = 1; i <= scc; ++i)
        if(!in[i]) {
            Q.push(i);
            dp[i] = val[i];
        }
    while(!Q.empty()) {
        register int u = Q.front();
        Q.pop();
        for(register int i = fst[u]; i; i = a[i].nxt) {
            register int v = a[i].v;
            gmax(dp[v], dp[u] + val[v]);
            if(--in[v] == 0) Q.push(v);
        }
    }
    register int ans = 0;
    for(register int i = 1; i <= scc; ++i) gmax(ans, dp[i]);
    printf("%d", ans);
    return 0;
}
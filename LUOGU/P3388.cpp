//Luogu P3388 【模板】割点（割顶）
#include<cstdio>
using namespace std;

const int MAXN = 2e4+10;
const int MAXM = 1e5+10;
int n, m, res;
int fst[MAXM], e;
struct Edge {
    int u, v, nxt;
}a[MAXM<<1];
int dfn[MAXN], low[MAXN], bIndex;
bool cut[MAXN];

inline void add(const int& u, const int& v) {
    a[++e].u = u;
    a[e].v = v;
    a[e].nxt = fst[u];
    fst[u] = e;
}

inline void gmin(int& a, const int& b) {
    if(a > b) a = b;
}

inline int read() {
    register int x = 0, f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '0') f = -1; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return x*f;
}

void tarjan(const int& u, const int& fa) {
    dfn[u] = low[u] = ++bIndex;
    register int v = 0, ch = 0;
    for(register int i = fst[u]; i; i = a[i].nxt) {
        v = a[i].v;
        if(!dfn[v]) {
            tarjan(v, u);
            gmin(low[u], low[v]);
            if(low[v] >= dfn[u] && u != fa) cut[u] = true;
            if(u == fa) ++ch;
        }
        gmin(low[u], dfn[v]);
    }
    if(ch >= 2 && u == fa) cut[u] = true;
}

int main() {
    n = read(), m = read();
    register int u = 0, v = 0;
    for(register int i = 1; i <= m; ++i) {
        u = read(), v = read();
        add(u, v), add(v, u);
    }
    for(register int i = 1; i <= n; ++i)
        if(!dfn[i]) tarjan(i, i);
    for(register int i = 1; i <= n; ++i)
        if(cut[i]) ++res;
    printf("%d\n", res);
    for(register int i = 1; i <= n; ++i) 
        if(cut[i]) printf("%d ", i);
    return 0;
}
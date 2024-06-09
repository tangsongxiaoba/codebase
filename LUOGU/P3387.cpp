//Luogu P3387 【模板】缩点
#include<cstdio>
#include<cstring>
using namespace std;

const int MAXN = 1e4+10;
const int MAXM = 1e5+10;
int n, m, res;
int fst[MAXM], fstb[MAXM], e, eb;
int we[MAXN], in[MAXN], dis[MAXN];
struct Edge {
    int u, v, nxt;
}a[MAXM], b[MAXM];
int s[MAXN], top;
bool inStack[MAXN];
int low[MAXN], dfn[MAXN], belong[MAXN], bIndex;

inline void add(const int& v, const int& u) {
    a[++e].u = u;
    a[e].v = v;
    a[e].nxt = fst[u];
    fst[u] = e;
}

inline void addb(const int& u, const int& v) {
    b[++eb].u = u;
    b[eb].v = v;
    b[eb].nxt = fstb[u];
    fstb[u] = eb;
}

inline void gmin(int& a, const int& b) {
    if(a > b) a = b;
}

inline void gmax(int& a, const int& b) {
    if(a < b) a = b;
}

inline int read() {
    register int x = 0, f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = -1; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return x*f;
}

void tarjan(const int& u) {
    register int v = 0;
    low[u] = dfn[u] = ++bIndex;
    s[++top] = u, inStack[u] = true;
    for(register int i = fst[u]; i; i = a[i].nxt) {
        v = a[i].v;
        if(!dfn[v]) {
            tarjan(v);
            gmin(low[u], low[v]);
        }
        else if(inStack[v]) gmin(low[u], dfn[v]);
    }
    if(low[u] == dfn[u]) {
        while(v = s[top--]) {
            inStack[v] = false;
            belong[v] = u;
            if(u == v) break;
            we[u] += we[v];
        }
    }
}

inline void tpsort() {
    for(register int i = 1; i <= n; ++i)
        if(belong[i] == i && !in[i]) s[++top] = i, dis[i] = we[i];
    while(top) {
        int u = s[top--];
        for(register int i = fstb[u]; i; i = b[i].nxt) {
            register int &v = b[i].v;
            gmax(dis[v], dis[u] + we[v]);
            if(!(--in[v])) s[++top] = v;
        }
    }
}

int main() {
    n = read(), m = read();
    for(register int i = 1; i <= n; ++i)
        we[i] = read();
    for(register int i = 1; i <= m; ++i)
        add(read(), read());
    for(register int i = 1; i <= n; ++i)
        if(!dfn[i]) tarjan(i);
    register int u = 0, v = 0;
    for(register int i = 1; i <= m; ++i) {
        u = belong[a[i].u], v = belong[a[i].v];
        if(u != v) {
            addb(u, v);
            ++in[v];
        }
    }
    top = 0;
    tpsort();
    for(register int i = 1; i <= n; ++i)
        gmax(res, dis[i]);
    return printf("%d", res), 0;
}
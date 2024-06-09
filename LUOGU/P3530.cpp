//Luogu P3530 [POI2012]FES-Festival
#include<cstdio>
#include<cstring>
using namespace std;

const int MAXN = 610;
const int MAXM = 1e5+10;
int n, m1, m2, res;
int fst[MAXM], e;
struct Edge {
    int v, w, nxt;
}a[MAXM<<1];
int low[MAXN], dfn[MAXN], belong[MAXN], bIndex, scc;
int s[MAXN], top;
bool inStack[MAXN];
int dp[MAXN][MAXN];

inline void add(const register int& u, const register int& v, const register int& w) {
    a[++e].v = v;
    a[e].w = w;
    a[e].nxt = fst[u];
    fst[u] = e;
}

inline void gmax(register int& a, const register int& b) {
    if(a < b) a = b;
}

inline void gmin(register int& a, const register int& b) {
    if(a > b) a = b;
}

inline int read() {
    register int x = 0, f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = -1; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return x*f;
}

void tarjan(const register int& u) {
    register int v;
    dfn[u] = low[u] = ++bIndex;
    s[++top] = u, inStack[u] = true;
    for(register int i = fst[u]; i; i = a[i].nxt) {
        v = a[i].v;
        if(!dfn[v]) {
            tarjan(v);
            gmin(low[u], low[v]);
        }
        else if(inStack[v]) gmin(low[u], dfn[v]);
    }
    if(dfn[u] == low[u]) {
        ++scc;
        do {
            v = s[top--];
            belong[v] = scc;
            inStack[v] = false;
        }while(u != v);
    }
}

int main() {
    memset(dp, 0x3f, sizeof dp);
    n = read(), m1 = read(), m2 = read();
    register int u = 0, v = 0;
    for(register int i = 1; i <= m1; ++i) {
        u = read(), v = read();
        add(u, v, 1), add(v, u, -1);
        gmin(dp[u][v], 1), gmin(dp[v][u], -1);
    }
    for(register int i = 1; i <= m2; ++i) {
        u = read(), v = read();
        add(v, u, 0);
        gmin(dp[v][u], 0);
    }
    for(register int i = 1; i <= n; ++i) {
        if(!dfn[i]) tarjan(i);
        gmin(dp[i][i], 0);
    }
    for(register int c = 1; c <= scc; ++c) {
        register int mx = 0;
        for(register int k = 1; k <= n; ++k) {
            if(belong[k] != c) continue;
            for(register int i = 1; i <= n; ++i) {
                if(belong[i] != c || dp[i][k] == dp[0][0]) continue;
                for(register int j = 1; j <= n; ++j) {
                    if(belong[j] != c || dp[k][j] == dp[0][0]) continue;
                    gmin(dp[i][j], dp[i][k] + dp[k][j]);
                }
            }
        }
        for(register int i = 1; i <= n; ++i) {
            if(belong[i] != c) continue;
            for(register int j = 1; j <= n; ++j) {
                if(belong[j] != c) continue;
                gmax(mx, dp[i][j]);
            }
        }
        res += mx + 1;
    }
    for(register int i = 1; i <= n; ++i) {
        if(dp[i][i] < 0) return puts("NIE"), 0;
    }
    return printf("%d\n", res), 0;
}
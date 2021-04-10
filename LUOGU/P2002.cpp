//Luogu P2002 消息扩散
#include<iostream>
#include<cstdio>
using namespace std;

const int MAXN = 1e5+10;
const int MAXM = 5e5+10;
int fst[MAXM], e;
struct Edge {
    int v, nxt;
}a[MAXM];
bool de[MAXN];
int dfn[MAXN], low[MAXN], belong[MAXN], bIndex, scc;
bool inStack[MAXN];
int s[MAXN], top;
int n, m;
int ans;

inline void add(const int& u, const int& v) {
    a[++e].v = v;
    a[e].nxt = fst[u];
    fst[u] = e;
}

inline void gmin(int &a, const int& b) {
    if(a > b) a = b;
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
    s[top++] = u, inStack[u] = true;
    for(register int i = fst[u]; i; i = a[i].nxt) {
        v = a[i].v;
        if(!dfn[v]) {
            tarjan(v);
            gmin(low[u], low[v]);
        }
        else if(inStack[v]) gmin(low[u], dfn[v]);
    }
    if(low[u] == dfn[u]) {
        ++scc;
        v = s[--top];
        inStack[v] = false;
        belong[v] = scc;
        while(v != u) {
            v = s[--top];
            inStack[v] = false;
            belong[v] = scc;    
        }
    }
}

int main() {
    n = read(), m = read();
    register int u = 0, v = 0;
    for(register int i = 1; i <= m; ++i) {
        u = read(), v = read();
        if(u != v) add(u, v);
    }
    for(register int i = 1; i <= n; ++i)
        if(!dfn[i]) tarjan(i);
    for(register int u = 1; u <= n; ++u)
        for(register int i = fst[u]; i; i = a[i].nxt) {
            v = a[i].v;
            if(belong[u] != belong[v]) 
                de[belong[v]] = true;
        }
    for(register int i = 1; i <= scc; ++i)
        if(!de[i]) ++ans;
    printf("%d\n", ans);
    return 0;
}
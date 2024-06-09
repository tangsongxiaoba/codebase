//Luogu P2341 [USACO03FALL][HAOI2006]受欢迎的牛 G
#include<iostream>
#include<cstdio>
using namespace std;

const int MAXN = 1e4+10;
const int MAXM = 5e4+10;
int fst[MAXM], e;
struct Edge {
    int v, nxt;
}a[MAXM];
int de[MAXN];
int dfn[MAXN], low[MAXN], numb[MAXN], belong[MAXN], bIndex, scc;
bool inStack[MAXN];
int s[MAXN], top;
int n, m;

inline void add(const int& v, const int& u) {
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
        do {
            v = s[--top];
            inStack[v] = false;
            belong[v] = scc;
            ++numb[scc];
        } while(v != u);
    }
}

int main() {
    n = read(), m = read();
    register int v;
    for(register int i = 1; i <= m; ++i)
        add(read(), read());
    for(register int i = 1; i <= n; ++i)
        if(!dfn[i]) tarjan(i);
    for(register int u = 1; u <= n; ++u)
        for(register int i = fst[u]; i; i = a[i].nxt) {
            v = a[i].v;
            if(belong[u] != belong[v]) ++de[belong[u]];
        }
    v = 0;
    for(register int i = 1; i <= scc; ++i)
        if(!de[i]) {
            if(v) return puts("0"), 0;
            v = i;
        }
    printf("%d\n", numb[v]);
    return 0;
}
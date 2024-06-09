//Luogu P3225 [HNOI2012]矿场搭建
#include<cstdio>
#include<cstring>
using namespace std;

const int MAXN = 510;
int n, m;
int fst[MAXN], e;
struct Edge{
    int v, nxt;
}a[MAXN<<1];
int dfn[MAXN], low[MAXN], vis[MAXN];
int bIndex, kase, g, num, ccut, ans1, fa, ch;
long long ans2;
bool cut[MAXN];

inline void add(const int& u, const int& v) {
    a[++e].v = v;
    a[e].nxt = fst[u];
    fst[u] = e;
}

inline void gmin(int &a, const int& b) {
    if(a > b) a = b;
}

inline void gmax(int &a, const int& b) {
    if(a < b) a = b;
}

inline int read() {
    register int x = 0, f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = -1; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return x*f;
}

void tarjan(const int& u, const int& f) {
    register int v = 0;
    dfn[u] = low[u] = ++bIndex;
    for(register int i = fst[u]; i; i = a[i].nxt) {
        v = a[i].v;
        if(!dfn[v]) {
            tarjan(v, u);
            gmin(low[u], low[v]);
            if(low[v] >= dfn[u]) {
                if(u != fa) cut[u] = true;
                else ++ch;
            }
        }
        else if(v != f) gmin(low[u], dfn[v]);
    }
}

void dfs(const int& u) {
    vis[u] = g;
    if(cut[u]) return;
    ++num;
    register int v = 0;
    for(register int i = fst[u]; i; i = a[i].nxt) {
        v = a[i].v;
        if(cut[v] && vis[v] != g) ++ccut, vis[v] = g;
        if(!vis[v]) dfs(v);
    }
}

int main() {
    register long long u = 0, v = 0;
    while(scanf("%d", &m) == 1 && m) {
        memset(fst, 0, sizeof fst);
        memset(dfn, 0, sizeof dfn);
        memset(cut, false, sizeof cut);
        memset(vis, 0, sizeof vis);
        memset(a, 0, sizeof a);
        n = bIndex = g = num = ccut = ans1 = fa = ch = e = 0;
        ans2 = 1;
        printf("Case %d: ", ++kase);
        for(register int i = 1; i <= m; ++i) {
            u = read(), v = read();
            add(u, v), add(v, u);
            gmax(n, u), gmax(n, v);
        }
        for(register int i = 1; i <= n; ++i) {
            if(!dfn[i]) tarjan(fa = i, i);
            if(ch >= 2) cut[fa] = true;
            ch = 0;
        }
        for(register int i = 1; i <= n; ++i) {
            if(!vis[i] && !cut[i]) {
                ++g;
                num = ccut = 0;
                dfs(i);
                if(!ccut) {
                    if(num == 0 || num == 1) continue;
                    ans1 += 2;
                    ans2 *= (num-1) * num / 2;
                }
                if(ccut == 1) {
                    ++ans1;
                    ans2 *= num;
                }
            }
        }
        printf("%d %lld\n", ans1, ans2);
    }
    return 0;
}
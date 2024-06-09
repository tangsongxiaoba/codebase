//Luogu P4551 最长异或路径
#include<iostream>
#include<algorithm>
#include<vector>
#include<cstdio>
#define idx(x) (xorr[x] >> i) & 1;
using namespace std;

const int MAXN = 2e6+10;
struct Edge {
    int v, w, nxt;
} a[MAXN];
int fst[MAXN], e, n, xorr[MAXN], trie[MAXN][3], sz, maxx;

inline void add(const int& u, const int& v, const int& w) {
    a[++e].v = v;
    a[e].w = w;
    a[e].nxt = fst[u];
    fst[u] = e;
}

inline int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

void dfs(const int& u, const int& fa) {
    register int v = 0;
    for(register int i = fst[u]; i; i = a[i].nxt) {
        v = a[i].v;
        if(v != fa) {
            xorr[v] = xorr[u] ^ a[i].w;
            dfs(v, u);
        }
    }
}

inline void insert(const int& x) {
    register int u = 0, c = 0;
    for(register int i = 30; i >= 0; --i) {
        c = idx(x);
        if(!trie[u][c]) trie[u][c] = ++sz;
        u = trie[u][c];
    }
}

inline int query(const int& x) {
    register int u = 0, c = 0, ans = 0;
    for(register int i = 30; i >= 0; --i) {
        c = idx(x);
        if(trie[u][!c]) u = trie[u][!c], ans += 1 << i;
        else u = trie[u][c];
    }
    return ans;
}

inline void gmax(int& a, const int& b) {
    if(a < b) a = b;
}

int main() {
    n = read();
    register int u, v, w;
    for(register int i = 1; i < n; ++i) {
        u = read(), v = read(), w = read();
        add(u, v, w);
        add(v, u, w);
    }
    dfs(1, 0);
    for(register int i = 1; i <= n; ++i) insert(i);
    for(register int i = 1; i <= n; ++i) gmax(maxx, query(i));
    printf("%d\n", maxx);
    return 0;
}
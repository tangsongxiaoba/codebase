//Luogu P2922 [USACO08DEC]Secret Message G
#include<iostream>
#include<cstdio>
using namespace std;

const int MAXN = 5e6+10;
int n, m, a[50000], q[500000];

struct Trie {
    int ch[MAXN][3];
    int val[500000];
    int sz;

    inline Trie() {sz = 0; memset(ch[0], 0, sizeof ch[0]); }

    inline void clear() {sz = 0; memset(ch[0], 0, sizeof ch[0]); }

    #define idx(c) (c - 'a')

    inline void insert(const int& l) {
        register int u = 0;
        for(register int i = 1; i <= l; ++i) {
            if(!ch[u][a[i]]) ch[u][a[i]] = ++sz;
            u = ch[u][a[i]];
            ++q[u];
        }
        ++val[u];
    }

    inline int query(const int& l) {
        register int u = 0, ans = 0;
        for(register int i = 1; i <= l; ++i) {
            if(!ch[u][a[i]]) return ans;
            u = ch[u][a[i]];
            ans += val[u];
        }
        return ans + q[u] - val[u];
    }
} trie;

inline int read() {
    register int x = 0;
    register bool f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = 0; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?x:-x;
}

int main() {
    n = read(), m = read();
    register int x;
    for(register int i = 1; i <= n; ++i) {
        x = read();
        for(register int j = 1; j <= x; ++j) a[j] = read();
        trie.insert(x);
    }
    for(register int i = 1; i <= m; ++i) {
        x = read();
        for(register int j = 1; j <= x; ++j) a[j] = read();
        printf("%d\n", trie.query(x));
    }
    return 0;
}
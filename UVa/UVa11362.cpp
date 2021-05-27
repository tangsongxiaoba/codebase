//UVA11362 Phone List
#include<cstdio>
#include<cstring>

const int MAXN = 1e5+10;
const int SS = 20;

struct Trie {
    int ch[MAXN][SS];
    bool p[MAXN];
    int sz;
    
    inline Trie() {sz = 0; memset(ch, 0, sizeof ch); }
    
    inline void clear() {
        memset(ch, 0, sizeof ch);
        memset(p, 0, sizeof p);
        sz = 0;
    }

    #define idx(c) (c - '0')
    
    inline bool insert(const char* s) {
        register int u = 0, n = strlen(s), c = 0;
        register bool o = 1, o1 = 0;
        for(register int i = 0; i < n; ++i) {
            c = idx(s[i]);
            if(!ch[u][c]) ch[u][c] = ++sz, o = 0;
            u = ch[u][c];
            if(p[u]) o1 = 1;
        }
        p[u] = 1;
        if(o || o1) return 1;
        return 0;
    }
};

int T, n;
bool ans = 0;
char s[SS];
Trie trie;

inline int read() {
    register int x = 0;
    register bool f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = 0; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?x:-x;
}

int main() {
    T = read();
    while(T--) {
        trie.clear();
        ans = 0;
        n = read();
        for(register int i = 1; i <= n; ++i) {
            scanf("%s", s);
            if(trie.insert(s)) ans = 1;
        }
        if(ans) puts("NO");
        else puts("YES");
    }
    return 0;
}
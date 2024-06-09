//Luogu P2580 于是他错误的点名开始了
#include<iostream>
#include<cstdio>
#include<cstring>
using namespace std;

const int MAXN = 5e5+10;
const int SS = 26;

struct Trie {
    int ch[MAXN][SS];
    int val[MAXN];
    int sz;
    
    inline Trie() {sz = 1; memset(ch[0], 0, sizeof ch[0]); }
    
    inline int idx(const char& c) {return c - 'a'; }
    
    inline void insert(const char* s) {
        register int u = 0, n = strlen(s), c = 0;
        for(register int i = 0; i < n; ++i) {
            c = idx(s[i]);
            if(!ch[u][c]) {
                memset(ch[sz], 0, sizeof ch[sz]);
                ch[u][c] = sz++;
            }
            u = ch[u][c];
        }
    }

    inline int search(const char* s) {
        register int u = 0, n = strlen(s), c = 0;
        for(register int i = 0; i < n; ++i) {
            c = idx(s[i]);
            if(!ch[u][c]) return 0;
            u = ch[u][c];
        }
        if(!val[u]) {
            return val[u] = 1;
        }
        return 2;
    }
};

int n, m, o;
char s[60];
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
    n = read();
    for(register int i = 1; i <= n; ++i) {
        scanf("%s", s);
        trie.insert(s);
    }
    m = read();
    for(register int i = 1; i <= m; ++i) {
        scanf("%s", s);
        o = trie.search(s);
        if(!o) puts("WRONG");
        else if(o == 1) puts("OK");
        else if(o == 2) puts("REPEAT");
    }
    return 0;
}
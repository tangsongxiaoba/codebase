//Luogu P2292 [HNOI2004]L语言
#include<iostream>
#include<map>
#include<cstdio>
#include<cstring>
using namespace std;

const int MAXN = 2e6+10;
map<string, bool> m1;
map<string, int> m2;
int n, m, o;
char s[MAXN];
bool f[MAXN];

struct Trie {
    int ch[1010][30];
    bool p[10010];
    int sz;
    
    inline Trie() {sz = 0; memset(ch, 0, sizeof ch); }
    
    inline int idx(const char& c) {return c - 'a'; }
    
    inline void insert(const char* s) {
        register int u = 0, len = strlen(s+1), c = 0;
        for(register int i = 1; i <= len; ++i) {
            c = idx(s[i]);
            if(!ch[u][c]) {
                ch[u][c] = ++sz;
            }
            u = ch[u][c];
        }
        p[u] = 1;
    }

    inline int search(const char* s, const int& l, const int& r) {
        register int u = 0, c = 0;
        for(register int i = l; i <= r; ++i) {
            c = idx(s[i]);
            if(!ch[u][c]) return 0;
            u = ch[u][c];
            if(p[u]) f[i] = 1;
        }
        return p[u];
    }
};
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
    n = read(); m = read();
    while(n--) {
        scanf("%s", s+1);
        trie.insert(s);
    }
    int len = 0, ans = 0;
    while(m--) {
        scanf("%s", s+1);
        if(m1[s+1]) printf("%d\n", m2[s+1]);
        else {
            len = strlen(s+1);
            memset(f, 0, sizeof f);
            f[0] = 1;
            for(register int i = 0; i <= len; ++i) {
                if(!f[i]) continue;
                else ans = i;
                trie.search(s, i+1, len);
            }
            m1[s+1] = true;
            m2[s+1] = ans;
            printf("%d\n", ans);
        }
    }
    return 0;
}
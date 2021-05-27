//UVA1401/LA3942 Remember the Word
#include<cstring>
#include<vector>
#include<cstdio>
using namespace std;

const int MAXL = 3e5+10;
const int MAXW = 4e3+10;
const int MAXWL = 1e2+10;
const int MAXN = 4e5+10;
const int MOD = 20071027;
const int SS = 26;

struct Trie {
    int ch[MAXN][SS];
    int val[MAXN];
    int sz;

    inline Trie() {sz = 1; memset(ch[0], 0, sizeof ch[0]); }

    inline void clear() {sz = 1; memset(ch[0], 0, sizeof ch[0]); }

    #define idx(c) (c - 'a')

    inline void insert(const char* s, const int& v) {
        register int u = 0, n = strlen(s), c = 0;
        for(register int i = 0; i < n; ++i) {
            c = idx(s[i]);
            if(!ch[u][c]) {
                memset(ch[sz], 0, sizeof ch[sz]);
                val[sz] = 0;
                ch[u][c] = sz++;
            }
            u = ch[u][c];
        }
        val[u] = v;
    }

    inline void find_pf(const char* s, const int& len, vector<int>& ans) {
        register int u = 0, c = 0;
        for(register int i = 0; i < len; ++i) {
            if(s[i] == '\0') break;
            c = idx(s[i]);
            if(!ch[u][c]) break;
            u = ch[u][c];
            if(val[u]) ans.push_back(val[u]);
        }
    }
};

int d[MAXL], len[MAXW], S;
char txt[MAXL], wrd[MAXWL];
Trie trie;

int main() {
    int T = 0;
    while(scanf("%s%d", txt, &S) == 2) {
        trie.clear();
        for(register int i = 1; i <= S; ++i) {
            scanf("%s", wrd);
            len[i] = strlen(wrd);
            trie.insert(wrd, i);
        }
        memset(d, 0, sizeof d);
        int L = strlen(txt);
        d[L] = 1;
        for(register int i = L-1; i >= 0; --i) {
            vector<int> p;
            trie.find_pf(txt+i, L - i, p);
            for(register int j = 0; j < (int)p.size(); ++j) 
                d[i] = (d[i] + d[i+len[p[j]]]) % MOD;
        }
        printf("Case %d: %d\n", ++T, d[0]);
    }
    return 0;
}
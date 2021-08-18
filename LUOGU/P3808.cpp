//Luogu P3808 【模板】AC自动机（简单版）
#include<bits/stdc++.h>
#define maxn 500010
using namespace std;

queue<int> q;
int n;
char p[1000005];

struct Aho_Corasick_Automaton {
    int c[maxn][26], val[maxn], fail[maxn], cnt;
    void insert(char *s) {
        int len = strlen(s);
        int u = 0;
        for(int i = 0; i < len; ++i){
            int v = s[i] - 'a';
            if(!c[u][v]) c[u][v] = ++cnt;
            u = c[u][v];
        }
        ++val[u];
    }
    void build() {
        for(int i = 0; i < 26; ++i) 
            if(c[0][i]) fail[c[0][i]] = 0, q.push(c[0][i]);
        while(!q.empty()) {
            int u = q.front();
            q.pop();
            for(int i = 0; i < 26; ++i)
            if(c[u][i]) fail[c[u][i]] = c[fail[u]][i], q.push(c[u][i]);
            else c[u][i] = c[fail[u]][i];
        }
    }
    int query(char *s) {
        int len = strlen(s);
        int u = 0, ans = 0;
        for(int i = 0; i < len; ++i) {
            u = c[u][s[i]-'a'];
            for(int t = u; t && ~val[t]; t = fail[t]) ans += val[t], val[t] = -1;
        }
        return ans;
    }
} AC;

int main() {
    scanf("%d", &n);
    for(int i = 1; i <= n; ++i) {
        scanf("%s", p);
        AC.insert(p);
    }
    AC.build();
    scanf("%s", p);
    int ans = AC.query(p);
    printf("%d", ans);
    return 0;
}
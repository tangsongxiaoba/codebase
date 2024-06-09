//Luogu P1137 旅行计划
#include<iostream>
#include<cstdio>
#include<algorithm>
#include<queue>
using namespace std;

const int MAXN = 1e5+10;
const int MAXM = 2e5+10;
int n, m, e, tot;
int fst[MAXM], in[MAXN], num[MAXN], dp[MAXN];
struct node {
    int u, v, nxt;
}a[MAXM<<1];

inline void add(const int &u, const int &v) {
    a[++e].u = u, a[e].v = v;
    a[e].nxt = fst[u], fst[u] = e;
}

inline int read() {
    register int x = 0, f = 1;
    char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = -1; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return x*f;
}

inline void tpsort() {
    queue<int> q;
    for(register int i = 1; i <= n; ++i)
        if(!in[i]) q.push(i), num[++tot] = i;
    while(!q.empty()) {
        int u = q.front(); q.pop();
        for(register int i = fst[u]; i; i = a[i].nxt) {
            register int &v = a[i].v; --in[v];
            if(!in[v]) q.push(v), num[++tot] = v;
        }
    }
}

inline void gmax(int &x, const int &y) {
    if(x < y) x = y;
}

int main() {
    n = read(), m = read();
    for(register int i = 1; i <= m; ++i) {
        register int u = read(), v = read();
        add(u, v), ++in[v];
    }
    tpsort();
    for(register int i = 1; i <= n; ++i) dp[i] = 1;
    for(register int i = 1; i <= n; ++i) {
        register int u = num[i];
        for(register int j = fst[u]; j; j = a[j].nxt) {
            register int &v = a[j].v;
            gmax(dp[v], dp[u] + 1);
        }
    }
    for(register int i = 1; i <= n; ++i) printf("%d\n", dp[i]);
    return 0;
}
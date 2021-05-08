//Luogu P3379 【模板】最近公共祖先（LCA）
#include<iostream>
#include<cstdio>
using namespace std;

const int MAXM = 5e5+10;
int n, m, s, e, q;
bool b[MAXM];
int fst[MAXM], que[MAXM], fa[MAXM], ans[MAXM];
struct Edge {
    int v, nxt;
} a[MAXM<<1];
struct Node {
    int v, nxt, same, num;
    bool flag;
    Node(register bool flag = false) : flag() {}
} Q[MAXM<<1];

inline int read() {
    register int x = 0, f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = 0; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?x:-x;
}

inline void add(const int& u, const int& v) {
    a[++e].v = v;
    a[e].nxt = fst[u];
    fst[u] = e;
}

inline void addQ(const int& u, const int& v, const int& w) {
    Q[++q].v = v;
    Q[q].same = q+1;
    Q[q].nxt = que[u];
    Q[q].num = w;
    que[u] = q;
    Q[++q].v = u;
    Q[q].same = q-1;
    Q[q].nxt = que[v];
    Q[q].num = w;
    que[v] = q;
}

int findFa(const int& x) {
    if(fa[x] == x) return x;
    return fa[x] = findFa(fa[x]);
}

void LCA(const int& u, const int& f) {
    register int v = 0;
    for(register int i = fst[u]; i; i = a[i].nxt) {
        v = a[i].v;
        if(v != f && !b[v]) {
            LCA(v, u);
            fa[findFa(v)] = findFa(u);
            b[v] = true;
        }
    }
    for(register int i = que[u]; i; i = Q[i].nxt) {
        v = Q[i].v;
        if(!Q[i].flag && b[v]) {
            ans[Q[i].num] = findFa(v);
            Q[i].flag = Q[Q[i].same].flag = true;
        }
    }
}

int main() {
    n = read(), m = read(), s = read();
    for(register int i = 1; i <= n; ++i) fa[i] = i;
    register int u, v;
    for(register int i = 1; i < n; ++i) {
        u = read(), v = read();
        add(u, v);
        add(v, u);
    }
    for(register int i = 1; i <= m; ++i) {
        u = read(), v = read();
        addQ(u, v, i);
    }
    LCA(s, 0);
    for(register int i = 1; i <= m; ++i) 
        printf("%d\n", ans[i]);
    return 0;
}
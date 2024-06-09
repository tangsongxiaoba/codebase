//Luogu P3369 【模板】普通平衡树
#include<cstdio>
#include<algorithm>
#define pushup(o) (t[o].v = t[t[o].lc].v + t[t[o].rc].v)
using namespace std;

const int MAXN = 1e5+10;
struct seg {
    int v, lc, rc;
} t[MAXN<<8];
int rt[MAXN<<2], cnt, n, m;
int a[MAXN<<2], tot;
int node[MAXN<<2];

inline int read() {
    register int x = 0;
    register bool f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = 0; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?x:-x;
}

void change(const int& lsto, int &o, const int& l, const int& r, const int& q, const int& v) {
    if(!o) o = ++cnt;
    if(l == r) {
        t[o].v += v;
        return;
    }
    register int mid = (l+r)>>1;
    if(q <= mid) {
        t[o].rc = t[lsto].rc;
        t[o].lc = ++cnt;
        t[t[o].lc] = t[t[lsto].lc];
        change(t[lsto].lc, t[o].lc, l, mid, q, v);
    }
    else {
        t[o].lc = t[lsto].lc;
        t[o].rc = ++cnt;
        t[t[o].rc] = t[t[lsto].rc];
        change(t[lsto].rc, t[o].rc, mid+1, r, q, v);
    }
    pushup(o);
}

int query(const int& o1, const int& o2, const int& l, const int& r, const int& q) {
    if(l == r) return l;
    register int mid = (l+r) >> 1, tmp = t[t[o2].lc].v - t[t[o1].lc].v;
    if(tmp >= q) return query(t[o1].lc, t[o2].lc, l, mid, q);
    else return query(t[o1].rc, t[o2].rc, mid+1, r, q-tmp);
}

int main() {
    n = read(), m = read();
    for(register int i = 1; i <= n; ++i) {
        node[i] = read();
        a[i] = node[i];
    }
    sort(a+1, a+n+1);
    tot = unique(a+1, a+n+1)-a-1;
    for(register int i = 1; i <= n; ++i) {
        node[i] = lower_bound(a+1, a+tot+1, node[i]) -a;
        change(rt[i-1], rt[i], 1, tot, node[i], 1);
    }
    while(m--) {
        register int l = read(), r = read(), q = read();
        printf("%d\n", a[query(rt[l-1], rt[r], 1, tot, q)]);
    }
    return 0;
}
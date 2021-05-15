//Luogu P3369 【模板】普通平衡树
#include<cstdio>
#include<algorithm>
#define ls (o<<1)
#define rs (o<<1|1)
#define pushup(o) (t[o] = t[ls] + t[rs])
using namespace std;

const int MAXN = 1e5+10;
int t[MAXN<<2];
int a[MAXN<<2], tot, n;
struct Node {
    int o, v;
} node[MAXN<<2];

inline int read() {
    register int x = 0;
    register bool f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = 0; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?x:-x;
}

void change(const int& o, const int& l, const int& r, const int& q, const int& v) {
    if(l == r) {
        t[o] += v;
        return;
    }
    register int mid = (l+r)>>1;
    if(q <= mid) change(ls, l, mid, q, v);
    else change(rs, mid+1, r, q, v);
    pushup(o);
}

int query_r(const int& o, const int& l, const int& r, const int& ql, const int& qr) {
    if(ql <= l && r <= qr) return t[o];
    register int mid = (l+r)>>1, ans = 0;
    if(ql <= mid) ans += query_r(ls, l, mid, ql, qr);
    if(qr > mid) ans += query_r(rs, mid+1, r, ql, qr);
    return ans;
}

int query_n(const int& o, const int& l, const int& r, const int& q) {
    if(l == r) return l;
    register int mid = (l+r) >> 1;
    if(t[ls] >= q) return query_n(ls, l, mid, q);
    else return query_n(rs, mid+1, r, q-t[ls]);
}

int main() {
    n = read();
    for(register int i = 1; i <= n; ++i) {
        node[i].o = read(), node[i].v = read();
        if(node[i].o == 4) continue;
        a[++tot] = node[i].v;
    }
    sort(a+1, a+tot+1);
    tot = unique(a+1, a+tot+1)-a-1;
    for(register int i = 1; i <= n; ++i) {
        if(node[i].o != 4) node[i].v = lower_bound(a+1, a+tot+1, node[i].v) -a;
        if(node[i].o == 1) change(1, 1, tot, node[i].v, 1);
        if(node[i].o == 2) change(1, 1, tot, node[i].v, -1);
        if(node[i].o == 3) {
            if(node[i].v == 1) {
                puts("1");
                continue;
            }
            printf("%d\n", query_r(1, 1, tot, 1, node[i].v -1) + 1);
        }
        if(node[i].o == 4) printf("%d\n", a[query_n(1, 1, tot, node[i].v)]);
        if(node[i].o == 5) {
            int rank = query_r(1, 1, tot, 1, node[i].v-1);
            printf("%d\n", a[query_n(1, 1, tot, rank)]);
        }
        if(node[i].o == 6) {
            int rank = query_r(1, 1, tot, 1, node[i].v)+1;
            printf("%d\n", a[query_n(1, 1, tot, rank)]);
        }
    }
    return 0;
}
//Luogu P3372 【模板】线段树 1
#include<cstdio>
#define ll long long
#define ls ((o) << 1)
#define rs ((o) << 1 | 1)

const int MAXN = 1e5+10;
int n, m;
ll a[MAXN], sum[MAXN<<2], tag[MAXN<<2];

inline ll read() {
    register int x = 0, f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = -1; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return x*f;
}

void build(const int& o, const int& L, const int& R) {
    if(L == R) {sum[o] = a[L]; return;}
    register int M = (L+R) >> 1;
    build(ls, L, M);
    build(rs, M+1, R);
    sum[o] = sum[ls] + sum[rs];
}

inline void pushdown(const int& o, const int& L, const int& R) {
    register int M = (L+R) >> 1;
    sum[ls] += tag[o] * (M-L+1);
    tag[ls] += tag[o];
    sum[rs] += tag[o] * (R-M);
    tag[rs] += tag[o];
    tag[o] = 0;
}


void add(const int& o, const int& L, const int& R, const int& x, const int& y, const ll& k) {
    if(x <= L && R <= y) {
        sum[o] += k * (R-L + 1);
        tag[o] += k;
        return;
    }
    pushdown(o, L, R);
    register int M = (L+R) >> 1;
    if(x <= M) add(ls, L, M, x, y, k);
    if(y > M) add(rs, M+1, R, x, y, k);
    sum[o] = sum[ls] + sum[rs];
}

ll query(const int& o, const int& L, const int& R, const int& x, const int& y) {
    if(x <= L && R <= y) return sum[o];
    pushdown(o, L, R);
    int M = (L+R) >> 1;
    ll res = 0;
    if(x <= M) res += query(ls, L, M, x, y);
    if(y > M) res += query(rs, M+1, R, x, y);
    return res;
}

int main() {
    n = read(), m = read();
    for(register int i = 1; i <= n; ++i) a[i] = read();
    build(1, 1, n);
    int opt, qL, qR;
    long long k;
    while(m--) {
        opt = read(), qL = read(), qR = read();
        if(opt == 1) {
            k = read();
            add(1, 1, n, qL, qR, k);
        }
        else {
            printf("%lld\n", query(1, 1, n, qL, qR));
        }
    }
    return 0;
}
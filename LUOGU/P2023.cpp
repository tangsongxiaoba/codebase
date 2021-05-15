//Luogu P2023 [AHOI2009] 维护序列
#include<cstdio>
#define ll long long
#define ls ((o) << 1)
#define rs ((o) << 1 | 1)

const int MAXN = 1e5+10;
int n, m, MOD;
ll a[MAXN], sumv[MAXN<<2], addv[MAXN<<2], mulv[MAXN<<2];

inline ll read() {
    register int x = 0, f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = -1; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return x*f;
}

void build(const int& o, const int& l, const int& r) {
    mulv[o] = 1;
    if(l == r) {sumv[o] = a[l] % MOD; return;}
    register int M = (l+r) >> 1;
    build(ls, l, M);
    build(rs, M+1, r);
    (sumv[o] = sumv[ls] + sumv[rs]) %= MOD;
}

inline void pushdown(const int& o, const int& l, const int& r) {
    register int M = (l+r) >> 1;
    (sumv[ls] = sumv[ls] * mulv[o] + addv[o] * (M-l+1)) %= MOD;
    (sumv[rs] = sumv[rs] * mulv[o] + addv[o] * (r-M)) %= MOD;
    (mulv[ls] *= mulv[o]) %= MOD;
    (mulv[rs] *= mulv[o]) %= MOD;
    (addv[ls] = addv[ls] * mulv[o] + addv[o]) %= MOD;
    (addv[rs] = addv[rs] * mulv[o] + addv[o]) %= MOD;
    mulv[o] = 1, addv[o] = 0;
}

void mul(const int& o, const int& l, const int& r, const int& x, const int& y, const ll& k) {
    if(y < l || r < x) return;
    if(x <= l && r <= y) {
        (sumv[o] *= k) %= MOD;
        (addv[o] *= k) %= MOD;
        (mulv[o] *= k) %= MOD;
        return;
    }
    pushdown(o, l, r);
    int M = (l+r) >> 1;
    mul(ls, l, M, x, y, k);
    mul(rs, M+1, r, x, y, k);
    (sumv[o] = sumv[ls] + sumv[rs]) %= MOD;
}

void add(const int& o, const int& l, const int& r, const int& x, const int& y, const ll& k) {
    if(y < l || r < x) return;
    if(x <= l && r <= y) {
        (sumv[o] += k * (r-l + 1)) %= MOD;
        (addv[o] += k) %= MOD;
        return;
    }
    pushdown(o, l, r);
    int M = (l+r) >> 1;
    add(ls, l, M, x, y, k);
    add(rs, M+1, r, x, y, k);
    (sumv[o] = sumv[ls] + sumv[rs]) %= MOD;
}

long long query(const int& o, const int& l, const int& r, const int& x, const int& y) {
    if(y < l || r < x) return 0;
    if(x <= l && r <= y) return sumv[o];
    pushdown(o, l, r);
    int M = (l+r) >> 1;
    return ((query(ls, l, M, x, y) + query(rs, M+1, r, x, y))) % MOD;
}

int main() {
    n = read(), MOD = read();
    for(register int i = 1; i <= n; ++i) a[i] = read();
    m = read();
    build(1, 1, n);
    int opt, qL, qR;
    ll k;
    while(m--) {
        opt = read(), qL = read(), qR = read();
        if(opt == 1) {
            k = read();
            mul(1, 1, n, qL, qR, k);
        }
        else if(opt == 2) {
            k = read();
            add(1, 1, n, qL, qR, k);
        }
        else printf("%lld\n", query(1, 1, n, qL, qR));
    } 
    return 0;
}
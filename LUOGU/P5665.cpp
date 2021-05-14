//Luogu P5665 [CSP-S2019] 划分
#include<cstdio>
#include<cstring>
#define ll long long

const unsigned ll BASE = 1000000000ULL;
const unsigned ll WIDTH = 9;
const int N = 20;
struct bint {
    unsigned ll ln, v[N];
    bint() { ln = 0; memset(v, 0, sizeof v);}
    bint operator = (ll rhs) {
       ln = 0;
       while(rhs) {
           v[++ln] = rhs % BASE;
           rhs /= BASE;
       }
       return *this;
    }
};

bint operator + (const bint& a, const bint& b) {
    bint res; res.ln = (a.ln > b.ln ? a.ln : b.ln); int p = 0;
    for(register int i = 1; i <= res.ln; ++i) {
        res.v[i] = a.v[i] + b.v[i] + p;
        p = res.v[i] / BASE;
        res.v[i] %= BASE;
    }
    if(p) res.v[++res.ln] = p;
    return res;
}

bint square(const bint& a) {
    bint res; res.ln = (a.ln << 1) - 1; int p = 0;
    for(register int i = 1; i <= a.ln; ++i) 
        for(register int j = 1; j <= a.ln; ++j)
            res.v[i+j-1] += a.v[i] * a.v[j];
    for(register int i = 1; i <= res.ln; ++i) {
        res.v[i] += p;
        p = res.v[i] / BASE;
        res.v[i] %= BASE;
    }
    while(p) {
        res.v[++res.ln] = p % BASE;
        p /= BASE;
    }
    return res;
}

inline void bwrite(const bint& v) {
    printf("%llu", v.v[v.ln]);
    for(register int i = v.ln - 1; i; --i) printf("%09llu", v.v[i]);
}

const int MOD = (1 << 30) - 1;
const int MAXN = 4e7+10;
const int MAXM = 1e5+10;
int n, type, aa, q[MAXN], b[MAXN], l[MAXM], r[MAXM], p[MAXM], g[MAXN];
ll sum[MAXN];
bint ans;

inline ll read() {
    register ll x = 0;
    register bool f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = 0; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?x:-x;
}

int main() {
    n = read(), type = read();
    if(!type) for(register int i = 1; i <= n; sum[i] = sum[i-1] + aa, ++i) aa = read();
    else {
        register int x, y, z, m;
        x = read(); y = read(); z = read(); b[1] = read(); b[2] = read(); m = read();
        for(register int i = 1; i <= m; ++i) {
            p[i] = read(); l[i] = read(); r[i] = read();
        }
        for(register int i = 3; i <= n; ++i) b[i] = ((1LL * x * b[i-1] & MOD) + (1LL * y * b[i-2] & MOD) + z) & MOD;
        for(register int j = 1; j <= m; ++j)
            for(register int i = p[j-1] + 1; i <= p[j]; sum[i] = sum[i-1] + aa, ++i) aa = b[i] % (r[j] - l[j] + 1) + l[j];
    }
    register int l = 1, r = 1;
    for(register int i = 1; i <= n; ++i) {
        while(l < r && ((sum[q[l+1]] << 1) - sum[g[q[l+1]]]) <= sum[i]) ++l;
        g[i] = q[l];
        while(l <= r && ((sum[q[r]] << 1) - sum[g[q[r]]]) >= ((sum[i] << 1) - sum[g[i]])) --r;
        q[++r] = i;
    }
    for(register int i = n; i; i = g[i]) {
        bint tmp;
        tmp = sum[i] - sum[g[i]];
        ans = ans + square(tmp); 
    }
    bwrite(ans);
    return 0;
}
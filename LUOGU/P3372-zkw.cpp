//Luogu P3372 【模板】线段树 1
#include<cstdio>
#define ll long long
#define ls ((o) << 1)
#define rs ((o) << 1 | 1)

const int MAXN = 1e5+10;
int n, m;
ll s[MAXN], a[MAXN], b[MAXN];

inline ll read() {
    register int x = 0, f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = -1; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return x*f;
}

int main() {
    n = read(), m = read();
    register int x, y, k;
    ll ans;
    for(register int i = 1; i <= n; ++i) s[i] = read() + s[i-1];
    while(m--) {
        if(1 == read()) {
            x = read(), y = read(), k = read();
            for(register int i = x; i <= n; i += i & -i) a[i] += k, b[i] += (x-1) * k;
            for(register int i = y+1; i <= n; i += i & -i) a[i] -= k, b[i] -= y * k;
        }
        else {
            x = read(), y = read(), ans = s[y] - s[x-1];
            for(register int i = y; i; i -= i & -i) ans += 1LL * a[i] * y - b[i];
            for(register int i = x-1; i; i -= i & -i) ans -= a[i] * (x-1) - b[i];
            printf("%lld\n", ans);
        }
    }
    return 0;
}
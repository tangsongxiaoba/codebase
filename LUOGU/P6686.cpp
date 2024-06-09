//Luogu P6686 混凝土数学
#include<iostream>
#include<cstdio>
using namespace std;

const int MAXN = 2e5+10;
const int MOD = 998244353;
long long f[MAXN], ans;
int n, m, k, a, l = 1;

inline int read() {
    register int x = 0, f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = -1; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return x*f;
}

int main() {
    n = read();
    for(register int i = 1; i <= n; ++i) 
        a = read(), ++f[a], m = m < a ? a : m;
    for(register int i = 1; i <= m; ++i) {
        for(; l < i * 2 && l <= m; ++l) 
            k += f[l];
        ans += (f[i] - 1) * f[i] * (k - f[i]) / 2 + (f[i] - 2) * (f[i] - 1) * f[i] / 6;
    }
    printf("%lld", ans % MOD);
    return 0;
}
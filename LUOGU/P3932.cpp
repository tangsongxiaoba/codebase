//Luogu P3932 浮游大陆的68号岛
#include<bits/stdc++.h>
#define mod 19260817
#define maxn 200010
using namespace std;

int n, m;
int d[maxn], a[maxn], c[maxn];

inline int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = x * 10 + (c ^ 48), c = getchar();
    return f?-x:x;
}

int main() {
    n = read(), m = read() + 1;
    for(register int i = 1; i < n; ++i) {
        d[i] = read(); 
        d[i] = (d[i] % mod + d[i-1]) % mod;
    }
    for(register int i = 1; i <= n; ++i) {
        a[i] = read();
        c[i] = (c[i-1] + 1LL * a[i] * d[i-1] % mod) % mod;
        a[i] = (a[i] % mod + a[i-1]) % mod;
    }
    int x, l, r;
    while(--m) {
        x = read(), l = read(), r = read();
        if(x < l) printf("%d\n", ((((c[r]-c[l-1])%mod+mod)%mod-1LL*d[x-1]*(a[r]-a[l-1])%mod)%mod+mod)%mod);
        else if(x > r) printf("%d\n", (1LL*d[x-1]*(((a[r]-a[l-1])%mod)+mod)%mod+((c[l-1]-c[r])%mod+mod)%mod)%mod);
        else printf("%d\n", ((1LL*d[x-1]*(((((a[x]-a[l-1])%mod+mod)%mod-a[r])%mod+mod)%mod+a[x])%mod-2LL*c[x]%mod+(c[l-1]+c[r])%mod)%mod+mod)%mod);
    }
    return 0;
}
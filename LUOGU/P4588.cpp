//Luogu P4588 [TJOI2018]数学计算
#include<iostream>
#include<cstdio>
#define ll long long

const int MAXN = 1e5+10;
ll t[MAXN<<2];
int n, M = 1, T, mod, p;

inline ll read() {
    register ll x = 0;
    register bool f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = 0; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?x:-x;
}

int main() {
    T = read();
    while(T--) {
        n = read(), mod = read();
        while(M <= n) {M <<= 1;}
        std::fill(t+1, t+M+n+2, 1);
        for(register int i = 1; i <= n; ++i) {
            register ll a = read(), b = read();
            if(a == 1) {
                p = i + M;
                t[p] = b % mod;
            }
            else {
                p = b + M;
                t[p] = 1;
            }
            while(p >>= 1) t[p] = t[p<<1] * t[p<<1|1] % mod;
            printf("%lld\n", t[1]);
        }
    }
    return 0;
}

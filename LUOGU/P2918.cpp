//Luogu P2918 [USACO08NOV]Buying Hay S
#include<cstdio>
#define maxn 55010
#define maxm 5010

int w[105], v[105];
int f[maxn];
int res = 0x3f3f3f3f, n, h;

inline int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

inline void gmin(int& a, const int& b) {
    if(a > b) a = b;
}

int main() {
    n = read(), h = read();
    for(register int i = 1; i <= n; ++i) w[i] = read(), v[i] = read();
    for(register int i = 1; i <= h + maxm; ++i) f[i] = res;
    for(register int i = 1; i <= n; ++i)
        for(register int j = w[i]; j <= h + maxm; ++j)
            gmin(f[j], f[j-w[i]] + v[i]);
    for(register int i = h; i <= h+maxm; ++i) gmin(res, f[i]);
    printf("%d", res);
    return 0;
}
//Luogu P5020 [NOIP2018 提高组] 货币系统
#include<cstdio>
#include<cstring>
#include<algorithm>
#define maxn 110
#define maxm 25010

int ans, n, f[maxm], a[maxn];

inline int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int main() {
    int T = read();
    while(T--) {
        memset(f, 0, sizeof f);
        ans = n = read();
        for(register int i = 1; i <= n; ++i) a[i] = read();
        std::sort(a+1, a+n+1);
        f[0] = 1;
        for(register int i = 1; i <= n; ++i) {
            if(f[a[i]]) {
                --ans;
                continue;
            }
            for(register int j = a[i]; j <= a[n]; ++j)
                f[j] |= f[j-a[i]];
        }
        printf("%d\n", ans);
    }
    return 0;
}
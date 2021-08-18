//Luogu P2224 [HNOI2001]产品加工
#include<cstdio>
// #include<algorithm>
#include<cstring>
// #define N 6010

inline int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int f[2][30005];

inline int max(int a, int b) {
    if(a > b) return a;
    return b;
}

inline int min(int a, int b) {
    if(a < b) return a;
    return b;
}

int main() {
    int n = read(), s = 0, i, j, x, y, z, ans = 0x7fffffff;
    memset(f, 0x7f, sizeof f);
    f[0][0] = 0;
    for(i = 1; i <= n; ++i) {
        memset(f[i&1], 0x3f, sizeof f[i&1]);
        x = read(), y = read(), z = read();
        s += max(x, max(y, z));
        for(j = 0; j <= s; ++j) {
            if(y) f[i&1][j] = min(f[i&1][j], f[(i&1)^1][j] + y);
            if(x && j >= x) f[i&1][j] = min(f[i&1][j], f[(i&1)^1][j-x]);
            if(z && j >= z) f[i&1][j] = min(f[i&1][j], f[(i&1)^1][j-z] + z);
        }
    }
    for(i = 0; i <= s; ++i) ans = min(ans, max(i, f[n&1][i]));
    printf("%d", ans);
    return 0;
}
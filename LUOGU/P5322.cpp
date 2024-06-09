//Luogu P5322 [BJOI2019]排兵布阵
#include<cstdio>
#include<algorithm>
#define maxn 110
#define maxm 20010

int a[maxn][maxm], w[maxn][maxm], c[maxn][maxm], f[maxm];
int s, n, m;

inline int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

inline void gmax(int& a, const int& b) {
    if(a < b) a = b;
}

int main() {
    s = read(), n = read(), m = read();
    for(register int i = 1; i <= s; ++i)
        for(register int j = 1; j <= n; ++j)
            a[j][i] = read();
    for(register int i = 1; i <= n; ++i) {
        std::sort(a[i]+1, a[i]+s+1);
        for(register int j = 1; j <= s; ++j)
            w[i][j] = 2*a[i][j] + 1, c[i][j] = j*i;
    }
    for(register int i = 1; i <= n; ++i) {
        for(register int j = m; j >= 1; --j) {
            for(register int k = 1; k <= s; ++k) {
                if(j < w[i][k]) continue;
                gmax(f[j], f[j-w[i][k]] + c[i][k]);
            }
        }
    }
    printf("%d", f[m]);
    return 0;
}
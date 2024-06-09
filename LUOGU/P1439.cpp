//Luogu P1439 【模板】最长公共子序列
#include<cstdio>

const int MAXN = 1e5+10;
int a[MAXN], b[MAXN], m[MAXN], dp[MAXN];

inline void gmin(int& a, const int& b) {
    if(a > b) a = b;
}

inline int read() {
    register int x = 0, f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = -1; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return x * f;
}

int main() {
    register int n = read();
    for(register int i = 1; i <= n; ++i) {
        a[i] = read();
        m[a[i]] = i;
    }
    for(register int i = 1; i <= n; ++i) {
        b[i] = read();
        dp[i] = 0x3f3f3f3f;
    }
    register int len = 0;
    for(register int i = 1; i <= n; ++i) {
        register int l = 0, r = len, mid;
        if(m[b[i]] > dp[len]) dp[++len] = m[b[i]];
        else {
            while(l < r) {
                mid = l+r >> 1;
                if(dp[mid] > m[b[i]]) r = mid;
                else l = mid+1;
            }
            gmin(dp[l], m[b[i]]);
        }
    }
    return printf("%d", len), 0;
}
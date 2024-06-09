//Luogu P4954 [USACO09OPEN]Tower of Hay G
#include<iostream>
#include<cstdio>
using namespace std;

const int MAXN = 1e5+10;
int n, a[MAXN], g[MAXN], q[MAXN], f[MAXN], sum[MAXN];
int l = 1, r = 0;

inline int read() {
    register int x = 0, f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = 0; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?x:-x;
}

int main() {
    n = read();
    for(register int i = n; i >= 1; --i) a[i] = read();
    for(register int i = 1; i <= n; ++i) sum[i] = sum[i-1] + a[i];
    for(register int i = 1; i <= n; ++i) {
        while(l <= r && sum[i] - sum[q[l]] >= g[q[l]]) ++l;
        g[i] = sum[i] - sum[q[l-1]];
        f[i] = f[q[l-1]] + 1;
        while(l <= r && sum[i] + g[i] < sum[q[r]] + g[q[r]]) --r;
        q[++r] = i;
    }
    printf("%d\n", f[n]);
    return 0;
}
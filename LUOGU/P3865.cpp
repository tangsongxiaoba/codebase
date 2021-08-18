//P3865 【模板】ST 表
#include<bits/stdc++.h>
#define maxn 100010
using namespace std;

int d[maxn][40];

inline int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

inline int query(const int& r, const int& l) {
    register int k = log2(r-l+1);
    return max(d[l][k], d[r-(1<<k)+1][k]);
}

int main() {
    int n = read(), m = read();
    for(register int i(1); i <= n; ++i) d[i][0] = read();
    for(register int j(1); j <= (int)(log(n)/log(2)); ++j)
        for(register int i = 1; i + (1<<j) - 1 <= n; ++i)
            d[i][j] = max(d[i][j-1], d[i+(1<<(j-1))][j-1]);
    for(register int i(1); i <= m; ++i)
        printf("%d\n", query(read(), read()));
    return 0;
}
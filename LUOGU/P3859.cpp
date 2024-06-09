//Luogu P3859 [TJOI2008]小偷
#include<iostream>
#include<cstdio>
using namespace std;

const int MAXN = 1e3+10;
int n, m, T[MAXN], dp[MAXN];
struct jewel {
    int room, val, t;
}d[MAXN];

inline int read() {
    register int x = 0, f = 1;
    char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = -1; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return x*f;
}

inline void gmin(int &x, const int &y) {
    if(x > y) x = y;
}

inline void gmax(int &x, const int &y) {
    if(x < y) x = y;
}

int main() {
    n = read(), m = read();
    for(register int i = 0; i < n; ++i) T[i] = read();
    for(register int i = 1; i < n; ++i) gmin(T[i], T[i-1]);
    for(register int i = 1; i <= m; ++i) d[i].room = read(), d[i].val = read(), d[i].t = read();
    for(register int i = 1; i < T[0]; ++i) {
        dp[i] = dp[i-1];
        for(register int j = 1; j <= m; ++j) 
            if(T[d[j].room] > i && d[j].t <= i) gmax(dp[i], dp[i-d[j].t] + d[j].val);
    }
    printf("%d", dp[T[0]-1]);
    return 0;
}
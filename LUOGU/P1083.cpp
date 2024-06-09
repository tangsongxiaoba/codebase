//Luogu P1083 [NOIP2012 提高组] 借教室
#include<iostream>
#include<cstring>
#include<cstdio>
using namespace std;

const int MAXN = 1e6+10;
int n, m;
int diff[MAXN], need[MAXN], rst[MAXN], r[MAXN], l[MAXN], d[MAXN];

inline int read() {
    register int x = 0, f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = -1; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return x * f;
}

inline bool check(const int& x) {
    memset(diff, 0, sizeof diff);
    for(register int i = 1; i <= x; ++i) {
        diff[l[i]] += d[i];
        diff[r[i] + 1] -= d[i];
    }
    for(register int i = 1; i <= n; ++i) {
        need[i] = need[i-1] + diff[i];
        if(need[i] > rst[i]) return 0;
    }
    return 1;
}

int main() {
    n = read(), m = read();
    for(register int i = 1; i <= n; ++i) rst[i] = read();
    for(register int i = 1; i <= m; ++i) d[i] = read(), l[i] = read(), r[i] = read();
    register int ll = 1, rr = m;
    if(check(m)) return printf("0"), 0;
    while(ll < rr) {
        register int mid = ll + rr >> 1;
        if(check(mid)) ll = mid + 1;
        else rr = mid;
    }
    printf("-1\n%d", ll);
    return 0;
}
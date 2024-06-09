//Luogu P2678 跳石头
#include<cstdio>

const int MAXN = 5e6+10;
int d, m, n;
int a[MAXN];

inline int read() {
    register int x = 0, f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = -1; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return x*f;
}

inline bool check(const int& x) {
    register int cnt = 0, i = 0, now = 0;
    while(i < n+1) {
        ++i;
        if(a[i]- a[now] < x)
            ++cnt;
        else now = i;
    }
    if(cnt > m) return false;
    return true;
}

int main() {
    d = read(), n = read(), m = read();
    for(register int i = 1; i <= n; ++i) a[i] = read();
    a[n+1] = d;
    register int l = 1, r = d, mid, ans;
    while(l <= r) {
        mid = l+r >> 1;
        if(check(mid)) {
            ans = mid;
            l = mid + 1;
        }
        else  r = mid - 1;
    }
    return printf("%d", ans), 0;
}
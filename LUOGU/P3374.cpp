//Luogu P3374 【模板】树状数组 1
#include<cstdio>
#define lowbit(x) (x & -x)

const int MAXN = 5e5+10;
int n, m, t[MAXN];

inline int read() {
    register int x = 0, f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = 0; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?x:-x;
}

inline void add(int x, const int& k) {
    while(x <= n) {
        t[x] += k;
        x += lowbit(x);
    }
}

inline int sum(int x) {
    register int ans = 0;
    while(x) {
        ans += t[x];
        x -= lowbit(x);
    }
    return ans;
}

int main() {
    n = read(), m = read();
    for(register int i = 1; i <= n; ++i) {
        register int a = read();
        add(i, a);
    }
    for(register int i = 1; i <= m; ++i) {
        register int a =  read(), b = read(), c = read();
        if(a == 1) add(b, c);
        if(a == 2) printf("%d\n", sum(c) - sum(b-1));
    }
    return 0;
}
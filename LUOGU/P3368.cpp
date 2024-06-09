//Luogu P3374 【模板】树状数组 1
#include<cstdio>
#define lowbit(x) (x & -x)

const int MAXN = 5e5+10;
int n, m, t[MAXN], a[MAXN];

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

inline int query(int x) {
    register int ans = 0;
    while(x) {
        ans += t[x];
        x -= lowbit(x);
    }
    return ans;
}

int main() {
    n = read(), m = read();
    for(register int i = 1; i <= n; ++i) a[i] = read();
    for(register int i = 1; i <= m; ++i) {
        register int o = read();
        if(o == 1) {
            register int x = read(), y = read(), z = read();
            add(x, z);
            add(y+1, -z);
        }
        if(o == 2) {
            register int x = read();
            printf("%d\n", a[x] + query(x));
        }
    }
    return 0;
}
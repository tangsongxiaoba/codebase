#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int vis[100010];

int main() {
    int T, n, p, i, j, x;
    T = read();
    while(T--) {
        n = read(), p = read();
        x = n / p;
        for(i = 1; i <= x; ++i) {
            printf("%d ", p*i);
            vis[p*i] = 1;
        }
        for(i = 1; i <= p; ++i) {
            for(j = 1; j <= x; ++j) {
                if(vis[p*j-i] || vis[p*(j-1)+i] || p*j-i == p*(j-1)+i) continue;
                printf("%d %d ", p*(j-1)+i, p*j-i);
                vis[p*j-i] = vis[p*(j-1)+i] = 1;
            }
        }
        for(i = 1; i <= n; ++i) {
            if(!vis[i]) printf("%d ", i);
            vis[i] = 0;
        }
        puts("");
    }
    return 0;
}

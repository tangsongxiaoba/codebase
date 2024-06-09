//UVA1583 生成元 Digit Generator
#include<cstdio>

const int MAXN = 1e5+10;
int ans[MAXN];
int T, n;

int main() {
    for(register int i = 1; i < MAXN; ++i) {
        register int x = i, y = i;
        while(x > 0) {
            y += x % 10;
            x /= 10;
        }
        if(!ans[y] || i < ans[y]) ans[y] = i;
    }
    scanf("%d", &T);
    while(T--) {
        scanf("%d", &n);
        printf("%d\n", ans[n]);
    }
    return 0;
}
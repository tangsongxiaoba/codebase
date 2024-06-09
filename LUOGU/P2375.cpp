//P2375 [NOI2014] 动物园
#include<cstdio>
#include<cstring>
#include<cctype>

const int MOD = 1e9+7;
const int MAXN = 1e6+10;
int n, nxt[MAXN], num[MAXN], ans;
char a[MAXN];

inline int read() {
    register int x(0), f(0);
    register char c(getchar());
    while(!isdigit(c)) f |= c == '-', c = getchar();
    while(isdigit(c)) x = x * 10 + c - 48, c = getchar();
    return f?-x:x;
}

int main() {
    int T = read(), j = 0;
    while(T--) {
        scanf("%s", a);
        n = strlen(a);
        memset(nxt, 0, sizeof nxt);
        j = 0;
        num[0] = 0, num[1] = 1;
        ans = 1;
        for(int i = 1; i < n; ++i) {
            while(j && a[i] != a[j]) j = nxt[j];
            j += (a[i] == a[j]);
            nxt[i+1] = j;
            num[i+1] = num[j] + 1;
        }
        j = 0;
        for(int i = 1; i < n; ++i) {
            while(j && (a[i] != a[j])) j = nxt[j];
            j += (a[i] == a[j]);
            while((j<<1) > i+1) j = nxt[j];
            ans = (1LL * ans * (num[j] + 1)) % MOD;
        }
        printf("%d\n", ans);
    }
    return 0;
}
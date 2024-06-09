//SP263 Period
#include<cstdio>

const int MAXN = 1e6+10;
char P[MAXN];
int f[MAXN];

inline int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int main() {
    int T = read();
    for(register int i = 1; i <= T; ++i) {
        int n = read();
        scanf("%s", P);
        f[0] = f[1] = 0;
        for(int i = 1; i < n; ++i) {
            int j = f[i];
            while(j && P[i] != P[j]) j = f[j];
            f[i+1] = (P[i] == P[j] ? j+1 : 0);
        }
        printf("Test case #%d\n", i);
        for(int i = 2; i <= n; ++i)
            if(f[i] > 0 && i % (i-f[i]) == 0)
                printf("%d %d\n", i, i/(i-f[i]));
        if(i == T) puts("");
    }
    return 0;
}
//UVA1328 Period
#include<cstdio>

const int MAXN = 1e6+10;
char P[MAXN];
int f[MAXN];

int main() {
    int T = 0, n;
    while(scanf("%d", &n) == 1 && n) {
        scanf("%s", P);
        f[0] = f[1] = 0;
        for(int i = 1; i < n; ++i) {
            int j = f[i];
            while(j && P[i] != P[j]) j = f[j];
            f[i+1] = (P[i] == P[j] ? j+1 : 0);
        }
        printf("Test case #%d\n", ++T);
        for(int i = 2; i <= n; ++i)
            if(f[i] > 0 && i % (i-f[i]) == 0)
                printf("%d %d\n", i, i/(i-f[i]));
        puts("");
    }
    return 0;
}
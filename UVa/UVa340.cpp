//UVA340 猜数字游戏的提示 Master-Mind Hints
#include<cstdio>

const int MAXN = 1e3+10;
int n, a[MAXN], b[MAXN], kase;

int main() {
    while(scanf("%d", &n) == 1 && n) {
        printf("Game %d:\n", ++kase);
        for(register int i = 0; i < n; ++i) scanf("%d", &a[i]);
        for(;;) {
            register int A = 0, B = 0;
            for(register int i = 0; i < n; ++i) {
                scanf("%d", &b[i]);
                if(a[i] == b[i]) ++A;
            }
            if(!b[0]) break;
            for(register int d = 1; d <= 9; ++d) {
                register int c1 = 0, c2 = 0;
                for(register int i = 0; i < n; ++i) {
                    if(a[i] == d) ++c1;
                    if(b[i] == d) ++c2;
                }
                if(c1 < c2) B += c1;
                else B += c2;
            }
            printf("    (%d,%d)\n", A, B-A);
        }
    }
    return 0;
}
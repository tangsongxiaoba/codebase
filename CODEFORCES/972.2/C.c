#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <string.h>
#define LL long long
#define DD double

int read(void) {
    register int x = 0;
    register int f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f ? -x : x;
}

void write(int x) {
    static int sta[35];
    int top = 0;
    if(x < 0) putchar('-'), x = -x;
    do {
        sta[top++] = x % 10, x /= 10;
    } while(x);
    while(top) putchar(sta[--top] + '0');
}

char name[] = "narek";

char ss[1010][1010];

int pre[1010][2][5];

long long dp[1010][5];

int main(void) {
    int t = read();

    while(t--) {
        int n = read(), m = read();
        for(int i = 0; i < n; ++i) {
            scanf("%s", ss[i]);
        }
        for(int i = 0; i < n; ++i) {
            // int pre1[5] = {0};
            // int pre2[5] = {0};
            for(int j = 0; j < 5; ++j) {
                int st = j, tot1 = 0, tot2 = 0;
                int lens = strlen(ss[i]);
                for(int k = 0; k < lens; ++k) {
                    int flag = 0;
                    for(int c = 0; c < 5; ++c) {
                        if(ss[i][k] == name[c]) {
                            flag = 1;
                            break;
                        }
                    }
                    if(flag == 1) {
                        tot2 ++;
                    }
                    char exp = 0;
                    if(st < 5) {
                        exp = name[st];
                    }
                    if(ss[i][k] == exp) {
                        st++;
                        if(st == 5) {
                            tot1++;
                            st = 0;
                        }
                    }
                }
                pre[i][0][j] = (10 * tot1) - tot2 - st;
                pre[i][1][j] = st;
            }
        }
        for(int i = 0; i <= n; ++i) {
            for(int j = 0; j < 5; ++j) {
                dp[i][j] = -1000;
            }
        }
        dp[0][0] = 0;

        for(int i = 1; i <= n; ++i) {
            long long x = -10000;
            for(int j = 0; j < 5; ++j) {
                if(x < dp[i - 1][j])
                    x = dp[i-1][j];
            }
            if(dp[i][0] < x) dp[i][0] = x;
            for(int j = 0; j < 5; ++j) {
                if(dp[i - 1][j] != -1000) {
                    if(dp[i][pre[i - 1][1][j]] < dp[i - 1][j] + pre[i - 1][0][j])
                        dp[i][pre[i - 1][1][j]] = dp[i - 1][j] + pre[i - 1][0][j];
                }
            }
        }

        long long res = -10000;
        for(int i = 0; i < 5; ++i) {
            if(dp[n][i] > res) res = dp[n][i];
        }
        printf("%lld\n", res);

    }

    return 0;
}

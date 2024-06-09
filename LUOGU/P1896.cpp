//Luogu P1896 [SCOI2005]互不侵犯
#include<bits/stdc++.h>
using namespace std;

const int maxState[] = {0,1,2,5,10,21,42,85,170,341};

int n, k;
int state[1000], king[1000], e, cnt;
long long dp[10][1000][100], res;

int main() {
    scanf("%d%d", &n, &k);
    for(int i = 0, mi = maxState[n], j; i <= mi; ++i) {
        for(j = 0, cnt = 0; j <= n-1; ++j)
            if((i >> j) & 1) {
                if((i >> (j+1)) & 1) break;
                ++cnt;
            }
        if(j != n) continue;
        if(cnt > k) break;
        state[++e] = i;
        king[e] = cnt;
    }
    for(int i = 1; i <= e; ++i) dp[1][i][king[i]] = 1;
    for(int i = 2; i <= n; ++i)
        for(int j = 1; j <= e; ++j)
            for(int kk = 1; kk <= e; ++kk) {
                if(state[j] & state[kk]) continue;
                if((state[j] << 1) & state[kk]) continue;
                if(state[j] & (state[kk] << 1)) continue;
                for(int s = k; s >= king[j]; --s) dp[i][j][s] += dp[i-1][kk][s-king[j]];
            }
    for(int i = 1; i <= e; ++i) res += dp[n][i][k];
    printf("%lld", res);
    return 0;
}
//Luogu P4516 [JSOI2018]潜入行动
#include<cstdio>
#include<iostream>
#include<algorithm>
#include<cstring>
#include<string>
#include<vector>
#include<cmath>
#include<queue>
using namespace std;

const int MAXN = 1e5+10;
const int MOD = 1e9+7;
int dp[MAXN][105][2][2];
int sz[MAXN];
int n, m;
int fst[MAXN], e;
struct node{
	int v, nxt;
}a[MAXN<<1];

inline void push(int u, int v) {
	a[++e].nxt = fst[u];
	a[e].v = v;
	fst[u] = e;
}

inline void gmin(int &x, const int &y) {
	if(x > y) x = y;
}

void dfs(int u, int fa) {
	dp[u][1][1][0] = dp[u][0][0][0] = sz[u] = 1;
	for(int i = fst[u]; i; i = a[i].nxt) {
		int v = a[i].v;
		if(v == fa) continue;
		dfs(v, u);
		for(int j = min(sz[u], m); j >= 0; --j) {
			int u00 = dp[u][j][0][0], u01 = dp[u][j][0][1], u10 = dp[u][j][1][0], u11 = dp[u][j][1][1];
			dp[u][j][0][0] = dp[u][j][0][1] = dp[u][j][1][0] = dp[u][j][1][1] = 0;
			for(int k = min(sz[v], m - j); k >= 0; --k) {
				int v00 = dp[v][k][0][0], v01 = dp[v][k][0][1], v10 = dp[v][k][1][0], v11 = dp[v][k][1][1];
				dp[u][j+k][0][0] = (1ll * dp[u][j+k][0][0] + 1ll * u00 * v01) % MOD;
				dp[u][j+k][1][0] = (1ll * dp[u][j+k][1][0] + 1ll * u10 * (v01 * 1ll + v00)) % MOD;
				dp[u][j+k][0][1] = (1ll * dp[u][j+k][0][1] + 1ll * u01 * (v01 + v11) + 1ll * u00 * v11) % MOD;
				dp[u][j+k][1][1] = (1ll * dp[u][j+k][1][1] + 1ll * u11 * (v01 * 1ll + v11 + v10 * 1ll + v00) + 1ll * u10 * (v11 + v10)) % MOD;
			}
		}
		sz[u] += sz[v];
	}
}

int main() {
	cin >> n >> m;
	int u, v;
	for(int i = 1; i < n; ++i) {
		cin >> u >> v;
		push(u, v);
		push(v, u);
	}
	dfs(1, 0);
	cout << (dp[1][m][1][1] + dp[1][m][0][1]) % MOD;
	return 0;
}
//Luogu P1273 有线电视网
#include<iostream>
#include<cstdio>
#include<algorithm>
#include<cmath>
#include<cstring>
using namespace std;

const int MAXN = 1e7+10;
int n, m, e;
int fst[3010], fee[3010];
int dp[3010][3010];

struct node{
	int v;
	int w;
	int nxt;
}a[MAXN];

void push(int u, int v, int w) {
	a[++e].v = v;
	a[e].w = w;
	a[e].nxt = fst[u];
	fst[u] = e;
}

inline void gmax(int &a, const int &b) {
	if(a < b) a = b;
}

int dfs(int x) {
	if(x > n-m) {
		dp[x][1] = fee[x];
		return 1;
	}
	int sum = 0;
	for(int i = fst[x]; i; i = a[i].nxt) {
		int v = a[i].v;
		int t = dfs(v);
		sum += t;
		for(int j = sum; j > 0; --j) {
			for(int k = 1; k <= t; ++k) {
				if(j - k >= 0) gmax(dp[x][j], dp[x][j-k] + dp[v][k] - a[i].w);
			}
		}
	}
	return sum;
}

int main() {
	memset(dp, ~0x3f, sizeof dp);
	cin >> n >> m;
	for(int u = 1; u <= n-m; ++u) {
		int k, v, w;
		cin >> k;
		for(int i = 1; i <= k; ++i) {
			cin >> v >> w;
			push(u, v, w);
		}
	}
	for(int i = n-m+1; i <= n; ++i) cin >> fee[i];
	for(int i = 1; i <= n; ++i) dp[i][0] = 0;
	dfs(1);
	for(int i = m; i > 0; --i) {
		if(dp[1][i] >= 0) {
			cout << i;
			break;
		}
	}
	return 0;             
}
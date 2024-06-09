//Luogu P1270 “访问”美术馆
#include<iostream>
#include<cstdio>
#include<algorithm>
#include<cmath>
using namespace std;

const int MAXN = 1100;
int m;
int dp[MAXN][MAXN];
struct node{
	int t, w;
}G[MAXN];

inline void gmax(int &a, const int &b) {
	if(a < b) a = b;
}

void dfs_read(int x) {
	cin >> G[x].t >> G[x].w;
	G[x].t <<= 1;
	if(!G[x].w) {
		dfs_read(x << 1);
		dfs_read(x << 1 | 1);
	}
}

int dfs(int x, int T) {
	if(dp[x][T] > 0 || !T) return dp[x][T];
	if(G[x].w) return dp[x][T] = min(G[x].w, (T - G[x].t) / 5);
	for(int k = 0; k <= T - G[x].t; ++k) {
		gmax(dp[x][T], dfs(x << 1, k) + dfs(x << 1 | 1, T - G[x].t - k));
	}
	return dp[x][T];
}

int main() {
	cin >> m; --m;
	dfs_read(1);
	cout << dfs(1, m);
	return 0;
}
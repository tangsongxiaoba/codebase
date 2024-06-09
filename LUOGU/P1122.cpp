//Luogu P1122 最大子树和
#include<iostream>
#include<cstdio>
#include<algorithm>
#include<cmath>
using namespace std;

const int MAXN = 1e6+10;
int n, e, ans, b[MAXN], fst[MAXN], dp[MAXN];
struct node {
	int v, nxt;
}a[MAXN];

inline void push(const int &u, const int &v) {
	a[++e].nxt = fst[u];
	a[e].v = v;
	fst[u] = e;
}

inline void gmax(int &a, const int &b) {
	if(a < b) a = b;
}

void dfs(int u, int fa) {
	dp[u] = b[u];
	for(int i = fst[u]; i; i = a[i].nxt) {
		int v = a[i].v;
		if(v == fa) continue;
		dfs(v, u);
		dp[u] += max(0, dp[v]);
	}
	gmax(ans, dp[u]);
}

int main() {
	cin >> n;
	for(int i = 1; i <= n; ++i) {
		cin >> b[i];
	}
	int u, v;
	for(int i = 1; i < n; ++i) {
		cin >> u >> v;
		push(u, v); push(v, u);
	}
	dfs(1, 0);
	cout << ans;
	return 0;
}
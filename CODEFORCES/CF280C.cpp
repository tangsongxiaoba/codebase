//CF280C Game on Tree
//#define LOCAL
#include<cstdio>
#include<iostream>
#include<algorithm>
#include<cstring>
#include<string>
#include<vector>
#include<cmath>
#include<queue>
using namespace std;

const int MAXN = 1e6+10;
const int MOD = 1e9+7;
int fst[MAXN], e;
int dp[MAXN];
double ans;
struct node{
	int v, nxt;
}a[MAXN];

inline void push(const int &u, const int &v) {
	a[++e].v = v;
	a[e].nxt = fst[u];
	fst[u] = e;
}

void dfs(int x, int fa) {
	dp[x] = dp[fa] + 1;
	for(int i = fst[x]; i; i = a[i].nxt) {
		if(a[i].v == fa) continue;
		dfs(a[i].v, x);
	}
}

int main() {
	#ifdef LOCAL
	freopen("tree.in", "r", stdin);
	freopen("tree.out", "w", stdout);
	#endif
	
	int n, a, b;
	cin >> n;
	for(int i = 1; i < n; ++i) {
		cin >> a >> b;
		push(a, b);
		push(b, a);
	}
	dp[1] = 1;
	dfs(1, 0);
	for(int i = 1; i <= n; ++i) 
		ans += 1.0 / dp[i];
	printf("%.7lf", ans);
	return 0;
}
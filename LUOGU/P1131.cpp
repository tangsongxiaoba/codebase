//Luogu P1131 [ZJOI2007] 时态同步
#include<iostream>
#include<cstdio>
#include<algorithm>
#include<cmath>
#define int long long
using namespace std;

const int MAXN = 5e6+10;
int n, s, ans;
int fst[MAXN], e = 1;
int dis[MAXN];

struct node{
	int u, v, w, nxt;
}a[MAXN];

void push(int u, int v, int w) {
	a[e].u = u;
	a[e].v = v;
	a[e].w = w;
	a[e].nxt = fst[u];
	fst[u] = e++;
}

void dfs(int u, int fa) {
	for(int i = fst[u]; i; i = a[i].nxt) {
		int v = a[i].v, w = a[i].w;
		if(v == fa) continue;
		dfs(v, u);
		dis[u] = max(dis[u], dis[v] + w);
	}
	for(int i = fst[u]; i; i = a[i].nxt) {
		int v = a[i].v, w = a[i].w;
		if(v == fa) continue;
		ans += dis[u] - (dis[v] + w);
	}
}

signed main() {
	cin >> n >> s;
	int a, b, t;
	for(int i = 1; i < n; ++i) {
		cin >> a >> b >> t;
		push(a, b, t);
		push(b, a, t);
	}
	dfs(s, 0);
	cout << ans;
	return 0;
}
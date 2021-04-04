//Luogu P3177 [HAOI2015]树上染色
#include<iostream>
#include<cstdio>
#include<algorithm>
#include<cstring>
#include<cmath>
#define ll long long
using namespace std;

const int MAXN = 4e3+20;
int n, k;
ll f[MAXN][MAXN];
int fst[MAXN], e = 1;
int sz[MAXN];

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
inline void gmax(ll &x, const ll &y) {
	if(x < y) x = y;
}


void dfs(int u, int fa) {
	sz[u] = 1; f[u][0] = f[u][1] = 0;
	int v, w; ll val ;
	for(int i = fst[u]; i; i = a[i].nxt) {
		v = a[i].v;
		w = a[i].w;
		if(v == fa) continue;
		dfs(v, u);
		for(int i = sz[u]; i >= 0; --i) {
			for(int j = sz[v]; j >= 0; --j) {
				if(~f[u][i]) {
					val = 1ll * j * (k - j) * w + 1ll * (sz[v] - j) * (n - k + j - sz[v]) * w;
					gmax(f[u][i+j], f[u][i] + f[v][j] + val);
				}
			}
		}
		sz[u] += sz[v];
	}
}

int main() {
	cin >> n >> k;
	int fr, to, dis;
	for(int i = 1; i < n; ++i) {
		cin >> fr >> to >> dis;
		push(fr, to, dis);
		push(to, fr, dis);
	}
	memset(f, -1, sizeof f);
	dfs(1, 0);
	cout << f[1][k];
	return 0;
}
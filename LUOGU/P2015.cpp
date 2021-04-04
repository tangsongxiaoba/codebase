//Luogu P2015 二叉苹果树
#include<iostream>
#include<cmath>
#include<cstdio>
using namespace std;

const int MAXN = 105;
int N, Q;
int f[MAXN][MAXN], first[MAXN], e = 1;

struct edge{
	int u;
	int v;
	int w;
	int next;
} a[MAXN];

void push(int u, int v, int w) {
	a[e].u = u;
	a[e].v = v;
	a[e].w = w;
	a[e].next = first[u];
	first[u] = e++;
}

void getMax(int &x, const int &y) {
	if(x < y) x = y;
}

void dp(int u, int fa) {
	int v;
	for(int i = first[u]; i; i = a[i].next) {
		v = a[i].v;
		if(v == fa) continue;
		dp(v, u);
		for(int j = Q; j > 0; --j) {
			for(int k = 0; k < j; ++k) {
				getMax(f[u][j], f[u][j-k-1] + f[v][k] + a[i].w);
			}
		}
	}
}

int main () {
	cin >> N >> Q;
	int u, v ,w;
	for(int i = 1; i < N; ++i) {
		cin >> u >> v >> w;
		push(u, v, w);
		push(v, u, w);
	}
	
	dp(1, 0);
	cout << f[1][Q];
	return 0;
} 
//luogu P2014 [CTSC1997]选课
#include<iostream>
#include<cstdio>
using namespace std;

const int MAXN = 305;
int f[MAXN][MAXN];
int n, m, first[MAXN], e = 1;

struct node{
	int u, v, next;
}a[MAXN];

void push(int u, int v) {
	a[e].u = u;
	a[e].v = v;
	a[e].next = first[u];
	first[u] = e++;
}

void getMax(int &x, const int &y) {
	if(x < y) x = y;
}

void dp(int u) {
	int v;
	for(int i = first[u]; i; i = a[i].next) {
		v = a[i].v;
		dp(v);
		for(int j = m + 1; j >= 1; --j) {
			for(int k = 0; k < j; ++k) {
				getMax(f[u][j], f[u][j-k] + f[v][k]);
			}
		}
	}
}

int main () {
	cin >> n >> m;
	int u, w;
	for(int i = 1; i <= n; ++i) {
		cin >> u >> f[i][1];
		push(u, i); 
	}
	dp(0);
	cout << f[0][m+1];
	return 0;
} 
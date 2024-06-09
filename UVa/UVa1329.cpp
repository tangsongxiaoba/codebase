//UVA1329/LA3027 Corporative Network
#include<cstdio>
#include<iostream>
#include<algorithm>
#include<cstring>
#include<string>
#include<vector>
#include<cmath>
#include<queue>
using namespace std;

const int MAXN = 2e4+10;
int pa[MAXN], d[MAXN];

int findset(int x) {
	if(pa[x] != x) {
		int root = findset(pa[x]);
		d[x] += d[pa[x]];
		return pa[x] = root;
	}
	else return x;
}

int main() {
	int T;
	scanf("%d", &T);
	while(T--) {
		int n, u, v;
		char cmd[9];
		scanf("%d", &n);
		for(int i = 1; i <= n; ++i) {
			pa[i] = i;
			d[i] = 0;
		}
		while(scanf("%s", cmd) && cmd[0] != 'O') {
			if(cmd[0] == 'E') {
				scanf("%d", &u);
				findset(u);
				printf("%d\n", d[u]);
			}
			if(cmd[0] == 'I') {
				scanf("%d%d", &u, &v);
				pa[u] = v;
				d[u] = abs(u-v) % 1000;
			}
		}
	}
	return 0;
}
//UVA11292 Dragon of Loowater
#include<cstdio>
#include<iostream>
#include<algorithm>
#include<cstring>
#include<string>
#include<vector>
#include<cmath>
#include<queue>
#include<stack>
#include<map>
using namespace std;

const int MAXN = 2e4+10;
int a[MAXN], b[MAXN];

int main() {
	int n, m;
	while(scanf("%d%d", &n, &m) == 2 && n && m) {
		for(int i = 0; i < n; ++i) scanf("%d", &a[i]);
		for(int i = 0; i < m; ++i) scanf("%d", &b[i]);
		sort(a, a+n);
		sort(b, b+m);
		int cur = 0, cost = 0;
		for(int i = 0; i < m; ++i) {
			if(b[i] >= a[cur]) {
				cost += b[i];
				if(++cur == n) break;
			}
		}
		if(cur < n) printf("Loowater is doomed!\n");
		else printf("%d\n", cost);
	}
	return 0;
}
//UVA1388/LA3708 Graveyard
//#define LOCAL
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

int main() {
	#ifdef LOCAL
	freopen("graveyard.in", "r", stdin);
	freopen("graveyard.out", "w", stdout);
	#endif
	
	int n, m;
	while(scanf("%d%d", &n, &m) == 2) {
		double ans = 0.0;
		for(int i = 1; i < n; ++i) {
			double pos = 1.0 * i / n * (n+m);
			ans += fabs(pos - round(pos)) / (n+m);
		}
		printf("%.4lf\n", ans*10000);
	}
	return 0;
}
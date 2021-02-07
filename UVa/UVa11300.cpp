//UVA11300 Spreading the Wealth
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

const int MAXN = 1e7+10;
long long a[MAXN], c[MAXN], tot, M;

int main() {
	#ifdef LOCAL
	freopen("spreading_the_wealth.in", "r", stdin);
	freopen("spreading_the_wealth.out", "w", stdout);
	#endif
	
	int n;
	while(scanf("%d", &n) == 1) {
		tot = 0;
		for(int i = 1; i <= n; ++i) {
			scanf("%lld", &a[i]);
			tot += a[i];
		}
		M = tot / n;
		c[0] = 0;
		for(int i = 1; i < n; ++i) c[i] = c[i-1] + a[i] - M;
		sort(c, c+n);
		long long xl = c[n/2], ans = 0;
		for(int i = 0; i < n; ++i) ans += abs(xl - c[i]);
		printf("%lld\n", ans);
	}
	return 0;
}
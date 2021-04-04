//P4016 负载平衡问题
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
	int n;
	cin >> n;
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
	for(int i = 0; i < n; ++i) 
		ans += abs(xl - c[i]);
	printf("%lld\n", ans);
	return 0;
}
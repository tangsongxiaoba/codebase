//UVA1099 Sharing Chocolate
#include<iostream>
#include<cstdio>
#include<cstring>
#include<algorithm>
using namespace std;

int n, a[16], sum[1<<16];
int f[1<<16][110], vis[1<<16][110];

int bitcount(const int &x) {
	return x == 0 ? 0 : bitcount(x/2) + (x&1);
}

int dp(int s, int x) {
	if(vis[s][x]) return f[s][x];
	vis[s][x] = 1;
	int &ans = f[s][x];
	if(bitcount(s) == 1) return ans = 1;
	int y = sum[s] / x;
	for(int s0 = (s-1)&s; s0; s0 = (s0-1)&s) {
		int s1 = s-s0;
		if(sum[s0] % x == 0 && dp(s0, min(x, sum[s0]/x)) && dp(s1, min(x, sum[s1]/x)))
			return ans = 1;
		if(sum[s0] % y == 0 && dp(s0, min(y, sum[s0]/y)) && dp(s1, min(y, sum[s1]/y)))
			return ans = 1;
	}
	return ans = 0;
}

int main() {
	int k = 0;
	int x, y;
	while(cin >> n && n) {
		cin >> x >> y;
		for(int i = 0; i < n; ++i)
			cin >> a[i];
		memset(sum, 0, sizeof sum);
		for(int s = 0; s < (1 << n); ++s) {
			for(int i = 0; i < n; ++i)
				if(s & (1<<i)) sum[s] += a[i];
		}
		
		memset(vis, 0, sizeof vis);
		int ALL = (1<<n) - 1;
		int ans;
		if(sum[ALL] != x*y || sum[ALL] % x != 0) ans = 0;
		else ans = dp(ALL, min(x, y));
		printf("Case %d: %s\n", ++k, ans ? "Yes" : "No");
	}
	return 0;
}
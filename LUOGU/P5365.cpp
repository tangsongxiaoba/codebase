//Luogu P5365 [SNOI2017]英雄联盟
#include<cstdio>
#include<iostream>
#include<algorithm>
#include<cstring>
#include<string>
#include<vector>
#include<cmath>
#include<queue>
using namespace std;

const int MAXN = 1e6+10;
long long n, m;
long long ki[MAXN], ci[MAXN];
long long dp[MAXN] = {1};
long long maxV;
long long ans = 0;

inline void gmax(long long &x, const long long &y) {
	if(x < y) x = y;
}

int main() {
	cin >> n >> m;
	for(int i = 1; i <= n; ++i) cin >> ki[i];
	for(int i = 1; i <= n; ++i) {
		cin >> ci[i];
		maxV += ci[i] * ki[i];	
	}
	dp[0] = 1;
	for(int i = 1; i <= n; ++i) {
		for(int j = maxV; j >= 0; --j) {
			for(int k = 0; k <= ki[i] && k * ci[i] <= j; ++k) {
				gmax(dp[j], dp[j-k*ci[i]]*k);
			}
		}
	}
	while(ans <= maxV && dp[ans] < m) ++ans;
	return cout << ans, 0;
}
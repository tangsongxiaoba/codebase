//Luogu P5365 [SNOI2017]英雄联盟
//#define LOCAL
#include<cstdio>
#include<iostream>
#include<algorithm>
#include<cstring>
#include<string>
#include<vector>
#include<cmath>
#include<queue>
#define ll long long
using namespace std;

const int MAXN = 1e6+10;
ll n, m;
ll ki[MAXN], ci[MAXN];
ll dp[MAXN] = {1};
ll maxV;
ll ans = 0;

inline void gmax(ll &x, const ll &y) {
	if(x < y) x = y;
}

int main() {
	#ifdef LOCAL
	freopen("lol.in", "r", stdin);
	freopen("lol.out", "w", stdout);
	#endif
	
	memset(dp, 0, sizeof dp);
	
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
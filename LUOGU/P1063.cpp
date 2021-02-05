//Luogu P1063 [NOIP2006 提高组] 能量项链
#include<iostream>
#include<cstdio>
#include<algorithm>
#include<cmath>
using namespace std;

int dp[440][440];
int v[440];
int ans, n;

inline void gmax(int &a, const int &b) {
	if(a < b) a = b;
}

int main() {
	cin >> n;
	for(int i = 1; i <= n; ++i) {
		cin >> v[i];
		v[i+n] = v[i];
	}
	for(int len = 2; len <= n; ++len) {
		for(int i = 1; i + len < (n << 1 | 1); ++i) {
			int j = i + len - 1;
			for(int k = i; k < j; ++k) {
				gmax(dp[i][j], dp[i][k] + dp[k+1][j] + v[i] * v[k+1] * v[j+1]);
			}
		}
	}
	for(int i = 1; i <= n; ++i)
		gmax(ans, dp[i][i+n-1]);
	cout << ans;
}
//Luogu P3360 偷天换日
#include<iostream>
#include<cstdio>
#include<algorithm>
#include<cmath>
using namespace std;

const int MAXN = 1e4+10;
int s, dp[MAXN][MAXN];
int a[MAXN], b[MAXN];

inline void gmax(int &a, const int &b) {
	if(a < b) a = b;
}

void dfs(int x) {
	int t, w;
	cin >> t >> w;
	t <<= 1;
	if(w > 0) {
		for(int i = 1; i <= w; ++i) 
			cin >> a[i] >> b[i];
		for(int i = 1; i <= w; ++i) {
			for(int j = s; j >= t+b[i]; --j) {
				gmax(dp[x][j], dp[x][j-b[i]]+a[i]);
			}
		}
	}
	if(!w) {
		dfs(x << 1);
		dfs(x << 1 | 1);
		for(int i = s; i >= t; --i) {
			for(int j = 0; j <= i-t; ++j) {
				gmax(dp[x][i], dp[x<<1][j] + dp[x<<1|1][i-j-t]);
			}
		}
	}
}

int main() {
	cin >> s; --s;
	dfs(1);
	cout << dp[1][s];
	return 0;             
}
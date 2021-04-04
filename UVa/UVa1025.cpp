//UVA1025 A Spy in the Metro
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

const int INF = 1e9;
int dp[300][100];
int train[300][100][2];
int t[100];

inline void gmin(int &x, const int &y) {
	if(x > y) x = y;
}

int main() {
	int k=0, n, T;
	while(cin >> n >> T && n) {
		int m1, m2, d;
		for(int i = 1; i < n; ++i) 
			cin >> t[i];
		memset(train, 0, sizeof train);
		cin >> m1;
		while(m1--) {
			cin >> d;
			for(int i = 1; i < n; ++i) {
				if(d <= T) train[d][i][0] = 1;
				d += t[i];
			}
		}
		cin >> m2;
		while(m2--) {
			cin >> d;
			for(int i = n-1; i >= 1; --i) {
				if(d <= T) train[d][i+1][1] = 1;
				d += t[i];
			}
		}
		for(int i = 1; i <= n-1; ++i) 
			dp[T][i] = INF;
		dp[T][n] = 0;
	
		for(int i = T-1; i >= 0; --i)
			for(int j = 1; j <= n; ++j) {
				dp[i][j] = dp[i+1][j] + 1;
				if(j < n && train[i][j][0] && i + t[j] <= T)
					gmin(dp[i][j], dp[i+t[j]][j+1]);
				if(j > 1 && train[i][j][1] && i + t[j-1] <= T)
					gmin(dp[i][j], dp[i+t[j-1]][j-1]);
			}
		printf("Case Number %d: ", ++k);
		if(dp[0][1] >= INF) cout << "impossible\n";
		else cout << dp[0][1] << "\n";
	}
	return 0;
}
//Luogu P1002 [NOIP2002 普及组] 过河卒
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

int hx[] = {0,  1, -1,  2, -2, -1, -2, 1, 2};
int hy[] = {0, -2,  2, -1,  1, -2, -1, 2, 1};

bool vis[50][50];
unsigned long long dp[50][50];

inline void gmax(unsigned long long &x, const unsigned long long &y) {
	if(x < y) x = y;
}

int main() {
	int n1, m1, n2, m2;
	cin >> n1 >> m1 >> n2 >> m2;
	
	n1 += 2, m1 += 2, n2 += 2, m2 += 2;
	
	for(int i = 0; i < 9; ++i) 
		vis[n2+hx[i]][m2+hy[i]] = true;
	
	dp[2][2] = 1;	
	for(int i = 2; i <= n1; ++i) {
		for(int j = 2; j <= m1; ++j) {
			if(vis[i][j]) continue;
			gmax(dp[i][j], dp[i-1][j] + dp[i][j-1]);
		}
	}
//	for(int i=2;i<=n1;++i){
//		for(int j=2;j<=m1;++j){
//			printf("%2d ",dp[i][j]);
//		}
//		printf("\n");
//	}
	cout << dp[n1][m1];

	return 0;
}
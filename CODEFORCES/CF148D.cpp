//CF148D Bag of mice
#include<iostream>
#include<cstdio>
#include<algorithm>
#include<cstring>
#include<cmath>
using namespace std;

const int MAXN = 1e3+10;
double dp[MAXN][MAXN];

int main() {
	int w, b;
	cin >> w >> b;
	for(int i = 1; i <= w; ++i) {
		dp[i][0] = 1.0;
		dp[i][1] = 1.0 * i / (i+1);
	}
	if(!b || b == 1) return printf("%.9lf\n", dp[w][b]), 0;
	for(int i = 1; i <= w; ++i) {
		for(int j = 2; j <= b; ++j) {
			dp[i][j] = 1.0 * i / (i+j) + 1.0 * j / (i+j) * (1.0*j-1) / (i+j-1) * 1.0 * i / (i+j-2) * dp[i-1][j-2];
			if(j^2) dp[i][j] += 1.0 * j / (i+j) * (1.0*j-1) / (i+j-1) * (1.0*j-2) / (1.0*i+j-2) * dp[i][j-3];
		}
	}
	printf("%.9lf", dp[w][b]);
	return 0;
}
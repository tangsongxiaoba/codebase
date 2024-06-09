//Luogu P1439 【模板】最长公共子序列
#include<iostream>
#include<cstdio>
#include<cmath>
using namespace std;

const int MAXN = 1e3+10;
int p1[MAXN], p2[MAXN];
int f[MAXN][MAXN];
int n;

int main () {
	cin >> n;
	for(int i = 1; i <= n; ++i) cin >> p1[i];
	for(int i = 1; i <= n; ++i) cin >> p2[i];
	for(int i = 1; i <= n; ++i) {
		for(int j = 1; j <= n; ++j) {
			f[i][j] = max(f[i-1][j], f[i][j-1]);
			if(p1[i] == p2[j]) f[i][j] = max(f[i][j], f[i-1][j-1]+1);
		}
	}
	printf("%d", f[n][n]);
	return 0;
} 
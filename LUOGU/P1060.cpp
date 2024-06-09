//Luogu P1060 [NOIP2006 普及组] 开心的金明
#include<iostream>
#include<cmath>
#include<cstdio>
using namespace std;

const int MAXN = 3e4+10;
int n, m;
int v[30], w[30];
int f[30][MAXN];

int main () {
	cin >> n >> m;
	for(int i = 1; i <= m; ++i) {
		cin >> v[i] >> w[i];
		w[i] *= v[i];
	}
	for(int i = 1; i <= m; ++i) {
		for(int j = 0; j <= n; ++j) {
			f[i][j] = f[i-1][j];			
			if(j >= v[i]) f[i][j] = max(f[i][j], f[i-1][j-v[i]] + w[i]);
		}
	}
	cout <<f[m][n];
	return 0;
} 

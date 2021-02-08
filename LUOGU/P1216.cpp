//Luogu P1216 [USACO1.5][IOI1994]数字三角形 Number Triangles 
#include<iostream>
#include<cmath>
#include<cstdio>
#include<cstring>
using namespace std;

const int MAXN = 1010;
int r;
int T[MAXN][MAXN];
int f[MAXN][MAXN];
int ans;

int solve(const int &i, const int &j) {
	if(f[i][j] >= 0) return f[i][j];
	return f[i][j] = T[i][j] + (i == r ? 0 : max(solve(i+1, j), solve(i+1, j+1)));
}

int main() {
	cin >> r;
	for(int i = 1; i <= r; ++i) {
		for(int j = 1; j <= i; ++j) {
			cin >> T[i][j];
		}
	}
	memset(f, -1, sizeof f);
//	for(int i = r; i > 0; --i) {
//		for(int j = 1; j <= i; ++j) {
//			if(i == r) f[i][j] = T[i][j];
//			else f[i][j] = T[i][j] + max(f[i+1][j], f[i+1][j+1]);
//		}
//	}
	cout << solve(1, 1);
	return 0;
}

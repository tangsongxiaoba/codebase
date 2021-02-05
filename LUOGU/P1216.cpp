//Luogu P1216 [USACO1.5][IOI1994]Êý×ÖÈý½ÇÐÎ Number Triangles 
#include<iostream>
#include<cmath>
#include<cstdio>
using namespace std;

const int MAXN = 1010;
int r;
int T[MAXN][MAXN];
int f[MAXN][MAXN];
int ans;

int main() {
	cin >> r;
	for(int i = 1; i <= r; ++i) {
		for(int j = 1; j <= i; ++j) {
			cin >> T[i][j];
		}
	}
	for(int i = r; i > 0; --i) {
		for(int j = 1; j <= i; ++j) {
			if(i == r) f[i][j] = T[i][j];
			else f[i][j] = T[i][j] + max(f[i+1][j], f[i+1][j+1]);
		}
	}
	cout << f[1][1];
	return 0;
}

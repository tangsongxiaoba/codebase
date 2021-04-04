//Luogu P3842 [TJOI2007]线段
#include<iostream>
#include<algorithm>
#include<cmath>
#include<cstdio>
using namespace std;

const int MAXN = 2e4+10;
int n, l[MAXN], r[MAXN], f[MAXN][2];

int main () {
	cin >> n;
	for(int i = 1; i <= n; ++i) {
		cin >> l[i] >> r[i];
	}
	f[1][0] = r[1] + 1 + r[1] - l[1];
	f[1][1] = r[1] - 1;
	for(int i = 2; i <= n; ++i) {
		f[i][0] = min(f[i-1][0] + abs(l[i-1] - r[i]) + r[i] - l[i] + 1, f[i-1][1] + abs(r[i-1] - r[i]) + r[i] - l[i] + 1);
		f[i][1] = min(f[i-1][0] + abs(l[i-1] - l[i]) + r[i] - l[i] + 1, f[i-1][1] + abs(r[i-1] - l[i]) + r[i] - l[i] + 1);
	}
	cout << min(f[n][0] + n - l[n], f[n][1] + n - r[n]);
	return 0;
} 
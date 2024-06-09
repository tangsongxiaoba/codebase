//Luogu P1435 [IOI2000]回文字串 / [蓝桥杯2016省]密码脱落
#include<iostream>
#include<algorithm>
#include<string>
#include<cstdio>
using namespace std;

const int MAXN = 5e3+10;
string a, b;
int f[MAXN][MAXN];

int main () {
	cin >> a;
	b = a;
	reverse(a.begin(), a.end());
	for(int i = 1; i <= a.length(); ++i) {
		for(int j = 1; j <= b.length(); ++j) {
			f[i][j] = max(f[i-1][j], f[i][j-1]);
			if(a[i-1] == b[j-1])
				f[i][j] = f[i-1][j-1] + 1;
		}
	}
	cout << a.length() - f[a.length()][a.length()];
	return 0;
} 
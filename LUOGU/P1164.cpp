//Luogu P1164 小A点菜
#include<iostream>
#include<cmath>
#include<cstdio>
using namespace std;

const int MAXN = 1e4+10;
int n, m;
int a[110], f[MAXN];

int main () {
	cin >> n >> m;
	for(int i = 1; i <= n; ++i)
		cin >> a[i];
	f[0] = 1;
	for(int i = 1; i <= n; ++i) {
		for(int j = m; j >= a[i]; --j) {
			f[j] = f[j] + f[j-a[i]];
		}
	}
	cout << f[m];
	return 0;
} 
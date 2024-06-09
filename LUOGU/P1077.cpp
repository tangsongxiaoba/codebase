//Luogu P1077 [NOIP2012 普及组] 摆花
#include<iostream>
#include<cstdio>
using namespace std;

const int MAXN = 110;
const int MOD = 1000007;
int n, m;
int a[MAXN];
int f[MAXN];

int main () {
	cin >> n >> m;
	for(int i = 1; i <= n; ++i) {
		cin >> a[i];
	}
	f[0] = 1;
	for(int i = 1; i <= n; ++i) {
		for(int j = m; j >= 0; --j) {
			for(int k = 1; k <= min(j, a[i]); ++k) {
				(f[j] += f[j-k]) %= MOD;
			}
		}
	}
	cout << f[m];
	return 0;
} 
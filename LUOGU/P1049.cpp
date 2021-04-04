//Luogu P1049 [NOIP2001 普及组] 装箱问题
#include<iostream>
#include<cmath>
#include<cstdio>
using namespace std;

const int MAXN = 2e4+10;
int V, n;
int v[40], f[MAXN];

int main () {
	cin >> V >> n;
	for(int i = 1; i <= n; ++i) {
		cin >> v[i];
	}
	for(int i = 1; i <= n; ++i) {
		for(int j = V; j >= v[i]; --j) {
			if(f[j] < f[j - v[i]] + v[i]) {
				f[j] = f[j - v[i]] + v[i];
			}
		}
	}
	cout << V - f[V];
	return 0;
} 
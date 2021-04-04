//Luogu P1048 [NOIP2005 普及组] 采药
#include<iostream>
#include<cmath>
#include<cstdio>
using namespace std;

const int MAXN = 1100;
int T, M;
int t[MAXN], w[MAXN], f[MAXN];

int main () {
	cin >> T >> M;
	for(int i = 1; i <= M; ++i) {
		cin >> t[i] >> w[i];
	}
	for(int i = 1; i <= M; ++i) {
		for(int j = T; j >= t[i]; --j) {
			if(f[j - t[i]] + w[i] > f[j]) f[j] = f[j - t[i]] + w[i];
		}
	}
	cout << f[T];
	return 0;
} 

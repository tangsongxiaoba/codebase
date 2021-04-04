//Luogu P1064 [NOIP2006 提高组] 金明的预算方案
#include<iostream>
#include<cmath>
#include<cstdio>
using namespace std;

const int MAXN = 32000;
int n, m, vi, pi, q;
int mv[MAXN], mp[MAXN];
int av[MAXN][3], ap[MAXN][3];
int f[MAXN];

int main () {
	cin >> n >> m;
	for(int i = 1; i <= m; ++i) {
		cin >> vi >> pi >> q;
		if(q) //a
			++av[q][0], av[q][av[q][0]] = vi, ap[q][av[q][0]] = vi * pi;
		else mv[i] = vi, mp[i] = vi * pi;
	}
	for(int i = 1; i <= m; ++i) {
		for(int j = n; mv[i] != 0 && j >= mv[i]; --j) {
			f[j] = max(f[j], f[j-mv[i]]+mp[i]);
			if(j >= mv[i] + av[i][1])
				f[j] = max(f[j], f[j-mv[i]-av[i][1]] + mp[i] + ap[i][1]);
			if(j >= mv[i] + av[i][2])
				f[j] = max(f[j], f[j-mv[i]-av[i][2]] + mp[i] + ap[i][2]);
			if(j >= mv[i] + av[i][1] + av[i][2])
				f[j] = max(f[j], f[j-mv[i]-av[i][1]-av[i][2]] + mp[i] + ap[i][1] + ap[i][2]);
		}
	}
	cout << f[n];
	return 0;
} 
//UVA10795 A Different Task
#include<cstdio>
#include<iostream>
using namespace std;

int n;
int st[65];
int fi[65];

long long f(int* p, int i, int final) {
	if(i == 0) return 0;
	if(p[i] == final) return f(p, i-1, final);
	return f(p, i-1, 6-p[i]-final) + (1LL << (i-1));
}

int main() {
	int kase = 0;
	while(scanf("%d", &n) == 1 && n) {
		for(int i = 1; i <= n; ++i) scanf("%d", &st[i]);
		for(int i = 1; i <= n; ++i) scanf("%d", &fi[i]);
		int k = n;
		while(k >= 1 && st[k] == fi[k]) --k;
		long long ans = 0;
		if(k >= 1) {
			int ex = 6-st[k]-fi[k];
			ans = f(st, k-1, ex) + f(fi, k-1, ex) + 1;
		}
		printf("Case %d: %lld\n", ++kase, ans);
	}
	return 0;
}
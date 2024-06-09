//Luogu P2352 队爷的新书
#include<iostream>
#include<algorithm>
#include<cstdio>
using namespace std;

const int MAXN = 1e5+1;
long long ans, g, n, l, a[MAXN], b[MAXN];

int main () {
	cin >> n;
	for(int i = 1; i <= n; ++i) {
		cin >> a[i] >> b[i];
	}
	sort(a+1, a+n+1);
	sort(b+1, b+n+1);
	l=1;
	for(int i = 1; i <= n; ++i) {
		while(l <= n && a[l] <= b[i]) ++l;
		ans = max((l-i) * b[i], ans);
	}
	cout << ans;
	return 0;
} 
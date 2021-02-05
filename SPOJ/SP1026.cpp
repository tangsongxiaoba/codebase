//SPOJ SP1026 FAVDICE - Favorite Dice
#include<iostream>
#include<cstdio>
#include<algorithm>
#include<cstring>
#include<cmath>
using namespace std;

int n, t;
double ans;

int main() {
	cin >> t;
	while(t--) {
		cin >> n;
		ans = 0.0;
		for(int i = 1; i <= n; ++i)
			ans += 1.0 / i;
		ans *= n;
		printf("%.2lf\n", ans);
	}
	return 0;
}
//Luogu P7223 [RC-04] 01 背包
#include<iostream>
#include<cmath>
#include<cstdio>
using namespace std;

const int MOD = 998244353;
long long n, p, ans, ai;

inline long long qpow(long long x, int n) {
	long long Ans = 1;
	for(; n; n >>= 1, x = x * x % MOD) {
		if(n & 1) {
			Ans = Ans * x % MOD;
		}
	}
	return Ans % MOD;
}

int main () {
	ans = 1;
	cin >> n >> p;
	for(int i = 1; i <= n; ++i) {
		cin >> ai;
		ans = (ans * (qpow(p, ai) + 1)) % MOD;
	}
	cout << ans;
	return 0;
} 
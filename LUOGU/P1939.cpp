//P1939 【模板】矩阵加速（数列）
#include<iostream>
#include<cstring>
#include<cstdio>
using namespace std;

const int MOD = 1e9+7;
struct Matrix {
	int a[4][4];
	Matrix() {
		memset(a, 0, sizeof a);
	}
	Matrix operator * (const Matrix &b) const {
		Matrix res;
		for(int i = 0; i <= 2; ++i)
			for(int j = 0; j <= 2; ++j)
				for(int k = 0; k <= 2; ++k)
					(res.a[i][j] += 1LL * a[i][k] * b.a[k][j] % MOD) %= MOD;
		return res;
	}
	Matrix operator = (const Matrix &b) {
		for(int i = 0; i <= 2; ++i) 
			for(int j = 0; j <= 2; ++j)
					a[i][j] = b.a[i][j];
		return *this;
	}
	Matrix operator *= (const Matrix &b) {
		return *this = *this * b;
	}
}base, ans, e;

void init() {
	memset(base.a, 0, sizeof(base.a));
	memset(ans.a, 0, sizeof(ans.a));
	memset(e.a, 0, sizeof(e.a));
	base.a[0][0] = base.a[0][2] = base.a[1][0] = base.a[2][1] = 1;
	ans.a[0][0] = ans.a[1][0] = ans.a[2][0] = 1;
	e.a[0][0] = e.a[1][1] = e.a[2][2] = 1;
}

inline Matrix qpow(Matrix x, int n) {
	Matrix tmp = e;
	for(; n; n >>= 1, x = x * x)
		if(n & 1) tmp = x * tmp;
	return tmp;
}

int main() {
	int T, tmp;
	scanf("%d", &T);
	for(; T; --T) {
		init();
		scanf("%d", &tmp);
		if(tmp <= 3){
			cout << 1 << endl;
			continue;
		}
		base = qpow(base, tmp-3);
		ans = base * ans;
		printf("%d\n", ans.a[0][0]);
	}
	return 0;
}
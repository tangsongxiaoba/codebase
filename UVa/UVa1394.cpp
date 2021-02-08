//UVA1394 And Then There Was One
#include<iostream>
using namespace std;
const int MAXN = 1e4+5;
int dp[MAXN];

int main() {
	int n, k, m;
	while(cin >> n >> k >> m && n) {
		dp[1] = 0;
		for(int i = 2; i <= n; ++i) 
			dp[i] = (dp[i-1] + k) % i;
		int ans = (m - k + 1 + dp[n]) & n;
		if(ans <= 0) ans += n;
		cout << ans << endl;
	}
	return 0;
}
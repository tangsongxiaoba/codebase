//Luogu P1616 疯狂的采药
#include<cstdio>
#define ll long long

const int N = 1e4 + 10;
const int M = 1e7 + 10;
ll n, m, w[N], v[N], f[M];

inline int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

inline void gmax(ll& a, const ll& b) {
    if(a < b) a = b;
}

int main() {
	scanf("%lld%lld", &m, &n);
	for(int i = 1; i <= n; ++i) w[i] = read(), v[i] = read();
	for(int i = 1; i <= n; ++i)
		for(int j = w[i]; j <= m; ++j)
			gmax(f[j], f[j-w[i]] + v[i]);
	printf("%lld", f[m]);
	return 0;
}
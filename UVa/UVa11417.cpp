//UVA11417 GCD
#include<cstdio>
#include<cstring>

long long n = 1;
long long ans, f[4000010];

inline long long read() {
    register long long x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int main() {
	n = read();
	while(n) {
		ans = 0;
		for(register int i = n; i; --i) {
			f[i] = n / i * (n / i);
			for(register int j = (i << 1); j <= n; j += i) f[i] -= f[j];
			ans += f[i] * i;
		}
		printf("%lld\n", ((ans - (n * (n+1) >> 1)) >> 1));
		n = read();
	}
	return 0;
}
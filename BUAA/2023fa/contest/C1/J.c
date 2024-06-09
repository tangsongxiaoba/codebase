#include <stdio.h>
#include <math.h>

const int MOD = 998244353;

int main() {
    long long n, res = 0;
    scanf("%lld", &n);
    res = (n % MOD) * (n % MOD);
    res = (res * ((n-1) % MOD)) % MOD;
    res = (res / 2) % MOD;
    res += 2;
    res = (res - (long long)pow(2, n-1)) % MOD;
    printf("%lld", res % MOD);
    return 0;
}
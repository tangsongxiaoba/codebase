//Luogu P1326 足球
#include<cstdio>
#include<algorithm>
using namespace std;

long long s, t, n;

int main() {
    while(scanf("%d%d%d", &s, &t, &n) == 3)
        printf("%lld %lld\n", (s < n) ? (2*s + n-1 + !t) : (3 * max(n-1, min(n, s-t)) + (s-t == n-1)), (s > t) ? (3 + max(0LL, n-t-1)) : (min(3 + max(0LL, n-t-1), max(n - t + s, 0LL))));
    return 0;
}
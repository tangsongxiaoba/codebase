#include<stdio.h>

int main() {
    long long x1, y1, x2, y2, x3, y3, k1, k2 ,k3, j;
    scanf("%lld%lld%lld%lld%lld%lld", &x1, &y1, &x2, &y2, &x3, &y3);
    for(k3 = 1, j = x1*x2; (x3 * k3 + 1) % j; ++k3);
    for(k2 = 1, j = x1*x3; (x2 * k2 + 1) % j; ++k2);
    for(k1 = 1, j = x2*x3; (x1 * k1 + 1) % j; ++k1);
    printf("%lld", ((k3*x3+1)*y3+(k2*x2+1)*y2+(k1*x1+1)*y1) % (x1*x2*x3));
    return 0;
}
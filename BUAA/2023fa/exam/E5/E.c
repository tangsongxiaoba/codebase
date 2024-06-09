#include<stdio.h>
#include<math.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

double a[1010];

int main() {
    int n, i;
    double sum1, sum2;
    n = read();
    sum1 = sum2 = 0;
    for(i = 1; i <= n; ++i) {
        scanf("%lf", &a[i]);
        sum1 += a[i];
        sum2 += a[i]*a[i];
    }
    printf("%.6f\n%.6f", sum1/n, sqrt((sum2-sum1*sum1/n)/(n*n-n)));
    return 0;
}

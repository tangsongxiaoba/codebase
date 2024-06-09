#include<stdio.h>
#include<math.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int main() {
    double x;
    while(scanf("%lf", &x) != EOF) {
        printf("%.3f\n", exp(cos(atan(x)))/log(cosh(x)+1.0));
    }
    return 0;
}

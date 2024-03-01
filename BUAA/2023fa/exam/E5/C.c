#include<stdio.h>
#include<math.h>

const double eps = 1e-8;

double f(double x) {
    return x * exp(x);
}

int main() {
    double x, l, r, mid;
    scanf("%lf", &x);
    l = -1.0, r = 10.0;
    mid = (l+r)/2;
    while(r-l>eps) {
        if(f(mid) > x) {
            r = mid;
        }
        else {
            l = mid;
        }
        mid = (l+r)/2;
    }
    printf("%.6f", l);
    return 0;
}

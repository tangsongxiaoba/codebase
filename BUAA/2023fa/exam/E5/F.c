#include<stdio.h>
#include<math.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

const double eps = 1e-10;
int x1, y1, x2, y2, s1, s2;

double f(double x) {
    double c1, c2;
    c1 = (1.0*x-x1)/sqrt((x-x1)*(x-x1)+y1*y1);
    c2 = (x2-1.0*x)/sqrt((x2-x)*(x2-x)+y2*y2);
    return c1/c2;
}

int main() {
    double n, x, l, r;
    x1 = read(), y1= read(), x2 = read(), y2 = read(), s1 = read(), s2 = read();
    n = 1.0*s2/s1;
    x = (x1 + x2) / 2.0;
    l = x1, r = x2;
    while(r - l > eps) {
        if(f(x) - n > eps) {
            r = x;
        }
        else {
            l = x;
        }
        x = (l + r) / 2.0;
    }
    printf("%.3f %.3f", l, s1*sqrt((x-x1)*(x-x1)+y1*y1)+s2*sqrt((x2-x)*(x2-x)+y2*y2));
    return 0;
}

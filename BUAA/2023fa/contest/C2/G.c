#include<stdio.h>
#include<math.h>

int main() {
    int a, b, c;
    scanf("%d%d%d", &a, &b, &c);
    if(a == 0) {
        if(b != 0) {
            if(c == 0) puts("0.00");
            else printf("%.2f", (double)(0-c)/(double)b);
        }
        else {
            if(c == 0) puts("infinite solutions");
            else puts("No real root");
        }
    }
    else {
        int delta = b*b-4*a*c;
        if(delta == 0) {
            double ans = (double)(0-b)/(double)a/2.0;
            printf("%.2f", ans);
        }
        else if(delta < 0) puts("No real root");
        else {
            double x1 = ((double)(0-b)-sqrt(delta))/(double)(a)/2.0;
            double x2 = (sqrt(delta) + (double)(0-b))/(double)(a)/2.0;
            if(fabs(x1 - 0) < 1e-10) x1 = 0;
            if(fabs(x2 - 0) < 1e-10) x2 = 0;
            if(x1 > x2) printf("%.2f %.2f", x2, x1);
            else printf("%.2f %.2f", x1, x2);
        }
    }
    return 0;
}
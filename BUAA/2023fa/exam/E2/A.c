#include<stdio.h>
#include<math.h>

int main() {
    double r, theta;
    scanf("%lf%lf", &r, &theta);
    printf("%.1lf %.1lf", r*cos(theta), r*sin(theta));
    return 0;
}
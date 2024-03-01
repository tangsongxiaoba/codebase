#include<stdio.h>
#include<math.h>

const double eps = 1e-6;

double xM, yM, r;

double getSin(const double x1, const double y1, const double x2, const double y2) {
    return ((x1-xM)*(y2-yM)-(y1-yM)*(x2-xM))/(r*r);
}

int main() {
    double x1, y1, x2, y2, x3, y3;
    double a, b, c, d, e, f, ans;
    double A, B, C, T, t;
    double PI = 2.0*asin(1.0);
    int i, k;
    scanf("%lf%lf", &x1, &y1);
    scanf("%lf%lf", &x2, &y2);
    scanf("%lf%lf", &x3, &y3);
    a=x1-x2, b=y1-y2, c=x1-x3, d=y1-y3;
    e=x1*x1-x2*x2+y1*y1-y2*y2;
    e/=2.0;
    f=x1*x1-x3*x3+y1*y1-y3*y3;
    f/=2.0;
    xM = (b*f-d*e)/(b*c-a*d);
    yM = (c*e-a*f)/(b*c-a*d);
    r = sqrt((xM-x1)*(xM-x1)+(yM-y1)*(yM-y1)) + sqrt((xM-x2)*(xM-x2)+(yM-y2)*(yM-y2)) + sqrt((xM-x3)*(xM-x3)+(yM-y3)*(yM-y3));
    r /= 3.0;
    A = asin(getSin(x1,y1,x2,y2));
    B = asin(getSin(x2,y2,x3,y3));
    C = asin(getSin(x3,y3,x1,y1));
    if(A < eps) A += PI;
    if(B < eps) B += PI;
    if(C < eps) C += PI;
    if((x1-xM)*(x2-xM)+(y1-yM)*(y2-yM) < eps) A = PI - A;
    if((x2-xM)*(x3-xM)+(y2-yM)*(y3-yM) < eps) B = PI - B;
    if((x3-xM)*(x1-xM)+(y3-yM)*(y1-yM) < eps) C = PI - C;
    if(A < eps) A += PI;
    if(B < eps) B += PI;
    if(C < eps) C += PI;
    if(A - B < eps) {
        if(A - C < eps) T = A;
        else T = C;
    }
    else {
        if(B - C < eps) T = B;
        else T = C;
    }
    for(i = 3; i <= 100; ++i) {
        t = 4.0 * asin(1.0) / i;
        k = T / t;
        if(fabs(T/t - k) < eps || fabs(T/t - (k+1)) < eps) {
            break;
        } 
    }
    ans = 2.0*r*i*sin(t/2.0);
    printf("%.6f", ans);
    return 0;
}

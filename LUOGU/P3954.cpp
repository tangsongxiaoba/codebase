//Luogu P3954 [NOIP2017 普及组] 成绩
#include<cstdio>

int main() {
    double a,b,c, s;
    scanf("%lf%lf%lf",&a,&b,&c);
    s = a*0.2 + b*0.3 + c*0.5;
    printf("%.lf", s);
} 
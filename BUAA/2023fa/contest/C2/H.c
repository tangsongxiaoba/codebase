#include <stdio.h>
#include <ctype.h>
#include <math.h>

const double eps = 1e-10;

void print_sig_fig(double x, int m) {
    static char format_str[11], str[31];
    sprintf(format_str, "%%.%dG", m);
    sprintf(str, format_str, x);
    int i, cnt = 0, flag = 0;
    for(i = 0; str[i]; ++i) {
        if(isdigit(str[i])) ++cnt;
        else if(str[i] == '.') flag = 1;
    }
    if(cnt < m && !flag) str[i++] = '.';
    for(; cnt < m; ++cnt) {
        str[i++] = '0';
    }
    printf("%s", str);
}

int main() {
    double m, acc, rks, a, b, c, d;
    while(scanf("%lf%lf%lf%lf%lf", &m, &a, &b, &c, &d) != EOF) {
        acc = a * 1.0 + b * 0.65;
        acc /= (a + b + c + d);
        if(acc > 0.7 - eps) {
            rks = pow((acc - 0.55) / 0.45, 2) * m;
        } else {
            rks = 0;
        }

        acc *= 100;
        print_sig_fig(acc, 4);
        printf("%% %.4lf\n", rks);
    }
    return 0;
}

#include<stdio.h>
#include<math.h>

int main() {
    int T, n, i;
    double a, b, sa=0, sb=0, delta;
    scanf("%d", &T);
    while(T--) {
        scanf("%d", &n);
        sa = sb = 0;
        for(i = 0; i < n; ++i) {
            a = 1.0 / (2*i + 1);
            if(i & 1) a = -a;
            sa += a;
            b = 1.0 / (2*i+1) / (2*i+1);
            sb += b;
        }
        sa *= 4.0;
        sb *= 8.0;
        sb = sqrt(sb);
        delta = fabs(sa - sb);
        printf("%lf\n", delta);
    }
    return 0;
}
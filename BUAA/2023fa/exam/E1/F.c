#include<stdio.h>

int main() {
    int a, k, n = 0, x1 = 0, x2 = 0, x3 = 0;
    scanf("%d%d", &a, &k);
    while(k != -1) {
        if(k >= a) {
            ++x1;
            x2 += k;
        }
        ++n;
        x3 += k;
        scanf("%d", &k);
    }
    printf("%d %d ", x1, x3/n);
    if(x1) {
        printf("%d", x2 / x1);
    }
    else {
        printf("-1");
    }
    return 0;
}
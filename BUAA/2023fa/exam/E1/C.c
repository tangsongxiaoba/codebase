#include<stdio.h>

int main() {
    int n, a = 0, t, i, x;
    scanf("%d", &n);
    for(i = 0; i < n; ++i) {
        scanf("%d", &x);
        a += x;
    }
    scanf("%d", &t);
    if(a <= 0) printf("0\nMoca finish 0 requirement!");
    else if(a >= t) printf("%d\nMoca finish all requirements!", t);
    else printf("%d", a);
    return 0;
}
#include<stdio.h>

int main() {
    int n, l, r;
    scanf("%d", &n);
    if(n == 1) puts("1\n1");
    else if(n <= 3) puts("-1");
    else if(n == 4) puts("4\n2 4 1 3");
    else {
        printf("%d\n", n);
        for(l = (n % 2 ? n : n-1); l >= 5; l -= 2) {
            printf("%d ", l);
        }
        printf("2 4 1 3 ");
        for(r = 6; r <= n; r += 2) {
            printf("%d ", r);
        }
    }
    return 0;
}
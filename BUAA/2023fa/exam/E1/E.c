#include<stdio.h>

int main() {
    int a, b, x = 1, y = 1;
    scanf("%d%d", &a, &b);
    while(a > 1) {
        x *= (a--);
    }
    while(b >= 2) {
        y *= b;
        b -= 2;
    }
    printf("%d %d\n", x, y);
    if(x > y) printf("a!>b!!");
    else if(x < y) printf("a!<b!!");
    else printf("a!=b!!");
    return 0;
}
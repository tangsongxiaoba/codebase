#include <stdio.h>

int gcd(int a, int b) {
    return b ? gcd(b, a%b) : a;
}

int main() {
    int a, b = 1;
    scanf("%d", &a);
    int div = a, res = a;
    while(b < 8) {
        scanf("%d", &a);
        res += a;
        div = gcd(div, a);
        ++b;
    }
    printf("%d", res / div);

    return 0;
}
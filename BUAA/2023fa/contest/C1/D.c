#include <stdio.h>

int main() {
    int a, b, c, x, y, z;
    scanf("%d%d%d%d%d%d", &a, &b, &c, &x, &y, &z);
    printf("%d", a*x + b*y + c*z);
    return 0;
}
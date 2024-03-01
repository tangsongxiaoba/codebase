#include <stdio.h>

int main() {
    int a,b;
    scanf("%d%d", &a, &b);
    printf("%d\n", b - (a-b));
    if(b - (a-b) >= 4) puts("Yes");
    else puts("No");
    return 0;
}
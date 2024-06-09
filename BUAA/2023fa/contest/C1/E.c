#include <stdio.h>

int main() {
    int n;
    scanf("%d", &n);
    while(n--) {
        int a, b;
        scanf("%d%d", &a, &b);
        if(a == 0) puts("Wait. That's illegal.");
        else {
            printf("%d mod %d = %d\n", b, a, b % a);
        }
    }
    return 0;
}
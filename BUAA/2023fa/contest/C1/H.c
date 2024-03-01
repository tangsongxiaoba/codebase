#include <stdio.h>
#include <math.h>

int main() {
    int T;
    scanf("%d", &T);
    while(T--) {
        int a, b;
        scanf("%d%d", &a, &b);
        if(b == 0) puts("0 0");
        else if(b == a) printf("%d %d\n", b, a);
        else {
            int res = ceil(1.0 * b / (a - b + 1));
            printf("%d %d\n", b, res);
        }
    }

    return 0;
}
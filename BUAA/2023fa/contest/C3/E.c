#include<stdio.h>

int main() {
    int m, n;
    while(scanf("%d%d", &m, &n) != EOF) {
        if((m == 1 && n == 2) || (m == 2 && n == 1)) {
            puts("YEEEEE!!!");
        }
        else {
            puts("W00000!!!");
        }
    }
    return 0;
}

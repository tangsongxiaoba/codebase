#include<stdio.h>

int main() {
    int n, h, m;
    scanf("%d", &n);
    while(n--) {
        scanf("%d%d", &h, &m);
        if((h == 6 && m >= 10) || (h == 22 && m <= 20) || (h > 6 && h < 22)) {
            puts("N");
        }
        else {
            puts("E");
        }
    }
    return 0;
}
#include <stdio.h>

int main () {
    int x, cnt = 0;
    scanf("%d", &x);
    while(x != 1) {
        if(x % 2) {
            x = 3 * x + 1;
        }
        else {
            x /= 2;
        }
        ++cnt;
    }
    printf("%d", cnt);
    return 0;
}
#include <stdio.h>

int main() {
    int n, cnt = 0, res = 0, x;
    scanf("%d", &n);
    while(n--) {
        scanf("%d", &x);
        if(x) ++cnt, res += x;
    }
    if(cnt == 0) puts("Oh!No!");
    else {
        printf("%d", res / cnt);
    }
    return 0;
}
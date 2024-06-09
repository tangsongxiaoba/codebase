#include<stdio.h>

int main() {
    short x;
    int n, i;
    n = 0;
    for(i = 0; i < 32; ++i) {
        x = getchar()-'0';
        n = (n << 1) | x;
    }
    getchar();
    printf("%d", n);
    return 0;
}

#include<stdio.h>

int main() {
    int n, i;
    while(scanf("%d", &n) != EOF) {
        for(i = 31; i >= 0; --i) {
            printf("%d", (n >> i) & 1);
        }
        puts("");
    }
    return 0;
}

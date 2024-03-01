#include<stdio.h>

int res[11] = {1, 1, 2, 720, 657629300, 314702675, 457854178, 771762143, 383066370, 134950653, 107621982};

int main() {
    int n;
    while(scanf("%d", &n) != EOF) {
        printf("%d\n", res[n]);
    }
    return 0;
}

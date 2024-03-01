#include<stdio.h>

int main() {
    int n, i;
    scanf("%d", &n);
    getchar();
    while(n--) {
        i = getchar();
        if(i != 'C' && i != 'B' && i != 'V') {
            putchar(i);
        }
    }
    return 0;
}
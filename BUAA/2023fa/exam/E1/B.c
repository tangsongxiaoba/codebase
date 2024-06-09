#include<stdio.h>

int main() {
    int x = 0, y = 0, i, t;
    for(i = 0; i < 4; ++i) {
        scanf("%d", &t);
        if(t < 0) y += t;
        else x += t;
    }
    printf("%d\n%d", x, y);
    return 0;
}
#include<stdio.h>

int cnt[6];

int main() {
    int a, b, y;
    y = 1;
    while(scanf("%d%d", &a, &b) != EOF) {
        cnt[a] += b;
        if(cnt[a] == 9) {
            printf("%d %d\n", y, a);
            cnt[a] = 0;
        }
        ++y;
    }
    return 0;
}

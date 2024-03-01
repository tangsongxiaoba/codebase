#include<stdio.h>

int highest[17];

int main() {
    int n, m, i, j, k, p;
    long long sum = 0;
    scanf("%d%d", &n, &m);
    m += 1;
    for(i = 0; i <= n; ++i) {
        scanf("%d", &p);
        sum += p;
        j = 0;
        while(j <= m && highest[++j] > p);
        if(j > m) continue;
        do {
            k = highest[j];
            highest[j++] = p;
            p = k;
        } while(j <= m);
    }
    for(i = 1; i <= m; ++i) {
        if(highest[i] == 0 || highest[i] < 6) continue;
        sum -= highest[i], sum += 6;
    }
    printf("%lld", sum);
    return 0;
}
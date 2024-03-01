#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int a[] = {30, 20, 10, 10, 10, 10, 5, 5, 5, 5};

int main() {
    int n, i, j, t, score, cnt;
    int c2, c3, c4;
    double c1;
    n = read();
    c1 = c3 = c4 = 0;
    c2 = n;
    for(j = 0; j < n; ++j) {
        score = cnt = 0;
        for(i = 0; i < 10; ++i) {
            t = read();
            score += t;
            if(t < a[i]) ++cnt;
        }
        if(cnt == 10) ++c4;
        if(score == 110) ++c3;
        if(score > 100) score = 100;
        if(score < 60) --c2;
        c1 += score;
    }
    c1 = c1 / (double)n;
    printf("%.2f\n%d\n%d\n%d", c1, c2, c3, c4);
    return 0;
}

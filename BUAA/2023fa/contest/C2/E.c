#include<stdio.h>

int x[1000100], y[1000100], s1, s2;

int main() {
    int n, i;
    s1 = 0, s2 = 0;
    scanf("%d", &n);
    for(i = 0; i < n; ++i) {
        scanf("%d", &x[i]);
    }
    s1 = x[0];
    for(i = 0; i < n; ++i) {
        scanf("%d", &y[i]);
        if(i == 0) continue;
        if(i == 1 && x[0] == 10) {
            s1 += 2*x[1];
        }
        else if(x[i-1] == 10 || x[i-2] == 10) {
            s1 += 2*x[i];
        }
        else s1 += x[i];
    }
    s2 = y[0];
    for(i = 0; i < n; ++i) {
        if(i == 0) continue;
        if(i == 1 && y[0] == 10) {
            s2 += 2*y[1];
        }
        else if(y[i-1] == 10 || y[i-2] == 10) {
            s2 += 2*y[i];
        }
        else s2 += y[i];
    }
    printf("%d %d\n%s", s1, s2, s1 > s2 ? "violet" : (s1 < s2 ? "Lilsio" : "Let's play again!"));
    return 0;
}
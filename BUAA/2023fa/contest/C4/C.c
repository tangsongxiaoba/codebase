#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

const double eps = 1e-10;
int s[1010];
int count[110];

int main() {
    int n, i, r;
    double t;
    n = read();
    for(i = 1, r = 1; i <= n; ++i, ++r) {
        s[i] = read();
        if(!count[s[i]]) count[s[i]] = r;
    }
    for(i = 1; i <= n; ++i) {
        t = 1.0*count[s[i]]/n;
        if(t - 0.9 > eps) {
            printf("E ");
        }
        else if(t - 0.6 > eps) {
            printf("D ");
        }
        else if(t - 0.25 > eps) {
            printf("C ");
        }
        else if(t - 0.1 > eps) {
            printf("B ");
        }
        else {
            printf("A ");
        }
    }
    return 0;
}

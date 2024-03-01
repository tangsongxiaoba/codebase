#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int ca[20];
int f(int n) {
    if(n == 0) {
        return 1;
    }
    else {
        int sum = 0, i;
        for(i = 0; i <= n-1; ++i) {
            sum += ca[i]*ca[n-1-i];
        }
        return sum;
    }
}

int main() {
    int T, i;
    T = read();
    for(i = 0; i <= 18; ++i) {
        ca[i] = f(i);
    }
    while(T--) {
        printf("%d\n", ca[read()]);
    }
    return 0;
}

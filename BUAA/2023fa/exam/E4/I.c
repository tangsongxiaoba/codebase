#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int a[1010];

int main() {
    int i, n, k, top, f;
    n = read(), k = read();
    k = 2 * k + 1;
    f = 0;
    if(n == 0) {
        return putchar('0'), 0;
    }
    if(n < 0) {
        f = 1;
        n = -n;
    }
    while(n) {
        a[++top] = n % k;
        n /= k;
    }
    k = (k-1)>>1;
    for(i = 1; i <= top; ++i) {
        if(a[i] > k) {
            ++a[i+1];
            a[i] = -k-1+(a[i]-k);
        }
    }
    if(a[top+1] != 0) ++top;
    if(f) {
        for(i = 1; i <= top; ++i) {
            a[i] = -a[i];
        }
    }
    while(top >= 1) {
        printf("%c", a[top] >= 0 ? a[top]+'0' : (-a[top]-1)+'A');
        --top;
    }
    return 0;
}

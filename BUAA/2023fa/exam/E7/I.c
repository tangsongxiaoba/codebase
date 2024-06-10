#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f ? -x : x;
}

void write(int x) {
    static int sta[35];
    int top = 0;
    if(x < 0) putchar('-'), x = -x;
    do {
        sta[top++] = x % 10, x /= 10;
    } while(x);
    while(top) putchar(sta[--top] + '0');
}

char a[1000100];

int main() {
    gets(a);
    int n = strlen(a);
    n = (n == 0 ? 1 : n);
    int k = 0, i = 0, j = 1;
    while (k < n && i < n && j < n) {
        if (a[(i + k) % n] == a[(j + k) % n]) k++;
        else {
            a[(i + k) % n] > a[(j + k) % n] ? (j = j + k + 1) : (i = i + k + 1);
            if (i == j) i++;
            k = 0;
        }
    }
    j = i < j ? i : j;
    i = j;
    do{
        write(a[i]-'0');
        ++i;
        if(i / n) i %= n;
    }while(i != j);
    return 0;
}

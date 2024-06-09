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
    return f?-x:x;
}

void write(int x) {
    static int sta[35];
    int top = 0;
    if(x < 0) putchar('-'), x = -x;
    do {
        sta[top++] = x % 10, x /= 10;
    }while(x);
    while(top) putchar(sta[--top] + '0');
}

typedef struct node{
    int x, y, z;
}point;

point a[11];

LL dot(point A, point B) {
    return 1LL*A.x*B.x+1LL*A.y*B.y+1LL*A.z*B.z;
}

point cross(point A, point B) {
    static point C;
    C.x = 1LL*A.y*B.z-1LL*A.z*B.y;
    C.y = 1LL*A.z*B.x-1LL*A.x*B.z;
    C.z = 1LL*A.x*B.y-1LL*A.y*B.x;
    return C;
}

int f(int p, int q, int r) {
    return dot(cross(a[p], a[q]), a[r]);
}

int main() {
    int i, n = read(), T = read(), p, q, r;
    for(i = 1; i <= n; ++i) {
        a[i].x = read(), a[i].y = read(), a[i].z = read();
    }
    for(i = 1; i <= T; ++i) {
        p = read(), q = read(), r = read();
        printf("%d\n", f(p, q, r));
    }
    return 0;
}

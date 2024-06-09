#include<stdio.h>
#include<math.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

double e(int a, int b) {
    if(a > b) {
        return sqrt(1.0*a*a-1.0*b*b)/(double)a;
    }
    else return sqrt(1.0*b*b-1.0*a*a)/(double)b;
}

int main() {
    int a[8], i;
    for(i = 0; i < 8; ++i) {
        a[i] = read();
    }
    printf("%.2f %.2f %.2f %.2f %.2f", e(a[0], a[4]), e(a[2], a[0]), e(a[6], a[5]), e(a[1], a[3]), e(a[7], a[2]));
    return 0;
}

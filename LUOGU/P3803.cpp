//Luogu P3803 【模板】多项式乘法（FFT）
#include<iostream>
#include<cstdio>
#include<cmath>
using namespace std;

const long double PI = acos(-1.0);
const int MAXN = 4e6+10;
int n, m;
struct CD {
    double x, y;
    CD(double x = 0, double y = 0):x(x), y(y) {}
    CD operator + (CD const &b) const {return CD(x+b.x, y+b.y);}
    CD operator - (CD const &b) const {return CD(x-b.x, y-b.y);}
    CD operator * (CD const &b) const {return CD(x*b.x - y*b.y, x*b.y + y*b.x);}
}a[MAXN];

inline int read() {
    register int x = 0, f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = -1; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return x*f;
}

inline void FFT(CD *a, bool inverse) {
    for(register int i = 0, j = 0; i < n; ++i) {
        if(j > i) swap(a[i], a[j]);
        int k = n;
        while(j & (k >>= 1)) j &= ~k;
        j |= k;
    }
    register CD t, w, x, y;
    for(register int mid = 1; mid < n; mid <<= 1) {
        t = CD(cos(PI/mid), sin(PI/mid));
        if(!inverse) t.y *= -1;
        for(register int k = 0; k < n; k += (mid << 1)) {
            w = CD(1, 0);
            for(register int p = 0; p < mid; ++p) {
                x = a[k|p];
                y = w * a[k|p|mid];
                a[k|p] = x + y;
                a[k|p|mid] = x - y;
                w = w * t;
            }
        }
    }
}

int main() {
    scanf("%d%d", &n, &m);
    for(int i = 0; i <= n; ++i) a[i].x = read();
    for(int i = 0; i <= m; ++i) a[i].y = read();
    for(m+=n, n=1; n <= m; n <<= 1);
    FFT(a, true);
    for(int i = 0; i < n; ++i) a[i] = a[i] * a[i];
    FFT(a, false);
    for(int i = 0; i <= m; ++i)
        printf("%d ", (int)(a[i].y/n/2+0.49));
    return 0;
}

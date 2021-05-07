//Luogu P4513 小白逛公园
#include<cstdio>
#include<algorithm>
using namespace std;

const int MAXN = 5e5+10;
int n, m;
struct sgt {
    int maxv, maxl, maxr, sumv;

    inline int mx(const int& a, const int& b) {
        return (b & ((a-b) >> 31)) | (a & (~(a-b) >> 31));
    }

    inline void pushup(const sgt& lc, const sgt& rc) {
        if(lc.maxr < 0 && rc.maxl < 0) maxv = mx(lc.maxr, rc.maxl);
        else {
            maxv = 0;
            if(lc.maxr > 0) maxv += lc.maxr;
            if(rc.maxl > 0) maxv += rc.maxl;
        }
        maxv = mx(maxv, lc.maxv);
        maxv = mx(maxv, rc.maxv);
        maxl = mx(lc.maxl, lc.sumv + rc.maxl);
        maxr = mx(rc.maxr, rc.sumv + lc.maxr);
        sumv = lc.sumv + rc.sumv;
    }
} T[MAXN<<2];


inline int read() {
    register int x = 0, f = 1;
    register char c = getchar();
    while(c < '0' || c > '9') {if(c == '-') f = 0; c = getchar();}
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f ? x : ~x+1;
}

void build(const int& o, const int& L, const int& R) {
    if(L == R) {
        T[o].maxv = read();
        T[o].sumv = T[o].maxl = T[o].maxr = T[o].maxv;
        return;
    }
    int M = (L+R) >> 1;
    build(o<<1, L, M);
    build(o<<1|1, M+1, R);
    T[o].pushup(T[o<<1], T[o<<1|1]);
}

void update(const int& p, const int& o, const int& L, const int& R, const int& k) {
    if(L == R) {
        T[o].sumv = T[o].maxl = T[o].maxr = T[o].maxv = k;
        return;
    }
    int M = (L+R) >> 1;
    if(p <= M) update(p, o<<1, L, M, k);
    else update(p, o<<1|1, M+1, R, k);
    T[o].pushup(T[o<<1], T[o<<1|1]);
}

sgt query(const int& o, const int& qL, const int& qR, const int& L, const int& R) {
    if(qL <= L && R <= qR) return T[o];
    int M = (L+R) >> 1;
    if(qL <= M && M < qR) {
        sgt res;
        res.pushup(query(o<<1, qL, qR, L, M), query(o<<1|1, qL, qR, M+1, R));
        return res;
    }
    else if(qL <= M) return query(o<<1, qL, qR, L, M);
    else return query(o<<1|1, qL, qR, M+1, R);
}

int main() {
    n = read(), m = read();
    build(1, 1, n);
    register int opt, x, y;
    while(m--) {
        opt = read(), x = read(), y = read();
        if(opt == 1) {
            if(x > y) x^=y, y^=x, x^=y;
            printf("%d\n", query(1, x, y, 1, n).maxv);
        }
        else update(x, 1, 1, n, y);
    }
    return 0;
}
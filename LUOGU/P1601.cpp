//Luogu P1601 A+B Problem（高精）
#include<cstdio>
#include<cstring>

const int BASE = 10000;
const int WIDTH = 4;
const int N = 20000;
struct bint {
    int ln, v[N];
    bint(int r = 0) {
        for(ln = 0; r > 0; r /= BASE) v[ln++] = r % BASE;
    }
    bint& operator = (const bint& rhs) {
        memcpy(this, &rhs, (rhs.ln + 1) * sizeof(int));
        return *this;
    }
};

bool operator < (const bint& a, const bint& b) {
    register int i;
    if(a.ln != b.ln) return a.ln < b.ln;
    for(i = a.ln - 1; i >= 0 && a.v[i] == b.v[i]; --i) ;
    return i < 0 ? 0 : a.v[i] < b.v[i];
}


bool operator <= (const bint& a, const bint& b) {
    return !(b < a);
}

bint operator + (const bint& a, const bint& b) {
    bint res; register int i, cy = 0;
    for(i = 0; i < a.ln || i < b.ln || cy > 0; ++i) {
        if(i < a.ln) cy += a.v[i];
        if(i < b.ln) cy += b.v[i];
        res.v[i] = cy % BASE; cy /= BASE;
    }
    res.ln = i;
    return res;
}

bint operator - (const bint& a, const bint& b) {
    bint res; register int i, cy = 0;
    for(res.ln = a.ln, i = 0; i < res.ln; ++i) {
        res.v[i] = a.v[i] - cy;
        if(i < b.ln) res.v[i] -= b.v[i];
        if(res.v[i] < 0) cy = 1, res.v[i] += BASE;
        else cy = 0;
    }
    while(res.ln > 0 && res.v[res.ln - 1] == 0) --res.ln;
    return res;    
}

bint operator * (const bint& a, const bint& b) {
    bint res; res.ln = 0;
    if(0 == b.ln) {res.v[0] = 0; return res;}
    register int i, j, cy;
    for(i = 0; i < a.ln; ++i) {
        for(j = cy = 0; j < b.ln || cy > 0; ++j, cy /= BASE) {
            if(j < b.ln) cy += a.v[i] * b.v[j];
            if(i + j < res.ln) cy += res.v[i+j];
            if(i + j >= res.ln) res.v[res.ln++] = cy % BASE;
            else res.v[i+j] = cy % BASE;
        }
    }
    return res;
}

bint operator / (const bint& a, const bint& b) {
    bint tmp, mod, res;
    register int i, lf, rg, mid;
    mod.v[0] = mod.ln = 0;
    for (i = a.ln - 1; i >= 0; --i) {
        mod = mod * BASE + a.v[i];
        for (lf = 0, rg = BASE -1; lf < rg; ) {
            mid = (lf + rg + 1) >> 1;
            if (b * mid <= mod) lf = mid;
            else rg = mid - 1;
        }
        res.v[i] = lf;
        mod = mod - b * lf;
    }
    res.ln = a.ln;
    while (res.ln > 0 && res.v[res.ln - 1] == 0) --res.ln;
    return res;
}

inline int digits(const bint& a) {
    if(a.ln == 0) return 0;
    register int l = (a.ln - 1) << 2;
    for(register int t = a.v[a.ln - 1]; t; ++l, t/=10);
    return l;
}

inline bool bread(bint& b, char* buf) {
    if(1 != scanf("%s", buf)) return 0;
    register int w, u, ln = strlen(buf);
    memset(&b, 0, sizeof(bint));
    if('0' == buf[0] && 0 == buf[1]) return 1;
    for(w = 1, u = 0; ln;) {
        u += (buf[--ln] - '0') * w;
        if(w * 10 == BASE) {
            b.v[b.ln++] = u; u = 0; w = 1;
        }
        else w *= 10;
    }
    if(w != 1) b.v[b.ln++] = u;
    return 1;
}

inline void bwrite(const bint& v) {
    register int i;
    printf("%d", v.ln == 0 ? 0 : v.v[v.ln-1]);
    for(i = v.ln - 2; i >= 0; --i) printf("%04d", v.v[i]);
    printf("\n");
}

char a[N], b[N];
bint ba, bb;

int main() {
    bread(ba, a);
    bread(bb, b);

    bwrite(ba+bb);

    return 0;
}
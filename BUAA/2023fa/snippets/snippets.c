#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double
#define UL unsigned long long
#define UU unsigned int
#define SWAP(a, b) (((a) ^ (b)) && ((b) ^= (a) ^= (b), (a) ^= (b)))

#define IO_TYPE int
IO_TYPE read() {
    register IO_TYPE x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= (c == '-'), c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f ? -x : x;
}
void write(IO_TYPE x) {
    static short sta[23];
    short top = 0;
    if(x < 0) putchar('-'), x = -x;
    do {
        sta[top++] = x % 10, x /= 10;
    } while(x);
    while(top) putchar(sta[--top] + '0');
}
#undef IO_TYPE

/*求汉明权重, 即 x 的二进制表示下 1 的个数*/
unsigned int popcount(unsigned int x) {
    unsigned int cnt;
    for(cnt = 0; x; ++cnt) x &= x - 1;
    return cnt;
}

/*计算 x 的奇偶校验码, 有偶数个 1 则返回 0, 否则返回非 0 的整数*/
unsigned int parity(unsigned int x) {
    unsigned int p;
    for(p = 0; x; p = !p) x &= x - 1;
    return p;
}

/*计算 x 最低位有多少个连续的 0, 注意若 x 为 0 应返回 32*/
unsigned int f(unsigned int x) {
    unsigned int c = 32;
    x &= -x;
    if (x) c--;
    if (x & 0x0000FFFF) c -= 16;
    if (x & 0x00FF00FF) c -= 8;
    if (x & 0x0F0F0F0F) c -= 4;
    if (x & 0x33333333) c -= 2;
    if (x & 0x55555555) c -= 1;
    return c;
}

/*对 x 四舍五入到下一个 2 的幂, 如 x = 5 则返回 8, x = 16 则返回 16*/
unsigned int nextpower(unsigned int x) {
    --x;
    x |= (x >> 1);
    x |= (x >> 2);
    x |= (x >> 4);
    x |= (x >> 8);
    x |= (x >> 16);
    ++x;
    return x;
}

/*交换 x 中两部分位的值, 给定两个起始位置 i, j 和需要交换的位数 n, 不得重叠*/
unsigned int reverse_bits(unsigned int x, int i, int j, int n) {
    unsigned int temp = ((x >> i) ^ (x >> j)) & ((1U << n) - 1);
    x ^= ((temp << i) | (temp << j));
    return x;
}

/*反转 x 的所有位, 若为 64 位整型则需要把所有 int 换为 long long*/
unsigned int reverse(unsigned int x) {
    unsigned int s = sizeof(x) * CHAR_BIT;
    unsigned int mask = ~0;
    while((s >>= 1) > 0) {
        mask ^= (mask << s);
        x = ((x >> s) & mask) | ((x << s) & ~ mask);
    }
    return x;
}

unsigned int interleave(unsigned short x, unsigned short y) {
    unsigned int z = 0, i;
    for(i = 0; i < sizeof(x) * CHAR_BIT; i++) {
        z |= (x & 1U << i) << i | (y & 1U << i) << (i + 1);
    }
    return z;
}

/*将 x 中所有的 1 作为一个排列, 按照字典序计算下一个排列*/
unsigned int next_permutation(unsigned int x) {
    unsigned int temp = (x | (x - 1)) + 1;  
    x = temp | ((((temp & -temp) / (x & -x)) >> 1) - 1);
    return x;
}

/*输出 x 的二进制表示*/
void write_binary(unsigned int x) {
    int i, s = sizeof(x) * CHAR_BIT - 1;
    for(i = s; i >= 0; --i ) {
        putchar(((x >> i) & 1) + '0');
    }
}

/*辗转相除法*/
int gcd(int a, int b) {
    return b ? gcd(b, a % b) : a;
}

/*如果是质数则返回 1, 否则返回 0. 时间复杂度为 O(sqrt(n))*/
int isPrime(int x) {
    if(x == 1) return 0;
    if(x % 2 == 0) return 0;
    int i;
    for(i = 3; i * i <= x; i += 2) {
        if(x % i == 0) return 0;
    }
    return 1;
}

/*数组 vis 存储 x 范围内每个数是否为质数的结果, 为 1 则是质数, 否则不是; 数组 pri 存储 x 范围内所有的质数, cnt 表示 x 范围内质数的数量. 时间复杂度为 O(n)*/
int vis[100], pri[100], cnt;
void init(int n) {
    int i, j;
    for(i = 2; i <= n; ++i) {
        if(!vis[i]) {
            pri[cnt++] = i;
        }
        for(j = 0; j < cnt; ++j) {
            if (1ll * i * pri[j] > n) break;
            vis[i * pri[j]] = 1;
            if (i % pri[j] == 0) break;
        }
    }
}

/*快速求 a 的 b 次方模 p 的结果. 时间复杂度为 O(logN)*/
long long qpow(long long a, unsigned long long b, long long p) {
    long long ans = 1;
    a = a % p;
    while(b) {
        if(b & 1)
            ans = (ans * a) % p;
        b >>= 1;
        a = a * a % p;
    }
    return ans;
}



int main() {
    
    unsigned int a = 0, x = 0, y = 1, k = 0, low, min_value, max_value, f, sign, mod = 2, res, mask = 2;
    
    /*位运算相关*/
    
    /*获取 x 的第 k 位*/ 
    a = (x >> k) & 1; 
    /*将 x 的第 k 位 置 1*/
    x |= (1 << k); 
    /*将 x 的第 k 位 置 0*/
    x &= ~(1 << k); 
    /*将 x 的第 k 位 取反*/
    x ^= (1 << k); 
    /*将 x 最低的为 0 的位 置 1*/
    x |= (x + 1); 
    /*将 x 最低的为 1 的位 置 0*/
    x &= (x - 1); 
    /*求 x 最低的为 1 的位, 如 6 (2 进制下为 110) 则输出 2 (2 进制下为 10)*/
    low = (x & (-x)); 
    /*将 x 的高 16 位与低 16 位对调*/
    x = (x << 16) | (x >> 16); 
    /*将 x 对 2 的非负整数次幂取模, 相当于 x % (1 << mod)*/
    x = x & (mod - 1); 
    /*对于 int 型, 计算 x 的符号, 即右移 31 位取符号位的值. CHAR_BIT 为宏常量*/
    sign = x >> (sizeof(int) * CHAR_BIT - 1);
    /*对于 int 型, 检测 x 和 y 是否具有相反的符号, 若为 0 则相同, 否则相反*/
    f = ((x ^ y) < 0);
    /*对于 int 型, 计算 x 的绝对值*/
    res = (x + sign) ^ sign;
    /*对于两个相同类型的任意整型变量, 计算 x 和 y 的最大值和最小值*/
    min_value = y ^ ((x ^ y) & -(x < y));
    max_value = x ^ ((x ^ y) & -(x < y));
    /*确定 x 是否为 2 的幂*/
    f = x && !(x & (x - 1));
    /*根据掩码 mask 合并 x 和 y 的位, 掩码中每一位为 0 时选择 x 的位, 1 则选择 y 的位*/
    res = (x ^ ((x ^ y) & mask));
    
    /*求 x 的所有素因子. 数组 p 存储 x 的所有素因子, cnt 为素因子的个数*/
    int p[10005];
    int cnt = 0;
    long long t = x, ii;
    for(ii = 2; ii * ii <= t; ++ii) {
        if(t % ii == 0) {
            p[cnt++] = ii;
            while(t % ii == 0)
                t /= ii;
        }
    }
    if(t != 1LL) p[cnt++] = t;
    
    /*免溢出输出组合数. 组合数 nCm 对应数组 a 中的元素 a[m][n-m]*/
    int arr[100][100], m = 1, n = 1, i, j;
    arr[0][0] = 1;
    for(i = 0; i <= m ; i++) {
        for(j = 0; j <= n; j++) {
            if(i == 0 && j == 0) continue;
            else if(i == 0) arr[i][j] = arr[i][j - 1];
            else if(j == 0) arr[i][j] = arr[i - 1][j];
            else arr[i][j] = arr[i - 1][j] + arr[i][j - 1];
        }
    }
    
    puts("AK finial examination!");
    return 0;
}

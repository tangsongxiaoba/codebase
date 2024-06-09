# 期末复习

## 前言

这是 BUAA 信类大一上程设期末复习资料, 由 "另一种" 小组 (一个传源书院学支学习互助小组) 的成员 (lzq, yzx, zjl) 共同整理而成, 仅供本校同学内部复习参考使用.
程序设计基础对于刚进入大学的同学来说是一门上手较难的课程. 经过一个学期的摸爬滚打, 相信各位已经有了属于自己的程设上机的一些套路. 本复习资料是 "另一种" 小组三位成员在开展学习互助活动中总结并整理各自的代码而形成的一些常见套路, 希望能帮助各位在程设期末更好上分!
此外, 这一复习资料的形成也参考了许多其他资料, 我们会在资料的结尾注明. 感谢编写这些资料的大佬们 (特别是我们的助教们) 的付出!
首先是一个模板:

```c
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

int main() {
    puts("AK finial examination!");
    return 0;
}
```

该模板包含了编写程序过程中的一些固定格式以及常用代码片段, 下面作解释:

1. 引入了一些常用的头文件; 特别地, 引入了 `stdbool.h`, 该头文件为 C 添加了 [布尔类型](https://oi-wiki.org/lang/var/#%E5%B8%83%E5%B0%94%E7%B1%BB%E5%9E%8B) 的支持. (此头文件于 C99 标准中加入, 虽然和老师课上所说 C89 标准不一, 但实测在 [accoding 平台](https://accoding.buaa.edu.cn/) 上可以正常通过编译.)
2. 使用宏定义简化了一些常用的数据类型, 并加入了一个简单的交换变量函数.
3. 加入了快读/快写函数, 可以用于输入/输出整型变量. 格式化输入/输出函数的使用过于繁琐, 使用快读/快写可以加速一部分代码的编写. (但快读/快写的"快"应该是运行时间的快.) 在模板中宏定义了一个 `IO_TYPE` 作为输入/输出变量的数据类型, 可以根据需要将 `int` 自由更改为 `(unsigned) short/int/long long` . 对于快写函数, 注意默认输出的内容不带回车/空格; 当然, 也可以在其末尾加上如 `puts("");` 或 `putchar(' ');` 等语句, 达到想要的效果.
4. `main` 函数内部为一个 `puts()` 语句, 其输出的内容是小组成员对所有同学表示的衷心祝福.

要使用该模板, 建议同学们善用自己的 IDE (如 vscode, Dev-Cpp, CLion, code::blocks 等) 的 "代码模板" 以及类似功能, 将该模板保存到这一功能当中, 在每次新建一个 c 语言文件时都能自动添加这些内容. 同时, 对于即将到来的期末考试, 建议同学们提前准备好 10 或 11 个带模板的 c 语言文件 (视考试题量而定), 考前在编辑器中全部打开, 以便自己快速编写代码.

衷心祝愿每一位同学都能够在程设期末考试中取得自己理想的成绩!

## 目录

- 前言
- 位运算
- 数学相关
- 算法模板
- 字符串
- 指针/结构体/排序/查找
- 后记

## 位运算

以下是位运算相关代码, 最低操作位为 0. 若未作说明, 则待操作数 x 均为 `unsigned int` 型, 能否转换为其他类型则视情况而定.

### 简单操作

```c
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
```

### 函数操作

#### 汉明码

```c
/*求汉明权重, 即 x 的二进制表示下 1 的个数*/
unsigned int popcount(unsigned int x) {
    unsigned int cnt;
    for(cnt = 0; x; ++cnt) x &= x - 1;
    return cnt;
}
```

#### 奇偶校验码

```c
/*计算 x 的奇偶校验码, 有偶数个 1 则返回 0, 否则返回非 0 的整数*/
unsigned int parity(unsigned int x) {
    unsigned int p;
    for(p = 0; x; p = !p) x &= x - 1;
    return p;
}
```

#### 求低位连续 0

```c
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
```

```c
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
```

```c
/*交换 x 中两部分位的值, 给定两个起始位置 i, j 和需要交换的位数 n, 不得重叠*/
unsigned int reverse_bits(unsigned int x, int i, int j, int n) {
    unsigned int temp = ((x >> i) ^ (x >> j)) & ((1U << n) - 1);
    x ^= ((temp << i) | (temp << j));
    return x;
}
```

```c
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
```

```c
/*交错位, 即将 16 位整型变量 x 和 y 的位交错排放在一起, 组成一个 32 位整型*/
unsigned int interleave(unsigned short x, unsigned short y) {
    unsigned int z = 0, i;
    for(i = 0; i < sizeof(x) * CHAR_BIT; i++) {
        z |= (x & 1U << i) << i | (y & 1U << i) << (i + 1);
    }
    return z;
}
```

```c
/*将 x 中所有的 1 作为一个排列, 按照字典序计算下一个排列*/
unsigned int next_permutation(unsigned int x) {
    unsigned int temp = (x | (x - 1)) + 1;  
    x = temp | ((((temp & -temp) / (x & -x)) >> 1) - 1);
    return x;
}
```

```c
/*输出 x 的二进制表示*/
void write_binary(unsigned int x) {
    int i, s = sizeof(x) * CHAR_BIT - 1;
    for(i = s; i >= 0; --i ) {
        putchar(((x >> i) & 1) + '0');
    }
}
```

## 数学相关

### 辗转相除法

```c
int gcd(int a, int b) {
    return b ? gcd(b, a % b) : a;
}
```

### 素数相关

#### 判断是否为质数

```c
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
```

#### 求 x 的所有素因子

```c
/*数组 p 存储 x 的所有素因子, cnt 为素因子的个数*/
int p[10005];
int cnt = 0;
long long t = x, i;
for(i = 2; i * i <= t; ++i) {
    if(t % i == 0) {
        p[cnt++] = i;
        while(t % i == 0)
            t /= i;
    }
}
if(t != 1LL) p[cnt++] = t;
```

#### 欧拉筛法求素数

```c
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
```

### 快速幂

```c
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
```

### 免溢出输出组合数

代码源于 2023 级程设 E8-F 题解.

```c
/*组合数 nCm 对应数组 a 中的元素 a[m][n-m]*/
a[0][0] = 1;
for(i = 0; i <= m ; i++) {
    for(j = 0; j <= n; j++) {
        if(i == 0 && j == 0) continue;
        else if(i == 0) a[i][j] = a[i][j - 1];
        else if(j == 0) a[i][j] = a[i - 1][j];
        else a[i][j] = a[i - 1][j] + a[i][j - 1];
    }
}
```

## 算法模板

### 输出一段能够运行并输出给定字符画的代码

即 2023 级程设 E7-C 题代码. 可能对第一题的快速解决有用处.

```c
#include <stdio.h>
int main() {
    int i;
    char s[505];
    printf("#include<stdio.h>\nint main()\n{\n");
    while(gets(s)) {
        printf(" printf(\"");
        for(i = 0; s[i]; ++i) {
            if(s[i] == '\\' || s[i] == '\'' || s[i] == '\"')
                printf("\\");
            else if(s[i] == '%')
                printf("%%");
            putchar(s[i]);
        }
        printf("\\n\");\n");
    }
    printf(" return 0;\n}");
    return 0;
}
```

### 单调队列

一种数据结构, 常用于求一个数组中每 k 个连续的数中的最大值/最小值.

```c
/*输出数组 a 中每 k 个连续的数中的最小值*/
int head = 0, tail = -1, i;
for(i = 1; i < k; i++) {
    while(head <= tail && a[q[tail]] >= a[i]) tail--;
    q[++tail] = i;
}
for(i = k; i <= n; i++) {
    while(head <= tail && a[q[tail]] >= a[i]) tail--;
    q[++tail] = i;
    while(q[head] <= i - k) head++;
    printf("%d ", a[q[head]]);
}
```

可以与前缀和结合起来求一段数的和的最大值/最小值, 如 2023 级 E4-J.

```c
/*求长度为 1 到 m 的区间和的最大值*/
for(i = 1; i <= n; ++i) {
    sum[i] = sum[i - 1] + a[i];
}
for(i = 1; i <= n; ++i) {
    while(head <= tail && q[head] < i - k) ++head;
    if(ans < sum[i] - sum[q[head]]) ans = sum[i] - sum[q[head]];
    while(head <= tail && sum[q[tail]] >= sum[i]) --tail;
    q[++tail] = i;
}
```

### 二分答案

适用于一些所有可能的答案为单调的问题, 如求一个一元三次方程在一段单调区间上的近似解等. 其实就是二分法. 可以用来解决:

1. 最大值中的最小值
2. 最小值中的最大值
3. 满足条件的最大值/最小值

```c
/*如求一元三次方程的解*/
while(r - l > eps) {
    if(check(mid) > 0) r = mid;
    else l = mid;
    mid = (l + r) / 2;
}

/*还有很相似的三分法*/
while(r - l > eps) {
    mid = (lmid + rmid) / 2;
    lmid = mid - eps;
    rmid = mid + eps;
    if (check(lmid) < check(rmid)) r = mid;
    else l = mid;
}
```

二分答案的关键在于如何编写 `check` 函数, 见仁见智. 以经典例题 [P2678 跳石头](https://www.luogu.com.cn/problem/P2678) 为例, 我们可以二分跳跃距离, 将猜测值代入过程中来看是否能够成立, 如果可以就往大猜, 否则就往小猜. 至于如何看是否能够成立, 我们只需要在该猜测值的条件下, 从第一块石头开始跳, 看看跳到终点是否需要移除多于 M 块岩石即可. 代码如下:

```c
int check(int x) {
    int cnt = 0, i, now = 0;
    for(i = 1; i <= n+1; ++i) {
        if(a[i]- a[now] < x) ++cnt;
        else now = i;
    }
    if(cnt > m) return 0;
    else return 1;
}
```

### 手搓二分查找

#### 二分查找

```c
/*在数组 arr 从下标 l 到 r 的范围中查找 key, 找到了返回对应的下标, 否则返回 -1*/
int binary_search(int key, int l, int r) {
    int ret = -1;
    int mid;
    while (start <= end) {
        mid = start + ((end - start) >> 1);
        if (arr[mid] < key)
            start = mid + 1;
        else if (arr[mid] > key)
            end = mid - 1;
        else {
            ret = mid;
            break;
        }
    }
    return ret;
}
```

#### 查找首个不小于/大于给定值的元素

```c
/*在数组 arr 从下标 l 到 r 的范围中查找首个不小于 key 的元素, 找到了返回对应的下标, 否则返回 -1*/
int lower_bound(int key, int l, int r) {
    while(l < r) {
        int mid = l + (r - l) / 2;
        if(arr[mid] >= key) r = mid;
        else l = mid + 1;
    }
    return arr[l] >= key ? l : -1;
}

/*在数组 arr 从下标 l 到 r 的范围中查找首个大于 key 的元素, 找到了返回对应的下标, 否则返回 -1*/
int upper_bound(int key, int l, int r) {
    while(l < r) {
        int mid = l + (r - l) / 2;
        if(arr[mid] > key) r = mid;
        else l = mid + 1;
    }
    return arr[l] > key ? l : -1;
}
```

### 输出数组中的前 K 小个数

即 2023 级程设 E8-D.

```c
/*时间复杂度为 O(Kn)*/
for(i = 1; i <= K; ++i)
    for(j = 1; j <= n - i; ++j)
        if(a[j] < a[j + 1]) {
            SWAP(a[j], a[j + 1]);
        }
for(i = 0; i < K; ++i)
    printf("%d ", a[n - i]);
}
```

### 归并排序

这是另一种排序的算法, 利用了分治的思想, 时间复杂度为 $O(n\log n)$. 介绍归并排序, 其一是因为快速排序对于一些极端情况, 其时间复杂度可能退化到 $O(n^2)$, 其二则是因为它可以用来解决逆序对问题: 在合并过程中, 若后段首元素是当前最小值, 则前段剩余元素个数就是逆序对的(一部分)数量, 累加即可.

```c
/*merge 为归并排序中合并的部分. cnt 为全局变量, 为待排序部分中逆序对的数量. 若不需计算, 注释掉即可*/
void merge(const int* aBegin, const int* aEnd, const int* bBegin, const int* bEnd, int* c) {
    while(aBegin != aEnd && bBegin != bEnd) {
        if(*bBegin < *aBegin) {
            *c = *bBegin;
            cnt += aEnd - aBegin;
            ++bBegin;
        } else {
            *c = *aBegin;
            ++aBegin;
        }
        ++c;
    }
    for(; aBegin != aEnd; ++aBegin, ++c) *c = *aBegin;
    for(; bBegin != bEnd; ++bBegin, ++c) *c = *bBegin;
}
/*对数组 a 从下标 l 到 r - 1 进行升序排序*/
void merge_sort(int* a, int l, int r) {
    if(r - l <= 1) return;
    int mid = l + ((r - l) >> 1);
    merge_sort(a, l, mid), merge_sort(a, mid, r);
    int i;
    merge(a + l, a + mid, a + mid, a + r, tmp + l);
    for(i = l; i < r; ++i) a[i] = tmp[i];
}

/*使用时, 对长度为 n 的数组 arr, 写法如下:*/
merge_sort(arr, 0, n);
```

## 字符串

### 日期相关

```c
/*月份天数数组*/
const int mon[13] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

/*判断八位字符串日期是否合法. 返回 1 为合法, 0 为不合法*/
int check(char x[]) {
    if(strlen(x) != 8) return 0;
    int year, month, day;
    sscanf(x, "%4d%2d%2d", &year, &month, &day);
    if(day > 31 || month < 1 || month > 12) return 0;
    if(((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) {
        if((month == 2 && day > 29) || (month != 2 && day > mon[month])) return 0;
    } else {
        if(day > mon[month]) return 0;
    }
    return 1;
}
```

### 操作相关

#### 输入输出

```c
/*字符串的输入, 注意不需要加取地址符 &*/

/*遇到换行符或者空格停止, 遇到 EOF, 即键盘输入按下 Ctrl+Z 则返回 EOF*/
scanf("%s", str);
/*使用通配符, 遇到换行符停止, 遇到 EOF 则返回 EOF*/
scanf("%[^\n]", str);
/*遇到换行符停止, 遇到 EOF 则返回 NULL, 注意 str 的大小要装得下输入的内容!*/
gets(str);
/*遇到换行符停止, 最多读入 N-1 个字符, 遇到 EOF 则返回 NULL. stdin 指标准输入流, 即键盘输入*/
fgets(str, N, stdin);
/*对于一些情况, 可以使用字符输入代替字符串输入, 框架如下. 其中第一行的判断是为了跳过换行符*/
while((c = getchar()) != EOF) {
    if(c == '\r' || c == '\n') continue;
    /*TO DO*/
}

/*sprintf 函数的使用: 和 printf 相似, 只是将输出重定向到字符串中, 因此最前面多一个参数 str. 注意 str 的大小要足够装得下输入的内容!*/

/*将整数, 浮点数转化为字符串*/
sprintf(str, "%d", 1234);
sprintf(str, "%.3f", 3.142);

/*将多个数以及一些字符拼接成一个字符串*/
sprintf(str, "%d divided by %d is %.2f", 5, 2, 2.5);

/*读入浮点数 x 和整数 m, 输出 x, 保留 m 位小数*/
scanf("%lf%d", &x, &m);
sprintf(format_str, "%%.%df\n", m);
printf(format_str, x);

/*sscanf 函数的使用: 和 scanf 相似, 只是将输入重定向到字符串中, 因此最前面多一个参数 str. 若 str 为空, 则返回 EOF, 否则返回成功读入的个数*/

/*将字符串转化为整数*/
sscanf(str, "%4d%2d%2d", &year, &month, &day);

/*有效数字的输出*/
void print_sig_fig(double x, int m) {
    static char format_str[11], str[31];
    sprintf(format_str, "%%.%dG", m);
    sprintf(str, format_str, x);
    int i, cnt = 0, flag = 0;
    for(i = 0; str[i]; ++i) {
        if(isdigit(str[i])) ++cnt;
        else if(str[i] == '.') flag = 1;
    }
    if(cnt < m && !flag) str[i++] = '.';
    for(; cnt < m; ++cnt) {
        str[i++] = '0';
    }
    printf("%s", str);
}
```

#### 头文件实现的函数

```c
/*定义字符数组str1, str2, 字符 c*/

/*返回字符串 str1 的长度, 从所给指针的地址开始直到遇见第一个'\0'. 注意, 该函数为线性时间复杂度, 请勿在循环条件判断中随意加入使用!!!*/
strlen(str1);
/*按照字典序比较 str1 和 str2, 若 str1 较小则返回负值, 较大则返回正值, 相同则返回 0. 注意返回的值是不确定的, 只有符号确定!*/
strcmp(str1, str2);
/*将 str2 中的字符复制到 str1 中, 原 str1 的内容会被覆盖. 注意 str1 的大小需要装得下 str2 的内容!*/
strcpy(str1, str2);
/*将 str2 接到 str1 的末尾, 覆盖原 str1 末尾的 '\0'. 注意 str1 的大小需要装得下原 str1 和 str2 的内容, 且 str1 和 str2 不能重叠!*/
strcat(str1, str2);
/*在 str1 中查找 str2. 若 str2 为 str1 的子串, 则返回 str2 在 str1 中首次出现的地址, 否则返回 NULL*/
strstr(str1, str2);
/*在 str1 中查找字符 c. 若找到则返回 c 在 str1 中首次出现的地址, 否则返回 NULL*/
strchr(str1, c);
/*在 str1 中反向查找字符 c. 若找到则返回 c 在 str1 中最后一次出现的地址, 否则返回 NULL*/
strrchr(str1, c);
```

##### strlen 函数的使用注意

再次强调一下 `strlen` 函数的使用. 这一函数的实现本身就是 $O(n)$ 的, 如果把它放到循环条件判断中, 每次都要重新计算一次, 复杂度就变为 $O(n^2)$ 了, 如下:

```c
/*禁忌写法*/
for(i = 0; i < strlen(str); ++i) {
    /*TO DO*/
}
```

这也是有些题目莫名其妙 TLE 的原因. 正确写法如下:

```c
/*正确写法*/
int len = strlen(str);
for(i = 0; i < len; ++i) {
    /*TO DO*/
}
```

#### 一些常用的字符串操作

部分操作源于 2023 级程设 E7-H. 操作从 0 开始计数.

##### 字符串截断

```c
/*将 str1 自第 i 位以后的内容删去 (包括第 i 位)*/
void del(char str1[], int i) {
    str1[i] = '\0';
}
/*这里可以选择直接把第 i 位 置为 '\0', 复杂度为 O(1), 也可以把从 i 开始到 strlen(str1) 的所有内容都变成 '\0', 但时间复杂度差不多是 O(n).*/
```

##### 字符串插入

```c
/*将 str2 插入在 str1 的第 i 位之后*/
void insert(char str1[], char str2[], int i) {
    static char str3[10005];
    strcpy(str3, str1 + i + 1);
    str1[i + 1] = '\0';
    strcat(str1, str3);
    strcat(str1, str2);
}
```

##### 字符串删除

```c
/*将 str1 第 i 位 到第 j 位 (包括第 i, j 位) 之间的内容删除, 可能存在的之后的字符向前补位*/
void delete_part(char str1[], int i, int j) {
    static char str2[10005];
    strcpy(str2, str1 + j + 1);
    str1[i] = '\0';
    strcat(str1, str2);
}
```

##### 字符串替换

```c
/*将 str1 第 i 位到第 j 位 (包括第 i, j 位) 之间的内容替换为 str2*/
void replace_part(char str1[], char str2[], int i, int j) {
    static char str3[10005];
    strcpy(str3, str1 + j + 1);
    str1[i] = '\0';
    strcat(str1, str2);
    strcat(str1, str3);
}
```

##### 子串首末位置查询

```c
/*输出 str2 在 str1 中第一次出现和最后一次出现的位置, 用一个空格分开. 若不存在, 则输出 NULL*/
void search(char str1[], str2[]) {
    char* p1 = strstr(str1, str2);
    if(p1 == NULL) puts("NULL");
    else {
        printf("%lld ", p1 - str1);
        char* p2;
        while((p2 = strstr(p1 + 1, str2)) != NULL) {
            p1 = p2;
        }
        printf("%lld\n", p1 - str1);
    }
}
```

##### 子串所有位置查询

```c
/*输出 str2 在 str1 中每一次出现的位置, 用空格分开. 若不存在, 则输出 NULL*/
void search_every(char str1[], char str2[]) {
    char* p1 = strstr(str1, str2);
    if(p1 == NULL) puts("NULL");
    else {
        char* p2 = p1;
        do {
            printf("%lld ", p2 - str1);
            p1 = p2;
        } while((p2 = strstr(p1 + 1, str2)) != NULL);
    }
}
```

##### 统计子串

```c
int count(char str1[], char str2[]) {
    char* p1 = strstr(str1, str2);
    if(p1 == NULL) return 0;
    else {
        char* p2;
        int cnt = 0;
        while((p2 = strstr(p1 + 1, str2)) != NULL) {
            ++cnt;
            p1 = p2;
        }
        return cnt;
    }
}
```

##### 删除所有子串

```c
/*把 str1 中所有的子串 str2 删除*/
void delete(char str1[], char str2[]) {
    char* p1 = str1, *p2;
    int len = strlen(str2);
    while((p2 = strstr(p1, str2)) != NULL) {
        delete_part(str1, p2 - str1, p2 - str1 + len - 1);
        p1 = p2;
    }
}
```

##### 替换所有子串

有两个版本, 看上去没什么区别, 但如果不理解题意的话, 很容易写成第二个版本, 造成错误.

```c
/*把 str1 中所有的子串 str2 替换为 str3*/
void replace(char str1[], char str2[], char str3[]) {
    char* p1 = str1, *p2;
    int len1 = strlen(str2), len2 = strlen(str3);
    while((p2 = strstr(p1, str2)) != NULL) {
        replace_part(str1, str3, p2 - p, p2 - p + len1 - 1);
        p1 = s + (p2 - p) + len2;
    }
}

/*把 str1 中所有的子串 str2 替换为 str3, 包括在替换过程中新生成的子串*/
void replace_all(char str1[], char str2[], char str3[]) {
    char* p1 = str1, *p2;
    int len1 = strlen(str2), len2 = strlen(str3);
    while((p2 = strstr(p1, str2)) != NULL) {
        replace_part(str1, str3, p2 - p, p2 - p + len1 - 1);
        p1 = p2;
    }
}
```

##### 字符串的翻转

```c
/*将 str 进行翻转, 返回指向 str 开头的指针*/
char* reverse(char str[]) {
    int head = 0, tail = strlen(str) - 1;
    while (head < tail) {
        SWAP(str[head], str[tail]);
        head++;
        tail--;
    }
    return str;
}
```

##### 偶回文处理

```c
/*将 str2 变成偶回文串 str1, 如 123 -> 123321*/
void even_palindrome(char str1[], char str2[]) {
    static char str3[10005];
    strcpy(str3, str2);
    strcpy(str1, str2);
    strcat(str1, reverse(str3));
}
```

##### 奇回文处理

```c
/*将 str2 变成奇回文串 str1, 如 123 -> 12321*/
void odd_palindrome(char str1[], char str2[]) {
    static char str3[10005];
    strcpy(str3, str2);
    strcpy(str1, str2);
    strcat(str1, reverse(str3)+1);
}
```

## 指针/结构体/排序/查找

这一部分内容主要介绍指针在排序/查找函数中的应用.

### 一般数组的排序/查找

首先我们要来复习一下这两个由 `stdlib.h` 给出的函数:

```c
/*qsort, 快速排序, 时间复杂度为 O(NlogN). 共四个参数, 第一个是待排序数组, 第二个是数组长度, 第三个是数组内每个单元的字节大小, 第四个是排序的规则函数*/
qsort(arr, len, sizeof(arr[0]), compare);

/*bsearch, 二分查找, 在单调数组中快速查找关键字, 时间复杂度为 O(logN). 共五个参数, 第一个是关键字, 第二个是待查找数组, 第三个是数组长度, 第四个是数组内每个单元的字节大小, 第五个是查找的规则函数. 如果找到, 返回结果的地址, 否则返回 NULL*/
bsearch(&key, arr, len, sizeof(arr[0]), compare);
```

这里值得注意的是如何利用 bsearch 的返回值. 我们知道其返回值是指向结果的一个指针, 那么我们有两种操作办法:

```c
/*假定操作数组为 int 型*/
int* res = bsearch(&key, arr, len, sizeof(arr[0]), compare);
/*第一种办法, 即直接输出结果, 那么得到的输出内容应该和 key 是一致的. 不要忘记加上解引用符 * !*/
printf("%d", *res);
/*第二种办法, 将 res 减去 arr, 即得到结果在数组中的下标. 这是因为数组在内存中是连续排列的, 而数组名称即数组首个元素的地址, 因此通过加减法我们便能得出结果对应的下标. 由此, 我们可以理解, 下标的含义是当前元素的地址距离首元素地址的偏移量.*/
printf("%lld", res - arr);
```

然后就是关于如何编写 `compare` 函数的问题. `qsort` 和 `bsearch` 函数的 `compare` 函数是一样的. 基本上来说这是一个模板:

```c
/*假定待操作数组为 int 型. 其他类型只需要将函数内部所有 int 进行替换即可*/
int compare(const void* p1, const void* p2) {
    int* a = (int*) p1;
    int* b = (int*) p2;
    if(*a > *b) return 1;
    else if(*a < *b) return -1;
    else return 0;
}
```

再解释一下 `compare` 函数返回值表示的含义:

对于 `qsort` 函数来说, 上述 `compare` 函数是指将数组从小到大排序, 即升序排序. 因此可以理解为, 对于左右两个数 a 和 b, 若返回值为正数, 则将 a 往后排, 若为负数将 b 往后排, 否则说明 a 等于 b, 二者顺序不变. (这只是说明了返回值的意思, 不代表实际算法.) 所以, 如果把上述 `compare` 函数中的 1 和 -1 换一下位置, 那么数组就变成从大到小, 即降序排序了.

对于 `bsearch` 函数来说, 上述 `compare` 函数是指在升序数组中查找关键字. **注意, 若将上述函数用在降序数组中, 则会得到 WA/REG.** 可以理解为, 将当前的数 b 与关键字 a 作比较, 若返回值为正数, 说明当前数较小, 应该往后找; 若为负数, 说明当前数较大, 应该往前找; 否则说明找到了. (同样不代表实际算法.) 所以, 如果把上述 `compare` 函数中的 1 和 -1 换一下位置, 那么就变成了在降序数组中查找关键字了.

### compare 与 lower_bound/upper_bound 的结合

我们还可以将 lower_bound/upper_bound 与 compare 结合, 实现使用 bsearch 来查找首个不小于/大于给定值的元素.

```c
/*使用时, 待查数组 arr 需为全局数组. 如果找不到满足条件的元素, 则返回 NULL*/
int lowerBound(const void* p1, const void* p2) {
    int* a = (int*)p1;
    int* b = (int*)p2;
    if ((b == arr || compare(a, b - 1) > 0) && compare(a, b) > 0) return 1;
    else if (b != arr && compare(a, b - 1) <= 0) return -1;
    else return 0;
}
int upperBound(const void* p1, const void* p2) {
    int* a = (int*)p1;
    int* b = (int*)p2;
    if ((b == arr || compare(a, b - 1) >= 0) && compare(a, b) >= 0) return 1;
    else if (b != arr && compare(a, b - 1) < 0) return -1;
    else return 0;
}
/*只需要把 bsearch 中的 compare 替换为 lowerBound/upperBound 即可使用*/
int* res = bsearch(&key, arr, len, sizeof(arr[0]), lowerBound);
```

不知道上述两个函数是否可能含有什么错误, 如发现欢迎指出. 在实际使用过程中, 我们发现手搓实现二分查找出错的概率比使用 bsearch 更小. 所以建议同学们在写题目的过程中使用手搓的方法.

### 使用结构体进行多数据/多关键字的排序/查找

在实际做题目过程中, 往往会出现多个数据作为一个单元, 要求对多个单元进行排序/查找的, 如 2023 级程设 E8-G. 对于这一类问题, 我们可以使用结构体来把这些数据统一起来, 作为一个单元进行操作.

首先是结构体 `struct` 的定义:

```c
/*定义一个名为 node 的 struct, 里面含有两个变量: int 型的 a 和 double 型的 b*/
struct node {
    int a;
    double b;
};
/*"struct + 结构体名称" 可以作为类似 "int" 一样的类型标识符, 来定义结构体变量/数组. 如下, 声明了一个长度为 10 的 arr 数组*/
struct node arr[10];
/*写两个单词过于麻烦, 可以使用 typedef 来将 struct node 直接定义为一种类型, 像 "int" 一样直接使用, 如下, 将其定义为 stu 类型, 再声明了一个长度为 10 的 cla 数组, 等价于 struct node cla[10];*/
typedef struct node stu;
stu cla[10];
```

在实际操作过程中, 有了 `typedef`, 我们就可以把结构体和 `int` 等类型一样一视同仁了, 操作基本一致, 不过要涉及到如何调用 struct 内部的变量:

```c
/*对于结构体变量, 调用其内部的变量需要用到成员访问操作符 . , 比如对于上述结构体, 访问, 赋值并输出其内部的变量 a 的方式如下*/
cla[0].a = 1;
printf("%d", cla[0].a);
/*对于指向结构体的指针, 调用需要用到成员访问操作符 -> . 如下*/
stu* p = &cla[0];
printf("%d", p->a);
```

最后来说说如何编写对结构体进行查找/排序的 `compare_node` 函数.

```c
/*compare_node 本身返回值还是 int 类型的! 如下, 我们把结构体中的 a 变量作为关键字进行操作*/
int compare_node(const void* p1, const void* p2) {
    stu* x = (stu*) p1;
    stu* y = (stu*) p2;
    if(x->a > y->a) return 1;
    else if(x->a < y->a) return -1;
    else return 0;
}
/*如果有多个关键字 (一般是排序), 我们也可以进行排序, 如下, 我们把 a 变量作为第一关键字, 把 b 作为第二关键字*/
int compare_node_more(const void* p1, const void* p2) {
    stu* x = (stu*) p1;
    stu* y = (stu*) p2;
    if(x->a > y->a) return 1;
    else if(x->a < y->a) return -1;
    else {
        if(x->b > y->b) return 1;
        else if(x->b < y->b) return -1;
        else return 0;
    }
}
/*根据需要使用即可*/
qsort(cla, 10, sizeof(cla[0]), compare_node_more);
```

### malloc 函数的使用

在做题的时候, 有时候我们需要操作一些不定长的数组(即长度事先不知道, 由题目给定), 且直接开最大的数组我们装不下, 如 2023级程设 E8-H. 这时候我们就需要使用 `malloc` 函数配合 `free` 函数, 来动态地申请/释放内存空间:

```c
/*输入一个字符串 s, 将其存储到指针 p 指向的 (动态分配的) 数组中*/
gets(s);
char* p;
p = (char*) malloc((int) strlen(s) * sizeof(char) + 1);
strcpy(p, s);

/*TO DO*/

/*经过一番操作之后, 用不着这个指针指向的字符串了, 就把它 free 掉*/
free(p);
```

## 后记

这份资料仅仅涵盖了位运算, 字符串, 指针, 以及一些数学相关的知识和一些可能用到的算法, 对于我们学过的递归等没有提及, 因为递归等算法没有什么套路可循, 需要我们在解题过程中自己思考.

编写这份复习资料的过程中, 我们小组参考了许多外部资料, 列举如下, 以表感谢.

1. 2023 年信息类程设题解, 由我们的助教编写;
2. 网页 [Bit Twiddling Hacks](https://graphics.stanford.edu/~seander/bithacks.html)
3. 网站 [洛谷](https://luogu.com.cn)
4. 网站 [OI-Wiki](https://oi-wiki.org/)

最后, 如果你发现这份资料有什么错误, 或有什么可以改进的地方的话, 欢迎发送邮件到 [lzq 的邮箱](mailto:tangsongxiaoba@buaa.edu.cn) 提建议. 感谢各位斧正!

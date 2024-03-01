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

typedef struct node{
    int id, len;
    char s[110];
}unit;

unit str[10010];

int compare(const void* p1, const void* p2) {
    unit* x = (unit*) p1;
    unit* y = (unit*) p2;
    if(x->len > y->len) return 1;
    else if(x->len < y->len) return -1;
    else {
        int res = strcmp(x->s, y->s);
        if(res > 0) return 1;
        else if(res < 0) return -1;
        else {
            if(x->id > y->id) return 1;
            else if(x->id < y->id) return -1;
            else return 0;
        }
    }
}

int main() {
    char s[110];
    int cnt = 0;
    while(gets(s) != NULL) {
        str[cnt].id = cnt + 1;
        str[cnt].len = strlen(s);
        strcpy(str[cnt].s, s);
        ++cnt;
    }
    qsort(str, cnt, sizeof(str[0]), compare);
    int i;
    for(i = 0; i < cnt; ++i) {
        printf("%d:%d:%s\n", str[i].id, str[i].len, str[i].s);
    }
    return 0;
}

#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnewline-eof"
#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define LL long long
#define DD double
#define HASH 131
#define MAXN 10000

int read(void) {
    register int x = 0;
    register int f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f ? -x : x;
}

unsigned long long hash(const char *s) {
    unsigned long long h = 0;
    int len = strlen(s);
    for(int i = 0; i < len; ++i) {
        h = h * HASH + s[i] - ' ';
    }
    return h % MAXN;
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

typedef struct node {
    int num;
    char name[20];
    int num2;
    char time[10];
} dat;

dat stu[200], err[200];
short hasht[MAXN][200], top, top2[MAXN];
bool vis[MAXN], vis2[MAXN];

int cmp(const void *aa, const void *b) {
    return (((dat *)aa)->num - ((dat *)b)->num);
}

int main(void) {
    int n = read();
    for(int i = 0; i < n; ++i) {
        scanf("%d%s%d%s", &stu[i].num, stu[i].name, &stu[i].num2, stu[i].time);
        int res = hash(stu[i].name);
        if(vis[res]) {
            bool flag = false;
            for(int j = 0; j < top2[res]; ++j) {
                if(hasht[res][j] == stu[i].num2) {
                    flag = true;
                    break;
                }
            }
            if(!flag) {
                hasht[res][top2[res]++] = stu[i].num2;
                if(!vis2[res]) {
                    err[top++] = stu[i];
                    vis2[res] = true;
                }
            }
        } else {
            vis[res] = true;
            hasht[res][top2[res]++] = stu[i].num2;
        }
    }
    qsort(err, top, sizeof(err[0]), cmp);
    for(int i = 0; i < top; ++i) {
        printf("%d %s\n", err[i].num, err[i].name);
    }
    return 0;
}
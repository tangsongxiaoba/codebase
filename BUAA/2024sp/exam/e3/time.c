#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnewline-eof"
#include <ctype.h>
#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#define LL long long
#define DD double

int read(void) {
    register int x = 0;
    register int f = 0;
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

typedef struct Node {
    int num;
    int cnt;
    double time;
} dat;

dat stu[3][1000];
int top[3];

int cmp(const void *p1, const void *p2) {
    dat *a = (dat *)p1;
    dat *b = (dat *)p2;
    if(a->time - b->time > 0) return -1;
    if(a->time - b->time < 0) return 1;
    return 0;
}

int main(void) {
    // freopen("in", "r", stdin);
    int n = read();
    while(n--) {
        char ch;
        do {
            ch = getchar();
        } while(!isalpha(ch));
        int num = read();
        int sthh = read(), stmm = read(), stss = read();
        int edhh = read(), edmm = read(), edss = read();
        double res = 0;
        res = (edhh * 3600 + edmm * 60 + edss) - (sthh * 3600 + stmm * 60 + stss);
        res /= 3600.0;
        int type = (ch == 'B' ? 0 : (ch == 'M' ? 1 : 2)), i;
        for(i = 0; i < top[type]; ++i) {
            if(stu[type][i].num == num) {
                break;
            }
        }
        if(i == top[type]) {
            stu[type][top[type]].num = num;
            stu[type][top[type]].cnt = 1;
            stu[type][top[type]].time = res;
            ++top[type];
        } else {
            ++stu[type][i].cnt;
            stu[type][i].time += res;
        }
    }
    for(int i = 0; i < 3; ++i) {
        qsort(stu[i], top[i], sizeof(stu[i][0]), cmp);
        for(int j = 0; j < top[i]; ++j) {
            putchar(i == 0 ? 'B' : (i == 1 ? 'M' : 'D'));
            write(stu[i][j].num);
            putchar(' ');
            write(stu[i][j].cnt);
            putchar(' ');
            printf("%.2lf\n", stu[i][j].time);
        }
    }    
    return 0;
}
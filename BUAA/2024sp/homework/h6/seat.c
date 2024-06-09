#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double
#define __min(a,b) (((a) < (b)) ? (a) : (b))
#define __max(a,b) (((a) > (b)) ? (a) : (b))

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

typedef struct {
    int num, seat;
    char name[20];
}dat;

dat T1[100];

int cmp(const void *p1, const void *p2) {
    dat *a = (dat *)p1;
    dat *b = (dat *)p2;
    return (a->seat == b->seat) ? (a->num - b->num) : (a->seat - b->seat);
}

int cmp2(const void *p1, const void *p2) {
    dat *a = (dat *)p1;
    dat *b = (dat *)p2;
    return (a->num - b->num);
}

int main() {
    int N = read();
    freopen("in.txt", "r", stdin);
    bool vis[100] = {false};
    for(int i = 1; i <= N; ++i) {
        scanf("%d%s%d", &T1[i].num, T1[i].name, &T1[i].seat);
        vis[T1[i].seat] = true;
    }
    qsort(T1+1, N, sizeof(dat), cmp);
    int Q = __min(T1[N].seat, N), k = N;
    for(int i = 1; i <= Q; ++i) {
        if(vis[i] == false) {
            if(T1[k].seat < i) break;
            T1[k].seat = i;
            vis[i] = true;
            k--;
        }
    }
    int m = __max(T1[k].seat, T1[k+1].seat);
    for(int i = 1; i <= N; ++i) {
        if(vis[T1[i].seat]) vis[T1[i].seat] = false;
        else {
            T1[i].seat = ++m;
            vis[T1[i].seat] = false;
        }
    }
    qsort(T1+1, N, sizeof(dat), cmp2);
    freopen("out.txt", "w", stdout);
    for(int i = 1; i <= N; ++i) {
        printf("%d %s %d\n", T1[i].num, T1[i].name, T1[i].seat);
    }
    return 0;
}

#include <time.h>
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
    int type;
    int cnt;
    struct Node *fa;
    struct Node *son[32];
} dat, *node;

node st[2000], son[2000];

int n, top = 1, stop;

void bian(node p, int scnt) {
    // if(p == NULL) return;
    // printf("%d ", p->num);
    // for(int i = 0; i < 32; ++i) {
    //     bian(p->son[i]);
    // }
    if(p == NULL) return;
    if(p->cnt != scnt) {
        if(p->cnt == 0) {
            printf("%d ", p->num);
        } else {
            int ss = 0;
            for(int i = 0; i < 32; ++i) {
                if(p->son[i] == NULL) continue;
                if(p->son[i]->type == 0) {
                    ++ss;
                }
            }
            for(int i = 0; i < 32; ++i) {
                if(p->son[i] == NULL) continue;
                if(p->son[i]->type == 1) {
                    bian(p->son[i], scnt-ss);
                } else {
                    if(p->son[i]->cnt == 0) {
                        printf("%d ", p->son[i]->num);
                    }
                }
            }
        }
    }
}

void update(node p) {
    if(p == NULL) return;
    p->cnt += 1;
    update(p->fa);
}

int main(void) {
    // freopen("in", "r", stdin);
    n = read();
    int i, num = read(), type = read(), fa = read(), port = read();
    st[0] = (node)malloc(sizeof(dat));
    st[0]->num = num;
    st[0]->type = type;
    st[0]->cnt = 0;
    st[0]->fa = NULL;
    for(i = 0; i < 32; ++i) st[0]->son[i] = NULL;
    n--;
    while(n--) {
        num = read(), type = read(), fa = read(), port = read();
        node p = (node)malloc(sizeof(dat));
        p->type = type;
        p->num = num;
        p->cnt = 0;
        for(i = 0; i < 32; ++i) p->son[i] = NULL;
        for(i = 0; i < top; ++i) {
            if(st[i]->num == fa)
                break;
        }
        if(i == top) {
            st[i] = p;
            st[i]->fa = NULL;
            ++top;
        } else {
            st[i]->son[port - 1] = p;
            p->fa = st[i];
            st[top++] = p;
        }
        if(type == 0) {
            son[stop++] = p;
        }
    }
    do {
        n = read();
        for(i = 0; i < stop; ++i) {
            if(son[i]->num == n) break;
        }
        update(son[i]);
    } while(n != -1);
    bian(st[0], stop);
    return 0;
}
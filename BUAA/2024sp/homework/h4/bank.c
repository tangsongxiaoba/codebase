#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double

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

int pCnt[100], tot;

typedef struct {
    int type, inTime, startTime;
}cus;

cus waitLn[100];
int fr, re;
int window[10], wCnt;

int main() {
    // freopen("in", "r", stdin);
    int inTime = read();
    fr = 1, re = 0, wCnt = 3;
    for(int i = 1; i <= inTime; ++i) {
        pCnt[i] = read();
        tot += pCnt[i];
    }
    for(int T = 1; tot > 0; ++T) {
        if(T <= inTime) {
            for(int i = 1; i <= pCnt[T]; ++i) {
                waitLn[++re].type = read();
                waitLn[re].inTime = T;
            }
            while(7 * wCnt <= re - fr + 1) ++wCnt;
        }
        if(wCnt > 5) wCnt = 5;
        for(int i = 1; i <= wCnt; ++i) {
            if(window[i] == 0 && fr <= re) {
                window[i] = waitLn[fr].type;
                waitLn[fr].startTime = T;
                --tot; ++fr;
            }
            // printf("%d ", window[i]);
        }
        // puts("");
        // puts("");
        while(7 * wCnt > re - fr + 1) --wCnt;
        if(wCnt < 3) wCnt = 3;
        for(int i = 1; i <= 5; ++i)
            if(window[i] > 0)
                --window[i];
    }
    for(int i = 1; i <= re; ++i)
        printf("%d : %d\n", i, waitLn[i].startTime - waitLn[i].inTime);
    return 0;
}

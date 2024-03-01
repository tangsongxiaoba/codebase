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
    do {
        sta[top++] = x % 10, x /= 10;
    }while(x);
    while(top) putchar(sta[--top] + '0');
}

bool vis[100000], vis2[100000];
int pri[50000], cnt;
int pri2[100000], cnt2;
void init1(int n) {
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

void init2(int n) {
    int i, j, flag;
    for(i = 4; i <= n; ++i) {
        if(vis[i]) {
            flag = 0;
            for(j = 0; j < cnt; ++j) {
                if(1ll*pri[j]*pri[j] > i) break;
                else if(i % pri[j] == 0 && !vis[i / pri[j]]) {
                    ++flag;
                    if(flag > 1) break;
                }
            }
            if(flag == 1) pri2[cnt2++] = i, vis2[i] = true;
        }
    }
}

int main() {
    int n = read(), i;
    init1(n); init2(n);
    for(i = 2; i <= n-i; ++i) {
        if(!vis[i]) {
            if(!vis[n-i]) {
                printf("1+1: %d=%d+%d\n", n, i, n-i);
            }
            else if(vis2[n-i]) {
                printf("1+2: %d=%d+%d\n", n, i, n-i);
            }
        }
        else if(vis2[i]) {
            if(!vis[n-i]) {
                printf("2+1: %d=%d+%d\n", n, i, n-i);
            }
        }
    }
    return 0;
}

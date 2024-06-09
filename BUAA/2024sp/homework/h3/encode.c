#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double

char key[128];
bool vis[128];
char f[128];

int main() {
    fgets(key, 50, stdin);
    int i, j, len;
    for(i = 0, j = 0, len = strlen(key); i < len; ++i) {
        if(vis[key[i]] == false && isprint(key[i])) {
            key[j++] = key[i];
            vis[key[i]] = true;
        }
    }
    for(i = 32; i <= 126; ++i) {
        if(vis[i] == false) {
            key[j++] = i;
        }
        vis[i] = false;
    }
    key[j] = '\0';
    int cnt = 95;
    i = 0;
    while(cnt > 1) {
        int op = key[i];
        vis[key[i]] = true;
        for(j = i+1; ; ++j) {
            j %= 95;
            if(!vis[key[j]]) --op;
            if(op < 1) break;
        }
        f[key[i]] = key[j];
        i = j;
        --cnt;
    }
    f[key[i]] = key[0];
    freopen("in.txt", "r", stdin);
    freopen("in_crpyt.txt", "w", stdout);
    char c;
    while((c = getchar()) != EOF) {
        if(isprint(c)) {
            putchar(f[c]);
        }
        else putchar(c);
    }
    return 0;
}

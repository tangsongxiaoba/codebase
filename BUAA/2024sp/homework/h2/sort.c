#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double

typedef struct node {
    char name[30];
    char phon[20];
}gp;

gp inf[110]; 

int main() {
    //freopen("sort.in", "r", stdin);
    int tot, i, j;
    scanf("%d", &tot);
    for(i = 0; i < tot; ++i) {
        scanf("%s%s", inf[i].name, inf[i].phon);
    }
    gp tmp;
    for(i = 1; i < tot; ++i) {
        tmp = inf[i];
        for(j = i; j > 0 && strcmp(inf[j-1].name, tmp.name) > 0; --j) {
            inf[j] = inf[j-1];
        }
        inf[j] = tmp;
    }
    i = 0;
    while(i < tot) {
        printf("%s %s\n", inf[i].name, inf[i].phon);
        int ii = i+1, cnt = 0;
        while(strcmp(inf[i].name, inf[ii].name) == 0) {
            int flag = 0;
            for(int j = i; j < ii; ++j) {
                if(strcmp(inf[j].phon, inf[ii].phon) == 0) {
                    flag = 1;
                    break;
                }
            }
            if(flag == 0) printf("%s_%d %s\n", inf[ii].name, ++cnt, inf[ii].phon);
            ++ii;
        }
        i = ii;
    }
    return 0;
}

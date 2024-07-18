#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnewline-eof"
#include <ctype.h>
#include <math.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define LL long long
#define DD double
#define HASH 131

unsigned long long hash(const char *s) {
    unsigned long long h = 0;
    int len = strlen(s);
    for(int i = 0; i < len; ++i) {
        if(!isprint(s[i])) continue;
        h = h * HASH + s[i] - ' ';
    }
    return h;
}

typedef struct node {
    char name[200];
} site;

typedef struct Node {
    unsigned LL hashValue;
    char name[200];
    int cnt;
} dat;

dat web[200];
int wtop;

site back[200], front[200], vis[200];
int btop, ftop, vtop;

char st[200] = "https://www.baidu.com/";

void count(void) {
    char wname[200];
    for(int k = 0; k < vtop; ++k) {
        int len = strlen(vis[k].name), i;
        for(i = 8; i < len; ++i) {
            if(vis[k].name[i] == '/') break;
        }
        strncpy(wname, vis[k].name + 8, i - 8);
        wname[i-8] = '\0';
        unsigned LL hashValue = hash(wname);
        for(i = 0; i < wtop; ++i) {
            if(hashValue == web[i].hashValue) {
                break;
            }
        }
        if(i == wtop) {
            web[wtop].cnt = 1;
            web[wtop].hashValue = hashValue;
            strcpy(web[wtop].name, wname);
            ++wtop;
        } else {
            ++web[i].cnt;
        }
    }
}

int main(void) {
    // freopen("in", "r", stdin);
    strcpy(vis[0].name, st);
    ++vtop;
    char op[10], name[200];
    int num;
    while(true) {
        bool flag = false;
        scanf("%s", op);
        switch(op[0]) {
        case 'V':
            scanf("%s", name);
            strcpy(back[btop].name, vis[vtop - 1].name);
            strcpy(vis[vtop].name, name);
            ++btop;
            ++vtop;
            ftop = 0;
            break;
        case '<':
            if(btop != 0) {
                strcpy(front[ftop].name, vis[vtop - 1].name);
                ++ftop;
                strcpy(vis[vtop].name, back[btop - 1].name);
                ++vtop;
                --btop;
            }
            break;
        case '>':
            if(ftop != 0) {
                strcpy(back[btop].name, vis[vtop - 1].name);
                ++btop;
                strcpy(vis[vtop].name, front[ftop -1 ].name);
                ++vtop;
                --ftop;
            }
            break;
        case 'Q':
            scanf("%d", &num);
            for(int i = 0; i < vtop; ++i) {
                puts(vis[i].name);
            }
            if(num == 0) {
                count();
                int maxi = 0, max = web[0].cnt;
                for(int i = 0; i < wtop; ++i) {
                    if(web[i].cnt > max) {
                        maxi = i;
                        max = web[i].cnt;
                    }
                    // printf("%s %d\n", web[i].name, web[i].cnt);
                }
                printf("%s %d", web[maxi].name, max);
            }
            flag = true;
            break;
        default:
            break;
        }
        if(flag) break;
    }
    return 0;
}
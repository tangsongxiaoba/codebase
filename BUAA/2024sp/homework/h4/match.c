#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double

typedef struct {
    char c;
    int l;
}node;

node bracket[233];
node st[233];
int len, p;

void throwError(node x) {
    printf("without maching \'%c\' at line %d", x.c, x.l);
    exit(0);
}

int main() {
    freopen("example.c", "r", stdin);
    char c, pre = '\0';
    int line = 1, flag = 0;
    while((c = getchar()) != EOF) {
        if(c == '\n') ++line;
        else {
            if(flag == 0) {
                if(c == '(' || c == ')' || c == '{' || c == '}') {
                    bracket[len].c = c;
                    bracket[len].l = line;
                    ++len;
                }
                else if(c == '\'') flag = 1;
                else if(c == '\"') flag = 2;
                else if(pre == '/' && c == '*') flag = 3;
                else if(pre == '/' && c == '/') {
                    while((c = getchar()) != '\n');
                    ++line;
                }
            }
            else {
                if(c == '\'' && flag == 1) flag = 0;
                else if(c == '\"' && flag == 2) flag = 0;
                else if(pre == '*' && c == '/' && flag == 3) flag = 0;
            }
        }
        pre = c;
    }
    for(int i = 0; i < len; ++i) {
        if(bracket[i].c == '(') {
            st[p++] = bracket[i];
        }
        else if(bracket[i].c == '{') {
            if(p > 0 && st[p-1].c == '(')
                throwError(st[p-1]);
            st[p++] = bracket[i];
        }
        else if(bracket[i].c == ')') {
            if(p == 0 || st[p-1].c != '(')
                throwError(bracket[i]);
            --p;
        }
        else {
            if(p == 0 || st[p-1].c != '{')
                throwError(bracket[i]);
            --p;
        }
    }
    if(p != 0) {
        throwError(st[p-1]);
    }
    for(int i = 0; i < len; ++i) {
        putchar(bracket[i].c);
    }
    return 0;
}

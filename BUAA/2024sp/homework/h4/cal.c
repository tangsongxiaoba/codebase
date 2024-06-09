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

int p, pp;
char op[2333];
double st[5333];

bool isOp(char c) {
    return c == '+' || c == '-' || c == '*' || c == '/';
}

int prio(char c) {
    if(c == '+' || c == '-') return 1;
    if(c == '*' || c == '/') return 2;
    return 0;
}

void calc() {
    double r = st[p-1];
    --p;
    double l = st[p-1];
    --p;
    // printf("%.2f %c %.2f = ", l, op[pp-1], r);
    switch (op[pp-1]) {
        case '+':
            st[p++] = l+r;
            break;
        case '-':
            st[p++] = l-r;
            break;
        case '*':
            st[p++] = l*r;
            break;
        case '/':
            st[p++] = l/r;
            break;
        default:
            break;
    }
    // printf("%.2f\n", st[p-1]);
}

int main() {
    char c;
    while((c = getchar()) != '=') {
        To:
        if(c == ' ') continue;
        if(c == '(') {
            op[pp++] = c;
        }
        else if(c == ')') {
            while(pp > 0 && op[pp-1] != '(') {
                calc();
                --pp;
            }
            if(pp > 0) --pp;
        }
        else if(isOp(c)) {
            while(pp > 0 && prio(op[pp-1]) >= prio(c)) {
                calc();
                --pp;
            }
            op[pp++] = c;
        }
        else {
            int num = 0;
            do {
                num = num * 10 + c - '0';
                c = getchar();
            }while(isdigit(c));
            st[p++] = num;
            goto To;
        }
    }
    while(pp > 0) {
        calc();
        --pp;
    }
    printf("%.2f", st[p-1]);
    return 0;
}

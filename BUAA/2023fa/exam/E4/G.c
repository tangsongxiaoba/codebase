#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int vis[3010];
int stk[3010];

int main() {
    int a, b, r, top, i;
    a = read(), b = read();
    top = 0;
    do{
        r = a % b;
        stk[top++] = a/b;
        a = r * 10;
        if(vis[r]) break;
        vis[r] = top;
    }while(r != 0);
    for(i = 0; i < top; ++i) {
        if(i == vis[r] && vis[r] != top) putchar('(');
        printf("%d", stk[i]);
        if(i == 0) putchar('.');
    }
    if(vis[r] == top) printf("(0)");
    else putchar(')');
    return 0;
}

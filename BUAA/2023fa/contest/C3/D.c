#include<stdio.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

int opt[] = {7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2};
int res[] = {1, 0, -1, 9, 8, 7, 6, 5, 4, 3, 2};

int main() {
    int n, chk, i, ret;
    char s[20];
    n = read();
    while(n--) {
        chk = 0;
        scanf("%s", s);
        for(i = 0; i < 17; ++i) {
            chk += (s[i]-'0') * opt[i];
        }
        ret = chk % 11;
        if(ret == 2) {
            if(s[17] == 'X') puts("YES");
            else puts("NO");
        }
        else {
            if(s[17]-'0' == res[ret]) puts("YES");
            else puts("NO");
        }
    }
    return 0;
}

#include<stdio.h>
#include<string.h>
#include<math.h>

int read() {
    register int x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= c == '-', c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f?-x:x;
}

char s[97], ans[97];

int main() {
    int T, M, N, i, t, len, rem;
    long long num, base;
    T = read();
    while(T--) {
        M = read(), N = read();
        scanf("%s", s);
        len = strlen(s);
        for(num = 0, base = 1, i = len-1; i >= 0; --i) {
            if(s[i] >= 'A') t = s[i] - 'A' + 10;
            else t = s[i] - '0';
            num += 1LL * t * base;
            base *= M;
        }
        if(num == 0) {
            puts("0");
            continue;
        }
        len = 0;
        while(num != 0) {
            rem = num % N;
            num /= N;
            if(rem < 0) {
                rem -= N;
                ++num;
            }
            if(rem >= 10) rem += 'A' - 10;
            else rem += '0';
            ans[++len] = rem;
        }
        for(i = len; i >= 1; --i) {
            printf("%c", ans[i]);
        }
        puts("");
    }
    return 0;
}

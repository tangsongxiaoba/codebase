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
    return f ? -x : x;
}

void write(int x) {
    static int sta[35];
    int top = 0;
    if(x < 0) putchar('-'), x = -x;
    do {
        sta[top++] = x % 10, x /= 10;
    } while(x);
    while(top) putchar(sta[--top] + '0');
}

char str1[10000010], str2[10100], str3[10100];

int main() {
    gets(str1);
    int m, n;
    while(gets(str2) != NULL) {
        switch(str2[0] - '0') {
            case 1:
                strcat(str1, str2 + 2);
                break;
            case 2:
                sscanf(str2 + 2, "%d", &m);
                str1[m] = '\0';
                break;
            case 3:
                sscanf(str2 + 2, "%d%s", &m, str3);
                strcpy(str2, str1 + m + 1);
                str1[m + 1] = '\0';
                strcat(str1, str3);
                strcat(str1, str2);
                break;
            case 4:
                sscanf(str2 + 2, "%d%d", &m, &n);
                strcpy(str2, str1 + n + 1);
                str1[m] = '\0';
                strcat(str1, str2);
                break;
            case 5:
                sscanf(str2 + 2, "%d%d%s", &m, &n, str3);
                strcpy(str2, str1 + n + 1);
                str1[m] = '\0';
                strcat(str1, str3);
                strcat(str1, str2);
                break;
            case 6:
                strcpy(str3, str2 + 2);
                char* p1 = strstr(str1, str3);
                if(p1 == NULL) puts("NULL");
                else {
                    printf("%lld ", p1 - str1);
                    char *p2;
                    while((p2 = strstr(p1 + 1, str3)) != NULL) {
                        p1 = p2;
                    }
                    printf("%lld\n", p1 - str1);
                }
                break;
            default:
                break;
        }
    }
    puts(str1);
    return 0;
}

#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double
#define UL unsigned long long
#define UU unsigned int
#define SWAP(a, b) (((a) ^ (b)) && ((b) ^= (a) ^= (b), (a) ^= (b)))

#define IO_TYPE unsigned long long
IO_TYPE read() {
    register IO_TYPE x = 0, f = 0;
    register char c = getchar();
    while(c < '0' || c > '9') f |= (c == '-'), c = getchar();
    while(c >= '0' && c <= '9') x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f ? -x : x;
}
void write(IO_TYPE x) {
    static short sta[100];
    short top = 0;
    if(x < 0) putchar('-'), x = -x;
    do {
        sta[top++] = x % 10, x /= 10;
    } while(x);
    while(top) putchar(sta[--top] + '0');
}
#undef IO_TYPE

const char tt[3][10] = {"u", "ll", "ull"};

int main() {
    char s[100];
    while(gets(s) != NULL) {
        int i, len = strlen(s);
        for(i = 0; i < len; ++i) {
            if(s[i] >= 'A' && s[i] <= 'Z') s[i] = s[i] - 'A' + 'a';
        }
        if(s[0] == '0') {
            if(s[1] == 'x') {
                for(i = 2; i < len; ++i) {
                    if(s[i] > 'f') break;
                }
                UL t = 0;
                int type = 3, j = i;
                for(i = 2; i < j; ++i) {
                    t *= 16;
                    if(isdigit(s[i])) t += s[i] - '0';
                    else t += s[i] - 'a' + 10;
                }
                for(i = 0; i < 3; ++i) {
                    if(strcmp(tt[i], s + j) == 0) {
                        type = i;
                        break;
                    }
                }
                if(type == 3 || type == 0) {
                    if(type == 0) {
                        printf("unsigned ");
                    }
                    if(t <= 2147483647ull) {
                        printf("int ");
                    } else if(t <= 4294967295ull) {
                        if(type != 0) printf("unsigned int ");
                        else printf("int ");
                    } else if(t <= 9223372036854775807ull) {
                        printf("long long ");
                    } else {
                        if(type != 0) printf("unsigned long long ");
                        else printf("long long ");
                    }
                } else {
                    if(type == 1) {
                        if(t <= 9223372036854775807ull) printf("long long ");
                        else printf("unsigned long long ");
                    } else printf("unsigned long long ");
                }
                write(t);
            } else {
                for(i = 1; i < len; ++i) {
                    if(isalpha(s[i])) break;
                }
                UL t = 0;
                int type = 3, j = i;
                for(i = 1; i < j; ++i) {
                    t *= 8;
                    t += s[i] - '0';
                }
                for(i = 0; i < 3; ++i) {
                    if(strcmp(tt[i], s + j) == 0) {
                        type = i;
                        break;
                    }
                }
                if(type == 3 || type == 0) {
                    if(type == 0) {
                        printf("unsigned ");
                    }
                    if(t <= 2147483647ull) {
                        printf("int ");
                    } else if(t <= 4294967295ull) {
                        if(type != 0) printf("unsigned int ");
                        else printf("int ");
                    } else if(t <= 9223372036854775807ull) {
                        printf("long long ");
                    } else {
                        if(type != 0) printf("unsigned long long ");
                        else printf("long long ");
                    }
                } else {
                    if(type == 1) {
                        if(t <= 9223372036854775807ull) printf("long long ");
                        else printf("unsigned long long ");
                    } else printf("unsigned long long ");
                }
                write(t);
            }
        } else {
            UL t = 0;
            int type = 3;
            for(i = 0; i < len; ++i) {
                if(isalpha(s[i])) break;
            }
            int j = i;
            for(i = 0; i < j; ++i) {
                t *= 10;
                t += s[i] - '0';
            }
            for(i = 0; i < 3; ++i) {
                if(strcmp(tt[i], s + j) == 0) {
                    type = i;
                    break;
                }
            }
            if(type == 3 || type == 0) {
                if(type == 0) {
                    printf("unsigned ");
                    if(t <= 2147483647ull) {
                        printf("int ");
                    } else if(t <= 4294967295ull) {
                        if(type != 0) printf("unsigned int ");
                        else printf("int ");
                    } else if(t <= 9223372036854775807ull) {
                        printf("long long ");
                    } else {
                        if(type != 0) printf("unsigned long long ");
                        else printf("long long ");
                    }
                }
                else {
                    if(t <= 2147483647ull) {
                        printf("int ");
                    } else printf("long long ");
                }
            } else {
                if(type == 1) {
                    printf("long long ");
                } else printf("unsigned long long ");
            }
            write(t);
        }
        puts("");
    }
    return 0;
}

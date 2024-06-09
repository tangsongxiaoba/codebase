#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double

int read()
{
    register int x = 0, f = 0;
    register char c = getchar();
    while (c < '0' || c > '9')
        f |= c == '-', c = getchar();
    while (c >= '0' && c <= '9')
        x = (x << 3) + (x << 1) + (c ^ 48), c = getchar();
    return f ? -x : x;
}

typedef struct
{
    int opt, pos;
    char text[133];
} dat;

dat st[100];
int p;

char src[533];

void insert(char str1[], char str2[], int i)
{
    static char str3[133];
    strcpy(str3, str1 + i + 1);
    str1[i + 1] = '\0';
    strcat(str1, str2);
    strcat(str1, str3);
}

void delete_part(char str1[], int i, int j)
{
    static char str2[133];
    strcpy(str2, str1 + j + 1);
    str1[i] = '\0';
    strcat(str1, str2);
}

int main()
{
    gets(src);
    int cnt = read();
    for (int i = 0; i < cnt; ++i)
    {
        st[p].opt = read();
        st[p].pos = read();
        scanf("%s", st[p].text);
        ++p;
    }
    while ((cnt = read()) != -1)
    {
        switch (cnt)
        {
        case 1:
            st[p].opt = 1;
            st[p].pos = read();
            scanf("%s", st[p].text);
            insert(src, st[p].text, st[p].pos - 1);
            ++p;
            break;
        case 2:
            st[p].opt = 2;
            st[p].pos = read();
            int len = read(), len0 = strlen(src);
            strncpy(st[p].text, &src[st[p].pos], len);
            delete_part(src, st[p].pos, st[p].pos + len - 1 > len0 - 1 ? len0 - 1 : st[p].pos + len - 1);
            ++p;
            break;
        case 3:
            if (p == 0)
                break;
            --p;
            if (st[p].opt == 1)
            {
                delete_part(src, st[p].pos, st[p].pos + strlen(st[p].text) - 1);
            }
            else
            {
                insert(src, st[p].text, st[p].pos - 1);
            }
            break;
        }
    }
    puts(src);
    return 0;
}

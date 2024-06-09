#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double
#define MAXL 200

void clr(int num[])
{
    int i;
    for (i = 0; i < MAXL; ++i)
    {
        num[i] = 0;
    }
}

void read(int num[])
{
    static char s[MAXL + 1];
    gets(s);
    int i;
    for (i = strlen(s) - 1; !isdigit(s[i]); --i)
        ;
    s[i + 1] = '\0';
    clr(num);
    int len = strlen(s);
    for (i = 0; i < len; ++i)
    {
        num[len - i - 1] = s[i] - '0';
    }
}

void write(int num[])
{
    int i;
    for (i = MAXL - 1; i >= 1; --i)
    {
        if (num[i] != 0)
            break;
    }
    for (; i >= 0; --i)
    {
        putchar(num[i] + '0');
    }
    putchar('\n');
}

void sub(int a[], int b[], int c[])
{
    clr(c);
    for (int i = 0; i < MAXL - 1; ++i)
    {
        c[i] += a[i] - b[i];
        if (c[i] < 0)
        {
            c[i + 1] -= 1;
            c[i] += 10;
        }
    }
}

int compare(int a[], int b[])
{
    int i, j;
    for (i = MAXL - 1; i >= 0; --i)
    {
        if (a[i] != 0)
            break;
    }
    for (j = MAXL - 1; j >= 0; --j)
    {
        if (b[j] != 0)
            break;
    }
    if (j > i)
    {
        return -1;
    }
    else if (i > j)
    {
        return 1;
    }
    else
    {
        for (; i >= 0; --i)
        {
            if (a[i] > b[i])
            {
                return 1;
            }
            else if (a[i] < b[i])
            {
                return -1;
            }
        }
        return 0;
    }
}

int a[200], b[200], c[200];

int main()
{
    read(a);
    read(b);
    if (compare(a, b) == 1)
    {
        sub(a, b, c);
    }
    else if (compare(a, b) == -1)
    {
        sub(b, a, c);
        putchar('-');
    }
    else
    {
        putchar('0');
        return 0;
    }
    write(c);
    return 0;
}

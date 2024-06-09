#include <stdio.h>
int main()
{
    char str[1005];
    char s[1005];
    char format[105];
    char format_p[105];
    int k, x;
    
    gets(str);
    gets(format);
    scanf("%d %d", &k, &x);
    sscanf(str, format, s);
    sprintf(format_p, "%%%d.%ds", k, x);
    printf(format_p, s);
    return 0;
}

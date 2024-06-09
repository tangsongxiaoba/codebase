//UVA1584 环状序列 Circular Sequence
#include<cstdio>
#include<cstring>

const int MAXN = 105;
int T;
char s[MAXN];

inline int less(const char* s, const int& p, const int& q) {
    register int n = strlen(s);
    for(register int i = 0; i < n; ++i)
        if(s[(p+i)%n] != s[(q+i)%n])
            return s[(p+i)%n] < s[(q+i)%n];
    return 0;
}

int main() {
    scanf("%d", &T);
    while(T--) {
        scanf("%s", s);
        register int ans = 0, n = strlen(s);
        for(register int i = 1; i < n; ++i) 
            if(less(s, i, ans)) ans = i;
        for(register int i = 0; i < n; ++i)
            putchar(s[(i+ans)%n]);
        putchar('\n');
    }
    return 0;
}
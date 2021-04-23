//Luogu P1241 括号序列
#include<cstdio>
#include<cstring>

int s[101], top;
char c[101], b[101];

int main() {
    scanf("%s", c);
    register int l = strlen(c);
    for(register int i = 0; i < l; ++i) {
        if(c[i] == '(') {
            s[++top] = i;
            b[i] = ')';
        }
        if(c[i] == '[') {
            s[++top] = i;
            b[i] = ']';
        }
        if(c[i] == ')' || c[i] == ']') {
            if(!top || b[s[top]] != c[i]) {
                if(c[i] == ')') b[i] = '(';
                else b[i] = '[';                
            }
            else b[s[top--]] = ' ';
        }
    }
    for(register int i = 0; i < l; ++i) {
        if(b[i] == '(' || b[i] == '[') printf("%c", b[i]);
        printf("%c", c[i]);
        if(b[i] == ')' || b[i] == ']') printf("%c", b[i]);
    }
    return 0;
}
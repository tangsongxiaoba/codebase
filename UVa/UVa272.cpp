//UVA272 TeX中的引号 TEX Quotes
#include<cstdio>

int c, q = 1;

int main() {
    while((c = getchar()) != EOF) {
        if(c == '"') {
            printf("%s", q ? "``" : "''");
            q = !q;
        }
        else printf("%c", c);
    }
}
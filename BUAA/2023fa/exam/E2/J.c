#include<stdio.h>
#include<math.h>

int main() {
    int n, m, a, b, i, j;
    int l1, r1;
    scanf("%d", &n);
    while(n--) {
        scanf("%d%d%d", &m, &a, &b);
        if(25LL*a + 24LL*b <= 20LL*m || 25LL*a + 24LL*b >= 69LL*m) {
            puts("No");
            continue;
        }
        l1 = floor((a-m)/4.0)*5, r1 = ceil(a/4.0)*5;
        if(l1 < 0) l1 = 0;
        if(r1 > m) r1 = m;
        for(i = l1; i <= r1; ++i) {
            for(j = l1/5; j <= (r1/5 > i ? i : r1/5); ++j) {
                if(j * 3 + i == a) {
                    
                }
            }
        }
    }
    return 0;
}
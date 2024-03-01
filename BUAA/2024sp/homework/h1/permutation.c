// full permutation
#include <stdio.h>

int a[10000];
int vis[10000];
int n;

void dfs(int x)
{
    if (x == n + 1)
    {
        for (int i = 1; i <= n; ++i)
            printf("%d ", a[i]);
        printf("\n");
        return;
    }
    for (int i = 1; i <= n; ++i)
    {
        if (!vis[i])
        {
            a[x] = i;
            vis[i] = 1;
            dfs(x + 1);
            vis[i] = 0;
        }
    }
}

int main()
{
    freopen("per.out", "w", stdout);
    scanf("%d", &n);
    dfs(1);
    return 0;
}
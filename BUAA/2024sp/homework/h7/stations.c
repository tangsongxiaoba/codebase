#include <math.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#define LL long long
#define DD double

int graph[512][512];

bool isTrans[512];
char namelist[512][20];
int tot;

int find_(char *s) {
    int i;
    for(i = 0; i < tot; ++i) {
        if(strcmp(namelist[i], s) == 0) {
            break;
        }
    }
    return i;
}

int addname(char *s) {
    int t = find_(s);
    strcpy(namelist[t], s);
    if(t == tot) ++tot;
    return t;
}

int main() {
    FILE *fp = fopen("bgstations.txt", "r");
    int n;
    fscanf(fp, "%d", &n);
    while(n--) {
        int id, nn;
        fscanf(fp, "%d%d", &id, &nn);
        char name[20];
        int op;
        fscanf(fp, "%s%d", name, &op);
        int u = addname(name);
        if(op) isTrans[u] = true;
        --nn;
        while(nn--) {
            fscanf(fp, "%s%d", name, &op);
            int t = addname(name);
            if(op) isTrans[u] = true;
            graph[u][t] = graph[t][u] = id;
            u = t;
        }
    }
    fclose(fp);
    // freopen("in", "r", stdin);
    char S[20], T[20];
    scanf("%s%s", S, T);
    int st = find_(S), ed = find_(T);
    int dis[512];
    int pre[512] = {0};
    bool vis[512] = {false};
    memset(dis, 0x3f3f3f3f, sizeof(dis));
    dis[st] = 0; pre[st] = st;
    for(int i = 0; i < tot; ++i) {
        int u = st, mn = 0x3f3f3f3f;
        for(int j = 0; j < tot; ++j) {
            if(!vis[j] && dis[j] < mn) {
                u = j;
                mn = dis[j];
            }
        }
        vis[u] = true;
        for(int j = 0; j < tot; ++j) {
            if(!vis[j] && graph[u][j] != 0 && dis[u] + 1 < dis[j]) {
                dis[j] = dis[u] + 1;
                pre[j] = u;
            }
        }
    }
    int way[512], pos = 0;
    for(int i = ed; i != st; i = pre[i]) {
        way[pos++] = i;
    }
    printf("%s", S);
    for(int i = pos-1, u = st; i >= 0;) {
        int id = graph[u][way[i]], cnt = 0;
        while(id == graph[u][way[i]] && i >= 0) {
            u = way[i];
            --i;
            ++cnt;
        }
        printf("-%d(%d)-%s", id, cnt, namelist[u]);
    }
    return 0;
}


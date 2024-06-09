#include<stdio.h>

short ma[29][29][29][29];

int main() {
    int n, i;
    scanf("%d", &n);
    char word[5];
    while(n--) {
        scanf("%s", word);
        if(ma[word[0]-'a'][word[1]-'a'][word[2]-'a'][word[3]-'a'] == 0) {
            puts("Moca memorized a new word!");
            ma[word[0]-'a'][word[1]-'a'][word[2]-'a'][word[3]-'a'] = 1;
        }
        else {
            puts("Moca has already memorized this word!");
        }
    }
    return 0;
}
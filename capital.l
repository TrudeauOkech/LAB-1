/*** Definition Section ***/
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_HASHTAG_LEN 100
#define MAX_MENTION_LEN 50

int hashtagCount = 0;
int mentionCount = 0;

char hashtags[MAX_HASHTAG_LEN][MAX_HASHTAG_LEN];
char mentions[MAX_MENTION_LEN][MAX_MENTION_LEN];
%}

/*** Rule Section ***/
%%
"#"[a-zA-Z0-9_]+ {
    char token[MAX_HASHTAG_LEN];
    strncpy(token, yytext + 1, yyleng - 1); // Remove the '#' character
    token[yyleng - 1] = '\0';

    // Check for duplicate hashtags
    int isDuplicate = 0;
    for (int i = 0; i < hashtagCount; i++) {
        if (strcmp(token, hashtags[i]) == 0) {
            isDuplicate = 1;
            break;
        }
    }

    if (!isDuplicate) {
        printf("Hashtag: #%s\n", token);
        strncpy(hashtags[hashtagCount], token, MAX_HASHTAG_LEN);
        hashtagCount++;
    }
}

"@"[a-zA-Z0-9_]+ {
    char token[MAX_MENTION_LEN];
    strncpy(token, yytext + 1, yyleng - 1); // Remove the '@' character
    token[yyleng - 1] = '\0';

    // Check for duplicate mentions
    int isDuplicate = 0;
    for (int i = 0; i < mentionCount; i++) {
        if (strcmp(token, mentions[i]) == 0) {
            isDuplicate = 1;
            break;
        }
    }

    if (!isDuplicate) {
        printf("Mention: @%s\n", token);
        strncpy(mentions[mentionCount], token, MAX_MENTION_LEN);
        mentionCount++;
    }
}

. { /* Ignore other characters */ }
\n { /* Ignore newlines */ }
%%

/*** Code Section ***/
int yywrap() {}

int main() {
    // Uncomment the lines below to take input from a file
    /*
    FILE *fp;
    char filename[50];
    printf("Enter the filename: \n");
    scanf("%s", filename);
    fp = fopen(filename, "r");
    yyin = fp;
    */

    yylex();

    printf("\nUnique Hashtags Detected: %d\n", hashtagCount);
    printf("Unique Mentions Detected: %d\n", mentionCount);

    return 0;
}

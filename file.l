%{
#include <stdio.h>
%}

%%
[a-zA-Z]+ {
    printf("%s\n", yytext); // Print the matched word
}
[^a-zA-Z\n]+ {
    // Ignore characters that are not part of words or newlines
}
\n {
    // Print a newline for empty lines
    if (yylineno > 1) {
        printf("\n");
    }
}
%%

int main() {
    yylex();
    return 0;
}

%{
#include <stdio.h>
%}

%%
\d+(?= dollars) {
    printf("Rule: Matched number preceding ' dollars': %s\n", yytext);
}
%%

int yywrap() {
    return 1;
}

int main() {
    printf("Enter a string: ");
    yylex();  
    return 0;
}

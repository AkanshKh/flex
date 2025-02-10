%{
#include <stdio.h>
%}

/* Optional definitions section:
   You can define macros for repeated patterns.
   For example, a macro for an identifier pattern.
*/
IDENT    [a-zA-Z_][a-zA-Z0-9_]*

%%
/* --- Literal Strings and Alternation --- */
"if"|"else"|"for"|"while" {
    printf("Matched keyword: %s\n", yytext);
}

/* --- Using a macro for identifiers --- */
{IDENT} {
    printf("Matched identifier: %s\n", yytext);
}

/* --- Number formats --- */
/* Match an integer or a float. Notice the use of grouping and the optional fractional part. */
[0-9]+(\.[0-9]+)? {
    printf("Matched number: %s\n", yytext);
}

/* --- POSIX character classes --- */
[[:space:]]+   { /* Skip whitespace */ }

/* --- Character classes and negation --- */
/* Match any character that is not a letter or digit */
[^a-zA-Z0-9\n] {
    printf("Matched a special character: %s\n", yytext);
}

/* --- Wildcard example --- */
/* The dot here matches any character (except newline) */
. {
    printf("Matched any character: %s\n", yytext);
}
%%
int main(void)
{
    yylex();
    return 0;
}

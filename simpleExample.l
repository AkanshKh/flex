%{
/* --- Definition Section --- */
/* Include the standard I/O header so we can use printf() */
#include <stdio.h>
%}

/* --- Rules Section --- */
%%
"if"                      { printf("Found keyword 'if'\n"); }
"else"                    { printf("Found keyword 'else'\n"); }
/* Recognize an integer number: one or more digits */
[0-9]+                    { printf("Found a number: %s\n", yytext); }
/* Recognize an identifier: a letter or underscore followed by letters, digits, or underscores */
[a-zA-Z_][a-zA-Z0-9_]*     { printf("Found an identifier: %s\n", yytext); }
/* Ignore newline characters (you could count lines here if desired) */
\n                        { /* do nothing */ }
/* Catch any single character (this rule should go last, as it’s a catch-all) */
.                         { /* Unrecognized character, ignore or handle error */ }
%%

/* --- User Code Section --- */
int main(void)
{
    /* yylex() is the Flex-generated scanning function.
       It reads the input (from stdin by default) and applies the rules above. */
    yylex();
    return 0;
}

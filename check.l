"hello"   { printf("Matched the literal string 'hello'\n"); }
[abc]     { printf("Matched one of 'a', 'b', or 'c': %s\n", yytext); }
[a-z]     { printf("Matched a lowercase letter: %s\n", yytext); }
[0-9]     { printf("Matched a digit: %s\n", yytext); }
[^0-9]   { printf("Matched a non-digit character: %s\n", yytext); }
[[:alpha:]]   { printf("Matched an alphabetic character: %s\n", yytext); }
[[:digit:]]   { printf("Matched a digit: %s\n", yytext); }
[[:space:]]   { /* Usually used to skip whitespace */ }
[0-9]*   { printf("Matched zero or more digits: %s\n", yytext); }
[0-9]+  { printf("Matched one or more digits: %s\n", yytext); }
"a"?"b" { printf("Matched 'b' optionally preceded by 'a': %s\n", yytext); }
[0-9]+(\.[0-9]+)?  { printf("Matched a number (integer or float): %s\n", yytext); }
("if"|"else"|"while")  { printf("Matched a keyword: %s\n", yytext); }
.   { printf("Matched any single character: %s\n", yytext); }
"\n"   { printf("Matched a newline character.\n"); }
"\\."  { printf("Matched a literal dot.\n"); }

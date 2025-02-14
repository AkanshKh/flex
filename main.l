%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define KEYWORD 1
#define IDENTIFIER 2
#define INTEGER_CONSTANT 3
#define CHARACTER_CONSTANT 4
#define STRING_LITERAL 5
#define PUNCTUATOR 6
#define SINGLE_LINE_COMMENT 7
#define MULTIPLE_LINE_COMMENT 8

#define MAX_ENTRIES 1000
typedef struct {
    char Category[50];
    char name[100];
} entry;

entry SymbolLiteralTable[MAX_ENTRIES];

int size = 0;

void insert(char* Category, char* name){
    for(int i = 0; i < size; i ++){
        if(strcmp(SymbolLiteralTable[i].Category, Category) == 0 && strcmp(SymbolLiteralTable[i].name, name) == 0) return;
    }
    strcpy(SymbolLiteralTable[size].Category, Category);
    strcpy(SymbolLiteralTable[size].name, name);
    size++;
}
%}

KEYWORD                 "int"|"char"|"else"|"for"|"if"|"return"|"void"
IDENTIFIER              [_a-zA-Z][_a-zA-Z0-9]*
INTEGER_CONSTANT        ([+-]?)[0-9]+
CHARACTER_CONSTANT      '([^\\'\n]|\\.)+'
ESCAPE_SEQUENCE         \\a|\\b|\\f|\\n|\\t|\\r|\\v|\\\'|\\\"|\\\\|\\\?
STRING_LITERAL          \"([^\\\"\n"]|{ESCAPE_SEQUENCE})*\"
PUNCTUATOR              "["|"]"|"("|")"|"{"|"}"|"->"|"&"|"*"|"+"|"-"|"/"|"%"|"!"|"?"|"<"|">"|"<="|">="|"=="|"!="|"&&"|"||"|"="|":"|";"|","
WS                      [ \t\n]
SINGLE_LINE_COMMENT     [/][/].*
MULTIPLE_LINE_COMMENT   [/][*]{NO_MATCH}*[*][/]
NO_MATCH		        [^*]|[*][^*/]

%%
{KEYWORD}               return KEYWORD;
{IDENTIFIER}            return IDENTIFIER;
{INTEGER_CONSTANT}      return INTEGER_CONSTANT;
{CHARACTER_CONSTANT}    return CHARACTER_CONSTANT;
{STRING_LITERAL}        return STRING_LITERAL;
{PUNCTUATOR}            return PUNCTUATOR;
{SINGLE_LINE_COMMENT}   return SINGLE_LINE_COMMENT;
{MULTIPLE_LINE_COMMENT} return MULTIPLE_LINE_COMMENT;
{WS}                    ;
%%

int yywrap(){
    return 1;
}

int main() {
    FILE *file = fopen("input.txt", "r");
    if(!file){
        printf("Error opening file\n");
        return 1;
    }
    FILE *output = fopen("output.txt", "w");
    if(!output){
        printf("Error opening file\n");
        return 1;
    }

    yyin = file;
    int token;
    while(token = yylex()){
        switch(token){
            case KEYWORD:{
                fprintf(output, "<KEYWORD, %s>\n", yytext);
                break;
            }
            case IDENTIFIER:{
                insert("Symbol", yytext);
                fprintf(output, "<IDENTIFIER, %s>\n", yytext);
                break;
            }
            case INTEGER_CONSTANT:{
                insert("Literal", yytext);
                fprintf(output, "<INTEGER_CONSTANT, %s>\n", yytext);
                break;
            }
            case CHARACTER_CONSTANT:{
                insert("Literal", yytext);
                fprintf(output, "<CHARACTER_CONSTANT, %s>\n", yytext);
                break;
            }
            case STRING_LITERAL:{
                insert("Literal", yytext);
                fprintf(output, "<STRING_LITERAL, %s>\n", yytext);
                break;
            }
            case PUNCTUATOR:{
                fprintf(output, "<PUNCTUATOR, %s>\n", yytext);
                break;
            }
            case SINGLE_LINE_COMMENT:{
                fprintf(output, "<SINGLE_LINE_COMMENT, %s>\n", yytext);
                break;
            }
            case MULTIPLE_LINE_COMMENT:{
                fprintf(output, "<MULTIPLE_LINE_COMMENT, %s>\n", yytext);
                break;
            }
            default:{
                fprintf(output, "<ERROR, %s>\n", yytext);
                break;
            }
        }
    }

    FILE *table = fopen("Table.txt", "w");
    fprintf(table, "Symbol and Literal Table\n");
    fprintf(table, "------------------------\n");
    for(int i = 0; i < size; i ++){
        fprintf(table, "%d: %s\t%s\n", i + 1, SymbolLiteralTable[i].Category, SymbolLiteralTable[i].name);
    }

    fclose(file);
    fclose(output);
    fclose(table);
    return 0;
}

%{
#include <stdio.h>
#include <string.h>

char symtab[50][20];
int count = 0;

void insert(char *id)
{
    int i;
    for(i = 0; i < count; i++)
    {
        if(strcmp(symtab[i], id) == 0)
            return;
    }
    strcpy(symtab[count], id);
    count++;
}

void display()
{
    int i;
    printf("\nSymbol Table:\n");
    for(i = 0; i < count; i++)
    {
        printf("%s\n", symtab[i]);
    }
}
%}

ID      [a-zA-Z_][a-zA-Z0-9_]*
NUMBER  [0-9]+

%%
"//".*              { /* Ignore single line comments */ }
{ID}                { printf("IDENTIFIER: %s\n", yytext); insert(yytext); }
{NUMBER}            { printf("NUMBER: %s\n", yytext); }
[+\-*/=]            { printf("OPERATOR: %s\n", yytext); }
[ \t\n]+            { /* Ignore whitespace */ }
.                   { printf("Invalid Character: %s\n", yytext); }
%%

int yywrap()
{
    return 1;
}

int main()
{
    printf("Enter Code:\n");
    yylex();
    display();
    return 0;
}
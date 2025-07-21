/*Identify keywords in program*/
%{
#include <stdio.h>
%}

%%
int|float|return|if|else|while|for   { printf("Keyword: %s\n", yytext); }
[a-zA-Z_][a-zA-Z0-9_]*               { /* identifiers ignored */ }
.|\n                                { /* ignore other chars */ }
%%

int main() {
    yylex();
    return 0;
}

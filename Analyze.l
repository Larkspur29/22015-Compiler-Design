/* Implementation of Lexical Analyzer using Lex tool */

%{
    int COMMENT = 0;
%}

/* Definitions */
identifier   [a-zA-Z][a-zA-Z0-9]*
number       [0-9]+
string       \"([^"\n])*\"

%%

/* Preprocessor directives */
#.* {
    printf("\n%s is a preprocessor directive", yytext);
}

/* Keywords */
int|float|char|double|while|for|struct|typedef|
do|if|break|continue|void|switch|return|else|goto {
    if (!COMMENT)
        printf("\n\t%s is a keyword", yytext);
}

/* Comments */
"/*" {
    COMMENT = 1;
    printf("\n\t%s begins a COMMENT", yytext);
}
"*/" {
    COMMENT = 0;
    printf("\n\t%s ends a COMMENT", yytext);
}

/* Functions */
{identifier}\( {
    if (!COMMENT)
        printf("\nFUNCTION \n\t%s", yytext);
}

/* Blocks */
\{ {
    if (!COMMENT)
        printf("\n BLOCK BEGINS");
}
\} {
    if (!COMMENT)
        printf("\n BLOCK ENDS");
}

/* Identifiers (including arrays) */
{identifier}(\[[0-9]*\])? {
    if (!COMMENT)
        printf("\n %s IDENTIFIER", yytext);
}

/* Strings */
{string} {
    if (!COMMENT)
        printf("\n\t%s is a STRING", yytext);
}

/* Numbers */
{number} {
    if (!COMMENT)
        printf("\n %s is a NUMBER", yytext);
}

/* Assignment operator */
= {
    if (!COMMENT)
        printf("\n\t%s is an ASSIGNMENT OPERATOR", yytext);
}

/* Relational operators */
\<=|\>=|\<|==|\> {
    if (!COMMENT)
        printf("\n\t%s is a RELATIONAL OPERATOR", yytext);
}

/* Ignore whitespace */
[ \t\n]+    { /* Do nothing */ }

/* Ignore other characters */
.           { /* Do nothing */ }

%%

int main(int argc, char **argv)
{
    FILE *file;
    file = fopen("var.c", "r");

    if (!file) {
        printf("Could not open the file");
        exit(0);
    }

    yyin = file;
    yylex();
    printf("\n");
    return 0;
}

int yywrap()
{
    return 1;
}

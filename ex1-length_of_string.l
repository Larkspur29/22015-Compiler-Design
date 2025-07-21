/*Length of string*/
%{
  #include <stdio.h>
%}

%%
.+       { 
            printf("Length: %d\n\n", yyleng);
          }
\n       { /* ignore newline */ }
%%

int main() {
  yylex();
  return 0;
}

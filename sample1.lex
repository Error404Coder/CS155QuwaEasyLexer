/* 
 * Sample Scanner1: 
 * Description: Replace the string "username" from standard input 
 *              with the user's login name (e.g. lgao)
 * Usage: (1) $ flex sample1.lex
 *        (2a on Mac OS X) $ gcc lex.yy.c -ll 
 *        (2b on Linux)    $ gcc lex.yy.c -lfl
 *        (3) $ ./a.out
 *            stdin> username
 *	      stdin> Ctrl-D
 * Question: What is the purpose of '%{' and '%}'?
 *           What else could be included in this section?
 */


%{
/* need this for the call to getlogin() below */
#include <unistd.h>
int unhandled = 0;
%}

%%
'.*'   { printf("<T_STRING, %s> ", yytext); };
go    { printf("<T_GO, %s> ", yytext); };
exit    { printf("<T_EXIT, %s> ", yytext); };
if    { printf("<T_IF, %s> ", yytext); };
then    { printf("<T_THEN, %s> ", yytext); };
else    { printf("<T_ELSE, %s> ", yytext); };
case    { printf("<T_CASE, %s> ", yytext); };
endcase    { printf("<T_ENDCASE, %s> ", yytext); };
while    { printf("<T_WHILE, %s> ", yytext); };
do    { printf("<T_DO, %s> ", yytext); };
endwhile    { printf("<T_ENDWHILE, %s> ", yytext); };
repeat    { printf("<T_REPEAT, %s> ", yytext); };
until    { printf("<T_UNTIL, %s> ", yytext); };
loop    { printf("<T_LOOP, %s> ", yytext); };
forever    { printf("<T_FOREVER, %s> ", yytext); };
for    { printf("<T_FOR, %s> ", yytext); };
to    { printf("<T_TO, %s> ", yytext); };
by    { printf("<T_BY, %s> ", yytext); };
endfor    { printf("<T_ENDFOR, %s> ", yytext); };
input    { printf("<T_INPUT, %s> ", yytext); };
output    { printf("<T_OUTPUT, %s> ", yytext); };
array    { printf("<T_ARRAY, %s> ", yytext); };
node    { printf("<T_NODE, %s> ", yytext); };
call    { printf("<T_CALL, %s> ", yytext); };
return  { printf("<T_RETURN, %s> ", yytext); };
stop    { printf("<T_STOP, %s> ", yytext); };
end    { printf("<T_END, %s> ", yytext); };
procedure    { printf("<T_PROCEDURE, %s> ", yytext); };

[+\-/\*^]     { printf("<T_ARITH_OP, %s> ", yytext); };
and|or|not     { printf("<T_LOGIC_OP, %s> ", yytext); };

[_a-zA-Z][_0-9a-zA-Z]*[ ]?\( { printf("<T_IDENTIFIER, %s> ", yytext); };

=         { printf("<T_ASSIGN, %s> ", yytext); };
:         { printf("<T_COLON, %s> ", yytext); };
,         { printf("<T_COMMA, %s> ", yytext); };
\;         { printf("<T_SEMICOLON, %s> ", yytext); };
\(         { printf("<T_O_PAREN, %s> ", yytext); };
\)         { printf("<T_C_PAREN, %s> ", yytext); };
\[         { printf("<T_O_BRACKET, %s> ", yytext); };
\]         { printf("<T_C_BRACKET, %s> ", yytext); };
\{         { printf("<T_O_BRACE, %s> ", yytext); };
\}         { printf("<T_C_BRACE, %s> ", yytext); };

[<=>!]=?    { printf("<T_REL_OP, %s> ", yytext); };

[0-9]+  { printf("<T_DIGIT, %s> ", yytext); };

\n      {printf("<T_NEWLINE, \\n>\n"); };
[ \t\n\r\f]+ {printf("%s", yytext);};
[_a-zA-Z][_0-9a-zA-Z]* { printf("<T_VARIABLE, %s> ", yytext); };
.      { unhandled+=1; printf("\nUnhandled: %s\n", yytext); };
%%


int main(int argc, char *argv[])
{
  yyin = fopen(argv[1],"r");

  yylex();
}



%{
#include "calculator.tab.h"
#include <stdlib.h>
#include <math.h>
%}
%%
"+"    { return ADD; }
"-"    { return SUB; }
"*"    { return MUL; }
"/"    { return DIV; }
"SQR"	{ return SQR; }
"COS"	{ return COS; }
"SIN"	{ return SIN; }
"TAN"	{ return TAN; }
"CUBE"	{ return CUBE; }
"CEIL"	{ return CEIL; }
"FLOOR"	{ return FLOOR; }
"FACT"	{ return FACT; }

[0-9]+[.]?[0-9]*           {

yylval.p = atof(yytext);

return NUMBER;

}

\n     { printf("EOL\n"); return EOL; }
[ \t]  { /* ignore whitespace */ }
.      { printf("Mystery character %c\n", *yytext); }
%%

%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int yylex();
int yyerror(char *s);
%}


/* declare tokens */

%union
{
double p;
}

%token <p> NUMBER
%token <p> ADD SUB MUL DIV
%token <p> EOL
%token <p> SQR CUBE
%token <p> COS SIN TAN
%token <p> CEIL FLOOR 
%token <p> FACT
%type <p> calclist
%type <p> exp
%type <p> factor
%type <p> term
%type <p> function
%type <p> trig
%type <p> sqr
%type <p> cube
%type <p> factorial


%%

calclist:
 /* empty */
 | calclist exp EOL { $$ = $2; printf("=%lf   %lf\n", $$, $2); } 
 ;
exp: factor
 | exp ADD factor { $$ = $1 + $3; }           
 | exp SUB factor { $$ = $1 - $3; }
 | function
 ;
factor: term
 | factor MUL term { $$ = $1 * $3; }
 | factor DIV term { $$ = $1 / $3; }
 ;
function: sqr
 | trig
 | cube
 | factorial
 | CEIL term { $$ = ceil($2); }
 | FLOOR term { $$ = floor($2); }
;
sqr: 
	SQR term { $$ = $2 * $2; }
;
trig:
	COS term { $$ = cos($2); }
 | SIN term { $$ = sin($2); }
 | TAN term	{ $$ = tan($2); }
;
cube: 
	CUBE term { $$ = $2 * $2 * $2; }
;
factorial:    
	FACT term               
	{
		int i,f,n;
		n = (int)$2;
		f=1;
		for(i=1;i<=n;i++)
			f=f*i;
		$$ = f ;
	}
;
term: NUMBER
;

%%


int main(int argc, char **argv)
{
  yyparse();
}

int yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
}


%{
	#include <ctype.h>
	#include <stdio.h>
	#define YYSTYPE double /* double type for Yacc stack */
	
	extern int yylex();
	void yyerror(char *msg);
%}

%token Or
%token And
%token Not
%token True
%token False

%left Or
%left And
%left Not

%%
lines	: lines bexpr '\n' { 	if ($2 == 1)
								{
									printf("True... \n");
								}
								else 
								{
									printf("False... \n");
								} 
						   }
		| lines '\n'
		| /* empty */
		;
		
bexpr	: bexpr Or bterm	{ 	if (($1 == 0) && ($3 == 0))
								{ 
									$$ = 0;
								}
								else 
								{
									$$ = 1;
								}
							}
		| bterm 	{ $$ = $1 }
		;
		
bterm	: bterm And bfactor { 	$$ = $1 * $3 }
		| bfactor 	{ $$ = $1}
		;
		
bfactor	: Not bfactor		{ if ($2 == 0)
								{ 
									$$ = 1;
								}
								else 
								{
									$$ = 0;
								}
							}
		| '(' bexpr ')'  { $$ = $2 }
		| True				 
		| False			
		;
		
%%

#include "lex.yy.c"

void yyerror(char *msg){
	printf("Error de sintaxis");
	exit(0);
}

int main(){
	yyparse();
	return 0;
}
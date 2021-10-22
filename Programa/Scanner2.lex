Or or|Or|OR
And and|And|AND
Not not|Not|NOT
True true|TRUE|True	
False false|FALSE|False
	/*number	[0-9]+\.?|[0-9]*\.[0-9]+*/

%%
[ \t]		; { /* Espacios en blanco */ }
{Or}		return Or;
{And}		return And;
{Not}		return Not;
{True}		{
				sscanf("1", "%lf", &yylval);
				return True;
			}
{False}		{
				sscanf("0", "%lf", &yylval);
				return False;
			}
[()\n]		return yytext[0];
.			printf("Error\n");
%%

int yywrap(void)
{
	return 0;
}

/*main()
{
	int token;
	token = yylex();
	while (token){
		printf("%d\n", token);
		token = yylex();
	}
}*/
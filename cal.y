%{
#define Pi 3.14159265358979
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
int yylex();
int yyerror(char *);
%}
%union 
{
int ival;
double dval;
}
%token NAME SIN COS TAN POW LOG EXP FAC
%token <ival> INTEGER
%token <dval> DECIMAL
%type <ival> iexpression
%type <dval> dexpression
%left 	'-' '+'
%left	'*' '/' '%'
%left  SIN COS TAN
%left POW LOG EXP
%left FAC
%nonassoc UMINUS
%%
lines:line
     |line lines
     ;

line: iexpression  '\n'  { printf("= %d\n", $1); }
    | dexpression  '\n' { printf("= %f\n", $1);}
 ;

iexpression:  iexpression '*' iexpression   { $$ = $1 * $3; }
    |   iexpression '/' iexpression   { $$ = $1 / $3; }
    |   iexpression '+' iexpression   { $$ = $1 + $3; }
    |   iexpression '-' iexpression   { $$ = $1 - $3; }
    |   iexpression '%' iexpression   { $$ = $1 % $3; }
    |   '-' iexpression  %prec UMINUS  {$$=- $2;}
    |   '(' iexpression ')' {$$=$2;}
    |  iexpression FAC {
    int ans=1;
    for (int i=2;i<=$1;i++)
    {
    ans=ans*i;
    }
    $$=ans;
    }
    |   INTEGER          { $$ = $1; }
;

dexpression :    dexpression '+' iexpression   { $$ = $1 + $3; }
    |   dexpression '-' iexpression   { $$ = $1 - $3; }
    |   dexpression '*' iexpression  { $$ = $1 * $3; }
    |   dexpression '/' iexpression  { $$ = $1 / $3; }
    |   iexpression '+' dexpression  { $$ = $1 + $3; }
    |   iexpression '-' dexpression   { $$ = $1 - $3; }
    |   iexpression '*'  dexpression { $$ = $1 * $3; }
    |   iexpression '/'  dexpression  { $$ = $1 / $3; }
    |   dexpression '+' dexpression   { $$ = $1 + $3; }
    |   dexpression '-'  dexpression   { $$ = $1 - $3; }
    |   dexpression '*'  dexpression   { $$ = $1 * $3; }
    |   dexpression '/'  dexpression   { $$ = $1 / $3; }
    |   SIN dexpression  {$$=sin($2*Pi/180);}
    |  SIN iexpression  {$$=sin($2*Pi/180);}
    |  COS dexpression {$$=cos($2*Pi/180);}
    |  COS iexpression  {$$=cos($2*Pi/180);}
    |  TAN dexpression {$$=tan($2*Pi/180);}
    |  TAN iexpression  {$$=tan($2*Pi/180);}
    |  LOG dexpression  {$$=log($2);}
    |  LOG iexpression  {$$=log($2);}
    |  EXP dexpression  {$$=exp($2);}
    |  EXP iexpression  {$$=exp($2);}
    |  dexpression POW dexpression {$$=pow($1,$3);}
    |  iexpression POW iexpression {$$=pow($1,$3);}
    |  dexpression POW iexpression {$$=pow($1,$3);}
    |  iexpression POW dexpression {$$=pow($1,$3);}
    |   '-' dexpression  %prec UMINUS     {$$= -$2;}
    |   '(' dexpression ')'          {$$=$2;}
    |   DECIMAL          { $$ = $1; }
    ;

%%
int main()  
{
    yyparse();
    return 0;
}

int yyerror(char *s)
{
    printf("%s/n",s);
    return 0;
}
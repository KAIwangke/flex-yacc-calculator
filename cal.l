%{
#include "cal.tab.h"

extern YYSTYPE yylval;
%}

%%
([1-9][0-9]*)|0  { yylval.ival = atoi(yytext); return INTEGER; } 
(([1-9][0-9]*)|0)(\.[0-9]+)  { yylval.dval= atof(yytext); return DECIMAL; } 
sin {return SIN;}
cos {return COS;}
tan {return TAN;}
"^" {return POW;}
log {return LOG;}
exp {return EXP;}
! {return FAC;}
[a-zA-Z][a-zA-Z0-9]*  { return NAME;}
[ \t]   ;       /* ignore white space */
"$" {return 0;}
\n | 
.   return yytext[0];
%%
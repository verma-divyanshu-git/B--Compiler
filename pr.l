digits [0-9]
alpha  [A-Z]
%{
#include<stdio.h>
FILE *yyin,*yyout;
%}



%%

(\;)|(\,)|(\=)                                                      {return yytext[0];}
[1-9][0-9]{0,3}                                                {fprintf(yyout,"%s",yytext);return LINE_NO;}
{digits}+\.{digits}+                                           {fprintf(yyout,"%s",yytext);return REAL;}
{digits}+                                                      {fprintf(yyout,"%s",yytext);return INTEGER;}
REM([ ]+.*)?\n                                                 {fprintf(yyout,"%s",yytext);return COMMENT;}
END                                                            {fprintf(yyout,"%s",yytext);return END;}
STOP                                                           {fprintf(yyout,"%s",yytext);return STOP;}
RETURN                                                         {fprintf(yyout,"%s",yytext);return RETURN;}
DATA                                                           {fprintf(yyout,"%s",yytext);return DATA;}
INPUT                                                          {fprintf(yyout,"%s",yytext);return INPUT;}
DIM                                                            {fprintf(yyout,"%s",yytext);return DIM;}
PRINT                                                          {fprintf(yyout,"%s",yytext);return PRINT;}
LET                                                            {fprintf(yyout,"%s",yytext);return LET;}
GOTO                                                           {fprintf(yyout,"%s",yytext);return GOTO;}
GOSUB                                                          {fprintf(yyout,"%s",yytext);return GOSUB;}
IF                                                             {fprintf(yyout,"%s",yytext);return IF;}
THEN                                                           {fprintf(yyout,"%s",yytext);return THEN;}
FOR                                                            {fprintf(yyout,"%s",yytext);return FOR;}
TO                                                             {fprintf(yyout,"%s",yytext);return TO;}
STEP                                                           {fprintf(yyout,"%s",yytext);return STEP;}
NEXT                                                           {fprintf(yyout,"%s",yytext);return NEXT;}
DEF[ ]+FN{alpha}[ ]+\({alpha}\)                                {fprintf(yyout,"%s",yytext);return PARAMETER_DEF;}
DEF[ ]+FN{alpha}                                               {fprintf(yyout,"%s",yytext);return PSEUDO_DEF;}
\".*\"                                                         {fprintf(yyout,"%s",yytext);return STRING_LITERAL;}
"+"|"-"|"/"|"*"                                                {fprintf(yyout,"%s",yytext);return ARITHMETIC_OP;}
">"|"<"|"<="|">="|"<>"                                     {fprintf(yyout,"%s",yytext);return RELATIONAL_OP;}
AND|OR|NOT|XOR                                                 {fprintf(yyout,"%s",yytext);return LOGICAL_OP;}
{alpha}\(({digits}+|{alpha})(\,({digits}+|{alpha}))*\)         {fprintf(yyout,"\t\t%s\t",yytext);return ARRAY_ID;}
{alpha}{digits}?%?                                             {fprintf(yyout,"\t\t%s\t",yytext);return INT_ID;}
{alpha}{digits}?\$                                             {fprintf(yyout,"\t\t%s\t",yytext);return STRING_ID;}
{alpha}{digits}?#                                              {fprintf(yyout,"\t\t%s\t",yytext);return DOUBLE_ID;}
{alpha}{digits}?!                                              {fprintf(yyout,"\t\t%s\t",yytext);return SINGLE_ID;}
[ ]+                                                           {return yytext[0];}
\n                                                             {return yytext[0];}
"("|")"                                                        {return yytext[0];}
.                                                              {}
%%


int yywrap(){
    return 1;
}

int main(){
yyin=fopen("in.txt","r");
yyout=fopen("out.txt","w");
yylex();
return 0;
}

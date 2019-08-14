%{                                                                                          
#include "C_minus.tab.h"                                                                     
extern int line_number;
void yyerror (char const *s) {
   fprintf (stderr, "%s\n", s);
 }                                                               
%}                                                                                        
%option noyywrap                                                                            
 
%%   

"/*" 				{   
						printf("COMMENTING STARTED => \n/*");
						register char x;
                       
						for ( ; ; )
						{   

							while ( (x = input()) != '*'){
                                if( x == EOF){
                                    yyerror( "EOF in comment" );
								    break;
                                }else{
                                    printf("%c", x);
                                }
							}

							if ( x == '*' )
							{   printf("%c", x);
                                if( (x =input()) == '/'){
                                    break;
                                }else if( x != '/' && x != EOF){
                                    printf("%c", x);
                                    continue;
                                }else{
                                    yyerror( "EOF in comment" );
								    break;
                                }
								
							}

						}
						printf("/\n COMMENTING ENDED.\n");
					}        

"else"          { printf("FROM FLEX ELSE %s\n", yytext); return ELSE; }                  
"if"            { printf("FROM FLEX IF %s\n", yytext); return IF; }      
"int"           { printf("FROM FLEX  %s\n", yytext); return INT; }
"return"        { printf("FROM FLEX  %s\n", yytext); return RETURN; }
"void"          { printf("FROM FLEX  %s\n", yytext); return VOID; }
"while"         { printf("FROM FLEX  %s\n", yytext); return WHILE; }

"+"            	{ printf("FROM FLEX SYMBOL %s\n", yytext);return ADD;}
"-"            	{ printf("FROM FLEX SYMBOL %s\n", yytext);return SUB;}
"*"            	{ printf("FROM FLEX SYMBOL %s\n", yytext);return MUL;}
"/"            	{ printf("FROM FLEX SYMBOL %s\n", yytext);return DIV;}
"<"            	{ printf("FROM FLEX SYMBOL %s\n", yytext);return LT;}
"<="            { printf("FROM FLEX SYMBOL %s\n", yytext);return LE;}
">"            	{ printf("FROM FLEX SYMBOL %s\n", yytext);return GR;}
">="            { printf("FROM FLEX SYMBOL %s\n", yytext);return GE;}
"="            	{ printf("FROM FLEX SYMBOL %s\n", yytext);return EQ;}
"=="            { printf("FROM FLEX SYMBOL %s\n", yytext);return ET;}
"!="            { printf("FROM FLEX SYMBOL %s\n", yytext);return NE;}
","            	{ printf("FROM FLEX SYMBOL %s\n", yytext);return CM;}
";"            	{ printf("FROM FLEX SYMBOL %s\n", yytext);return SC;}
"{"            	{ printf("FROM FLEX SYMBOL %s\n", yytext);return LC;}
"}"            	{ printf("FROM FLEX SYMBOL %s\n", yytext);return RC;}
"("            	{ printf("FROM FLEX SYMBOL %s\n", yytext);return LP;}
")"            	{ printf("FROM FLEX SYMBOL %s\n", yytext);return RP;}
"["            	{ printf("FROM FLEX SYMBOL %s\n", yytext);return LS;}
"]"            	{ printf("FROM FLEX SYMBOL %s\n", yytext);return RS;}
                                                                   
[a-zA-Z]+       { printf("FROM FLEX ID: %s\n", yytext); return ID; } 
[0-9]+          { printf("FROM FLEX NUM: %s\n", yytext); return NUM; } 

[ \t\r]+        {}                                                  
[\n]            { line_number++; }  

.               { yyerror("Unknown character"); return 1;} 

%%
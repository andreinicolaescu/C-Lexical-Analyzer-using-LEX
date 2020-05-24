
 //Semigrupa 3421, Nicolaescu Andrei, Tema2 : 1.7, Analizor Lexical Folosind Lex
%{

%}
invalidHexa 0[xX][0-9a-fA-F]+[g-zG-Z]+[0-9a-fA-F]?
invalidOcta 0+[8-9]?[0-7]?[8-9]?
invalidID [0-9]+\.?([0-9]*)?([eE][-+]?[0-9]+)?[A-Za-z_]+
invalidSTRING1 \"[^\n\"]*[\n]?[^\n\"]*\"?
invalidSTRINGTEST \"[^\n\"]*[\n]?
invalidSTRING2 \'[^\n\']*[\n]?
literalString1 \"([^\\\"\n]|\\.)*(\\\n)?([^\\\"\n]|\\.)*\"
literalString2 \'([^\\\'\n]|\\.)*\'
octa 0[0-7]+
hexa 0[xX][0-9a-fA-F]+
literalNumber ([0-9]*)?\.?([0-9]*)?([eE][-+]?[0-9]+)?
separator [\[{};,()\]]
identifier [a-zA-Z][a-zA-Z0-9]*
comentariuMultiplu "/*"([^*]|\*+[^*/])*\*+"/"
comentariuSimplu \/\/(.*)
operator [+-/=*%]|->|&&|\|\||\!|\<=|\>=|\<|\==|\>|\+\+|\-\-|\!\=|\<\<|\>\>|&|\||\~|\^|\?\:|\+\=|\-\=|\*\=|\/\=|\%\=
keyword string|auto|break|case|char|const|continue|default|do|double|else|enum|extern|float|for|goto|if|int|long|register|return|short|signed|sizeof|static|struct|switch|typedef|union|unsigned|void|volatile|while
%%
#.* {printf("\n\t%s is a preprocessor directive",yytext);}
{invalidOcta} {printf("\n\t%s\t\t ------> EROARE ... Ies din program\n______________", yytext);}{exit(666);}
{invalidHexa} {printf("\n\t%s\t\t ------> EROARE ... Ies din program\n______________", yytext);}{exit(666);}
{octa} {printf("\n\t%s ------> LITERAL NUM\n______________",yytext);}
{hexa} {printf("\n\t%s ------> LITERAL NUM\n______________",yytext);}
{invalidID} {printf("\n\t%s\t\t ------> EROARE ... Ies din program\n______________", yytext);}{exit(666);}
{keyword} {printf("\n\t%s ------> KEYWORD\n______________",yytext);}
{comentariuSimplu} {}
{comentariuMultiplu} {}
{separator}   {printf("\n\t%s ------> SEPARATOR\n______________",yytext);}
{operator}   {printf("\n\t%s ------> OPERATOR\n______________",yytext);}
{identifier}([0-9]*)? {printf("\n\t%s ------> IDENTIFIER\n______________",yytext);}
{literalString1} {printf("\n\t%s ------> LITERAL STRING\n______________",yytext);}
{literalString2} {printf("\n\t%s ------> LITERAL STRING\n______________",yytext);}
{invalidSTRINGTEST} {printf("\n\t\t%s\t\t ------> EROARE ... Ies din program\n______________", yytext);}{exit(666);}
{invalidSTRING2} {printf("\n\t\t%s\t\t ------> EROARE ... Ies din program\n______________", yytext);}{exit(666);}
{literalNumber} {printf("\n\t%s ------> LITERAL NUM\n______________",yytext);}
%%
int main(int argc, char **argv)
{
FILE *file;

if (argv[1] != NULL) // Daca a fost introdus numele fisierului din linia de comanda, il preluam de acolo.
{
printf("\n\n\t%s este numele fisierului.\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n",argv[1]);
file=fopen(argv[1],"r");
}
else
{
file=fopen("var.c","r");
}
if(!file)
{
printf("could not open the file");
exit(0);
}
yyin=file;
yylex();
printf("\n");
return(0);
}
int yywrap()
{
return(1);
}
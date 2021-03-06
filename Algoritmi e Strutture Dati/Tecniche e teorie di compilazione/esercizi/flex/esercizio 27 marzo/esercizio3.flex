/*
 * Analizzatore lessicale che effettua soltanto il riconoscimento del lessico
 *
*/

%x COMM
%x DATI	
/* definizioni regolari */

delim   [ \t]
ws      {delim}+
newline \n
letter  [a-zA-Z]
digit   [0-9]
id      {letter}({letter}|{digit})*
number	{digit}+
%option noyywrap
%%
<INITIAL>{ws}
<INITIAL>{newline}
<INITIAL>\{		{BEGIN(COMM);}
<INITIAL>(PROGRAM|program)	
<INITIAL>(BEGIN|begin) 
<INITIAL>(END|end) 
<INITIAL>(IF|if) 
(THEN|then) 
<INITIAL>(ELSE|else) 
<INITIAL>(READ|read) 
<INITIAL>(WRITE|write) 
<INITIAL>(WHILE|while) 
<INITIAL>(DO|do) 
<INITIAL>\;
<INITIAL>{number} 
<INITIAL>":="  
<INITIAL>[\+\-\*/] 
<INITIAL>"="|">"|"<"|"<="|">="|"<>"  
<INITIAL>{id} 
<COMM>\}	{BEGIN(INITIAL);}
<COMM>"AUTORE:"\n		{BEGIN(DATI);}
<COMM>"DATA:"\n		{BEGIN(DATI);}
<COMM>"VERSIONE:"\n	{BEGIN(DATI);}
<COMM>[^}\n]*	;
<COMM>\n	;
<DATI>[^}\n]*\n	{ECHO; BEGIN(COMM);}
%% 
main (int argc, char *argv[])
	{
	--argc;
	if (argc>0)
		{ 
		yyin=fopen(argv[1],"r");
		if (argc>1)
			yyout=fopen(argv[2],"w");
		else 
			yyout=stdout;
		}
	else 
		yyin=stdin;
	yylex();
	}



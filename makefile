calculator:	calculator.l calculator.y
		bison -d calculator.y
		flex calculator.l
		gcc -g -o $@ calculator.tab.c lex.yy.c -lfl -lm

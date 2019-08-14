C_minus: lex.yy.o C_minus.tab.o
	gcc -o C_minus $^

C_minus.tab.h: src/C_minus.y
	bison --debug --verbose -d src/C_minus.y

C_minus.tab.c: src/C_minus.y
	bison -d src/C_minus.y

lex.yy.c: src/C_minus.lex C_minus.tab.h
	flex  src/C_minus.lex
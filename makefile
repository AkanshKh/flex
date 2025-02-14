lex: lex.yy.c
	gcc lex.yy.c -o lex -ll

lex.yy.c: main.l
	flex main.l

clean:
	rm -f lex.yy.c lex
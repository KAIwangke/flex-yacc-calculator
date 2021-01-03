flex cal.l

bison -d cal.y

gcc -o cal cal.tab.c lex.yy.c -ly -lm -lfl

./cal
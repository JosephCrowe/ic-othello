OTHELLO_SRCS=\
	Othello.ml

MAIN_SRCS=\
	Colour.ml Board.ml Player.ml Game.ml GameInterface.ml

GAMEINTERFACETEST_SRCS=\
	$(MAIN_SRCS) GameInterfaceTest.ml

EXTRA_SRCS=\
	str.cma

BINS=\
	Othello GameInterfaceTest

Othello: $(OTHELLO_SRCS)
	ocamlc $(EXTRA_SRCS) $(OTHELLO_SRCS) -o Othello

GameInterfaceTest: $(GAMEINTERFACETEST_SRCS)
	ocamlc $(EXTRA_SRCS) $(GAMEINTERFACETEST_SRCS) -o GameInterfaceTest

clean:
	rm -f *.cmi *.cmo $(BINS)

.phony: clean

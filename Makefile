MAIN_SRCS=Colour.ml Board.ml Player.ml Game.ml GameInterface.ml
EXTRA_SRCS=str.cma

BINS=Othello ConsoleTest

OTHELLO_SRCS=$(MAIN_SRCS) Othello.ml
Othello: $(OTHELLO_SRCS)
	ocamlc $(EXTRA_SRCS) $(OTHELLO_SRCS) -o Othello

CONSOLETEST_SRCS=$(MAIN_SRCS) ConsoleGame.ml HumanPlayer.ml ConsoleTest.ml
ConsoleTest: $(GAMEINTERFACETEST_SRCS)
	ocamlc $(EXTRA_SRCS) $(CONSOLETEST_SRCS) -o ConsoleTest

clean:
	rm -f *.cmi *.cmo $(BINS)

.phony: clean

OTHELLO_SRCS=Othello.ml
TEST_SRCS=Colour.ml Board.ml Player.ml Game.ml GameInterface.ml Test.ml

Othello: $(OTHELLO_SRCS)
	ocamlc str.cma $(OTHELLO_SRCS) -o Othello

Test: $(TEST_SRCS)
	ocamlc str.cma $(TEST_SRCS) -o Test

clean:
	rm -f *.cmi *.cmo Othello

.phony: clean

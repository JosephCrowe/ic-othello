OBJS=Colour.ml Board.ml Player.ml Game.ml GameInterface.ml Test.ml

Othello: $(OBJS)
	ocamlc str.cma $(OBJS) -o Othello

clean:
	rm -f *.cmi *.cmo Othello

.phony: clean

Othello: Othello.ml GameInterface.ml
	ocamlc str.cma Othello.ml GameInterface.ml -o Othello

clean:
	rm -f *.cmi *.cmo Othello

.phony: clean
